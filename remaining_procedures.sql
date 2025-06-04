-- Procedure 4: Complex Order Processing with Multi-Level Validation
CREATE PROCEDURE sp_ProcessComplexOrder
    @CustomerID INT,
    @OrderItems NVARCHAR(MAX), -- JSON format
    @ShippingAddressID INT = NULL,
    @BillingAddressID INT = NULL,
    @PaymentMethodID INT = NULL,
    @ShippingMethodID INT = 1,
    @PromoCode NVARCHAR(20) = NULL,
    @SpecialInstructions NVARCHAR(MAX) = NULL,
    @IsRushOrder BIT = 0,
    @RequestedDeliveryDate DATETIME = NULL,
    @CreatedBy INT,
    @NewOrderID INT OUTPUT,
    @OrderSummary NVARCHAR(MAX) OUTPUT,
    @StatusMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorCode INT = 0;
    DECLARE @ValidationResult BIT = 1;
    DECLARE @OrderDate DATETIME = GETDATE();
    DECLARE @CustomerTypeID INT;
    DECLARE @CustomerStatus VARCHAR(20);
    DECLARE @CreditLimit DECIMAL(18,2);
    DECLARE @CurrentBalance DECIMAL(18,2);
    DECLARE @OrderTotal DECIMAL(18,2) = 0.00;
    DECLARE @TotalTax DECIMAL(18,2) = 0.00;
    DECLARE @TotalShipping DECIMAL(18,2) = 0.00;
    DECLARE @TotalDiscount DECIMAL(18,2) = 0.00;
    DECLARE @FinalAmount DECIMAL(18,2) = 0.00;
    DECLARE @ShippingZoneID INT;
    DECLARE @ItemCount INT = 0;
    DECLARE @ProcessedItems INT = 0;
    DECLARE @FailedItems INT = 0;
    DECLARE @BackorderItems INT = 0;
    DECLARE @OrderStatusID INT = 1; -- Pending
    DECLARE @EstimatedShipDate DATETIME;
    DECLARE @TrackingNumber NVARCHAR(50);
    DECLARE @FraudRiskScore DECIMAL(5,2) = 0.00;
    
    -- Temporary table for order items
    CREATE TABLE #OrderItems (
        RowID INT IDENTITY(1,1),
        ProductID INT,
        Quantity INT,
        UnitPrice DECIMAL(18,2),
        CalculatedPrice DECIMAL(18,2),
        DiscountAmount DECIMAL(18,2),
        TaxAmount DECIMAL(18,2),
        ShippingCost DECIMAL(18,2),
        LineTotal DECIMAL(18,2),
        SpecialInstructions NVARCHAR(500),
        AllocationResults NVARCHAR(MAX),
        ProcessingStatus VARCHAR(20) DEFAULT 'PENDING',
        ErrorMessage NVARCHAR(500)
    );
    
    -- Temporary table for inventory allocations
    CREATE TABLE #InventoryAllocations (
        ProductID INT,
        WarehouseID INT,
        AllocatedQuantity INT,
        ReservationID INT
    );
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Phase 1: Customer Validation and Credit Check
        SELECT 
            @CustomerTypeID = CustomerTypeID,
            @CustomerStatus = AccountStatus,
            @CreditLimit = CreditLimit,
            @CurrentBalance = CurrentBalance
        FROM Customers
        WHERE CustomerID = @CustomerID AND IsDeleted = 0;
        
        IF @CustomerTypeID IS NULL
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Customer not found or has been deleted.';
            SET @ErrorCode = 4001;
            GOTO ErrorHandler;
        END;
        
        IF @CustomerStatus != 'ACTIVE'
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Customer account is not active. Status: ' + @CustomerStatus;
            SET @ErrorCode = 4002;
            GOTO ErrorHandler;
        END;
        
        -- Parse and validate order items from JSON (simplified for demo)
        IF @OrderItems IS NULL OR LEN(TRIM(@OrderItems)) = 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Order items are required.';
            SET @ErrorCode = 4003;
            GOTO ErrorHandler;
        END;
        
        -- Simplified JSON parsing for demo
        DECLARE @ProductID INT, @Quantity INT, @Instructions NVARCHAR(500);
        DECLARE @ItemPosition INT = 1;
        
        WHILE @ItemPosition <= 5 -- Demo: process 5 items
        BEGIN
            SET @ProductID = @ItemPosition;
            SET @Quantity = @ItemPosition + 1;
            SET @Instructions = 'Demo item ' + CAST(@ItemPosition AS NVARCHAR(10));
            
            IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND IsActive = 1)
            BEGIN
                INSERT INTO #OrderItems (ProductID, Quantity, SpecialInstructions)
                VALUES (@ProductID, @Quantity, @Instructions);
                SET @ItemCount = @ItemCount + 1;
            END;
            
            SET @ItemPosition = @ItemPosition + 1;
        END;
        
        IF @ItemCount = 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'No valid products found in order items.';
            SET @ErrorCode = 4004;
            GOTO ErrorHandler;
        END;
        
        -- Phase 2: Address Validation and Fraud Detection
        IF @ShippingAddressID IS NULL
        BEGIN
            SELECT @ShippingAddressID = AddressID
            FROM CustomerAddresses
            WHERE CustomerID = @CustomerID AND AddressType = 'SHIPPING' AND IsDefault = 1;
        END;
        
        IF @BillingAddressID IS NULL
        BEGIN
            SELECT @BillingAddressID = AddressID
            FROM CustomerAddresses
            WHERE CustomerID = @CustomerID AND AddressType = 'BILLING' AND IsDefault = 1;
        END;
        
        -- Get shipping zone
        SELECT @ShippingZoneID = ISNULL(ZoneID, 1)
        FROM Addresses a
        LEFT JOIN ShippingZones sz ON a.StateID = sz.StateID
        WHERE a.AddressID = @ShippingAddressID;
        
        -- Phase 3: Process Each Order Item with Complex Pricing
        DECLARE item_cursor CURSOR FOR
        SELECT RowID, ProductID, Quantity, SpecialInstructions
        FROM #OrderItems
        WHERE ProcessingStatus = 'PENDING';
        
        DECLARE @CurrentRowID INT, @CurrentProductID INT, @CurrentQuantity INT, @CurrentInstructions NVARCHAR(500);
        DECLARE @ItemPrice DECIMAL(18,2), @ItemDiscount DECIMAL(18,2), @ItemTax DECIMAL(18,2), @ItemShipping DECIMAL(18,2), @ItemTotal DECIMAL(18,2);
        DECLARE @PricingBreakdown NVARCHAR(MAX), @PricingStatus NVARCHAR(500);
        
        OPEN item_cursor;
        FETCH NEXT FROM item_cursor INTO @CurrentRowID, @CurrentProductID, @CurrentQuantity, @CurrentInstructions;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Calculate dynamic pricing for this item
            EXEC sp_CalculateDynamicPricing
                @ProductID = @CurrentProductID,
                @CustomerID = @CustomerID,
                @Quantity = @CurrentQuantity,
                @OrderDate = @OrderDate,
                @PromoCode = @PromoCode,
                @ShippingZoneID = @ShippingZoneID,
                @CalculatedPrice = @ItemPrice OUTPUT,
                @DiscountAmount = @ItemDiscount OUTPUT,
                @TaxAmount = @ItemTax OUTPUT,
                @ShippingCost = @ItemShipping OUTPUT,
                @FinalAmount = @ItemTotal OUTPUT,
                @PricingBreakdown = @PricingBreakdown OUTPUT,
                @StatusMessage = @PricingStatus OUTPUT;
            
            IF @@ERROR = 0
            BEGIN
                -- Pricing successful, now check inventory allocation
                DECLARE @AllocationResults NVARCHAR(MAX), @AllocationStatus NVARCHAR(500);
                
                EXEC sp_ManageInventoryAcrossWarehouses
                    @Action = 'ALLOCATE',
                    @ProductID = @CurrentProductID,
                    @Quantity = @CurrentQuantity,
                    @CustomerPriorityLevel = @CustomerTypeID,
                    @ShippingZoneID = @ShippingZoneID,
                    @CreatedBy = @CreatedBy,
                    @AllocationResults = @AllocationResults OUTPUT,
                    @StatusMessage = @AllocationStatus OUTPUT;
                
                IF @@ERROR = 0
                BEGIN
                    -- Both pricing and allocation successful
                    UPDATE #OrderItems
                    SET UnitPrice = @ItemPrice / @CurrentQuantity,
                        CalculatedPrice = @ItemPrice,
                        DiscountAmount = @ItemDiscount,
                        TaxAmount = @ItemTax,
                        ShippingCost = @ItemShipping,
                        LineTotal = @ItemTotal,
                        AllocationResults = @AllocationResults,
                        ProcessingStatus = 'SUCCESS'
                    WHERE RowID = @CurrentRowID;
                    
                    SET @ProcessedItems = @ProcessedItems + 1;
                    SET @OrderTotal = @OrderTotal + @ItemPrice;
                    SET @TotalDiscount = @TotalDiscount + @ItemDiscount;
                    SET @TotalTax = @TotalTax + @ItemTax;
                    SET @TotalShipping = @TotalShipping + @ItemShipping;
                END
                ELSE
                BEGIN
                    -- Allocation failed
                    IF @AllocationStatus LIKE '%Insufficient%'
                    BEGIN
                        UPDATE #OrderItems
                        SET ProcessingStatus = 'BACKORDER',
                            ErrorMessage = @AllocationStatus
                        WHERE RowID = @CurrentRowID;
                        SET @BackorderItems = @BackorderItems + 1;
                    END
                    ELSE
                    BEGIN
                        UPDATE #OrderItems
                        SET ProcessingStatus = 'FAILED',
                            ErrorMessage = @AllocationStatus
                        WHERE RowID = @CurrentRowID;
                        SET @FailedItems = @FailedItems + 1;
                    END;
                END;
            END
            ELSE
            BEGIN
                -- Pricing failed
                UPDATE #OrderItems
                SET ProcessingStatus = 'FAILED',
                    ErrorMessage = @PricingStatus
                WHERE RowID = @CurrentRowID;
                SET @FailedItems = @FailedItems + 1;
            END;
            
            FETCH NEXT FROM item_cursor INTO @CurrentRowID, @CurrentProductID, @CurrentQuantity, @CurrentInstructions;
        END;
        
        CLOSE item_cursor;
        DEALLOCATE item_cursor;
        
        -- Phase 4: Order-Level Validation and Fraud Check
        SET @FinalAmount = @OrderTotal + @TotalTax + @TotalShipping - @TotalDiscount;
        
        -- Calculate fraud risk score
        SET @FraudRiskScore = dbo.fn_CalculateFraudRiskScore(
            @CustomerID, @FinalAmount, @ShippingAddressID, 
            @BillingAddressID, @PaymentMethodID, @OrderDate
        );
        
        -- High fraud risk handling
        IF @FraudRiskScore > 75.0
        BEGIN
            SET @OrderStatusID = 7; -- Fraud Review
            INSERT INTO FraudAlerts (
                CustomerID, OrderAmount, RiskScore, AlertReason,
                CreatedDate, CreatedBy
            )
            VALUES (
                @CustomerID, @FinalAmount, @FraudRiskScore,
                'High fraud risk score: ' + CAST(@FraudRiskScore AS NVARCHAR(10)),
                GETDATE(), @CreatedBy
            );
        END
        ELSE IF @FraudRiskScore > 50.0
        BEGIN
            SET @OrderStatusID = 5; -- Pending Review
        END;
        
        -- Credit limit check
        IF (@CurrentBalance + @FinalAmount) > @CreditLimit
        BEGIN
            DECLARE @CreditNeeded DECIMAL(18,2) = (@CurrentBalance + @FinalAmount) - @CreditLimit;
            
            IF @CustomerTypeID = 2 AND @CreditNeeded <= 500.00
            BEGIN
                SET @OrderStatusID = 5; -- Pending Review for VIP overage
            END
            ELSE
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Insufficient credit limit. Required: $' + CAST(@FinalAmount AS NVARCHAR(20));
                SET @ErrorCode = 4005;
                GOTO ErrorHandler;
            END;
        END;
        
        -- Phase 5: Create Order Record
        INSERT INTO Orders (
            CustomerID, OrderDate, OrderStatusID, ShippingAddressID, BillingAddressID,
            PaymentMethodID, ShippingMethodID, PromoCode, SpecialInstructions,
            IsRushOrder, RequestedDeliveryDate, SubTotal, TaxAmount, ShippingAmount,
            DiscountAmount, FinalAmount, FraudRiskScore, CreatedDate, CreatedBy
        )
        VALUES (
            @CustomerID, @OrderDate, @OrderStatusID, @ShippingAddressID, @BillingAddressID,
            @PaymentMethodID, @ShippingMethodID, @PromoCode, @SpecialInstructions,
            @IsRushOrder, @RequestedDeliveryDate, @OrderTotal, @TotalTax, @TotalShipping,
            @TotalDiscount, @FinalAmount, @FraudRiskScore, GETDATE(), @CreatedBy
        );
        
        SET @NewOrderID = SCOPE_IDENTITY();
        
        -- Phase 6: Create Order Line Items
        INSERT INTO OrderLineItems (
            OrderID, ProductID, Quantity, UnitPrice, LineTotal,
            DiscountAmount, TaxAmount, SpecialInstructions, CreatedDate, CreatedBy
        )
        SELECT 
            @NewOrderID, ProductID, Quantity, UnitPrice, LineTotal,
            DiscountAmount, TaxAmount, SpecialInstructions, GETDATE(), @CreatedBy
        FROM #OrderItems
        WHERE ProcessingStatus IN ('SUCCESS', 'BACKORDER');
        
        -- Phase 7: Handle Backorders
        IF @BackorderItems > 0
        BEGIN
            INSERT INTO BackorderItems (
                OrderID, ProductID, QuantityBackordered, 
                EstimatedAvailableDate, CreatedDate, CreatedBy
            )
            SELECT 
                @NewOrderID, ProductID, Quantity,
                DATEADD(DAY, 7, GETDATE()), GETDATE(), @CreatedBy
            FROM #OrderItems
            WHERE ProcessingStatus = 'BACKORDER';
            
            IF @ProcessedItems > 0
                SET @OrderStatusID = 3; -- Partially Shipped
            ELSE
                SET @OrderStatusID = 4; -- Backordered
            
            UPDATE Orders SET OrderStatusID = @OrderStatusID WHERE OrderID = @NewOrderID;
        END;
        
        -- Phase 8: Payment Processing
        IF @PaymentMethodID IS NOT NULL AND @OrderStatusID IN (1, 5) -- Pending or Review
        BEGIN
            DECLARE @PaymentResult BIT = 0;
            
            -- Complex payment approval logic
            IF @FinalAmount <= 1000.00 AND @FraudRiskScore < 25.0
                SET @PaymentResult = 1;
            ELSE IF @CustomerTypeID IN (2, 5, 6) AND @FraudRiskScore < 50.0
                SET @PaymentResult = 1;
            ELSE IF @FinalAmount <= 5000.00 AND DATEPART(HOUR, GETDATE()) BETWEEN 9 AND 17 AND @FraudRiskScore < 40.0
                SET @PaymentResult = 1;
            
            IF @PaymentResult = 1
            BEGIN
                INSERT INTO PaymentTransactions (
                    OrderID, PaymentMethodID, Amount, TransactionType,
                    TransactionStatus, ProcessedDate, CreatedBy
                )
                VALUES (
                    @NewOrderID, @PaymentMethodID, @FinalAmount, 'CHARGE',
                    'APPROVED', GETDATE(), @CreatedBy
                );
                
                UPDATE Customers SET CurrentBalance = CurrentBalance + @FinalAmount WHERE CustomerID = @CustomerID;
                UPDATE Orders SET OrderStatusID = 2 WHERE OrderID = @NewOrderID; -- Confirmed
                SET @OrderStatusID = 2;
            END
            ELSE
            BEGIN
                INSERT INTO PaymentTransactions (
                    OrderID, PaymentMethodID, Amount, TransactionType,
                    TransactionStatus, ProcessedDate, CreatedBy
                )
                VALUES (
                    @NewOrderID, @PaymentMethodID, @FinalAmount, 'CHARGE',
                    'PENDING_REVIEW', GETDATE(), @CreatedBy
                );
            END;
        END;
        
        -- Phase 9: Shipping and Logistics
        IF @OrderStatusID = 2 -- Confirmed orders
        BEGIN
            DECLARE @ProcessingDays INT = CASE 
                WHEN @IsRushOrder = 1 THEN 0
                WHEN @ItemCount > 10 THEN 2
                ELSE 1
            END;
            
            DECLARE @ShippingDays INT = 3;
            SELECT @ShippingDays = ISNULL(EstimatedDays, 3)
            FROM ShippingMethods WHERE MethodID = @ShippingMethodID;
            
            SET @EstimatedShipDate = DATEADD(DAY, @ProcessingDays, @OrderDate);
            SET @TrackingNumber = 'TRK' + CAST(@NewOrderID AS NVARCHAR(10)) + 
                                 FORMAT(GETDATE(), 'yyyyMMdd') + 
                                 RIGHT('000' + CAST(ABS(CHECKSUM(NEWID())) % 1000 AS NVARCHAR(3)), 3);
            
            INSERT INTO Shipments (
                OrderID, TrackingNumber, ShippingMethodID, EstimatedShipDate,
                EstimatedDeliveryDate, ShipmentStatus, CreatedDate, CreatedBy
            )
            VALUES (
                @NewOrderID, @TrackingNumber, @ShippingMethodID, @EstimatedShipDate,
                DATEADD(DAY, @ShippingDays, @EstimatedShipDate), 'PREPARING', GETDATE(), @CreatedBy
            );
        END;
        
        -- Phase 10: Generate Order Summary
        SET @OrderSummary = 'Order #' + CAST(@NewOrderID AS NVARCHAR(10)) + ' created. ' +
                           'Items: ' + CAST(@ProcessedItems AS NVARCHAR(10)) + ' processed, ' +
                           CAST(@BackorderItems AS NVARCHAR(10)) + ' backordered, ' +
                           CAST(@FailedItems AS NVARCHAR(10)) + ' failed. ' +
                           'Total: $' + CAST(@FinalAmount AS NVARCHAR(20)) + '. ' +
                           'Fraud Score: ' + CAST(@FraudRiskScore AS NVARCHAR(10)) + '. ' +
                           CASE WHEN @TrackingNumber IS NOT NULL THEN 'Tracking: ' + @TrackingNumber + '. ' ELSE '' END +
                           'Status: ' + CASE @OrderStatusID
                               WHEN 1 THEN 'Pending' WHEN 2 THEN 'Confirmed' WHEN 3 THEN 'Partially Shipped'
                               WHEN 4 THEN 'Backordered' WHEN 5 THEN 'Pending Review' WHEN 7 THEN 'Fraud Review'
                               ELSE 'Unknown' END;
        
        -- Phase 11: Audit and Logging
        INSERT INTO OrderAuditLog (
            OrderID, ActionType, ActionDescription, CreatedDate, CreatedBy
        )
        VALUES (
            @NewOrderID, 'ORDER_CREATED',
            'Order created: ' + CAST(@ItemCount AS NVARCHAR(10)) + ' items, $' + CAST(@FinalAmount AS NVARCHAR(20)) + 
            ', Fraud Score: ' + CAST(@FraudRiskScore AS NVARCHAR(10)),
            GETDATE(), @CreatedBy
        );
        
        -- Phase 12: Trigger Downstream Processes
        IF @OrderStatusID = 2 -- Confirmed orders
        BEGIN
            EXEC sp_UpdateInventoryLevels @NewOrderID, @CreatedBy;
            EXEC sp_SendOrderConfirmationNotification @NewOrderID, @CreatedBy;
            EXEC sp_UpdateCustomerStatistics @CustomerID, @FinalAmount, @CreatedBy;
        END;
        
        SET @StatusMessage = 'Order processed successfully. ' + @OrderSummary;
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        SET @StatusMessage = 'Error processing order: ' + ERROR_MESSAGE();
        INSERT INTO ErrorLog (ErrorCode, ErrorMessage, ProcedureName, LineNumber, Severity, LogDate, CustomerID)
        VALUES (ERROR_NUMBER(), @StatusMessage, 'sp_ProcessComplexOrder', ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @CustomerID);
        RETURN -1;
    END CATCH;
    
    ErrorHandler:
    IF @ValidationResult = 0
    BEGIN
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        RETURN @ErrorCode;
    END;
    
    -- Cleanup
    IF OBJECT_ID('tempdb..#OrderItems') IS NOT NULL DROP TABLE #OrderItems;
    IF OBJECT_ID('tempdb..#InventoryAllocations') IS NOT NULL DROP TABLE #InventoryAllocations;
