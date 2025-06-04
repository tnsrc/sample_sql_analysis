# Universal Stored Procedure Analysis Guide
============================================================

## Overview
This stored procedure has been automatically broken into 6 logical chunks.
Each chunk represents a distinct logical operation or set of related operations.
Analyze each chunk independently to understand the complete business logic.

## Procedure Statistics
- **Total Chunks**: 6
- **Total Complexity Score**: 122
- **Average Complexity per Chunk**: 20.3

**Chunk Type Distribution:**
- Error Handling: 1
- General Logic: 1
- Transaction Control: 2
- Variable Declaration: 2

## Recommended Analysis Order
Process chunks in this order to maintain logical flow:

1. **Chunk 1**: Variable & Parameter Declarations (CREATE)
   - Type: variable_declaration
   - Complexity: 3
   - Lines: 1-15

2. **Chunk 2**: Variable & Parameter Declarations - Part 2
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 15-40

3. **Chunk 3**: Error Handling & Exception Management (CONTROL_FLOW_START/BEGIN)
   - Type: error_handling
   - Complexity: 4
   - Lines: 40-48

4. **Chunk 4**: Transaction Control (UPDATE/INSERT)
   - Type: transaction_control
   - Complexity: 105
   - Lines: 48-333

5. **Chunk 5**: Transaction Control (INSERT)
   - Type: transaction_control
   - Complexity: 10
   - Lines: 333-358
   - Depends on Chunks: 4

6. **Chunk 6**: General Business Logic (END/RETURN)
   - Type: general_logic
   - Complexity: 0
   - Lines: 358-360
   - Depends on Chunks: 4

## Detailed Chunk Analysis

### Chunk 1: Variable & Parameter Declarations (CREATE)
**Type**: variable_declaration
**Complexity Score**: 3/10
**Lines**: 1-15
**SQL Operations**: CREATE
**Control Structures**: BEGIN
**Variables Declared**: @TOTALAMOUNT
**Variables Used**: @TotalAmount, @CartItems, @CustomerID, @PaymentMethodID, @PromoCode, @ErrorMessage, @ShippingAddressID, @OrderDate, @OrderID

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 2: Variable & Parameter Declarations - Part 2
**Type**: variable_declaration
**Complexity Score**: 0/10
**Lines**: 15-40
**Variables Declared**: @AVAILABLESTOCK, @CURRENTITEM, @DISCOUNTAMOUNT, @UNITPRICE, @TAXAMOUNT, @ISVALID, @CUSTOMERORDERCOUNT, @ORDERSTATUSID, @PRODUCTID, @PROMOID, @ERRORCODE, @CUSTOMERTYPEID, @PROMOSTARTDATE, @CART, @QUANTITY, @FINALAMOUNT, @PROMOENDDATE, @TRANSACTIONID, @DISCOUNTPERCENTAGE, @ITEMCOUNT, @SHIPPINGCOST, @MAXDISCOUNT, @TOTALAMOUNT
**Variables Used**: @MaxDiscount, @Quantity, @PromoID, @ProductID, @CurrentItem, @CustomerTypeID, @Cart, @TotalAmount, @ShippingCost, @FinalAmount, @ItemCount, @TaxAmount, @DiscountAmount, @OrderStatusID, @PromoEndDate, @AvailableStock, @ErrorCode, @CustomerOrderCount, @TransactionID, @IsValid, @PromoStartDate, @UnitPrice, @DiscountPercentage

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 3: Error Handling & Exception Management (CONTROL_FLOW_START/BEGIN)
**Type**: error_handling
**Complexity Score**: 4/10
**Lines**: 40-48
**Control Structures**: CONTROL_FLOW_START, BEGIN, TRY

**Code:**
```sql
        RowNum INT IDENTITY(1,1),
        ProductID INT,
        Quantity INT,
        UnitPrice DECIMAL(18,2),
        LineTotal DECIMAL(18,2)
    );
    
    -- Begin transaction
    BEGIN TRY
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 4: Transaction Control (UPDATE/INSERT)
**Type**: transaction_control
**Complexity Score**: 105/10
**Lines**: 48-333
**SQL Operations**: UPDATE, INSERT, SELECT
**Control Structures**: GOTO, TRY, IF, END, WHEN, WHILE, CASE, BEGIN, FOR, ELSE, CONTROL_FLOW_START, CATCH
**Variables Used**: @MaxDiscount, @Quantity, @PaymentMethodID, @PromoCode, @ProductID, @CurrentItem, @CustomerTypeID, @Cart, @TotalAmount, @ShippingCost, @FinalAmount, @ShippingAddressID, @ItemCount, @OrderDate, @TaxAmount, @TRANCOUNT, @CustomerID, @DiscountAmount, @OrderStatusID, @ErrorMessage, @PromoEndDate, @AvailableStock, @DiscountPercentage, @ErrorCode, @CartItems, @CustomerOrderCount, @TransactionID, @IsValid, @PromoStartDate, @UnitPrice, @PromoID, @OrderID
**Tables/Views**: CUSTOMERS, PROMOTIONS, PAYMENTMETHODS, OPENJSON, ORDERS, ADDRESSES, CUSTOMERLOG, P, PRODUCTS, TRANSACTIONLOG, ORDERITEMS

**Code:**
```sql
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
    
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 5: Transaction Control (INSERT)
**Type**: transaction_control
**Complexity Score**: 10/10
**Lines**: 333-358
**SQL Operations**: INSERT
**Control Structures**: END, BEGIN, RETURN, IF
**Variables Used**: @TRANCOUNT, @ErrorCode, @CustomerID, @IsValid, @ErrorMessage, @OrderID
**Tables/Views**: ERRORLOG
**Dependencies**: Chunks 4

**Code:**
```sql
    
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
    
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 6: General Business Logic (END/RETURN)
**Type**: general_logic
**Complexity Score**: 0/10
**Lines**: 358-360
**Control Structures**: END, RETURN
**Dependencies**: Chunks 4

**Code:**
```sql
    
    RETURN 0;
END;
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---
