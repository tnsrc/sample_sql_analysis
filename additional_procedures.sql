-- Procedure 4: Complex Order Processing with Multi-Level Validation
CREATE PROCEDURE sp_ProcessComplexOrder
    @CustomerID INT,
    @OrderItems NVARCHAR(MAX), -- JSON format: [{"ProductID":1,"Quantity":5,"SpecialInstructions":""}]
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
        
        -- Parse and validate order items from JSON
        IF @OrderItems IS NULL OR LEN(TRIM(@OrderItems)) = 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Order items are required.';
            SET @ErrorCode = 4003;
            GOTO ErrorHandler;
        END;
        
        -- Parse JSON order items (simplified parsing for demo)
        -- In real implementation, use JSON functions or XML parsing
        DECLARE @ProductID INT, @Quantity INT, @Instructions NVARCHAR(500);
        DECLARE @ItemPosition INT = 1;
        DECLARE @ItemString NVARCHAR(MAX) = @OrderItems;
        
        -- Simplified JSON parsing loop (in production, use proper JSON parsing)
        WHILE @ItemPosition <= LEN(@ItemString)
        BEGIN
            -- Extract ProductID and Quantity from JSON-like string
            -- This is a simplified version - real implementation would use JSON_VALUE
            SET @ProductID = 1 + (@ItemPosition % 10); -- Demo data
            SET @Quantity = 1 + (@ItemPosition % 5);
            SET @Instructions = 'Item ' + CAST(@ItemPosition AS NVARCHAR(10));
            
            -- Validate product exists and is active
            IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND IsActive = 1)
            BEGIN
                INSERT INTO #OrderItems (ProductID, Quantity, SpecialInstructions)
                VALUES (@ProductID, @Quantity, @Instructions);
                
                SET @ItemCount = @ItemCount + 1;
            END;
            
            SET @ItemPosition = @ItemPosition + 100; -- Demo increment
            IF @ItemCount >= 5 BREAK; -- Limit for demo
        END;
        
        IF @ItemCount = 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'No valid products found in order items.';
            SET @ErrorCode = 4004;
            GOTO ErrorHandler;
        END;
        
        -- Phase 2: Address Validation
        IF @ShippingAddressID IS NULL
        BEGIN
            -- Use customer's default shipping address
            SELECT @ShippingAddressID = AddressID
            FROM CustomerAddresses
            WHERE CustomerID = @CustomerID AND AddressType = 'SHIPPING' AND IsDefault = 1;
        END;
        
        IF @BillingAddressID IS NULL
        BEGIN
            -- Use customer's default billing address
            SELECT @BillingAddressID = AddressID
            FROM CustomerAddresses
            WHERE CustomerID = @CustomerID AND AddressType = 'BILLING' AND IsDefault = 1;
        END;
        
        -- Get shipping zone from address
        SELECT @ShippingZoneID = ZoneID
        FROM Addresses a
        INNER JOIN ShippingZones sz ON a.StateID = sz.StateID
        WHERE a.AddressID = @ShippingAddressID;
        
        IF @ShippingZoneID IS NULL
            SET @ShippingZoneID = 1; -- Default zone
        
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
                    -- Allocation failed - check if partial allocation or backorder
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
        
        -- Phase 4: Order-Level Validation and Credit Check
        SET @FinalAmount = @OrderTotal + @TotalTax + @TotalShipping - @TotalDiscount;
        
        -- Check if customer has sufficient credit
        IF (@CurrentBalance + @FinalAmount) > @CreditLimit
        BEGIN
            DECLARE @CreditNeeded DECIMAL(18,2) = (@CurrentBalance + @FinalAmount) - @CreditLimit;
            
            -- For VIP customers, allow small overages
            IF @CustomerTypeID = 2 AND @CreditNeeded <= 500.00
            BEGIN
                -- Allow VIP overage but flag for review
                SET @OrderStatusID = 5; -- Pending Review
            END
            ELSE
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Insufficient credit limit. Required: $' + CAST(@FinalAmount AS NVARCHAR(20)) + 
                                   ', Available: $' + CAST(@CreditLimit - @CurrentBalance AS NVARCHAR(20));
                SET @ErrorCode = 4005;
                GOTO ErrorHandler;
            END;
        END;
        
        -- Phase 5: Create Order Record
        INSERT INTO Orders (
            CustomerID, OrderDate, OrderStatusID, ShippingAddressID, BillingAddressID,
            PaymentMethodID, ShippingMethodID, PromoCode, SpecialInstructions,
            IsRushOrder, RequestedDeliveryDate, SubTotal, TaxAmount, ShippingAmount,
            DiscountAmount, FinalAmount, CreatedDate, CreatedBy
        )
        VALUES (
            @CustomerID, @OrderDate, @OrderStatusID, @ShippingAddressID, @BillingAddressID,
            @PaymentMethodID, @ShippingMethodID, @PromoCode, @SpecialInstructions,
            @IsRushOrder, @RequestedDeliveryDate, @OrderTotal, @TotalTax, @TotalShipping,
            @TotalDiscount, @FinalAmount, GETDATE(), @CreatedBy
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
            -- Create backorder records
            INSERT INTO BackorderItems (
                OrderID, ProductID, QuantityBackordered, 
                EstimatedAvailableDate, CreatedDate, CreatedBy
            )
            SELECT 
                @NewOrderID, ProductID, Quantity,
                DATEADD(DAY, 7, GETDATE()), GETDATE(), @CreatedBy
            FROM #OrderItems
            WHERE ProcessingStatus = 'BACKORDER';
            
            -- Update order status if any items are backordered
            IF @ProcessedItems > 0
                SET @OrderStatusID = 3; -- Partially Shipped
            ELSE
                SET @OrderStatusID = 4; -- Backordered
            
            UPDATE Orders
            SET OrderStatusID = @OrderStatusID
            WHERE OrderID = @NewOrderID;
        END;
        
        -- Phase 8: Payment Processing Simulation
        IF @PaymentMethodID IS NOT NULL AND @OrderStatusID = 1 -- Only for pending orders
        BEGIN
            DECLARE @PaymentResult BIT = 0;
            DECLARE @PaymentMessage NVARCHAR(500);
            
            -- Simulate payment processing with complex logic
            IF @FinalAmount <= 1000.00
                SET @PaymentResult = 1; -- Auto-approve small amounts
            ELSE IF @CustomerTypeID IN (2, 5, 6) -- VIP, Corporate, Wholesale
                SET @PaymentResult = 1; -- Auto-approve for premium customers
            ELSE IF @FinalAmount <= 5000.00 AND DATEPART(HOUR, GETDATE()) BETWEEN 9 AND 17
                SET @PaymentResult = 1; -- Auto-approve medium amounts during business hours
            ELSE
                SET @PaymentResult = 0; -- Require manual review
            
            IF @PaymentResult = 1
            BEGIN
                -- Payment approved
                INSERT INTO PaymentTransactions (
                    OrderID, PaymentMethodID, Amount, TransactionType,
                    TransactionStatus, ProcessedDate, CreatedBy
                )
                VALUES (
                    @NewOrderID, @PaymentMethodID, @FinalAmount, 'CHARGE',
                    'APPROVED', GETDATE(), @CreatedBy
                );
                
                -- Update customer balance
                UPDATE Customers
                SET CurrentBalance = CurrentBalance + @FinalAmount
                WHERE CustomerID = @CustomerID;
                
                -- Update order status to confirmed
                UPDATE Orders
                SET OrderStatusID = 2 -- Confirmed
                WHERE OrderID = @NewOrderID;
                
                SET @PaymentMessage = 'Payment processed successfully.';
            END
            ELSE
            BEGIN
                -- Payment requires review
                INSERT INTO PaymentTransactions (
                    OrderID, PaymentMethodID, Amount, TransactionType,
                    TransactionStatus, ProcessedDate, CreatedBy
                )
                VALUES (
                    @NewOrderID, @PaymentMethodID, @FinalAmount, 'CHARGE',
                    'PENDING_REVIEW', GETDATE(), @CreatedBy
                );
                
                SET @PaymentMessage = 'Payment requires manual review.';
                SET @OrderStatusID = 5; -- Pending Review
                
                UPDATE Orders
                SET OrderStatusID = @OrderStatusID
                WHERE OrderID = @NewOrderID;
            END;
        END;
        
        -- Phase 9: Shipping and Logistics
        IF @OrderStatusID = 2 -- Confirmed orders
        BEGIN
            -- Calculate estimated ship date based on processing time and shipping method
            DECLARE @ProcessingDays INT = 1; -- Default processing time
            DECLARE @ShippingDays INT = 3; -- Default shipping time
            
            -- Adjust based on order complexity and rush status
            IF @ItemCount > 10
                SET @ProcessingDays = @ProcessingDays + 1;
            
            IF @IsRushOrder = 1
                SET @ProcessingDays = 0; -- Rush orders ship same day
            
            -- Get shipping method details
            SELECT @ShippingDays = EstimatedDays
            FROM ShippingMethods
            WHERE MethodID = @ShippingMethodID;
            
            SET @EstimatedShipDate = DATEADD(DAY, @ProcessingDays, @OrderDate);
            
            -- Generate tracking number
            SET @TrackingNumber = 'TRK' + CAST(@NewOrderID AS NVARCHAR(10)) + 
                                 FORMAT(GETDATE(), 'yyyyMMdd') + 
                                 RIGHT('000' + CAST(ABS(CHECKSUM(NEWID())) % 1000 AS NVARCHAR(3)), 3);
            
            -- Create shipment record
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
        SET @OrderSummary = 'Order #' + CAST(@NewOrderID AS NVARCHAR(10)) + ' created successfully. ' +
                           'Items: ' + CAST(@ProcessedItems AS NVARCHAR(10)) + ' processed, ' +
                           CAST(@BackorderItems AS NVARCHAR(10)) + ' backordered, ' +
                           CAST(@FailedItems AS NVARCHAR(10)) + ' failed. ' +
                           'Total: $' + CAST(@FinalAmount AS NVARCHAR(20)) + '. ' +
                           CASE 
                               WHEN @TrackingNumber IS NOT NULL THEN 'Tracking: ' + @TrackingNumber + '. '
                               ELSE ''
                           END +
                           'Status: ' + CASE @OrderStatusID
                               WHEN 1 THEN 'Pending'
                               WHEN 2 THEN 'Confirmed'
                               WHEN 3 THEN 'Partially Shipped'
                               WHEN 4 THEN 'Backordered'
                               WHEN 5 THEN 'Pending Review'
                               ELSE 'Unknown'
                           END;
        
        -- Phase 11: Audit and Logging
        INSERT INTO OrderAuditLog (
            OrderID, ActionType, ActionDescription, 
            CreatedDate, CreatedBy
        )
        VALUES (
            @NewOrderID, 'ORDER_CREATED',
            'Order created with ' + CAST(@ItemCount AS NVARCHAR(10)) + ' items. ' +
            'Processing result: ' + CAST(@ProcessedItems AS NVARCHAR(10)) + ' success, ' +
            CAST(@BackorderItems AS NVARCHAR(10)) + ' backorder, ' +
            CAST(@FailedItems AS NVARCHAR(10)) + ' failed.',
            GETDATE(), @CreatedBy
        );
        
        -- Phase 12: Trigger Downstream Processes
        IF @OrderStatusID = 2 -- Confirmed orders
        BEGIN
            -- Trigger inventory updates
            DECLARE @InventoryUpdateResult INT;
            EXEC @InventoryUpdateResult = sp_UpdateInventoryLevels @NewOrderID, @CreatedBy;
            
            -- Trigger notification system
            EXEC sp_SendOrderConfirmationNotification @NewOrderID, @CreatedBy;
            
            -- Update customer statistics
            EXEC sp_UpdateCustomerStatistics @CustomerID, @FinalAmount, @CreatedBy;
        END;
        
        SET @StatusMessage = 'Order processed successfully. ' + @OrderSummary;
        
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ValidationResult = 0;
        SET @StatusMessage = 'Error processing order: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
        
        -- Log the error
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate, CustomerID
        )
        VALUES (
            @ErrorCode, @StatusMessage, 'sp_ProcessComplexOrder',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @CustomerID
        );
        
        RETURN -1;
    END CATCH;
    
    ErrorHandler:
    IF @ValidationResult = 0
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        -- Release any allocated inventory
        IF EXISTS (SELECT 1 FROM #InventoryAllocations)
        BEGIN
            DECLARE @ReleaseProductID INT, @ReleaseWarehouseID INT, @ReleaseQuantity INT;
            DECLARE release_cursor CURSOR FOR
            SELECT ProductID, WarehouseID, AllocatedQuantity
            FROM #InventoryAllocations;
            
            OPEN release_cursor;
            FETCH NEXT FROM release_cursor INTO @ReleaseProductID, @ReleaseWarehouseID, @ReleaseQuantity;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                EXEC sp_ManageInventoryAcrossWarehouses
                    @Action = 'RELEASE',
                    @ProductID = @ReleaseProductID,
                    @Quantity = @ReleaseQuantity,
                    @TargetWarehouseID = @ReleaseWarehouseID,
                    @CreatedBy = @CreatedBy,
                    @AllocationResults = NULL,
                    @StatusMessage = NULL;
                
                FETCH NEXT FROM release_cursor INTO @ReleaseProductID, @ReleaseWarehouseID, @ReleaseQuantity;
            END;
            
            CLOSE release_cursor;
            DEALLOCATE release_cursor;
        END;
        
        RETURN @ErrorCode;
    END;
    
    -- Cleanup temporary tables
    IF OBJECT_ID('tempdb..#OrderItems') IS NOT NULL
        DROP TABLE #OrderItems;
    
    IF OBJECT_ID('tempdb..#InventoryAllocations') IS NOT NULL
        DROP TABLE #InventoryAllocations;
END;
GO

-- Procedure 5: Update Inventory Levels After Order Processing
CREATE PROCEDURE sp_UpdateInventoryLevels
    @OrderID INT,
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ProductID INT, @Quantity INT;
    DECLARE @WarehouseID INT, @AllocatedQty INT;
    DECLARE @TotalProcessed INT = 0;
    DECLARE @ErrorCount INT = 0;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Process each order line item
        DECLARE item_cursor CURSOR FOR
        SELECT oli.ProductID, oli.Quantity
        FROM OrderLineItems oli
        INNER JOIN Orders o ON oli.OrderID = o.OrderID
        WHERE o.OrderID = @OrderID AND o.OrderStatusID = 2; -- Confirmed orders only
        
        OPEN item_cursor;
        FETCH NEXT FROM item_cursor INTO @ProductID, @Quantity;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Move reserved inventory to shipped
            DECLARE warehouse_cursor CURSOR FOR
            SELECT iad.WarehouseID, iad.AllocatedQuantity
            FROM InventoryAllocationDetails iad
            INNER JOIN InventoryTransactions it ON iad.TransactionID = it.TransactionID
            WHERE it.ProductID = @ProductID
              AND iad.AllocationDate >= (SELECT OrderDate FROM Orders WHERE OrderID = @OrderID)
              AND iad.AllocatedQuantity <= @Quantity;
            
            OPEN warehouse_cursor;
            FETCH NEXT FROM warehouse_cursor INTO @WarehouseID, @AllocatedQty;
            
            WHILE @@FETCH_STATUS = 0 AND @Quantity > 0
            BEGIN
                DECLARE @QtyToProcess INT = CASE 
                    WHEN @AllocatedQty <= @Quantity THEN @AllocatedQty 
                    ELSE @Quantity 
                END;
                
                -- Update inventory: move from reserved to shipped
                UPDATE Inventory
                SET QuantityReserved = QuantityReserved - @QtyToProcess,
                    QuantityShipped = QuantityShipped + @QtyToProcess,
                    LastModifiedDate = GETDATE(),
                    LastModifiedBy = @CreatedBy
                WHERE ProductID = @ProductID AND WarehouseID = @WarehouseID;
                
                SET @Quantity = @Quantity - @QtyToProcess;
                SET @TotalProcessed = @TotalProcessed + @QtyToProcess;
                
                FETCH NEXT FROM warehouse_cursor INTO @WarehouseID, @AllocatedQty;
            END;
            
            CLOSE warehouse_cursor;
            DEALLOCATE warehouse_cursor;
            
            FETCH NEXT FROM item_cursor INTO @ProductID, @Quantity;
        END;
        
        CLOSE item_cursor;
        DEALLOCATE item_cursor;
        
        -- Update order status to shipped if all items processed
        IF @ErrorCount = 0
        BEGIN
            UPDATE Orders
            SET OrderStatusID = 6, -- Shipped
                ShippedDate = GETDATE(),
                LastModifiedDate = GETDATE(),
                LastModifiedBy = @CreatedBy
            WHERE OrderID = @OrderID;
        END;
        
        COMMIT TRANSACTION;
        RETURN @TotalProcessed;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate
        )
        VALUES (
            ERROR_NUMBER(), ERROR_MESSAGE(), 'sp_UpdateInventoryLevels',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE()
        );
        
        RETURN -1;
    END CATCH;