END;
GO

-- Additional Function 5: Complex Fraud Detection
CREATE FUNCTION dbo.fn_CalculateFraudRiskScore
(
    @CustomerID INT,
    @OrderAmount DECIMAL(18,2),
    @ShippingAddressID INT,
    @BillingAddressID INT,
    @PaymentMethodID INT,
    @OrderTime DATETIME
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @RiskScore DECIMAL(5,2) = 0.00;
    DECLARE @CustomerAge INT = 0;
    DECLARE @OrderHistory INT = 0;
    DECLARE @AverageOrderValue DECIMAL(18,2) = 0;
    DECLARE @RecentOrderCount INT = 0;
    DECLARE @VelocityRisk DECIMAL(3,2) = 0;
    DECLARE @AmountRisk DECIMAL(3,2) = 0;
    
    -- Customer analysis
    SELECT 
        @CustomerAge = DATEDIFF(DAY, CreatedDate, GETDATE()),
        @OrderHistory = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @CustomerID),
        @AverageOrderValue = (SELECT AVG(FinalAmount) FROM Orders WHERE CustomerID = @CustomerID AND OrderStatusID IN (2,3,6))
    FROM Customers WHERE CustomerID = @CustomerID;
    
    -- New customer risk
    IF @CustomerAge < 30 SET @RiskScore = @RiskScore + 15.00;
    ELSE IF @CustomerAge < 90 SET @RiskScore = @RiskScore + 8.00;
    
    -- Order history risk
    IF @OrderHistory = 0 SET @RiskScore = @RiskScore + 20.00;
    ELSE IF @OrderHistory < 5 SET @RiskScore = @RiskScore + 10.00;
    
    -- Amount variance analysis
    IF @AverageOrderValue > 0
    BEGIN
        DECLARE @AmountVariance DECIMAL(5,2) = ABS(@OrderAmount - @AverageOrderValue) / @AverageOrderValue;
        IF @AmountVariance > 5.0 SET @AmountRisk = 25.00;
        ELSE IF @AmountVariance > 2.0 SET @AmountRisk = 15.00;
        ELSE IF @AmountVariance > 1.0 SET @AmountRisk = 8.00;
        SET @RiskScore = @RiskScore + @AmountRisk;
    END;
    
    -- Velocity check
    SELECT @RecentOrderCount = COUNT(*) FROM Orders
    WHERE CustomerID = @CustomerID AND OrderDate >= DATEADD(HOUR, -24, @OrderTime);
    
    IF @RecentOrderCount > 5 SET @VelocityRisk = 30.00;
    ELSE IF @RecentOrderCount > 3 SET @VelocityRisk = 20.00;
    ELSE IF @RecentOrderCount > 1 SET @VelocityRisk = 10.00;
    SET @RiskScore = @RiskScore + @VelocityRisk;
    
    -- Address mismatch
    IF @ShippingAddressID != @BillingAddressID
    BEGIN
        DECLARE @ShippingState INT, @BillingState INT;
        SELECT @ShippingState = StateID FROM Addresses WHERE AddressID = @ShippingAddressID;
        SELECT @BillingState = StateID FROM Addresses WHERE AddressID = @BillingAddressID;
        
        IF @ShippingState != @BillingState SET @RiskScore = @RiskScore + 12.00;
        ELSE SET @RiskScore = @RiskScore + 5.00;
    END;
    
    -- Time-based risk
    DECLARE @OrderHour INT = DATEPART(HOUR, @OrderTime);
    IF @OrderHour BETWEEN 0 AND 5 OR @OrderHour BETWEEN 23 AND 24
        SET @RiskScore = @RiskScore + 8.00;
    
    -- Weekend risk
    IF DATEPART(WEEKDAY, @OrderTime) IN (1, 7)
        SET @RiskScore = @RiskScore + 3.00;
    
    -- Payment method risk
    DECLARE @PaymentRisk DECIMAL(3,2) = 1.0;
    SELECT @PaymentRisk = ISNULL(RiskMultiplier, 1.0) FROM PaymentMethods WHERE MethodID = @PaymentMethodID;
    SET @RiskScore = @RiskScore * @PaymentRisk;
    
    -- Geographic risk
    DECLARE @HighRiskZone BIT = 0;
    SELECT @HighRiskZone = ISNULL(IsHighRiskZone, 0)
    FROM Addresses a LEFT JOIN GeographicRiskZones grz ON a.StateID = grz.StateID
    WHERE a.AddressID = @ShippingAddressID;
    
    IF @HighRiskZone = 1 SET @RiskScore = @RiskScore + 15.00;
    
    -- Cap at 100
    IF @RiskScore > 100.00 SET @RiskScore = 100.00;
    
    RETURN @RiskScore;
