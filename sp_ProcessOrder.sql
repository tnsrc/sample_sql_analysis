CREATE PROCEDURE sp_ProcessOrder
    @CustomerID INT,
    @OrderDate DATETIME,
    @ShippingAddressID INT,
    @PaymentMethodID INT,
    @CartItems NVARCHAR(MAX), -- JSON array of items: [{"ProductID": int, "Quantity": int}, ...]
    @PromoCode NVARCHAR(50),
    @OrderID INT OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Declare variables
    DECLARE @TotalAmount DECIMAL(18,2) = 0;
    DECLARE @DiscountAmount DECIMAL(18,2) = 0;
    DECLARE @TaxAmount DECIMAL(18,2) = 0;
    DECLARE @ShippingCost DECIMAL(18,2) = 0;
    DECLARE @FinalAmount DECIMAL(18,2) = 0;
    DECLARE @OrderStatusID INT = 1; -- 1 = Pending
    DECLARE @IsValid BIT = 1;
    DECLARE @CurrentItem INT;
    DECLARE @ItemCount INT;
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @UnitPrice DECIMAL(18,2);
    DECLARE @AvailableStock INT;
    DECLARE @DiscountPercentage DECIMAL(5,2);
    DECLARE @MaxDiscount DECIMAL(18,2);
    DECLARE @PromoID INT;
    DECLARE @PromoStartDate DATETIME;
    DECLARE @PromoEndDate DATETIME;
    DECLARE @CustomerTypeID INT;
    DECLARE @CustomerOrderCount INT;
    DECLARE @TransactionID INT;
    DECLARE @ErrorCode INT = 0;
    
    -- Temporary table for cart items
    DECLARE @Cart TABLE (
        RowNum INT IDENTITY(1,1),
        ProductID INT,
        Quantity INT,
        UnitPrice DECIMAL(18,2),
        LineTotal DECIMAL(18,2)
    );
    
    -- Begin transaction
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate input parameters
        IF @CustomerID IS NULL OR @CustomerID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Customer ID.';
            SET @ErrorCode = 1001;
            GOTO ErrorHandler;
        END;
        
        IF @ShippingAddressID IS NULL OR @ShippingAddressID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Shipping Address ID.';
            SET @ErrorCode = 1002;
            GOTO ErrorHandler;
        END;
        
        IF @PaymentMethodID IS NULL OR @PaymentMethodID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Payment Method ID.';
            SET @ErrorCode = 1003;
            GOTO ErrorHandler;
        END;
        
        -- Validate customer exists and is active
        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID AND IsActive = 1)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Customer does not exist or is inactive.';
            SET @ErrorCode = 1004;
            GOTO ErrorHandler;
        END;
        
        -- Validate shipping address belongs to customer
        IF NOT EXISTS (SELECT 1 FROM Addresses WHERE AddressID = @ShippingAddressID AND CustomerID = @CustomerID)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Shipping address does not belong to the customer.';
            SET @ErrorCode = 1005;
            GOTO ErrorHandler;
        END;
        
        -- Validate payment method
        IF NOT EXISTS (SELECT 1 FROM PaymentMethods WHERE PaymentMethodID = @PaymentMethodID AND IsActive = 1)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid or inactive payment method.';
            SET @ErrorCode = 1006;
            GOTO ErrorHandler;
        END;
        
        -- Parse and validate cart items (assuming JSON input)
        INSERT INTO @Cart (ProductID, Quantity)
        SELECT 
            JSON_VALUE(value, '$.ProductID'),
            JSON_VALUE(value, '$.Quantity')
        FROM OPENJSON(@CartItems);
        
        -- Get item count
        SET @ItemCount = (SELECT COUNT(*) FROM @Cart);
        IF @ItemCount = 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Cart is empty.';
            SET @ErrorCode = 1007;
            GOTO ErrorHandler;
        END;
        
        -- Validate cart items
        SET @CurrentItem = 1;
        WHILE @CurrentItem <= @ItemCount
        BEGIN
            SELECT 
                @ProductID = ProductID,
                @Quantity = Quantity
            FROM @Cart
            WHERE RowNum = @CurrentItem;
            
            -- Check if product exists
            IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND IsActive = 1)
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + ' does not exist or is inactive.';
                SET @ErrorCode = 1008;
                GOTO ErrorHandler;
            END;
            
            -- Check stock availability
            SELECT @AvailableStock = StockQuantity, @UnitPrice = UnitPrice
            FROM Products
            WHERE ProductID = @ProductID;
            
            IF @Quantity <= 0 OR @Quantity > @AvailableStock
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Invalid quantity or insufficient stock for Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + '.';
                SET @ErrorCode = 1009;
                GOTO ErrorHandler;
            END;
            
            -- Update cart with unit price and line total
            UPDATE @Cart
            SET UnitPrice = @UnitPrice,
                LineTotal = @Quantity * @UnitPrice
            WHERE RowNum = @CurrentItem;
            
            SET @CurrentItem = @CurrentItem + 1;
        END;
        
        -- Calculate total amount
        SELECT @TotalAmount = SUM(LineTotal)
        FROM @Cart;
        
        -- Apply promo code if provided
        IF @PromoCode IS NOT NULL AND @PromoCode != ''
        BEGIN
            SELECT 
                @PromoID = PromoID,
                @DiscountPercentage = DiscountPercentage,
                @MaxDiscount = MaxDiscountAmount,
                @PromoStartDate = StartDate,
                @PromoEndDate = EndDate
            FROM Promotions
            WHERE PromoCode = @PromoCode AND IsActive = 1;
            
            IF @PromoID IS NULL
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Invalid or inactive promo code.';
                SET @ErrorCode = 1010;
                GOTO ErrorHandler;
            END;
            
            IF @OrderDate < @PromoStartDate OR @OrderDate > @PromoEndDate
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Promo code is not valid for the current date.';
                SET @ErrorCode = 1011;
                GOTO ErrorHandler;
            END;
            
            -- Calculate discount
            SET @DiscountAmount = @TotalAmount * (@DiscountPercentage / 100);
            IF @MaxDiscount IS NOT NULL AND @DiscountAmount > @MaxDiscount
                SET @DiscountAmount = @MaxDiscount;
        END;
        
        -- Get customer type and order history
        SELECT @CustomerTypeID = CustomerTypeID
        FROM Customers
        WHERE CustomerID = @CustomerID;
        
        SELECT @CustomerOrderCount = COUNT(*)
        FROM Orders
        WHERE CustomerID = @CustomerID AND OrderStatusID IN (2, 3); -- Completed or Shipped
        
        -- Apply additional discount for VIP customers
        IF @CustomerTypeID = 2 -- VIP
        BEGIN
            SET @DiscountAmount = @DiscountAmount + (@TotalAmount * 0.05); -- 5% extra discount
        END;
        
        -- Calculate tax (e.g., 8% tax rate)
        SET @TaxAmount = (@TotalAmount - @DiscountAmount) * 0.08;
        
        -- Calculate shipping cost based on total weight
        SELECT @ShippingCost = CASE 
            WHEN SUM(p.Weight * c.Quantity) <= 5 THEN 10.00
            WHEN SUM(p.Weight * c.Quantity) <= 20 THEN 20.00
            ELSE 50.00
        END
        FROM @Cart c
        JOIN Products p ON c.ProductID = p.ProductID;
        
        -- Calculate final amount
        SET @FinalAmount = @TotalAmount - @DiscountAmount + @TaxAmount + @ShippingCost;
        
        -- Insert order
        INSERT INTO Orders (
            CustomerID,
            OrderDate,
            ShippingAddressID,
            PaymentMethodID,
            TotalAmount,
            DiscountAmount,
            TaxAmount,
            ShippingCost,
            FinalAmount,
            OrderStatusID,
            PromoID
        )
        VALUES (
            @CustomerID,
            @OrderDate,
            @ShippingAddressID,
            @PaymentMethodID,
            @TotalAmount,
            @DiscountAmount,
            @TaxAmount,
            @ShippingCost,
            @FinalAmount,
            @OrderStatusID,
            @PromoID
        );
        
        SET @OrderID = SCOPE_IDENTITY();
        
        -- Insert order items
        INSERT INTO OrderItems (
            OrderID,
            ProductID,
            Quantity,
            UnitPrice,
            LineTotal
        )
        SELECT 
            @OrderID,
            ProductID,
            Quantity,
            UnitPrice,
            LineTotal
        FROM @Cart;
        
        -- Update inventory
        UPDATE p
        SET p.StockQuantity = p.StockQuantity - c.Quantity
        FROM Products p
        JOIN @Cart c ON p.ProductID = c.ProductID;
        
        -- Log transaction
        INSERT INTO TransactionLog (
            OrderID,
            CustomerID,
            TransactionDate,
            TransactionType,
            Amount
        )
        VALUES (
            @OrderID,
            @CustomerID,
            @OrderDate,
            'OrderPlaced',
            @FinalAmount
        );
        
        SET @TransactionID = SCOPE_IDENTITY();
        
        -- Check if customer qualifies for upgrade to VIP
        IF @CustomerOrderCount >= 10 AND @CustomerTypeID != 2
        BEGIN
            UPDATE Customers
            SET CustomerTypeID = 2
            WHERE CustomerID = @CustomerID;
            
            INSERT INTO CustomerLog (
                CustomerID,
                LogDate,
                LogMessage
            )
            VALUES (
                @CustomerID,
                @OrderDate,
                'Customer upgraded to VIP status.'
            );
        END;
        
        -- Commit transaction
        COMMIT TRANSACTION;
        
        SET @ErrorMessage = 'Order processed successfully.';
        
    END TRY
    BEGIN CATCH
        -- Rollback transaction on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @IsValid = 0;
        SET @ErrorMessage = 'Error processing order: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
    END CATCH;
    
    -- Error handling
    ErrorHandler:
    IF @IsValid = 0
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        INSERT INTO ErrorLog (
            ErrorCode,
            ErrorMessage,
            LogDate,
            CustomerID,
            OrderID
        )
        VALUES (
            @ErrorCode,
            @ErrorMessage,
            GETDATE(),
            @CustomerID,
            @OrderID
        );
        
        RETURN -1;
    END;
    
    RETURN 0;
END;