END;
GO

-- Procedure 6: Send Order Confirmation Notification
CREATE PROCEDURE sp_SendOrderConfirmationNotification
    @OrderID INT,
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @CustomerID INT, @CustomerEmail NVARCHAR(100), @CustomerName NVARCHAR(100);
    DECLARE @OrderTotal DECIMAL(18,2), @TrackingNumber NVARCHAR(50);
    DECLARE @PreferredContactMethod VARCHAR(10);
    DECLARE @NotificationID INT;
    
    BEGIN TRY
        -- Get order and customer information
        SELECT 
            @CustomerID = o.CustomerID,
            @CustomerEmail = c.Email,
            @CustomerName = c.FirstName + ' ' + c.LastName,
            @OrderTotal = o.FinalAmount,
            @PreferredContactMethod = c.PreferredContactMethod,
            @TrackingNumber = s.TrackingNumber
        FROM Orders o
        INNER JOIN Customers c ON o.CustomerID = c.CustomerID
        LEFT JOIN Shipments s ON o.OrderID = s.OrderID
        WHERE o.OrderID = @OrderID;
        
        -- Create notification record
        INSERT INTO NotificationQueue (
            CustomerID, NotificationType, RecipientEmail, 
            Subject, MessageBody, Priority, CreatedDate, CreatedBy
        )
        VALUES (
            @CustomerID, 'ORDER_CONFIRMATION', @CustomerEmail,
            'Order Confirmation #' + CAST(@OrderID AS NVARCHAR(10)),
            'Dear ' + @CustomerName + ', your order #' + CAST(@OrderID AS NVARCHAR(10)) + 
            ' has been confirmed. Total: $' + CAST(@OrderTotal AS NVARCHAR(20)) + 
            CASE WHEN @TrackingNumber IS NOT NULL THEN '. Tracking: ' + @TrackingNumber ELSE '' END,
            'NORMAL', GETDATE(), @CreatedBy
        );
        
        SET @NotificationID = SCOPE_IDENTITY();
        
        -- If customer prefers SMS, also create SMS notification
        IF @PreferredContactMethod = 'SMS'
        BEGIN
            INSERT INTO SMSQueue (
                CustomerID, PhoneNumber, MessageText, 
                Priority, CreatedDate, CreatedBy
            )
            SELECT 
                @CustomerID, c.Phone,
                'Order #' + CAST(@OrderID AS NVARCHAR(10)) + ' confirmed. Total: $' + CAST(@OrderTotal AS NVARCHAR(20)),
                'NORMAL', GETDATE(), @CreatedBy
            FROM Customers c
            WHERE c.CustomerID = @CustomerID AND c.Phone IS NOT NULL;
        END;
        
        RETURN @NotificationID;
        
    END TRY
    BEGIN CATCH
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate
        )
        VALUES (
            ERROR_NUMBER(), ERROR_MESSAGE(), 'sp_SendOrderConfirmationNotification',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE()
        );
        
        RETURN -1;
    END CATCH;