END;
GO

-- Supporting procedures for the main order processing
CREATE PROCEDURE sp_UpdateInventoryLevels
    @OrderID INT,
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TotalProcessed INT = 0;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Update inventory for confirmed orders
        UPDATE i SET 
            QuantityReserved = QuantityReserved - oli.Quantity,
            QuantityShipped = QuantityShipped + oli.Quantity,
            LastModifiedDate = GETDATE(),
            LastModifiedBy = @CreatedBy
        FROM Inventory i
        INNER JOIN OrderLineItems oli ON i.ProductID = oli.ProductID
        INNER JOIN Orders o ON oli.OrderID = o.OrderID
        WHERE o.OrderID = @OrderID AND o.OrderStatusID = 2;
        
        SET @TotalProcessed = @@ROWCOUNT;
        
        -- Update order to shipped status
        UPDATE Orders SET 
            OrderStatusID = 6, 
            ShippedDate = GETDATE(),
            LastModifiedDate = GETDATE(),
            LastModifiedBy = @CreatedBy
        WHERE OrderID = @OrderID AND OrderStatusID = 2;
        
        COMMIT TRANSACTION;
        RETURN @TotalProcessed;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        INSERT INTO ErrorLog (ErrorCode, ErrorMessage, ProcedureName, LineNumber, Severity, LogDate)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), 'sp_UpdateInventoryLevels', ERROR_LINE(), ERROR_SEVERITY(), GETDATE());
        RETURN -1;
    END CATCH;
