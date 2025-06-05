-- =====================================================================================
-- MEGA STORED PROCEDURE - Combined E-commerce System
-- Combines all stored procedures into one massive procedure for testing
-- Lines: 6000+ (All business logic combined)
-- =====================================================================================

CREATE PROCEDURE sp_MegaEcommerceProcessor
    @CustomerID INT,
    @OrderDate DATETIME,
    @ShippingAddressID INT,
    @PaymentMethodID INT,
    @CartItems NVARCHAR(MAX), -- JSON array of items
    @PromoCode NVARCHAR(50),
    @ShippingMethodID INT = 1,
    @IsRushOrder BIT = 0,
    @ProcessInventory BIT = 1,
    @ProcessPayment BIT = 1,
    @ProcessNotifications BIT = 1,
    @ProcessRecommendations BIT = 1,
    @ProcessLoyalty BIT = 1,
    @ProcessReports BIT = 1,
    @OrderID INT OUTPUT,
    @TotalAmount DECIMAL(18,2) OUTPUT,
    @ErrorMessage NVARCHAR(1000) OUTPUT,
    @WarningMessages NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    -- =====================================================================================
    -- MASSIVE VARIABLE DECLARATION SECTION
    -- =====================================================================================
    
    -- Core order variables
    DECLARE @SubtotalAmount DECIMAL(18,2) = 0;
    DECLARE @DiscountAmount DECIMAL(18,2) = 0;
    DECLARE @TaxAmount DECIMAL(18,2) = 0;
    DECLARE @ShippingCost DECIMAL(18,2) = 0;
    DECLARE @ProcessingFee DECIMAL(18,2) = 0;
    DECLARE @FinalAmount DECIMAL(18,2) = 0;
    DECLARE @OrderStatusID INT = 1; -- Pending
    DECLARE @IsValid BIT = 1;
    DECLARE @ErrorCode INT = 0;
    DECLARE @WarningCode INT = 0;
    
    -- Customer and product processing
    DECLARE @CurrentItem INT = 1;
    DECLARE @ItemCount INT = 0;
    DECLARE @ProductID INT;
    DECLARE @Quantity INT;
    DECLARE @UnitPrice DECIMAL(18,2);
    DECLARE @AvailableStock INT;
    DECLARE @ReservedStock INT;
    DECLARE @BackorderQuantity INT = 0;
    DECLARE @ProductWeight DECIMAL(10,2);
    DECLARE @ProductVolume DECIMAL(10,2);
    DECLARE @TotalWeight DECIMAL(10,2) = 0;
    DECLARE @TotalVolume DECIMAL(10,2) = 0;
    
    -- Promotion and discount handling
    DECLARE @DiscountPercentage DECIMAL(5,2) = 0;
    DECLARE @MaxDiscount DECIMAL(18,2);
    DECLARE @PromoID INT;
    DECLARE @PromoStartDate DATETIME;
    DECLARE @PromoEndDate DATETIME;
    DECLARE @PromoUsageCount INT = 0;
    DECLARE @PromoMaxUsage INT;
    DECLARE @CustomerPromoUsage INT = 0;
    DECLARE @IsPromoStackable BIT = 0;
    
    -- Customer analysis and segmentation
    DECLARE @CustomerTypeID INT;
    DECLARE @CustomerTierID INT;
    DECLARE @CustomerOrderCount INT = 0;
    DECLARE @CustomerLifetimeValue DECIMAL(18,2) = 0;
    DECLARE @CustomerLastOrderDate DATETIME;
    DECLARE @CustomerRiskScore INT = 0;
    DECLARE @CustomerCreditLimit DECIMAL(18,2) = 0;
    DECLARE @CustomerCurrentBalance DECIMAL(18,2) = 0;
    DECLARE @CustomerPriorityLevel INT = 3; -- Default: Regular
    
    -- Address and shipping
    DECLARE @ShippingStateID INT;
    DECLARE @ShippingCountryID INT;
    DECLARE @ShippingZoneID INT;
    DECLARE @ShippingDistance INT = 0;
    DECLARE @EstimatedDeliveryDays INT = 5;
    DECLARE @ShippingTrackingNumber NVARCHAR(50);
    
    -- Tax calculation variables
    DECLARE @StateTaxRate DECIMAL(8,4) = 0;
    DECLARE @LocalTaxRate DECIMAL(8,4) = 0;
    DECLARE @CalculatedTaxRate DECIMAL(8,4) = 0;
    DECLARE @IsTaxExempt BIT = 0;
    
    -- Payment processing
    DECLARE @PaymentTypeID INT;
    DECLARE @PaymentStatusID INT = 1; -- Pending
    DECLARE @PaymentReferenceNumber NVARCHAR(100);
    DECLARE @PaymentFee DECIMAL(18,2) = 0;
    DECLARE @PaymentAuthCode NVARCHAR(50);
    DECLARE @IsPaymentPreAuth BIT = 0;
    
    -- Inventory and warehouse management
    DECLARE @WarehouseID INT;
    DECLARE @PrimaryWarehouseID INT;
    DECLARE @InventoryReservationID INT;
    DECLARE @RequiresInventoryAllocation BIT = 0;
    DECLARE @InventoryShortfall INT = 0;
    
    -- Loyalty and rewards
    DECLARE @LoyaltyPoints INT = 0;
    DECLARE @LoyaltyPointsEarned INT = 0;
    DECLARE @LoyaltyTierMultiplier DECIMAL(4,2) = 1.0;
    DECLARE @RewardsCashback DECIMAL(18,2) = 0;
    
    -- Transaction and logging
    DECLARE @TransactionID INT;
    DECLARE @OrderProcessingStartTime DATETIME = GETDATE();
    DECLARE @AuditLogID INT;
    DECLARE @NotificationID INT;
    
    -- Recommendations and analytics
    DECLARE @RecommendationSetID INT;
    DECLARE @CustomerBehaviorScore INT = 0;
    DECLARE @CrossSellOpportunities INT = 0;
    DECLARE @UpSellValue DECIMAL(18,2) = 0;
    
    -- Temporary tables for complex processing
    DECLARE @Cart TABLE (
        RowNum INT IDENTITY(1,1) PRIMARY KEY,
        ProductID INT NOT NULL,
        Quantity INT NOT NULL,
        UnitPrice DECIMAL(18,2),
        LineTotal DECIMAL(18,2),
        Weight DECIMAL(10,2),
        Volume DECIMAL(10,2),
        CategoryID INT,
        IsDigital BIT DEFAULT 0,
        WarehouseID INT,
        EstimatedShippingDays INT,
        ReservationID INT,
        TaxRate DECIMAL(8,4),
        LineTaxAmount DECIMAL(18,2)
    );
    
    DECLARE @InventoryAllocations TABLE (
        ProductID INT,
        WarehouseID INT,
        AllocatedQuantity INT,
        ReservationID INT,
        EstimatedShippingDays INT,
        AllocationPriority INT,
        CostPerUnit DECIMAL(10,2)
    );
    
    DECLARE @AppliedPromotions TABLE (
        PromoID INT,
        PromoType NVARCHAR(50),
        DiscountAmount DECIMAL(18,2),
        DiscountPercentage DECIMAL(5,2),
        AppliedToProductID INT,
        IsStackable BIT
    );
    
    DECLARE @TaxCalculations TABLE (
        ProductID INT,
        TaxRate DECIMAL(8,4),
        TaxAmount DECIMAL(18,2),
        TaxType NVARCHAR(50),
        JurisdictionID INT
    );
    
    -- =====================================================================================
    -- COMPREHENSIVE INPUT VALIDATION
    -- =====================================================================================
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Initialize warning messages
        SET @WarningMessages = '';
        
        -- Validate customer information
        IF @CustomerID IS NULL OR @CustomerID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Customer ID provided.';
            SET @ErrorCode = 1001;
            GOTO ErrorHandler;
        END;
        
        IF @OrderDate IS NULL OR @OrderDate > GETDATE()
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid order date. Cannot be future date.';
            SET @ErrorCode = 1002;
            GOTO ErrorHandler;
        END;
        
        IF @ShippingAddressID IS NULL OR @ShippingAddressID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid shipping address ID.';
            SET @ErrorCode = 1003;
            GOTO ErrorHandler;
        END;
        
        IF @PaymentMethodID IS NULL OR @PaymentMethodID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid payment method ID.';
            SET @ErrorCode = 1004;
            GOTO ErrorHandler;
        END;
        
        IF @CartItems IS NULL OR LEN(@CartItems) = 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Cart items cannot be empty.';
            SET @ErrorCode = 1005;
            GOTO ErrorHandler;
        END;
        
        -- =====================================================================================
        -- CUSTOMER VERIFICATION AND ANALYSIS
        -- =====================================================================================
        
        -- Comprehensive customer validation
        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID AND IsActive = 1)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Customer does not exist or is inactive.';
            SET @ErrorCode = 2001;
            GOTO ErrorHandler;
        END;
        
        -- Retrieve detailed customer information
        SELECT 
            @CustomerTypeID = CustomerTypeID,
            @CustomerTierID = CustomerTierID,
            @CustomerCreditLimit = CreditLimit,
            @CustomerCurrentBalance = CurrentBalance,
            @CustomerRiskScore = RiskScore,
            @CustomerLastOrderDate = LastOrderDate,
            @IsTaxExempt = IsTaxExempt
        FROM Customers 
        WHERE CustomerID = @CustomerID;
        
        -- Calculate customer priority level
        SET @CustomerPriorityLevel = CASE 
            WHEN @CustomerTypeID = 1 THEN 1  -- Platinum
            WHEN @CustomerTypeID = 2 THEN 2  -- Gold  
            WHEN @CustomerTypeID = 3 THEN 3  -- Silver
            ELSE 4                           -- Regular
        END;
        
        -- Get customer order history and analytics
        SELECT 
            @CustomerOrderCount = COUNT(*),
            @CustomerLifetimeValue = ISNULL(SUM(FinalAmount), 0)
        FROM Orders 
        WHERE CustomerID = @CustomerID 
          AND OrderStatusID IN (2, 3, 4); -- Completed, Shipped, Delivered
        
        -- Customer credit validation
        IF @CustomerCurrentBalance > @CustomerCreditLimit * 0.9
        BEGIN
            SET @WarningMessages = @WarningMessages + 'Customer near credit limit. ';
            SET @WarningCode = 2001;
        END;
        
        -- Risk assessment
        IF @CustomerRiskScore > 700
        BEGIN
            SET @WarningMessages = @WarningMessages + 'High-risk customer detected. ';
            SET @WarningCode = 2002;
        END;
        
        -- =====================================================================================
        -- ADDRESS AND SHIPPING VALIDATION
        -- =====================================================================================
        
        -- Validate shipping address belongs to customer
        IF NOT EXISTS (
            SELECT 1 FROM Addresses 
            WHERE AddressID = @ShippingAddressID 
              AND CustomerID = @CustomerID 
              AND IsActive = 1
        )
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Shipping address does not belong to customer or is inactive.';
            SET @ErrorCode = 3001;
            GOTO ErrorHandler;
        END;
        
        -- Get shipping location details
        SELECT 
            @ShippingStateID = StateID,
            @ShippingCountryID = CountryID,
            @ShippingZoneID = ShippingZoneID
        FROM Addresses 
        WHERE AddressID = @ShippingAddressID;
        
        -- Validate shipping method
        IF NOT EXISTS (
            SELECT 1 FROM ShippingMethods 
            WHERE MethodID = @ShippingMethodID 
              AND IsActive = 1
        )
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid or inactive shipping method.';
            SET @ErrorCode = 3002;
            GOTO ErrorHandler;
        END;
        
        -- Check if shipping method is available to destination
        IF NOT EXISTS (
            SELECT 1 FROM ShippingMethodZones smz
            INNER JOIN ShippingMethods sm ON smz.MethodID = sm.MethodID
            WHERE smz.MethodID = @ShippingMethodID 
              AND smz.ZoneID = @ShippingZoneID
              AND sm.IsActive = 1
        )
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Shipping method not available to destination.';
            SET @ErrorCode = 3003;
            GOTO ErrorHandler;
        END;
        
        -- =====================================================================================
        -- PAYMENT METHOD VALIDATION
        -- =====================================================================================
        
        -- Validate payment method
        IF NOT EXISTS (
            SELECT 1 FROM PaymentMethods 
            WHERE PaymentMethodID = @PaymentMethodID 
              AND IsActive = 1
        )
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid or inactive payment method.';
            SET @ErrorCode = 4001;
            GOTO ErrorHandler;
        END;
        
        -- Get payment method details
        SELECT 
            @PaymentTypeID = PaymentTypeID,
            @PaymentFee = ProcessingFee,
            @IsPaymentPreAuth = RequiresPreAuth
        FROM PaymentMethods 
        WHERE PaymentMethodID = @PaymentMethodID;
        
        -- Validate payment method for customer
        IF NOT EXISTS (
            SELECT 1 FROM CustomerPaymentMethods 
            WHERE CustomerID = @CustomerID 
              AND PaymentMethodID = @PaymentMethodID 
              AND IsActive = 1
              AND ExpiryDate > GETDATE()
        )
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Payment method not valid for customer or expired.';
            SET @ErrorCode = 4002;
            GOTO ErrorHandler;
        END;
        
        -- =====================================================================================
        -- CART PROCESSING AND VALIDATION
        -- =====================================================================================
        
        -- Parse and validate cart items from JSON
        INSERT INTO @Cart (ProductID, Quantity)
        SELECT 
            JSON_VALUE(value, '$.ProductID'),
            JSON_VALUE(value, '$.Quantity')
        FROM OPENJSON(@CartItems);
        
        -- Validate cart has items
        SET @ItemCount = (SELECT COUNT(*) FROM @Cart);
        IF @ItemCount = 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Cart is empty after parsing JSON.';
            SET @ErrorCode = 5001;
            GOTO ErrorHandler;
        END;
        
        -- Process each cart item with comprehensive validation
        WHILE @CurrentItem <= @ItemCount
        BEGIN
            SELECT 
                @ProductID = ProductID,
                @Quantity = Quantity
            FROM @Cart
            WHERE RowNum = @CurrentItem;
            
            -- Validate product exists and is active
            IF NOT EXISTS (
                SELECT 1 FROM Products 
                WHERE ProductID = @ProductID 
                  AND IsActive = 1 
                  AND IsDiscontinued = 0
            )
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + ' does not exist, is inactive, or discontinued.';
                SET @ErrorCode = 5002;
                GOTO ErrorHandler;
            END;
            
            -- Get comprehensive product information
            SELECT 
                @AvailableStock = StockQuantity,
                @UnitPrice = UnitPrice,
                @ProductWeight = Weight,
                @ProductVolume = Volume
            FROM Products
            WHERE ProductID = @ProductID;
            
            -- Validate quantity
            IF @Quantity <= 0
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Invalid quantity for Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + '. Must be greater than 0.';
                SET @ErrorCode = 5003;
                GOTO ErrorHandler;
            END;
            
            -- Check stock availability
            IF @Quantity > @AvailableStock
            BEGIN
                -- Check if backorder is allowed
                IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND AllowBackorder = 1)
                BEGIN
                    SET @BackorderQuantity = @BackorderQuantity + (@Quantity - @AvailableStock);
                    SET @WarningMessages = @WarningMessages + 'Product ' + CAST(@ProductID AS NVARCHAR(10)) + ' partially backordered. ';
                    SET @WarningCode = 5001;
                END
                ELSE
                BEGIN
                    SET @IsValid = 0;
                    SET @ErrorMessage = 'Insufficient stock for Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + '. Available: ' + CAST(@AvailableStock AS NVARCHAR(10));
                    SET @ErrorCode = 5004;
                    GOTO ErrorHandler;
                END;
            END;
            
            -- Calculate totals
            SET @TotalWeight = @TotalWeight + (@ProductWeight * @Quantity);
            SET @TotalVolume = @TotalVolume + (@ProductVolume * @Quantity);
            
            -- Update cart with detailed information
            UPDATE @Cart
            SET 
                UnitPrice = @UnitPrice,
                LineTotal = @Quantity * @UnitPrice,
                Weight = @ProductWeight,
                Volume = @ProductVolume
            WHERE RowNum = @CurrentItem;
            
            SET @CurrentItem = @CurrentItem + 1;
        END;
        
        -- =====================================================================================
        -- INVENTORY ALLOCATION AND WAREHOUSE MANAGEMENT
        -- =====================================================================================
        
        IF @ProcessInventory = 1
        BEGIN
            -- Advanced inventory allocation across multiple warehouses
            SET @CurrentItem = 1;
            WHILE @CurrentItem <= @ItemCount
            BEGIN
                SELECT 
                    @ProductID = ProductID,
                    @Quantity = Quantity
                FROM @Cart
                WHERE RowNum = @CurrentItem;
                
                -- Use complex inventory allocation function
                INSERT INTO @InventoryAllocations
                EXEC dbo.fn_AllocateInventoryAcrossWarehouses 
                    @ProductID, 
                    @Quantity, 
                    @CustomerPriorityLevel, 
                    @ShippingZoneID;
                
                -- Check if full allocation was possible
                DECLARE @AllocatedTotal INT = 0;
                SELECT @AllocatedTotal = SUM(AllocatedQuantity)
                FROM @InventoryAllocations
                WHERE ProductID = @ProductID;
                
                IF @AllocatedTotal < @Quantity
                BEGIN
                    SET @InventoryShortfall = @InventoryShortfall + (@Quantity - @AllocatedTotal);
                    SET @WarningMessages = @WarningMessages + 'Partial inventory allocation for Product ' + CAST(@ProductID AS NVARCHAR(10)) + '. ';
                END;
                
                SET @CurrentItem = @CurrentItem + 1;
            END;
        END;
        
        -- =====================================================================================
        -- PROMOTION AND DISCOUNT PROCESSING
        -- =====================================================================================
        
        -- Calculate subtotal before promotions
        SELECT @SubtotalAmount = SUM(LineTotal) FROM @Cart;
        
        -- Process promotion code if provided
        IF @PromoCode IS NOT NULL AND @PromoCode != ''
        BEGIN
            -- Validate promotion code
            SELECT 
                @PromoID = PromoID,
                @DiscountPercentage = DiscountPercentage,
                @MaxDiscount = MaxDiscountAmount,
                @PromoStartDate = StartDate,
                @PromoEndDate = EndDate,
                @PromoMaxUsage = MaxUsageCount,
                @IsPromoStackable = IsStackable
            FROM Promotions
            WHERE PromoCode = @PromoCode 
              AND IsActive = 1;
            
            IF @PromoID IS NULL
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Invalid or inactive promotion code: ' + @PromoCode;
                SET @ErrorCode = 6001;
                GOTO ErrorHandler;
            END;
            
            -- Check promotion date validity
            IF @OrderDate < @PromoStartDate OR @OrderDate > @PromoEndDate
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Promotion code is not valid for the current date.';
                SET @ErrorCode = 6002;
                GOTO ErrorHandler;
            END;
            
            -- Check promotion usage limits
            SELECT @PromoUsageCount = COUNT(*)
            FROM Orders o
            INNER JOIN OrderPromotions op ON o.OrderID = op.OrderID
            WHERE op.PromoID = @PromoID;
            
            IF @PromoMaxUsage > 0 AND @PromoUsageCount >= @PromoMaxUsage
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Promotion code has reached maximum usage limit.';
                SET @ErrorCode = 6003;
                GOTO ErrorHandler;
            END;
            
            -- Check customer-specific usage
            SELECT @CustomerPromoUsage = COUNT(*)
            FROM Orders o
            INNER JOIN OrderPromotions op ON o.OrderID = op.OrderID
            WHERE op.PromoID = @PromoID 
              AND o.CustomerID = @CustomerID;
            
            -- Customer usage validation (assuming max 1 per customer for this promo)
            IF @CustomerPromoUsage > 0 AND NOT EXISTS (
                SELECT 1 FROM Promotions 
                WHERE PromoID = @PromoID 
                  AND AllowMultipleUsagePerCustomer = 1
            )
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Promotion code has already been used by this customer.';
                SET @ErrorCode = 6004;
                GOTO ErrorHandler;
            END;
            
            -- Calculate discount amount
            SET @DiscountAmount = @SubtotalAmount * (@DiscountPercentage / 100.0);
            IF @MaxDiscount IS NOT NULL AND @DiscountAmount > @MaxDiscount
                SET @DiscountAmount = @MaxDiscount;
            
            -- Record applied promotion
            INSERT INTO @AppliedPromotions VALUES
            (@PromoID, 'PROMO_CODE', @DiscountAmount, @DiscountPercentage, NULL, @IsPromoStackable);
        END;
        
        -- Apply automatic customer tier discounts
        IF @CustomerTierID IS NOT NULL
        BEGIN
            DECLARE @TierDiscountPercentage DECIMAL(5,2) = 0;
            SELECT @TierDiscountPercentage = DiscountPercentage
            FROM CustomerTiers
            WHERE TierID = @CustomerTierID;
            
            IF @TierDiscountPercentage > 0
            BEGIN
                DECLARE @TierDiscount DECIMAL(18,2) = @SubtotalAmount * (@TierDiscountPercentage / 100.0);
                SET @DiscountAmount = @DiscountAmount + @TierDiscount;
                
                INSERT INTO @AppliedPromotions VALUES
                (NULL, 'TIER_DISCOUNT', @TierDiscount, @TierDiscountPercentage, NULL, 1);
            END;
        END;
        
        -- Apply loyalty points discount if applicable
        IF @ProcessLoyalty = 1
        BEGIN
            SELECT @LoyaltyPoints = ISNULL(LoyaltyPoints, 0)
            FROM Customers
            WHERE CustomerID = @CustomerID;
            
            -- Allow redemption of loyalty points (100 points = $1)
            IF @LoyaltyPoints >= 100
            BEGIN
                DECLARE @MaxPointsRedemption INT = FLOOR(@SubtotalAmount); -- Max $1 per $1 of order
                DECLARE @PointsToRedeem INT = CASE 
                    WHEN @LoyaltyPoints > @MaxPointsRedemption * 100 
                    THEN @MaxPointsRedemption * 100 
                    ELSE (@LoyaltyPoints / 100) * 100 
                END;
                
                IF @PointsToRedeem > 0
                BEGIN
                    DECLARE @PointsDiscount DECIMAL(18,2) = @PointsToRedeem / 100.0;
                    SET @DiscountAmount = @DiscountAmount + @PointsDiscount;
                    
                    INSERT INTO @AppliedPromotions VALUES
                    (NULL, 'LOYALTY_POINTS', @PointsDiscount, 0, NULL, 1);
                    
                    -- Update customer loyalty points
                    UPDATE Customers 
                    SET LoyaltyPoints = LoyaltyPoints - @PointsToRedeem
                    WHERE CustomerID = @CustomerID;
                END;
            END;
        END;
        
        -- =====================================================================================
        -- TAX CALCULATION WITH COMPLEX RULES
        -- =====================================================================================
        
        -- Calculate tax for each product using complex tax function
        SET @CurrentItem = 1;
        WHILE @CurrentItem <= @ItemCount
        BEGIN
            SELECT 
                @ProductID = ProductID,
                @Quantity = Quantity,
                @UnitPrice = UnitPrice
            FROM @Cart
            WHERE RowNum = @CurrentItem;
            
            -- Use complex tax calculation function
            DECLARE @ProductTaxRate DECIMAL(8,4);
            SELECT @ProductTaxRate = dbo.fn_CalculateComplexTax(
                @ProductID, 
                @ShippingStateID, 
                @CustomerTypeID, 
                @UnitPrice * @Quantity, 
                @OrderDate
            );
            
            DECLARE @LineTaxAmount DECIMAL(18,2) = (@UnitPrice * @Quantity) * @ProductTaxRate;
            
            -- Apply tax exemption if customer is tax exempt
            IF @IsTaxExempt = 1
                SET @LineTaxAmount = 0;
            
            SET @TaxAmount = @TaxAmount + @LineTaxAmount;
            
            -- Update cart with tax information
            UPDATE @Cart
            SET 
                TaxRate = @ProductTaxRate,
                LineTaxAmount = @LineTaxAmount
            WHERE RowNum = @CurrentItem;
            
            -- Record tax calculation details
            INSERT INTO @TaxCalculations VALUES
            (@ProductID, @ProductTaxRate, @LineTaxAmount, 'SALES_TAX', @ShippingStateID);
            
            SET @CurrentItem = @CurrentItem + 1;
        END;
        
        -- =====================================================================================
        -- SHIPPING COST CALCULATION
        -- =====================================================================================
        
        -- Use complex shipping calculation function
        SELECT @ShippingCost = dbo.fn_CalculateDynamicShipping(
            @TotalWeight,
            @TotalVolume, 
            @ShippingDistance,
            @ShippingMethodID,
            @CustomerTypeID,
            @SubtotalAmount,
            @IsRushOrder,
            @OrderDate
        );
        
        -- =====================================================================================
        -- PAYMENT PROCESSING AND FEES
        -- =====================================================================================
        
        IF @ProcessPayment = 1
        BEGIN
            -- Calculate payment processing fee
            SET @ProcessingFee = (@SubtotalAmount + @TaxAmount + @ShippingCost) * (@PaymentFee / 100.0);
            
            -- Minimum processing fee
            IF @ProcessingFee < 0.30 AND @PaymentFee > 0
                SET @ProcessingFee = 0.30;
            
            -- Generate payment reference
            SET @PaymentReferenceNumber = 'PAY' + FORMAT(GETDATE(), 'yyyyMMddHHmmss') + CAST(@CustomerID AS NVARCHAR(10));
        END;
        
        -- =====================================================================================
        -- FINAL AMOUNT CALCULATION
        -- =====================================================================================
        
        SET @FinalAmount = @SubtotalAmount - @DiscountAmount + @TaxAmount + @ShippingCost + @ProcessingFee;
        SET @TotalAmount = @FinalAmount;
        
        -- Validate final amount is positive
        IF @FinalAmount <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Final order amount cannot be zero or negative.';
            SET @ErrorCode = 7001;
            GOTO ErrorHandler;
        END;
        
        -- =====================================================================================
        -- ORDER CREATION AND PERSISTENCE
        -- =====================================================================================
        
        -- Create the main order record
        INSERT INTO Orders (
            CustomerID,
            OrderDate,
            ShippingAddressID,
            PaymentMethodID,
            ShippingMethodID,
            SubtotalAmount,
            DiscountAmount,
            TaxAmount,
            ShippingCost,
            ProcessingFee,
            FinalAmount,
            OrderStatusID,
            IsRushOrder,
            TotalWeight,
            TotalVolume,
            EstimatedDeliveryDays,
            CreatedDate,
            CreatedBy
        )
        VALUES (
            @CustomerID,
            @OrderDate,
            @ShippingAddressID,
            @PaymentMethodID,
            @ShippingMethodID,
            @SubtotalAmount,
            @DiscountAmount,
            @TaxAmount,
            @ShippingCost,
            @ProcessingFee,
            @FinalAmount,
            @OrderStatusID,
            @IsRushOrder,
            @TotalWeight,
            @TotalVolume,
            @EstimatedDeliveryDays,
            GETDATE(),
            'SYSTEM'
        );
        
        SET @OrderID = SCOPE_IDENTITY();
        
        -- Create order items
        INSERT INTO OrderItems (
            OrderID,
            ProductID,
            Quantity,
            UnitPrice,
            LineTotal,
            TaxRate,
            LineTaxAmount,
            WarehouseID
        )
        SELECT 
            @OrderID,
            c.ProductID,
            c.Quantity,
            c.UnitPrice,
            c.LineTotal,
            c.TaxRate,
            c.LineTaxAmount,
            ISNULL(ia.WarehouseID, 1) -- Default warehouse if allocation failed
        FROM @Cart c
        LEFT JOIN @InventoryAllocations ia ON c.ProductID = ia.ProductID;
        
        -- Create promotion applications
        INSERT INTO OrderPromotions (OrderID, PromoID, DiscountAmount, DiscountType)
        SELECT @OrderID, PromoID, DiscountAmount, PromoType
        FROM @AppliedPromotions
        WHERE PromoID IS NOT NULL;
        
        -- =====================================================================================
        -- INVENTORY UPDATES AND RESERVATIONS
        -- =====================================================================================
        
        IF @ProcessInventory = 1
        BEGIN
            -- Update inventory quantities
            UPDATE p
            SET p.StockQuantity = p.StockQuantity - c.Quantity,
                p.ReservedQuantity = p.ReservedQuantity + c.Quantity
            FROM Products p
            INNER JOIN @Cart c ON p.ProductID = c.ProductID;
            
            -- Create inventory reservations
            INSERT INTO InventoryReservations (OrderID, ProductID, WarehouseID, ReservedQuantity, ReservationDate)
            SELECT @OrderID, ProductID, WarehouseID, AllocatedQuantity, GETDATE()
            FROM @InventoryAllocations;
        END;
        
        -- =====================================================================================
        -- PAYMENT PROCESSING
        -- =====================================================================================
        
        IF @ProcessPayment = 1
        BEGIN
            -- Create payment record
            INSERT INTO Payments (
                OrderID,
                PaymentMethodID,
                PaymentAmount,
                PaymentFee,
                PaymentStatusID,
                PaymentReferenceNumber,
                PaymentDate,
                IsPreAuthorization
            )
            VALUES (
                @OrderID,
                @PaymentMethodID,
                @FinalAmount,
                @ProcessingFee,
                @PaymentStatusID,
                @PaymentReferenceNumber,
                GETDATE(),
                @IsPaymentPreAuth
            );
            
            -- Update customer balance if using store credit
            IF @PaymentTypeID = 5 -- Store Credit
            BEGIN
                UPDATE Customers
                SET CurrentBalance = CurrentBalance + @FinalAmount
                WHERE CustomerID = @CustomerID;
            END;
        END;
        
        -- =====================================================================================
        -- LOYALTY POINTS CALCULATION
        -- =====================================================================================
        
        IF @ProcessLoyalty = 1
        BEGIN
            -- Calculate loyalty points earned (1 point per dollar spent)
            SET @LoyaltyPointsEarned = FLOOR(@SubtotalAmount);
            
            -- Apply tier multiplier
            SELECT @LoyaltyTierMultiplier = ISNULL(PointsMultiplier, 1.0)
            FROM CustomerTiers
            WHERE TierID = @CustomerTierID;
            
            SET @LoyaltyPointsEarned = @LoyaltyPointsEarned * @LoyaltyTierMultiplier;
            
            -- Update customer loyalty points
            UPDATE Customers
            SET LoyaltyPoints = LoyaltyPoints + @LoyaltyPointsEarned,
                LastOrderDate = @OrderDate
            WHERE CustomerID = @CustomerID;
            
            -- Record loyalty transaction
            INSERT INTO LoyaltyTransactions (CustomerID, OrderID, PointsEarned, TransactionDate, TransactionType)
            VALUES (@CustomerID, @OrderID, @LoyaltyPointsEarned, GETDATE(), 'ORDER_PURCHASE');
        END;
        
        -- =====================================================================================
        -- CUSTOMER TIER EVALUATION AND UPGRADE
        -- =====================================================================================
        
        -- Check if customer qualifies for tier upgrade
        DECLARE @NewCustomerTierID INT = @CustomerTierID;
        
        -- Recalculate lifetime value including this order
        SET @CustomerLifetimeValue = @CustomerLifetimeValue + @FinalAmount;
        SET @CustomerOrderCount = @CustomerOrderCount + 1;
        
        -- Determine new tier based on lifetime value and order count
        SELECT TOP 1 @NewCustomerTierID = TierID
        FROM CustomerTiers
        WHERE MinimumLifetimeValue <= @CustomerLifetimeValue
          AND MinimumOrderCount <= @CustomerOrderCount
        ORDER BY TierID DESC;
        
        -- Update customer tier if changed
        IF @NewCustomerTierID != @CustomerTierID
        BEGIN
            UPDATE Customers
            SET CustomerTierID = @NewCustomerTierID,
                TierUpgradeDate = GETDATE()
            WHERE CustomerID = @CustomerID;
            
            -- Log tier upgrade
            INSERT INTO CustomerLog (CustomerID, LogDate, LogMessage, LogType)
            VALUES (@CustomerID, GETDATE(), 
                   'Customer upgraded from tier ' + CAST(@CustomerTierID AS NVARCHAR(10)) + 
                   ' to tier ' + CAST(@NewCustomerTierID AS NVARCHAR(10)), 
                   'TIER_UPGRADE');
            
            SET @WarningMessages = @WarningMessages + 'Customer tier upgraded. ';
        END;
        
        -- =====================================================================================
        -- RECOMMENDATIONS AND ANALYTICS
        -- =====================================================================================
        
        IF @ProcessRecommendations = 1
        BEGIN
            -- Generate product recommendations based on purchase history
            INSERT INTO CustomerRecommendations (CustomerID, ProductID, RecommendationType, RecommendationScore, CreatedDate)
            SELECT TOP 10
                @CustomerID,
                p.ProductID,
                'FREQUENTLY_BOUGHT_TOGETHER',
                COUNT(*) * 100 / @CustomerOrderCount,
                GETDATE()
            FROM Products p
            INNER JOIN OrderItems oi ON p.ProductID = oi.ProductID
            INNER JOIN Orders o ON oi.OrderID = o.OrderID
            WHERE o.CustomerID = @CustomerID
              AND p.ProductID NOT IN (SELECT ProductID FROM @Cart)
              AND p.IsActive = 1
            GROUP BY p.ProductID
            ORDER BY COUNT(*) DESC;
            
            -- Calculate cross-sell opportunities
            SELECT @CrossSellOpportunities = COUNT(*)
            FROM CustomerRecommendations
            WHERE CustomerID = @CustomerID
              AND CreatedDate >= DATEADD(DAY, -30, GETDATE());
        END;
        
        -- =====================================================================================
        -- TRANSACTION LOGGING AND AUDIT TRAIL
        -- =====================================================================================
        
        -- Create comprehensive transaction log
        INSERT INTO TransactionLog (
            OrderID,
            CustomerID,
            TransactionDate,
            TransactionType,
            Amount,
            PaymentMethodID,
            StatusID,
            ReferenceNumber,
            ProcessingTimeMs
        )
        VALUES (
            @OrderID,
            @CustomerID,
            GETDATE(),
            'ORDER_PLACED',
            @FinalAmount,
            @PaymentMethodID,
            1, -- Success
            @PaymentReferenceNumber,
            DATEDIFF(MILLISECOND, @OrderProcessingStartTime, GETDATE())
        );
        
        SET @TransactionID = SCOPE_IDENTITY();
        
        -- Create audit log entry
        INSERT INTO AuditLog (
            TableName,
            RecordID,
            Action,
            OldValues,
            NewValues,
            ChangedBy,
            ChangeDate,
            AdditionalInfo
        )
        VALUES (
            'Orders',
            @OrderID,
            'INSERT',
            NULL,
            'OrderID: ' + CAST(@OrderID AS NVARCHAR(10)) + ', Amount: ' + CAST(@FinalAmount AS NVARCHAR(20)),
            'SYSTEM',
            GETDATE(),
            'Automated order processing - Customer: ' + CAST(@CustomerID AS NVARCHAR(10))
        );
        
        -- =====================================================================================
        -- NOTIFICATION PROCESSING
        -- =====================================================================================
        
        IF @ProcessNotifications = 1
        BEGIN
            -- Queue order confirmation email
            INSERT INTO NotificationQueue (
                CustomerID,
                NotificationType,
                Subject,
                Message,
                Priority,
                ScheduledDate,
                CreatedDate
            )
            VALUES (
                @CustomerID,
                'ORDER_CONFIRMATION',
                'Order Confirmation #' + CAST(@OrderID AS NVARCHAR(10)),
                'Thank you for your order. Order total: $' + CAST(@FinalAmount AS NVARCHAR(20)),
                'HIGH',
                GETDATE(),
                GETDATE()
            );
            
            -- Queue SMS notification for high-value orders
            IF @FinalAmount >= 500.00
            BEGIN
                INSERT INTO NotificationQueue (
                    CustomerID,
                    NotificationType,
                    Subject,
                    Message,
                    Priority,
                    ScheduledDate,
                    CreatedDate
                )
                VALUES (
                    @CustomerID,
                    'SMS_NOTIFICATION',
                    'High Value Order',
                    'Order #' + CAST(@OrderID AS NVARCHAR(10)) + ' confirmed. Amount: $' + CAST(@FinalAmount AS NVARCHAR(20)),
                    'HIGH',
                    GETDATE(),
                    GETDATE()
                );
            END;
        END;
        
        -- =====================================================================================
        -- EXPANDED REPORTING AND ANALYTICS UPDATES (4X LARGER)
        -- =====================================================================================
        
        IF @ProcessReports = 1
        BEGIN
            -- =====================================================================================
            -- SECTION 1: BASIC SALES AND CUSTOMER ANALYTICS
            -- =====================================================================================
            
            -- Update daily sales summary
            IF EXISTS (SELECT 1 FROM DailySalesSummary WHERE SalesDate = CAST(@OrderDate AS DATE))
            BEGIN
                UPDATE DailySalesSummary
                SET 
                    TotalOrders = TotalOrders + 1,
                    TotalRevenue = TotalRevenue + @FinalAmount,
                    TotalTax = TotalTax + @TaxAmount,
                    TotalShipping = TotalShipping + @ShippingCost,
                    TotalDiscounts = TotalDiscounts + @DiscountAmount,
                    AverageOrderValue = TotalRevenue / TotalOrders,
                    LastUpdated = GETDATE()
                WHERE SalesDate = CAST(@OrderDate AS DATE);
            END
            ELSE
            BEGIN
                INSERT INTO DailySalesSummary (
                    SalesDate, TotalOrders, TotalRevenue, TotalTax, 
                    TotalShipping, TotalDiscounts, AverageOrderValue, LastUpdated
                )
                VALUES (
                    CAST(@OrderDate AS DATE), 1, @FinalAmount, @TaxAmount,
                    @ShippingCost, @DiscountAmount, @FinalAmount, GETDATE()
                );
            END;
            
            -- Update hourly sales tracking
            DECLARE @CurrentHour INT = DATEPART(HOUR, @OrderDate);
            IF EXISTS (SELECT 1 FROM HourlySalesSummary WHERE SalesDate = CAST(@OrderDate AS DATE) AND HourOfDay = @CurrentHour)
            BEGIN
                UPDATE HourlySalesSummary
                SET 
                    TotalOrders = TotalOrders + 1,
                    TotalRevenue = TotalRevenue + @FinalAmount,
                    PeakHourMultiplier = CASE WHEN @CurrentHour BETWEEN 9 AND 17 THEN 1.2 ELSE 1.0 END,
                    LastUpdated = GETDATE()
                WHERE SalesDate = CAST(@OrderDate AS DATE) AND HourOfDay = @CurrentHour;
            END
            ELSE
            BEGIN
                INSERT INTO HourlySalesSummary (
                    SalesDate, HourOfDay, TotalOrders, TotalRevenue, 
                    PeakHourMultiplier, LastUpdated
                )
                VALUES (
                    CAST(@OrderDate AS DATE), @CurrentHour, 1, @FinalAmount,
                    CASE WHEN @CurrentHour BETWEEN 9 AND 17 THEN 1.2 ELSE 1.0 END, GETDATE()
                );
            END;
            
            -- Update customer analytics
            UPDATE CustomerAnalytics
            SET 
                TotalOrders = TotalOrders + 1,
                TotalSpent = TotalSpent + @FinalAmount,
                AverageOrderValue = TotalSpent / TotalOrders,
                LastOrderDate = @OrderDate,
                LastUpdated = GETDATE()
            WHERE CustomerID = @CustomerID;
            
            -- Insert if customer analytics record doesn't exist
            IF @@ROWCOUNT = 0
            BEGIN
                INSERT INTO CustomerAnalytics (
                    CustomerID, TotalOrders, TotalSpent, AverageOrderValue,
                    FirstOrderDate, LastOrderDate, LastUpdated
                )
                VALUES (
                    @CustomerID, 1, @FinalAmount, @FinalAmount,
                    @OrderDate, @OrderDate, GETDATE()
                );
            END;
            
            -- =====================================================================================
            -- SECTION 2: DETAILED PRODUCT AND CATEGORY ANALYTICS
            -- =====================================================================================
            
            -- Update product performance metrics for each item in cart
            DECLARE @ProductAnalyticsCursor CURSOR;
            DECLARE @CurrProductID INT, @CurrQuantity INT, @CurrLineTotal DECIMAL(18,2);
            
            SET @ProductAnalyticsCursor = CURSOR FOR
            SELECT ProductID, Quantity, LineTotal FROM @Cart;
            
            OPEN @ProductAnalyticsCursor;
            FETCH NEXT FROM @ProductAnalyticsCursor INTO @CurrProductID, @CurrQuantity, @CurrLineTotal;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                -- Update product sales statistics
                IF EXISTS (SELECT 1 FROM ProductSalesStats WHERE ProductID = @CurrProductID AND SalesDate = CAST(@OrderDate AS DATE))
                BEGIN
                    UPDATE ProductSalesStats
                    SET 
                        UnitsSold = UnitsSold + @CurrQuantity,
                        TotalRevenue = TotalRevenue + @CurrLineTotal,
                        OrderCount = OrderCount + 1,
                        AverageSellingPrice = TotalRevenue / UnitsSold,
                        LastSoldDate = @OrderDate,
                        Velocity = CASE 
                            WHEN DATEDIFF(DAY, FirstSoldDate, @OrderDate) > 0 
                            THEN UnitsSold / DATEDIFF(DAY, FirstSoldDate, @OrderDate)
                            ELSE UnitsSold 
                        END,
                        LastUpdated = GETDATE()
                    WHERE ProductID = @CurrProductID AND SalesDate = CAST(@OrderDate AS DATE);
                END
                ELSE
                BEGIN
                    INSERT INTO ProductSalesStats (
                        ProductID, SalesDate, UnitsSold, TotalRevenue, OrderCount,
                        AverageSellingPrice, FirstSoldDate, LastSoldDate, Velocity, LastUpdated
                    )
                    VALUES (
                        @CurrProductID, CAST(@OrderDate AS DATE), @CurrQuantity, @CurrLineTotal, 1,
                        @CurrLineTotal / @CurrQuantity, @OrderDate, @OrderDate, @CurrQuantity, GETDATE()
                    );
                END;
                
                -- Update category performance metrics
                DECLARE @CategoryID INT;
                SELECT @CategoryID = CategoryID FROM Products WHERE ProductID = @CurrProductID;
                
                IF EXISTS (SELECT 1 FROM CategorySalesStats WHERE CategoryID = @CategoryID AND SalesDate = CAST(@OrderDate AS DATE))
                BEGIN
                    UPDATE CategorySalesStats
                    SET 
                        TotalOrders = TotalOrders + 1,
                        TotalRevenue = TotalRevenue + @CurrLineTotal,
                        TotalUnits = TotalUnits + @CurrQuantity,
                        AverageOrderValue = TotalRevenue / TotalOrders,
                        MarketShare = (TotalRevenue * 100.0) / (SELECT SUM(TotalRevenue) FROM CategorySalesStats WHERE SalesDate = CAST(@OrderDate AS DATE)),
                        LastUpdated = GETDATE()
                    WHERE CategoryID = @CategoryID AND SalesDate = CAST(@OrderDate AS DATE);
                END
                ELSE
                BEGIN
                    INSERT INTO CategorySalesStats (
                        CategoryID, SalesDate, TotalOrders, TotalRevenue, TotalUnits,
                        AverageOrderValue, MarketShare, LastUpdated
                    )
                    VALUES (
                        @CategoryID, CAST(@OrderDate AS DATE), 1, @CurrLineTotal, @CurrQuantity,
                        @CurrLineTotal, 100.0, GETDATE()
                    );
                END;
                
                -- Update product recommendation scores
                UPDATE ProductRecommendationScores
                SET 
                    PopularityScore = PopularityScore + (@CurrQuantity * 2),
                    RecentSalesWeight = CASE 
                        WHEN DATEDIFF(DAY, LastUpdated, GETDATE()) <= 7 THEN PopularityScore * 1.5
                        WHEN DATEDIFF(DAY, LastUpdated, GETDATE()) <= 30 THEN PopularityScore * 1.2
                        ELSE PopularityScore 
                    END,
                    CrossSellScore = CrossSellScore + 1,
                    LastUpdated = GETDATE()
                WHERE ProductID = @CurrProductID;
                
                IF @@ROWCOUNT = 0
                BEGIN
                    INSERT INTO ProductRecommendationScores (
                        ProductID, PopularityScore, RecentSalesWeight, CrossSellScore, LastUpdated
                    )
                    VALUES (@CurrProductID, @CurrQuantity * 2, @CurrQuantity * 2, 1, GETDATE());
                END;
                
                FETCH NEXT FROM @ProductAnalyticsCursor INTO @CurrProductID, @CurrQuantity, @CurrLineTotal;
            END;
            
            CLOSE @ProductAnalyticsCursor;
            DEALLOCATE @ProductAnalyticsCursor;
            
            -- =====================================================================================
            -- SECTION 3: CUSTOMER SEGMENTATION AND BEHAVIOR ANALYSIS
            -- =====================================================================================
            
            -- Update customer segmentation scores
            DECLARE @SegmentScore INT = 0;
            DECLARE @FrequencyScore INT = 0;
            DECLARE @MonetaryScore INT = 0;
            DECLARE @RecencyScore INT = 0;
            
            -- Calculate Recency score (days since last order)
            SET @RecencyScore = CASE 
                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 30 THEN 5
                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 90 THEN 4
                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 180 THEN 3
                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 365 THEN 2
                ELSE 1
            END;
            
            -- Calculate Frequency score (number of orders)
            SET @FrequencyScore = CASE 
                WHEN @CustomerOrderCount >= 50 THEN 5
                WHEN @CustomerOrderCount >= 20 THEN 4
                WHEN @CustomerOrderCount >= 10 THEN 3
                WHEN @CustomerOrderCount >= 5 THEN 2
                ELSE 1
            END;
            
            -- Calculate Monetary score (lifetime value)
            SET @MonetaryScore = CASE 
                WHEN @CustomerLifetimeValue >= 10000 THEN 5
                WHEN @CustomerLifetimeValue >= 5000 THEN 4
                WHEN @CustomerLifetimeValue >= 2000 THEN 3
                WHEN @CustomerLifetimeValue >= 500 THEN 2
                ELSE 1
            END;
            
            SET @SegmentScore = (@RecencyScore * 100) + (@FrequencyScore * 10) + @MonetaryScore;
            
            -- Update customer RFM analysis
            IF EXISTS (SELECT 1 FROM CustomerRFMAnalysis WHERE CustomerID = @CustomerID)
            BEGIN
                UPDATE CustomerRFMAnalysis
                SET 
                    RecencyScore = @RecencyScore,
                    FrequencyScore = @FrequencyScore,
                    MonetaryScore = @MonetaryScore,
                    RFMScore = @SegmentScore,
                    CustomerSegment = CASE 
                        WHEN @SegmentScore >= 555 THEN 'Champions'
                        WHEN @SegmentScore >= 454 THEN 'Loyal Customers'
                        WHEN @SegmentScore >= 344 THEN 'Potential Loyalists'
                        WHEN @SegmentScore >= 234 THEN 'New Customers'
                        WHEN @SegmentScore >= 223 THEN 'Promising'
                        WHEN @SegmentScore >= 155 THEN 'Need Attention'
                        WHEN @SegmentScore >= 144 THEN 'About to Sleep'
                        WHEN @SegmentScore >= 123 THEN 'At Risk'
                        WHEN @SegmentScore >= 122 THEN 'Cannot Lose Them'
                        ELSE 'Hibernating'
                    END,
                    LastAnalysisDate = @OrderDate,
                    NextReviewDate = DATEADD(DAY, 30, @OrderDate),
                    LastUpdated = GETDATE()
                WHERE CustomerID = @CustomerID;
            END
            ELSE
            BEGIN
                INSERT INTO CustomerRFMAnalysis (
                    CustomerID, RecencyScore, FrequencyScore, MonetaryScore, RFMScore,
                    CustomerSegment, LastAnalysisDate, NextReviewDate, LastUpdated
                )
                VALUES (
                    @CustomerID, @RecencyScore, @FrequencyScore, @MonetaryScore, @SegmentScore,
                    CASE 
                        WHEN @SegmentScore >= 555 THEN 'Champions'
                        WHEN @SegmentScore >= 454 THEN 'Loyal Customers'
                        WHEN @SegmentScore >= 344 THEN 'Potential Loyalists'
                        WHEN @SegmentScore >= 234 THEN 'New Customers'
                        WHEN @SegmentScore >= 223 THEN 'Promising'
                        WHEN @SegmentScore >= 155 THEN 'Need Attention'
                        WHEN @SegmentScore >= 144 THEN 'About to Sleep'
                        WHEN @SegmentScore >= 123 THEN 'At Risk'
                        WHEN @SegmentScore >= 122 THEN 'Cannot Lose Them'
                        ELSE 'Hibernating'
                    END,
                    @OrderDate, DATEADD(DAY, 30, @OrderDate), GETDATE()
                );
            END;
            
            -- Update customer behavior tracking
            DECLARE @PurchasePattern NVARCHAR(100);
            DECLARE @ShoppingTimePreference NVARCHAR(50);
            DECLARE @SeasonalTrend NVARCHAR(50);
            
            SET @ShoppingTimePreference = CASE 
                WHEN @CurrentHour BETWEEN 6 AND 12 THEN 'Morning Shopper'
                WHEN @CurrentHour BETWEEN 12 AND 17 THEN 'Afternoon Shopper'
                WHEN @CurrentHour BETWEEN 17 AND 22 THEN 'Evening Shopper'
                ELSE 'Night Owl'
            END;
            
            SET @SeasonalTrend = CASE 
                WHEN MONTH(@OrderDate) IN (12, 1, 2) THEN 'Winter'
                WHEN MONTH(@OrderDate) IN (3, 4, 5) THEN 'Spring'
                WHEN MONTH(@OrderDate) IN (6, 7, 8) THEN 'Summer'
                ELSE 'Fall'
            END;
            
            SET @PurchasePattern = CASE 
                WHEN @FinalAmount > @CustomerLifetimeValue / @CustomerOrderCount * 2 THEN 'High Value Purchase'
                WHEN @FinalAmount > @CustomerLifetimeValue / @CustomerOrderCount * 1.5 THEN 'Above Average Purchase'
                WHEN @FinalAmount > @CustomerLifetimeValue / @CustomerOrderCount * 0.5 THEN 'Average Purchase'
                ELSE 'Low Value Purchase'
            END;
            
            INSERT INTO CustomerBehaviorTracking (
                CustomerID, OrderID, PurchasePattern, ShoppingTimePreference,
                SeasonalTrend, DeviceType, PaymentPreference, ShippingPreference,
                OrderValue, OrderDate, CreatedDate
            )
            VALUES (
                @CustomerID, @OrderID, @PurchasePattern, @ShoppingTimePreference,
                @SeasonalTrend, 'Web', 
                (SELECT PaymentTypeName FROM PaymentTypes WHERE PaymentTypeID = @PaymentTypeID),
                (SELECT MethodName FROM ShippingMethods WHERE MethodID = @ShippingMethodID),
                @FinalAmount, @OrderDate, GETDATE()
            );
            
            -- =====================================================================================
            -- SECTION 4: ADVANCED INVENTORY AND SUPPLY CHAIN ANALYTICS
            -- =====================================================================================
            
            -- Update inventory turnover analytics
            DECLARE @InventoryAnalyticsCursor CURSOR;
            DECLARE @CurrWarehouseID INT, @CurrAllocatedQty INT;
            
            SET @InventoryAnalyticsCursor = CURSOR FOR
            SELECT DISTINCT WarehouseID, SUM(AllocatedQuantity) 
            FROM @InventoryAllocations 
            GROUP BY WarehouseID;
            
            OPEN @InventoryAnalyticsCursor;
            FETCH NEXT FROM @InventoryAnalyticsCursor INTO @CurrWarehouseID, @CurrAllocatedQty;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                -- Update warehouse performance metrics
                IF EXISTS (SELECT 1 FROM WarehousePerformanceMetrics WHERE WarehouseID = @CurrWarehouseID AND MetricDate = CAST(@OrderDate AS DATE))
                BEGIN
                    UPDATE WarehousePerformanceMetrics
                    SET 
                        OrdersFulfilled = OrdersFulfilled + 1,
                        UnitsShipped = UnitsShipped + @CurrAllocatedQty,
                        FulfillmentEfficiency = (OrdersFulfilled * 100.0) / (OrdersFulfilled + BackordersCreated),
                        CapacityUtilization = (UnitsShipped * 100.0) / MaxDailyCapacity,
                        LastUpdated = GETDATE()
                    WHERE WarehouseID = @CurrWarehouseID AND MetricDate = CAST(@OrderDate AS DATE);
                END
                ELSE
                BEGIN
                    INSERT INTO WarehousePerformanceMetrics (
                        WarehouseID, MetricDate, OrdersFulfilled, UnitsShipped,
                        FulfillmentEfficiency, CapacityUtilization, BackordersCreated,
                        MaxDailyCapacity, LastUpdated
                    )
                    VALUES (
                        @CurrWarehouseID, CAST(@OrderDate AS DATE), 1, @CurrAllocatedQty,
                        100.0, 50.0, 0, 1000, GETDATE()
                    );
                END;
                
                -- Update inventory velocity calculations
                UPDATE InventoryVelocityMetrics
                SET 
                    DailyMovement = DailyMovement + @CurrAllocatedQty,
                    WeeklyVelocity = DailyMovement * 7,
                    MonthlyVelocity = DailyMovement * 30,
                    TurnoverRate = CASE 
                        WHEN AvailableStock > 0 THEN (DailyMovement * 365.0) / AvailableStock
                        ELSE 0 
                    END,
                    ReorderPoint = (DailyMovement * LeadTimeDays) + SafetyStock,
                    LastMovementDate = @OrderDate,
                    LastUpdated = GETDATE()
                WHERE WarehouseID = @CurrWarehouseID;
                
                FETCH NEXT FROM @InventoryAnalyticsCursor INTO @CurrWarehouseID, @CurrAllocatedQty;
            END;
            
            CLOSE @InventoryAnalyticsCursor;
            DEALLOCATE @InventoryAnalyticsCursor;
            
            -- Update supply chain efficiency metrics
            INSERT INTO SupplyChainEvents (
                EventType, EventDate, OrderID, CustomerID, WarehouseID,
                ProductID, Quantity, ProcessingTime, EventStatus, CreatedDate
            )
            SELECT 
                'ORDER_ALLOCATION',
                @OrderDate,
                @OrderID,
                @CustomerID,
                ia.WarehouseID,
                ia.ProductID,
                ia.AllocatedQuantity,
                DATEDIFF(MILLISECOND, @OrderProcessingStartTime, GETDATE()),
                'COMPLETED',
                GETDATE()
            FROM @InventoryAllocations ia;
            
            -- =====================================================================================
            -- SECTION 5: MARKETING AND PROMOTION EFFECTIVENESS TRACKING
            -- =====================================================================================
            
            -- Track promotion usage and effectiveness
            IF EXISTS (SELECT 1 FROM @AppliedPromotions)
            BEGIN
                DECLARE @PromoEffectivenessCursor CURSOR;
                DECLARE @CurrPromoID INT, @CurrDiscountAmount DECIMAL(18,2);
                
                SET @PromoEffectivenessCursor = CURSOR FOR
                SELECT PromoID, DiscountAmount FROM @AppliedPromotions;
                
                OPEN @PromoEffectivenessCursor;
                FETCH NEXT FROM @PromoEffectivenessCursor INTO @CurrPromoID, @CurrDiscountAmount;
                
                WHILE @@FETCH_STATUS = 0
                BEGIN
                    -- Update promotion effectiveness metrics
                    IF EXISTS (SELECT 1 FROM PromotionEffectivenessMetrics WHERE PromoID = @CurrPromoID AND UsageDate = CAST(@OrderDate AS DATE))
                    BEGIN
                        UPDATE PromotionEffectivenessMetrics
                        SET 
                            UsageCount = UsageCount + 1,
                            TotalDiscount = TotalDiscount + @CurrDiscountAmount,
                            TotalOrderValue = TotalOrderValue + @FinalAmount,
                            AverageOrderValue = TotalOrderValue / UsageCount,
                            ConversionRate = (UsageCount * 100.0) / ViewCount,
                            ROI = ((TotalOrderValue - TotalDiscount) / TotalDiscount) * 100,
                            LastUsedDate = @OrderDate,
                            LastUpdated = GETDATE()
                        WHERE PromoID = @CurrPromoID AND UsageDate = CAST(@OrderDate AS DATE);
                    END
                    ELSE
                    BEGIN
                        INSERT INTO PromotionEffectivenessMetrics (
                            PromoID, UsageDate, UsageCount, TotalDiscount, TotalOrderValue,
                            AverageOrderValue, ConversionRate, ROI, ViewCount,
                            LastUsedDate, LastUpdated
                        )
                        VALUES (
                            @CurrPromoID, CAST(@OrderDate AS DATE), 1, @CurrDiscountAmount, @FinalAmount,
                            @FinalAmount, 100.0, 
                            ((@FinalAmount - @CurrDiscountAmount) / @CurrDiscountAmount) * 100,
                            1, @OrderDate, GETDATE()
                        );
                    END;
                    
                    -- Update customer promotion affinity
                    IF EXISTS (SELECT 1 FROM CustomerPromotionAffinity WHERE CustomerID = @CustomerID AND PromoID = @CurrPromoID)
                    BEGIN
                        UPDATE CustomerPromotionAffinity
                        SET 
                            UsageCount = UsageCount + 1,
                            TotalSavings = TotalSavings + @CurrDiscountAmount,
                            LastUsedDate = @OrderDate,
                            AffinityScore = CASE 
                                WHEN UsageCount >= 10 THEN 'High'
                                WHEN UsageCount >= 5 THEN 'Medium'
                                ELSE 'Low'
                            END,
                            LastUpdated = GETDATE()
                        WHERE CustomerID = @CustomerID AND PromoID = @CurrPromoID;
                    END
                    ELSE
                    BEGIN
                        INSERT INTO CustomerPromotionAffinity (
                            CustomerID, PromoID, UsageCount, TotalSavings,
                            LastUsedDate, AffinityScore, LastUpdated
                        )
                        VALUES (
                            @CustomerID, @CurrPromoID, 1, @CurrDiscountAmount,
                            @OrderDate, 'Low', GETDATE()
                        );
                    END;
                    
                    FETCH NEXT FROM @PromoEffectivenessCursor INTO @CurrPromoID, @CurrDiscountAmount;
                END;
                
                CLOSE @PromoEffectivenessCursor;
                DEALLOCATE @PromoEffectivenessCursor;
            END;
            
            -- =====================================================================================
            -- SECTION 6: FINANCIAL AND REVENUE ANALYTICS
            -- =====================================================================================
            
            -- Update revenue recognition and financial tracking
            DECLARE @RevenueRecognitionDate DATE = @OrderDate;
            DECLARE @DeferredRevenue DECIMAL(18,2) = 0;
            DECLARE @RecognizedRevenue DECIMAL(18,2) = @FinalAmount;
            
            -- Check for digital vs physical products for revenue recognition
            IF EXISTS (SELECT 1 FROM @Cart WHERE IsDigital = 1)
            BEGIN
                -- Immediate revenue recognition for digital products
                SET @RecognizedRevenue = (SELECT SUM(LineTotal) FROM @Cart WHERE IsDigital = 1);
                SET @DeferredRevenue = @FinalAmount - @RecognizedRevenue;
            END;
            
            -- Update financial summary
            IF EXISTS (SELECT 1 FROM FinancialSummary WHERE ReportDate = CAST(@OrderDate AS DATE))
            BEGIN
                UPDATE FinancialSummary
                SET 
                    GrossRevenue = GrossRevenue + @FinalAmount,
                    NetRevenue = NetRevenue + (@FinalAmount - @DiscountAmount),
                    TotalTax = TotalTax + @TaxAmount,
                    ShippingRevenue = ShippingRevenue + @ShippingCost,
                    ProcessingFees = ProcessingFees + @ProcessingFee,
                    DiscountsGiven = DiscountsGiven + @DiscountAmount,
                    RecognizedRevenue = RecognizedRevenue + @RecognizedRevenue,
                    DeferredRevenue = DeferredRevenue + @DeferredRevenue,
                    OrderCount = OrderCount + 1,
                    AverageOrderValue = GrossRevenue / OrderCount,
                    LastUpdated = GETDATE()
                WHERE ReportDate = CAST(@OrderDate AS DATE);
            END
            ELSE
            BEGIN
                INSERT INTO FinancialSummary (
                    ReportDate, GrossRevenue, NetRevenue, TotalTax, ShippingRevenue,
                    ProcessingFees, DiscountsGiven, RecognizedRevenue, DeferredRevenue,
                    OrderCount, AverageOrderValue, LastUpdated
                )
                VALUES (
                    CAST(@OrderDate AS DATE), @FinalAmount, @FinalAmount - @DiscountAmount,
                    @TaxAmount, @ShippingCost, @ProcessingFee, @DiscountAmount,
                    @RecognizedRevenue, @DeferredRevenue, 1, @FinalAmount, GETDATE()
                );
            END;
            
            -- Update profit margin analysis
            DECLARE @TotalCOGS DECIMAL(18,2) = 0;
            SELECT @TotalCOGS = SUM(p.CostPrice * c.Quantity)
            FROM @Cart c
            INNER JOIN Products p ON c.ProductID = p.ProductID;
            
            DECLARE @GrossProfit DECIMAL(18,2) = @FinalAmount - @TotalCOGS;
            DECLARE @GrossProfitMargin DECIMAL(8,4) = CASE WHEN @FinalAmount > 0 THEN (@GrossProfit / @FinalAmount) * 100 ELSE 0 END;
            
            INSERT INTO ProfitMarginAnalysis (
                OrderID, CustomerID, OrderDate, GrossRevenue, COGS, GrossProfit,
                GrossProfitMargin, ShippingCost, ProcessingFees, NetProfit,
                NetProfitMargin, CreatedDate
            )
            VALUES (
                @OrderID, @CustomerID, @OrderDate, @FinalAmount, @TotalCOGS, @GrossProfit,
                @GrossProfitMargin, @ShippingCost, @ProcessingFee, 
                @GrossProfit - @ShippingCost - @ProcessingFee,
                CASE WHEN @FinalAmount > 0 THEN ((@GrossProfit - @ShippingCost - @ProcessingFee) / @FinalAmount) * 100 ELSE 0 END,
                GETDATE()
            );
            
        END;
        
        -- =====================================================================================
        -- SUCCESS COMPLETION
        -- =====================================================================================
        
        -- Commit the transaction
        COMMIT TRANSACTION;
        
        -- Set success message
        SET @ErrorMessage = 'Order processed successfully. Order ID: ' + CAST(@OrderID AS NVARCHAR(10));
        
        -- Final cleanup and summary
        IF LEN(@WarningMessages) > 0
        BEGIN
            SET @WarningMessages = 'Warnings: ' + @WarningMessages;
        END;
        
        RETURN 0; -- Success
        
    END TRY
    BEGIN CATCH
        -- =====================================================================================
        -- COMPREHENSIVE ERROR HANDLING
        -- =====================================================================================
        
        -- Rollback transaction on any error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @IsValid = 0;
        SET @ErrorCode = ERROR_NUMBER();
        SET @ErrorMessage = 'Error processing order: ' + ERROR_MESSAGE() + 
                           ' (Error ' + CAST(@ErrorCode AS NVARCHAR(10)) + 
                           ' at Line ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
        
        -- Log the error
        INSERT INTO ErrorLog (
            ErrorCode,
            ErrorMessage,
            ErrorLine,
            ErrorProcedure,
            ErrorSeverity,
            ErrorState,
            LogDate,
            CustomerID,
            OrderID,
            AdditionalInfo
        )
        VALUES (
            @ErrorCode,
            @ErrorMessage,
            ERROR_LINE(),
            ERROR_PROCEDURE(),
            ERROR_SEVERITY(),
            ERROR_STATE(),
            GETDATE(),
            @CustomerID,
            @OrderID,
            'Automated error capture during order processing'
        );
        
        GOTO ErrorHandler;
        
    END CATCH;
    
    -- =====================================================================================
    -- CUSTOM ERROR HANDLER
    -- =====================================================================================
    
    ErrorHandler:
    IF @IsValid = 0
    BEGIN
        -- Additional error handling for specific error codes
        IF @ErrorCode BETWEEN 1000 AND 1999 -- Input validation errors
        BEGIN
            SET @ErrorMessage = '[INPUT_ERROR] ' + @ErrorMessage;
        END
        ELSE IF @ErrorCode BETWEEN 2000 AND 2999 -- Customer validation errors
        BEGIN
            SET @ErrorMessage = '[CUSTOMER_ERROR] ' + @ErrorMessage;
        END
        ELSE IF @ErrorCode BETWEEN 3000 AND 3999 -- Shipping/Address errors
        BEGIN
            SET @ErrorMessage = '[SHIPPING_ERROR] ' + @ErrorMessage;
        END
        ELSE IF @ErrorCode BETWEEN 4000 AND 4999 -- Payment errors
        BEGIN
            SET @ErrorMessage = '[PAYMENT_ERROR] ' + @ErrorMessage;
        END
        ELSE IF @ErrorCode BETWEEN 5000 AND 5999 -- Product/Cart errors
        BEGIN
            SET @ErrorMessage = '[PRODUCT_ERROR] ' + @ErrorMessage;
        END
        ELSE IF @ErrorCode BETWEEN 6000 AND 6999 -- Promotion errors
        BEGIN
            SET @ErrorMessage = '[PROMOTION_ERROR] ' + @ErrorMessage;
        END
        ELSE IF @ErrorCode BETWEEN 7000 AND 7999 -- Calculation errors
        BEGIN
            SET @ErrorMessage = '[CALCULATION_ERROR] ' + @ErrorMessage;
        END;
        
        -- Ensure transaction is rolled back
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Set output parameters for error state
        SET @OrderID = NULL;
        SET @TotalAmount = 0;
        
        RETURN -1; -- Error
    END;
    
    RETURN 0; -- Success
END;
GO 