END;
GO

-- Procedure 7: Update Customer Statistics
CREATE PROCEDURE sp_UpdateCustomerStatistics
    @CustomerID INT,
    @OrderAmount DECIMAL(18,2),
    @CreatedBy INT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @OrderCount INT, @TotalSpent DECIMAL(18,2);
    DECLARE @LastOrderDate DATETIME, @AverageOrderValue DECIMAL(18,2);
    DECLARE @CustomerTier VARCHAR(20), @NewTier VARCHAR(20);
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Calculate updated statistics
        SELECT 
            @OrderCount = COUNT(*),
            @TotalSpent = SUM(FinalAmount),
            @LastOrderDate = MAX(OrderDate),
            @AverageOrderValue = AVG(FinalAmount)
        FROM Orders
        WHERE CustomerID = @CustomerID AND OrderStatusID IN (2, 3, 6); -- Confirmed, Partial, Shipped
        
        -- Determine new customer tier
        IF @TotalSpent >= 50000 AND @OrderCount >= 100
            SET @NewTier = 'PLATINUM';
        ELSE IF @TotalSpent >= 20000 AND @OrderCount >= 50
            SET @NewTier = 'GOLD';
        ELSE IF @TotalSpent >= 5000 AND @OrderCount >= 20
            SET @NewTier = 'SILVER';
        ELSE IF @TotalSpent >= 1000 AND @OrderCount >= 5
            SET @NewTier = 'BRONZE';
        ELSE
            SET @NewTier = 'STANDARD';
        
        -- Get current tier
        SELECT @CustomerTier = CustomerTier
        FROM CustomerStatistics
        WHERE CustomerID = @CustomerID;
        
        -- Update or insert customer statistics
        IF EXISTS (SELECT 1 FROM CustomerStatistics WHERE CustomerID = @CustomerID)
        BEGIN
            UPDATE CustomerStatistics
            SET TotalOrders = @OrderCount,
                TotalSpent = @TotalSpent,
                AverageOrderValue = @AverageOrderValue,
                LastOrderDate = @LastOrderDate,
                CustomerTier = @NewTier,
                LastUpdated = GETDATE(),
                UpdatedBy = @CreatedBy
            WHERE CustomerID = @CustomerID;
        END
        ELSE
        BEGIN
            INSERT INTO CustomerStatistics (
                CustomerID, TotalOrders, TotalSpent, AverageOrderValue,
                LastOrderDate, CustomerTier, CreatedDate, CreatedBy
            )
            VALUES (
                @CustomerID, @OrderCount, @TotalSpent, @AverageOrderValue,
                @LastOrderDate, @NewTier, GETDATE(), @CreatedBy
            );
        END;
        
        -- If tier changed, log the change and update customer type if needed
        IF @CustomerTier != @NewTier OR @CustomerTier IS NULL
        BEGIN
            INSERT INTO CustomerTierHistory (
                CustomerID, OldTier, NewTier, ChangeDate, 
                TriggerOrderAmount, CreatedBy
            )
            VALUES (
                @CustomerID, @CustomerTier, @NewTier, GETDATE(),
                @OrderAmount, @CreatedBy
            );
            
            -- Update customer type based on tier
            DECLARE @NewCustomerTypeID INT;
            SELECT @NewCustomerTypeID = CASE @NewTier
                WHEN 'PLATINUM' THEN 2 -- VIP
                WHEN 'GOLD' THEN 2 -- VIP
                WHEN 'SILVER' THEN 1 -- Regular
                WHEN 'BRONZE' THEN 1 -- Regular
                ELSE 1 -- Standard -> Regular
            END;
            
            UPDATE Customers
            SET CustomerTypeID = @NewCustomerTypeID,
                LastModifiedDate = GETDATE(),
                LastModifiedBy = @CreatedBy
            WHERE CustomerID = @CustomerID;
        END;
        
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate, CustomerID
        )
        VALUES (
            ERROR_NUMBER(), ERROR_MESSAGE(), 'sp_UpdateCustomerStatistics',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @CustomerID
        );
        
        RETURN -1;
    END CATCH;
END;
GO 