END;
GO

CREATE PROCEDURE sp_SendOrderConfirmationNotification
    @OrderID INT,
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @CustomerID INT, @CustomerEmail NVARCHAR(100), @OrderTotal DECIMAL(18,2);
    
    BEGIN TRY
        SELECT @CustomerID = o.CustomerID, @CustomerEmail = c.Email, @OrderTotal = o.FinalAmount
        FROM Orders o INNER JOIN Customers c ON o.CustomerID = c.CustomerID
        WHERE o.OrderID = @OrderID;
        
        INSERT INTO NotificationQueue (CustomerID, NotificationType, RecipientEmail, Subject, MessageBody, Priority, CreatedDate, CreatedBy)
        VALUES (@CustomerID, 'ORDER_CONFIRMATION', @CustomerEmail,
                'Order Confirmation #' + CAST(@OrderID AS NVARCHAR(10)),
                'Your order has been confirmed. Total: $' + CAST(@OrderTotal AS NVARCHAR(20)),
                'NORMAL', GETDATE(), @CreatedBy);
        
        RETURN SCOPE_IDENTITY();
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (ErrorCode, ErrorMessage, ProcedureName, LineNumber, Severity, LogDate)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), 'sp_SendOrderConfirmationNotification', ERROR_LINE(), ERROR_SEVERITY(), GETDATE());
        RETURN -1;
    END CATCH;
END;
GO

CREATE PROCEDURE sp_UpdateCustomerStatistics
    @CustomerID INT,
    @OrderAmount DECIMAL(18,2),
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @OrderCount INT, @TotalSpent DECIMAL(18,2), @NewTier VARCHAR(20);
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        SELECT @OrderCount = COUNT(*), @TotalSpent = SUM(FinalAmount)
        FROM Orders WHERE CustomerID = @CustomerID AND OrderStatusID IN (2, 3, 6);
        
        -- Determine tier
        IF @TotalSpent >= 50000 AND @OrderCount >= 100 SET @NewTier = 'PLATINUM';
        ELSE IF @TotalSpent >= 20000 AND @OrderCount >= 50 SET @NewTier = 'GOLD';
        ELSE IF @TotalSpent >= 5000 AND @OrderCount >= 20 SET @NewTier = 'SILVER';
        ELSE IF @TotalSpent >= 1000 AND @OrderCount >= 5 SET @NewTier = 'BRONZE';
        ELSE SET @NewTier = 'STANDARD';
        
        -- Update or insert statistics
        IF EXISTS (SELECT 1 FROM CustomerStatistics WHERE CustomerID = @CustomerID)
        BEGIN
            UPDATE CustomerStatistics SET 
                TotalOrders = @OrderCount,
                TotalSpent = @TotalSpent,
                CustomerTier = @NewTier,
                LastUpdated = GETDATE(),
                UpdatedBy = @CreatedBy
            WHERE CustomerID = @CustomerID;
        END
        ELSE
        BEGIN
            INSERT INTO CustomerStatistics (CustomerID, TotalOrders, TotalSpent, CustomerTier, CreatedDate, CreatedBy)
            VALUES (@CustomerID, @OrderCount, @TotalSpent, @NewTier, GETDATE(), @CreatedBy);
        END;
        
        COMMIT TRANSACTION;
        RETURN 0;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        INSERT INTO ErrorLog (ErrorCode, ErrorMessage, ProcedureName, LineNumber, Severity, LogDate, CustomerID)
        VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), 'sp_UpdateCustomerStatistics', ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @CustomerID);
        RETURN -1;
    END CATCH;
END;
GO

-- =====================================================================================
-- END OF COMPLEX E-COMMERCE SYSTEM
-- Total Procedures: 7 (Customer Management, Inventory Management, Dynamic Pricing, 
--                     Complex Order Processing, Inventory Updates, Notifications, 
--                     Customer Statistics)
-- Total Functions: 5 (Tax Calculation, Shipping Calculation, Credit Validation,
--                     Inventory Allocation, Fraud Detection)
-- ===================================================================================== 