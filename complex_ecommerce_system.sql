-- =====================================================================================
-- Complex E-commerce System with Multiple Stored Procedures and Functions
-- Total Lines: 4000+ (Multi-part system)
-- Author: Universal SQL Analyzer Test Suite
-- =====================================================================================

-- =====================================================================================
-- USER-DEFINED FUNCTIONS SECTION
-- =====================================================================================

-- Function 1: Calculate Complex Tax Based on Location and Product Category
CREATE FUNCTION dbo.fn_CalculateComplexTax
(
    @ProductID INT,
    @ShippingStateID INT,
    @CustomerTypeID INT,
    @OrderAmount DECIMAL(18,2),
    @OrderDate DATETIME
)
RETURNS DECIMAL(18,4)
AS
BEGIN
    DECLARE @TaxRate DECIMAL(8,4) = 0.0000;
    DECLARE @StateTaxRate DECIMAL(8,4) = 0.0000;
    DECLARE @LocalTaxRate DECIMAL(8,4) = 0.0000;
    DECLARE @ProductCategoryID INT;
    DECLARE @IsLuxuryItem BIT = 0;
    DECLARE @IsDigitalProduct BIT = 0;
    DECLARE @SeasonalMultiplier DECIMAL(4,2) = 1.00;
    DECLARE @CustomerTaxExemption DECIMAL(4,2) = 0.00;
    
    -- Get product category and special flags
    SELECT 
        @ProductCategoryID = CategoryID,
        @IsLuxuryItem = CASE WHEN UnitPrice > 1000 THEN 1 ELSE 0 END,
        @IsDigitalProduct = IsDigital
    FROM Products 
    WHERE ProductID = @ProductID;
    
    -- Base state tax rate
    SELECT @StateTaxRate = ISNULL(TaxRate, 0.0000)
    FROM StateTaxRates 
    WHERE StateID = @ShippingStateID;
    
    -- Local tax adjustments
    IF EXISTS (SELECT 1 FROM LocalTaxZones WHERE StateID = @ShippingStateID)
    BEGIN
        SELECT @LocalTaxRate = ISNULL(AVG(LocalTaxRate), 0.0000)
        FROM LocalTaxZones 
        WHERE StateID = @ShippingStateID;
    END;
    
    -- Category-based tax modifications
    IF @ProductCategoryID IN (1, 2, 3) -- Electronics, Luxury, Jewelry
    BEGIN
        SET @TaxRate = @StateTaxRate + (@StateTaxRate * 0.15); -- 15% surcharge
    END
    ELSE IF @ProductCategoryID IN (10, 11) -- Books, Education
    BEGIN
        SET @TaxRate = @StateTaxRate * 0.50; -- 50% reduction
    END
    ELSE
    BEGIN
        SET @TaxRate = @StateTaxRate;
    END;
    
    -- Digital product exemptions
    IF @IsDigitalProduct = 1
    BEGIN
        SET @TaxRate = @TaxRate * 0.75; -- 25% reduction for digital
    END;
    
    -- Luxury item additional tax
    IF @IsLuxuryItem = 1
    BEGIN
        SET @TaxRate = @TaxRate + 0.0500; -- Additional 5% luxury tax
    END;
    
    -- Seasonal adjustments
    DECLARE @Month INT = MONTH(@OrderDate);
    IF @Month IN (11, 12) -- Holiday season
    BEGIN
        SET @SeasonalMultiplier = 0.85; -- Holiday tax reduction
    END
    ELSE IF @Month IN (6, 7, 8) -- Summer
    BEGIN
        SET @SeasonalMultiplier = 1.10; -- Summer tax increase
    END;
    
    -- Customer type exemptions
    IF @CustomerTypeID = 3 -- Non-profit
    BEGIN
        SET @CustomerTaxExemption = 1.00; -- Full exemption
    END
    ELSE IF @CustomerTypeID = 4 -- Government
    BEGIN
        SET @CustomerTaxExemption = 1.00; -- Full exemption
    END
    ELSE IF @CustomerTypeID = 2 -- VIP
    BEGIN
        SET @CustomerTaxExemption = 0.10; -- 10% reduction
    END;
    
    -- Final calculation
    SET @TaxRate = (@TaxRate + @LocalTaxRate) * @SeasonalMultiplier * (1 - @CustomerTaxExemption);
    
    -- Ensure minimum tax rate compliance
    IF @TaxRate < 0.0000
        SET @TaxRate = 0.0000;
    
    -- Maximum tax rate cap
    IF @TaxRate > 0.2500
        SET @TaxRate = 0.2500;
    
    RETURN @TaxRate;
END;
GO

-- Function 2: Calculate Dynamic Shipping Cost with Complex Rules
CREATE FUNCTION dbo.fn_CalculateDynamicShipping
(
    @TotalWeight DECIMAL(10,2),
    @TotalVolume DECIMAL(10,2),
    @ShippingDistance INT,
    @ShippingMethodID INT,
    @CustomerTypeID INT,
    @OrderValue DECIMAL(18,2),
    @IsRushOrder BIT,
    @ShippingDate DATETIME
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @BaseCost DECIMAL(18,2) = 0.00;
    DECLARE @WeightCost DECIMAL(18,2) = 0.00;
    DECLARE @VolumeCost DECIMAL(18,2) = 0.00;
    DECLARE @DistanceCost DECIMAL(18,2) = 0.00;
    DECLARE @MethodMultiplier DECIMAL(4,2) = 1.00;
    DECLARE @RushMultiplier DECIMAL(4,2) = 1.00;
    DECLARE @SeasonalMultiplier DECIMAL(4,2) = 1.00;
    DECLARE @CustomerDiscount DECIMAL(4,2) = 0.00;
    DECLARE @FreeShippingThreshold DECIMAL(18,2) = 100.00;
    
    -- Base shipping method costs
    SELECT 
        @BaseCost = BaseCost,
        @MethodMultiplier = CostMultiplier,
        @FreeShippingThreshold = FreeShippingThreshold
    FROM ShippingMethods 
    WHERE MethodID = @ShippingMethodID;
    
    -- Weight-based calculation
    IF @TotalWeight <= 1.0
        SET @WeightCost = 5.00;
    ELSE IF @TotalWeight <= 5.0
        SET @WeightCost = 10.00 + ((@TotalWeight - 1.0) * 2.50);
    ELSE IF @TotalWeight <= 20.0
        SET @WeightCost = 20.00 + ((@TotalWeight - 5.0) * 1.75);
    ELSE IF @TotalWeight <= 50.0
        SET @WeightCost = 46.25 + ((@TotalWeight - 20.0) * 1.25);
    ELSE
        SET @WeightCost = 83.75 + ((@TotalWeight - 50.0) * 0.85);
    
    -- Volume-based surcharge
    IF @TotalVolume > 10000 -- Large items
    BEGIN
        SET @VolumeCost = (@TotalVolume - 10000) / 1000 * 15.00;
    END;
    
    -- Distance-based calculation
    IF @ShippingDistance <= 100
        SET @DistanceCost = 5.00;
    ELSE IF @ShippingDistance <= 500
        SET @DistanceCost = 15.00 + ((@ShippingDistance - 100) / 100 * 5.00);
    ELSE IF @ShippingDistance <= 1500
        SET @DistanceCost = 35.00 + ((@ShippingDistance - 500) / 250 * 10.00);
    ELSE
        SET @DistanceCost = 75.00 + ((@ShippingDistance - 1500) / 500 * 8.00);
    
    -- Rush order premium
    IF @IsRushOrder = 1
    BEGIN
        SET @RushMultiplier = 2.50;
    END;
    
    -- Seasonal adjustments
    DECLARE @Month INT = MONTH(@ShippingDate);
    DECLARE @DayOfWeek INT = DATEPART(WEEKDAY, @ShippingDate);
    
    IF @Month IN (11, 12) -- Holiday rush
        SET @SeasonalMultiplier = 1.75;
    ELSE IF @Month IN (6, 7, 8) -- Summer peak
        SET @SeasonalMultiplier = 1.25;
    ELSE IF @DayOfWeek IN (1, 7) -- Weekend premium
        SET @SeasonalMultiplier = @SeasonalMultiplier * 1.15;
    
    -- Customer type discounts
    IF @CustomerTypeID = 2 -- VIP
        SET @CustomerDiscount = 0.20; -- 20% discount
    ELSE IF @CustomerTypeID = 5 -- Corporate
        SET @CustomerDiscount = 0.15; -- 15% discount
    ELSE IF @CustomerTypeID = 6 -- Wholesale
        SET @CustomerDiscount = 0.25; -- 25% discount
    
    -- Calculate total cost
    DECLARE @TotalCost DECIMAL(18,2);
    SET @TotalCost = (@BaseCost + @WeightCost + @VolumeCost + @DistanceCost) 
                    * @MethodMultiplier 
                    * @RushMultiplier 
                    * @SeasonalMultiplier 
                    * (1 - @CustomerDiscount);
    
    -- Free shipping threshold check
    IF @OrderValue >= @FreeShippingThreshold AND @CustomerTypeID IN (2, 5, 6)
    BEGIN
        SET @TotalCost = @TotalCost * 0.50; -- 50% off for qualifying orders
    END
    ELSE IF @OrderValue >= (@FreeShippingThreshold * 2)
    BEGIN
        SET @TotalCost = 0.00; -- Free shipping for large orders
    END;
    
    -- Minimum shipping cost
    IF @TotalCost < 3.00
        SET @TotalCost = 3.00;
    
    RETURN @TotalCost;
END;
GO

-- Function 3: Validate Customer Credit and Calculate Credit Score
CREATE FUNCTION dbo.fn_ValidateCustomerCredit
(
    @CustomerID INT,
    @RequestedCreditAmount DECIMAL(18,2),
    @OrderHistory INT -- Number of previous orders
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        c.CustomerID,
        c.CreditLimit,
        c.CurrentBalance,
        (c.CreditLimit - c.CurrentBalance) AS AvailableCredit,
        CASE 
            WHEN @RequestedCreditAmount <= (c.CreditLimit - c.CurrentBalance) THEN 1
            ELSE 0
        END AS IsCreditApproved,
        CASE 
            WHEN @OrderHistory = 0 THEN 500 -- New customer base score
            WHEN @OrderHistory < 5 THEN 550 + (@OrderHistory * 10)
            WHEN @OrderHistory < 20 THEN 600 + ((@OrderHistory - 5) * 8)
            WHEN @OrderHistory < 50 THEN 720 + ((@OrderHistory - 20) * 5)
            ELSE 850 -- Maximum score for 50+ orders
        END AS CalculatedCreditScore,
        CASE
            WHEN c.LastPaymentDate < DATEADD(DAY, -90, GETDATE()) THEN 'HIGH_RISK'
            WHEN c.LastPaymentDate < DATEADD(DAY, -30, GETDATE()) THEN 'MEDIUM_RISK'
            ELSE 'LOW_RISK'
        END AS RiskCategory
    FROM Customers c
    WHERE c.CustomerID = @CustomerID
);
GO

-- Function 4: Complex Inventory Allocation Logic
CREATE FUNCTION dbo.fn_AllocateInventoryAcrossWarehouses
(
    @ProductID INT,
    @RequestedQuantity INT,
    @CustomerPriorityLevel INT,
    @ShippingZoneID INT
)
RETURNS @InventoryAllocation TABLE
(
    WarehouseID INT,
    AllocatedQuantity INT,
    EstimatedShippingDays INT,
    AllocationPriority INT,
    CostPerUnit DECIMAL(10,2)
)
AS
BEGIN
    DECLARE @RemainingQuantity INT = @RequestedQuantity;
    DECLARE @CurrentWarehouse INT;
    DECLARE @AvailableQuantity INT;
    DECLARE @ShippingDays INT;
    DECLARE @CostPerUnit DECIMAL(10,2);
    DECLARE @Priority INT;
    
    -- Cursor for warehouses ordered by priority and proximity
    DECLARE warehouse_cursor CURSOR FOR
    SELECT 
        w.WarehouseID,
        i.QuantityAvailable,
        CASE 
            WHEN w.ZoneID = @ShippingZoneID THEN 1
            WHEN ABS(w.ZoneID - @ShippingZoneID) <= 2 THEN 2
            ELSE 3
        END AS ShippingDays,
        i.CostPerUnit,
        CASE
            WHEN @CustomerPriorityLevel = 1 THEN -- Platinum
                CASE WHEN w.IsPriorityWarehouse = 1 THEN 1 ELSE 3 END
            WHEN @CustomerPriorityLevel = 2 THEN -- Gold
                CASE WHEN w.IsPriorityWarehouse = 1 THEN 2 ELSE 4 END
            ELSE 5 -- Regular
        END AS Priority
    FROM Warehouses w
    INNER JOIN Inventory i ON w.WarehouseID = i.WarehouseID
    WHERE i.ProductID = @ProductID 
      AND i.QuantityAvailable > 0
      AND w.IsActive = 1
    ORDER BY Priority ASC, ShippingDays ASC, i.CostPerUnit ASC;
    
    OPEN warehouse_cursor;
    FETCH NEXT FROM warehouse_cursor INTO @CurrentWarehouse, @AvailableQuantity, @ShippingDays, @CostPerUnit, @Priority;
    
    WHILE @@FETCH_STATUS = 0 AND @RemainingQuantity > 0
    BEGIN
        DECLARE @AllocationQty INT;
        
        IF @AvailableQuantity >= @RemainingQuantity
        BEGIN
            SET @AllocationQty = @RemainingQuantity;
            SET @RemainingQuantity = 0;
        END
        ELSE
        BEGIN
            SET @AllocationQty = @AvailableQuantity;
            SET @RemainingQuantity = @RemainingQuantity - @AvailableQuantity;
        END;
        
        INSERT INTO @InventoryAllocation VALUES
        (@CurrentWarehouse, @AllocationQty, @ShippingDays, @Priority, @CostPerUnit);
        
        FETCH NEXT FROM warehouse_cursor INTO @CurrentWarehouse, @AvailableQuantity, @ShippingDays, @CostPerUnit, @Priority;
    END;
    
    CLOSE warehouse_cursor;
    DEALLOCATE warehouse_cursor;
    
    RETURN;
END;
GO

-- =====================================================================================
-- STORED PROCEDURES SECTION
-- =====================================================================================

-- Procedure 1: Advanced Customer Management with Complex Validation
CREATE PROCEDURE sp_ManageCustomerAccount
    @Action VARCHAR(20), -- CREATE, UPDATE, SUSPEND, ACTIVATE, DELETE
    @CustomerID INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @Email NVARCHAR(100) = NULL,
    @Phone NVARCHAR(20) = NULL,
    @CustomerTypeID INT = NULL,
    @CreditLimit DECIMAL(18,2) = NULL,
    @PreferredContactMethod VARCHAR(10) = NULL,
    @MarketingOptIn BIT = NULL,
    @CompanyName NVARCHAR(100) = NULL,
    @TaxID NVARCHAR(20) = NULL,
    @CreatedBy INT,
    @Notes NVARCHAR(MAX) = NULL,
    @NewCustomerID INT OUTPUT,
    @StatusMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorCode INT = 0;
    DECLARE @ValidationResult BIT = 1;
    DECLARE @DuplicateCheck INT = 0;
    DECLARE @CurrentStatus VARCHAR(20);
    DECLARE @OrderCount INT = 0;
    DECLARE @LastOrderDate DATETIME;
    DECLARE @TotalSpent DECIMAL(18,2) = 0;
    DECLARE @AuditLogID INT;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Comprehensive input validation
        IF @Action IS NULL OR @Action NOT IN ('CREATE', 'UPDATE', 'SUSPEND', 'ACTIVATE', 'DELETE')
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Invalid action specified. Must be CREATE, UPDATE, SUSPEND, ACTIVATE, or DELETE.';
            SET @ErrorCode = 2001;
            GOTO ErrorHandler;
        END;
        
        -- Action-specific validation
        IF @Action = 'CREATE'
        BEGIN
            -- Validate required fields for creation
            IF @FirstName IS NULL OR LEN(TRIM(@FirstName)) = 0
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'First name is required for customer creation.';
                SET @ErrorCode = 2002;
                GOTO ErrorHandler;
            END;
            
            IF @LastName IS NULL OR LEN(TRIM(@LastName)) = 0
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Last name is required for customer creation.';
                SET @ErrorCode = 2003;
                GOTO ErrorHandler;
            END;
            
            IF @Email IS NULL OR LEN(TRIM(@Email)) = 0
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Email is required for customer creation.';
                SET @ErrorCode = 2004;
                GOTO ErrorHandler;
            END;
            
            -- Email format validation
            IF @Email NOT LIKE '%@%.%' OR @Email LIKE '%..%' OR @Email LIKE '@%' OR @Email LIKE '%@'
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Invalid email format provided.';
                SET @ErrorCode = 2005;
                GOTO ErrorHandler;
            END;
            
            -- Check for duplicate email
            SELECT @DuplicateCheck = COUNT(*)
            FROM Customers 
            WHERE Email = @Email AND IsDeleted = 0;
            
            IF @DuplicateCheck > 0
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'A customer with this email address already exists.';
                SET @ErrorCode = 2006;
                GOTO ErrorHandler;
            END;
            
            -- Validate customer type
            IF @CustomerTypeID IS NULL OR NOT EXISTS (SELECT 1 FROM CustomerTypes WHERE TypeID = @CustomerTypeID AND IsActive = 1)
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Invalid or inactive customer type specified.';
                SET @ErrorCode = 2007;
                GOTO ErrorHandler;
            END;
            
            -- Business customer additional validation
            IF @CustomerTypeID IN (5, 6) -- Corporate or Wholesale
            BEGIN
                IF @CompanyName IS NULL OR LEN(TRIM(@CompanyName)) = 0
                BEGIN
                    SET @ValidationResult = 0;
                    SET @StatusMessage = 'Company name is required for business customers.';
                    SET @ErrorCode = 2008;
                    GOTO ErrorHandler;
                END;
                
                IF @TaxID IS NULL OR LEN(TRIM(@TaxID)) = 0
                BEGIN
                    SET @ValidationResult = 0;
                    SET @StatusMessage = 'Tax ID is required for business customers.';
                    SET @ErrorCode = 2009;
                    GOTO ErrorHandler;
                END;
                
                -- Check for duplicate Tax ID
                SELECT @DuplicateCheck = COUNT(*)
                FROM Customers 
                WHERE TaxID = @TaxID AND IsDeleted = 0;
                
                IF @DuplicateCheck > 0
                BEGIN
                    SET @ValidationResult = 0;
                    SET @StatusMessage = 'A customer with this Tax ID already exists.';
                    SET @ErrorCode = 2010;
                    GOTO ErrorHandler;
                END;
            END;
            
            -- Create new customer
            INSERT INTO Customers (
                FirstName, LastName, Email, Phone, CustomerTypeID, 
                CreditLimit, PreferredContactMethod, MarketingOptIn,
                CompanyName, TaxID, AccountStatus, CreatedDate, 
                CreatedBy, LastModifiedDate, LastModifiedBy, IsDeleted
            )
            VALUES (
                @FirstName, @LastName, @Email, @Phone, @CustomerTypeID,
                ISNULL(@CreditLimit, 0), ISNULL(@PreferredContactMethod, 'EMAIL'), 
                ISNULL(@MarketingOptIn, 0), @CompanyName, @TaxID, 
                'ACTIVE', GETDATE(), @CreatedBy, GETDATE(), @CreatedBy, 0
            );
            
            SET @NewCustomerID = SCOPE_IDENTITY();
            SET @StatusMessage = 'Customer created successfully with ID: ' + CAST(@NewCustomerID AS NVARCHAR(10));
            
            -- Create initial customer log entry
            INSERT INTO CustomerActivityLog (
                CustomerID, ActivityType, ActivityDescription, 
                CreatedDate, CreatedBy
            )
            VALUES (
                @NewCustomerID, 'ACCOUNT_CREATED', 
                'Customer account created by user ID: ' + CAST(@CreatedBy AS NVARCHAR(10)),
                GETDATE(), @CreatedBy
            );
            
        END
        ELSE
        BEGIN
            -- For UPDATE, SUSPEND, ACTIVATE, DELETE actions
            IF @CustomerID IS NULL OR @CustomerID <= 0
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Valid Customer ID is required for this action.';
                SET @ErrorCode = 2011;
                GOTO ErrorHandler;
            END;
            
            -- Check if customer exists
            IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID AND IsDeleted = 0)
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Customer not found or has been deleted.';
                SET @ErrorCode = 2012;
                GOTO ErrorHandler;
            END;
            
            -- Get customer current status and statistics
            SELECT 
                @CurrentStatus = AccountStatus,
                @OrderCount = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @CustomerID),
                @LastOrderDate = (SELECT MAX(OrderDate) FROM Orders WHERE CustomerID = @CustomerID),
                @TotalSpent = (SELECT ISNULL(SUM(FinalAmount), 0) FROM Orders WHERE CustomerID = @CustomerID AND OrderStatusID IN (2, 3))
            FROM Customers 
            WHERE CustomerID = @CustomerID;
            
            -- Action-specific logic
            IF @Action = 'UPDATE'
            BEGIN
                -- Validate email uniqueness if email is being updated
                IF @Email IS NOT NULL AND @Email != (SELECT Email FROM Customers WHERE CustomerID = @CustomerID)
                BEGIN
                    SELECT @DuplicateCheck = COUNT(*)
                    FROM Customers 
                    WHERE Email = @Email AND CustomerID != @CustomerID AND IsDeleted = 0;
                    
                    IF @DuplicateCheck > 0
                    BEGIN
                        SET @ValidationResult = 0;
                        SET @StatusMessage = 'Another customer with this email address already exists.';
                        SET @ErrorCode = 2013;
                        GOTO ErrorHandler;
                    END;
                END;
                
                -- Update customer information
                UPDATE Customers
                SET FirstName = ISNULL(@FirstName, FirstName),
                    LastName = ISNULL(@LastName, LastName),
                    Email = ISNULL(@Email, Email),
                    Phone = ISNULL(@Phone, Phone),
                    CustomerTypeID = ISNULL(@CustomerTypeID, CustomerTypeID),
                    CreditLimit = ISNULL(@CreditLimit, CreditLimit),
                    PreferredContactMethod = ISNULL(@PreferredContactMethod, PreferredContactMethod),
                    MarketingOptIn = ISNULL(@MarketingOptIn, MarketingOptIn),
                    CompanyName = ISNULL(@CompanyName, CompanyName),
                    TaxID = ISNULL(@TaxID, TaxID),
                    LastModifiedDate = GETDATE(),
                    LastModifiedBy = @CreatedBy
                WHERE CustomerID = @CustomerID;
                
                SET @StatusMessage = 'Customer information updated successfully.';
                
                -- Log the update
                INSERT INTO CustomerActivityLog (
                    CustomerID, ActivityType, ActivityDescription, 
                    CreatedDate, CreatedBy
                )
                VALUES (
                    @CustomerID, 'ACCOUNT_UPDATED', 
                    'Customer account updated by user ID: ' + CAST(@CreatedBy AS NVARCHAR(10)) + 
                    ISNULL('. Notes: ' + @Notes, ''),
                    GETDATE(), @CreatedBy
                );
            END
            ELSE IF @Action = 'SUSPEND'
            BEGIN
                IF @CurrentStatus = 'SUSPENDED'
                BEGIN
                    SET @StatusMessage = 'Customer account is already suspended.';
                END
                ELSE
                BEGIN
                    -- Check if customer has pending orders
                    DECLARE @PendingOrders INT;
                    SELECT @PendingOrders = COUNT(*)
                    FROM Orders 
                    WHERE CustomerID = @CustomerID AND OrderStatusID = 1; -- Pending status
                    
                    IF @PendingOrders > 0
                    BEGIN
                        SET @ValidationResult = 0;
                        SET @StatusMessage = 'Cannot suspend customer with pending orders. Please process or cancel pending orders first.';
                        SET @ErrorCode = 2014;
                        GOTO ErrorHandler;
                    END;
                    
                    UPDATE Customers
                    SET AccountStatus = 'SUSPENDED',
                        LastModifiedDate = GETDATE(),
                        LastModifiedBy = @CreatedBy
                    WHERE CustomerID = @CustomerID;
                    
                    SET @StatusMessage = 'Customer account suspended successfully.';
                    
                    -- Log the suspension
                    INSERT INTO CustomerActivityLog (
                        CustomerID, ActivityType, ActivityDescription, 
                        CreatedDate, CreatedBy
                    )
                    VALUES (
                        @CustomerID, 'ACCOUNT_SUSPENDED', 
                        'Customer account suspended by user ID: ' + CAST(@CreatedBy AS NVARCHAR(10)) + 
                        ISNULL('. Reason: ' + @Notes, ''),
                        GETDATE(), @CreatedBy
                    );
                END;
            END
            ELSE IF @Action = 'ACTIVATE'
            BEGIN
                IF @CurrentStatus = 'ACTIVE'
                BEGIN
                    SET @StatusMessage = 'Customer account is already active.';
                END
                ELSE
                BEGIN
                    UPDATE Customers
                    SET AccountStatus = 'ACTIVE',
                        LastModifiedDate = GETDATE(),
                        LastModifiedBy = @CreatedBy
                    WHERE CustomerID = @CustomerID;
                    
                    SET @StatusMessage = 'Customer account activated successfully.';
                    
                    -- Log the activation
                    INSERT INTO CustomerActivityLog (
                        CustomerID, ActivityType, ActivityDescription, 
                        CreatedDate, CreatedBy
                    )
                    VALUES (
                        @CustomerID, 'ACCOUNT_ACTIVATED', 
                        'Customer account activated by user ID: ' + CAST(@CreatedBy AS NVARCHAR(10)) + 
                        ISNULL('. Notes: ' + @Notes, ''),
                        GETDATE(), @CreatedBy
                    );
                END;
            END
            ELSE IF @Action = 'DELETE'
            BEGIN
                -- Soft delete validation
                IF @OrderCount > 0
                BEGIN
                    -- Customer has order history, perform soft delete
                    UPDATE Customers
                    SET IsDeleted = 1,
                        AccountStatus = 'DELETED',
                        DeletedDate = GETDATE(),
                        DeletedBy = @CreatedBy,
                        LastModifiedDate = GETDATE(),
                        LastModifiedBy = @CreatedBy
                    WHERE CustomerID = @CustomerID;
                    
                    SET @StatusMessage = 'Customer account marked as deleted (soft delete due to order history).';
                ELSE
                BEGIN
                    -- No order history, safe to hard delete
                    DELETE FROM CustomerActivityLog WHERE CustomerID = @CustomerID;
                    DELETE FROM Customers WHERE CustomerID = @CustomerID;
                    
                    SET @StatusMessage = 'Customer account permanently deleted.';
                END;
                
                -- Log the deletion
                INSERT INTO SystemAuditLog (
                    TableName, ActionType, RecordID, 
                    ActionDescription, CreatedDate, CreatedBy
                )
                VALUES (
                    'Customers', 'DELETE', @CustomerID,
                    'Customer deleted by user ID: ' + CAST(@CreatedBy AS NVARCHAR(10)) + 
                    ISNULL('. Reason: ' + @Notes, ''),
                    GETDATE(), @CreatedBy
                );
            END;
        END;
        
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ValidationResult = 0;
        SET @StatusMessage = 'Error in customer management: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
        
        -- Log the error
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName, 
            LineNumber, Severity, LogDate, CustomerID
        )
        VALUES (
            @ErrorCode, @StatusMessage, 'sp_ManageCustomerAccount',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @CustomerID
        );
        
        RETURN -1;
    END CATCH;
    
    ErrorHandler:
    IF @ValidationResult = 0
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        -- Log validation errors
        INSERT INTO ValidationErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            InputParameters, LogDate, CreatedBy
        )
        VALUES (
            @ErrorCode, @StatusMessage, 'sp_ManageCustomerAccount',
            'Action: ' + ISNULL(@Action, 'NULL') + ', CustomerID: ' + ISNULL(CAST(@CustomerID AS NVARCHAR(10)), 'NULL'),
            GETDATE(), @CreatedBy
        );
        
        RETURN @ErrorCode;
    END;
END;
GO

-- Procedure 2: Complex Inventory Management with Multi-Warehouse Logic
CREATE PROCEDURE sp_ManageInventoryAcrossWarehouses
    @Action VARCHAR(20), -- ALLOCATE, TRANSFER, RESTOCK, ADJUST, RESERVE, RELEASE
    @ProductID INT,
    @Quantity INT,
    @SourceWarehouseID INT = NULL,
    @TargetWarehouseID INT = NULL,
    @ReasonCode VARCHAR(20) = NULL,
    @CustomerPriorityLevel INT = 1,
    @ShippingZoneID INT = NULL,
    @CreatedBy INT,
    @Notes NVARCHAR(MAX) = NULL,
    @AllocationResults NVARCHAR(MAX) OUTPUT,
    @StatusMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorCode INT = 0;
    DECLARE @ValidationResult BIT = 1;
    DECLARE @TotalAvailable INT = 0;
    DECLARE @TotalAllocated INT = 0;
    DECLARE @RemainingQuantity INT = @Quantity;
    DECLARE @TransactionID INT;
    DECLARE @CurrentWarehouse INT;
    DECLARE @AvailableQty INT;
    DECLARE @AllocatedQty INT;
    DECLARE @CostPerUnit DECIMAL(10,2);
    DECLARE @AllocationCounter INT = 0;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Input validation
        IF @Action IS NULL OR @Action NOT IN ('ALLOCATE', 'TRANSFER', 'RESTOCK', 'ADJUST', 'RESERVE', 'RELEASE')
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Invalid action specified.';
            SET @ErrorCode = 3001;
            GOTO ErrorHandler;
        END;
        
        IF @ProductID IS NULL OR @ProductID <= 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Valid Product ID is required.';
            SET @ErrorCode = 3002;
            GOTO ErrorHandler;
        END;
        
        IF @Quantity IS NULL OR @Quantity <= 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Valid quantity is required.';
            SET @ErrorCode = 3003;
            GOTO ErrorHandler;
        END;
        
        -- Check if product exists
        IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND IsActive = 1)
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Product not found or inactive.';
            SET @ErrorCode = 3004;
            GOTO ErrorHandler;
        END;
        
        -- Create inventory transaction record
        INSERT INTO InventoryTransactions (
            ProductID, TransactionType, Quantity, 
            CreatedDate, CreatedBy, Notes
        )
        VALUES (
            @ProductID, @Action, @Quantity,
            GETDATE(), @CreatedBy, @Notes
        );
        
        SET @TransactionID = SCOPE_IDENTITY();
        
        -- Action-specific logic
        IF @Action = 'ALLOCATE'
        BEGIN
            -- Complex allocation logic across multiple warehouses
            IF @ShippingZoneID IS NULL
                SET @ShippingZoneID = 1; -- Default zone
            
            -- Get total available inventory
            SELECT @TotalAvailable = ISNULL(SUM(QuantityAvailable), 0)
            FROM Inventory i
            INNER JOIN Warehouses w ON i.WarehouseID = w.WarehouseID
            WHERE i.ProductID = @ProductID 
              AND i.QuantityAvailable > 0
              AND w.IsActive = 1;
            
            IF @TotalAvailable < @Quantity
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Insufficient inventory available. Available: ' + CAST(@TotalAvailable AS NVARCHAR(10)) + ', Requested: ' + CAST(@Quantity AS NVARCHAR(10));
                SET @ErrorCode = 3005;
                GOTO ErrorHandler;
            END;
            
            -- Use the inventory allocation function
            DECLARE allocation_cursor CURSOR FOR
            SELECT WarehouseID, AllocatedQuantity, CostPerUnit
            FROM dbo.fn_AllocateInventoryAcrossWarehouses(@ProductID, @Quantity, @CustomerPriorityLevel, @ShippingZoneID)
            ORDER BY AllocationPriority ASC;
            
            OPEN allocation_cursor;
            FETCH NEXT FROM allocation_cursor INTO @CurrentWarehouse, @AllocatedQty, @CostPerUnit;
            
            SET @AllocationResults = '';
            
            WHILE @@FETCH_STATUS = 0 AND @RemainingQuantity > 0
            BEGIN
                -- Reserve inventory in this warehouse
                UPDATE Inventory
                SET QuantityReserved = QuantityReserved + @AllocatedQty,
                    QuantityAvailable = QuantityAvailable - @AllocatedQty,
                    LastModifiedDate = GETDATE(),
                    LastModifiedBy = @CreatedBy
                WHERE ProductID = @ProductID 
                  AND WarehouseID = @CurrentWarehouse;
                
                -- Log the allocation detail
                INSERT INTO InventoryAllocationDetails (
                    TransactionID, WarehouseID, AllocatedQuantity,
                    CostPerUnit, AllocationDate, CreatedBy
                )
                VALUES (
                    @TransactionID, @CurrentWarehouse, @AllocatedQty,
                    @CostPerUnit, GETDATE(), @CreatedBy
                );
                
                SET @TotalAllocated = @TotalAllocated + @AllocatedQty;
                SET @RemainingQuantity = @RemainingQuantity - @AllocatedQty;
                SET @AllocationCounter = @AllocationCounter + 1;
                
                -- Build results string
                SET @AllocationResults = @AllocationResults + 
                    'Warehouse ' + CAST(@CurrentWarehouse AS NVARCHAR(10)) + 
                    ': ' + CAST(@AllocatedQty AS NVARCHAR(10)) + ' units @ $' + 
                    CAST(@CostPerUnit AS NVARCHAR(10)) + '; ';
                
                FETCH NEXT FROM allocation_cursor INTO @CurrentWarehouse, @AllocatedQty, @CostPerUnit;
            END;
            
            CLOSE allocation_cursor;
            DEALLOCATE allocation_cursor;
            
            SET @StatusMessage = 'Successfully allocated ' + CAST(@TotalAllocated AS NVARCHAR(10)) + 
                               ' units across ' + CAST(@AllocationCounter AS NVARCHAR(10)) + ' warehouses.';
        END
        ELSE IF @Action = 'TRANSFER'
        BEGIN
            -- Transfer inventory between warehouses
            IF @SourceWarehouseID IS NULL OR @TargetWarehouseID IS NULL
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Both source and target warehouse IDs are required for transfer.';
                SET @ErrorCode = 3006;
                GOTO ErrorHandler;
            END;
            
            IF @SourceWarehouseID = @TargetWarehouseID
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Source and target warehouses cannot be the same.';
                SET @ErrorCode = 3007;
                GOTO ErrorHandler;
            END;
            
            -- Check source warehouse availability
            SELECT @AvailableQty = ISNULL(QuantityAvailable, 0)
            FROM Inventory
            WHERE ProductID = @ProductID AND WarehouseID = @SourceWarehouseID;
            
            IF @AvailableQty < @Quantity
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Insufficient inventory in source warehouse. Available: ' + CAST(@AvailableQty AS NVARCHAR(10));
                SET @ErrorCode = 3008;
                GOTO ErrorHandler;
            END;
            
            -- Perform the transfer
            -- Reduce from source
            UPDATE Inventory
            SET QuantityAvailable = QuantityAvailable - @Quantity,
                LastModifiedDate = GETDATE(),
                LastModifiedBy = @CreatedBy
            WHERE ProductID = @ProductID AND WarehouseID = @SourceWarehouseID;
            
            -- Add to target (create record if doesn't exist)
            IF EXISTS (SELECT 1 FROM Inventory WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID)
            BEGIN
                UPDATE Inventory
                SET QuantityAvailable = QuantityAvailable + @Quantity,
                    LastModifiedDate = GETDATE(),
                    LastModifiedBy = @CreatedBy
                WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            END
            ELSE
            BEGIN
                -- Get cost per unit from source warehouse
                SELECT @CostPerUnit = CostPerUnit
                FROM Inventory
                WHERE ProductID = @ProductID AND WarehouseID = @SourceWarehouseID;
                
                INSERT INTO Inventory (
                    ProductID, WarehouseID, QuantityAvailable, 
                    QuantityReserved, CostPerUnit, CreatedDate, CreatedBy
                )
                VALUES (
                    @ProductID, @TargetWarehouseID, @Quantity,
                    0, @CostPerUnit, GETDATE(), @CreatedBy
                );
            END;
            
            -- Log transfer details
            INSERT INTO InventoryTransferLog (
                TransactionID, SourceWarehouseID, TargetWarehouseID,
                Quantity, TransferDate, CreatedBy, ReasonCode
            )
            VALUES (
                @TransactionID, @SourceWarehouseID, @TargetWarehouseID,
                @Quantity, GETDATE(), @CreatedBy, @ReasonCode
            );
            
            SET @StatusMessage = 'Successfully transferred ' + CAST(@Quantity AS NVARCHAR(10)) + 
                               ' units from warehouse ' + CAST(@SourceWarehouseID AS NVARCHAR(10)) +
                               ' to warehouse ' + CAST(@TargetWarehouseID AS NVARCHAR(10)) + '.';
        END
        ELSE IF @Action = 'RESTOCK'
        BEGIN
            -- Add new inventory (purchase/manufacturing)
            IF @TargetWarehouseID IS NULL
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Target warehouse ID is required for restocking.';
                SET @ErrorCode = 3009;
                GOTO ErrorHandler;
            END;
            
            -- Get current cost per unit or use default
            SELECT @CostPerUnit = ISNULL(CostPerUnit, 0)
            FROM Inventory
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            IF @CostPerUnit = 0
            BEGIN
                SELECT @CostPerUnit = ISNULL(StandardCost, UnitPrice * 0.7)
                FROM Products
                WHERE ProductID = @ProductID;
            END;
            
            -- Update or insert inventory
            IF EXISTS (SELECT 1 FROM Inventory WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID)
            BEGIN
                UPDATE Inventory
                SET QuantityAvailable = QuantityAvailable + @Quantity,
                    LastModifiedDate = GETDATE(),
                    LastModifiedBy = @CreatedBy
                WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            END
            ELSE
            BEGIN
                INSERT INTO Inventory (
                    ProductID, WarehouseID, QuantityAvailable,
                    QuantityReserved, CostPerUnit, CreatedDate, CreatedBy
                )
                VALUES (
                    @ProductID, @TargetWarehouseID, @Quantity,
                    0, @CostPerUnit, GETDATE(), @CreatedBy
                );
            END;
            
            SET @StatusMessage = 'Successfully restocked ' + CAST(@Quantity AS NVARCHAR(10)) + 
                               ' units in warehouse ' + CAST(@TargetWarehouseID AS NVARCHAR(10)) + '.';
        END
        ELSE IF @Action = 'ADJUST'
        BEGIN
            -- Inventory adjustment (positive or negative)
            IF @TargetWarehouseID IS NULL
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Target warehouse ID is required for adjustment.';
                SET @ErrorCode = 3010;
                GOTO ErrorHandler;
            END;
            
            -- Check current inventory
            SELECT @AvailableQty = ISNULL(QuantityAvailable, 0)
            FROM Inventory
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            -- For negative adjustments, ensure sufficient inventory
            IF @Quantity < 0 AND ABS(@Quantity) > @AvailableQty
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Cannot adjust inventory below zero. Current: ' + CAST(@AvailableQty AS NVARCHAR(10));
                SET @ErrorCode = 3011;
                GOTO ErrorHandler;
            END;
            
            -- Perform adjustment
            UPDATE Inventory
            SET QuantityAvailable = QuantityAvailable + @Quantity,
                LastModifiedDate = GETDATE(),
                LastModifiedBy = @CreatedBy
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            -- Log adjustment reason
            INSERT INTO InventoryAdjustmentLog (
                TransactionID, WarehouseID, AdjustmentQuantity,
                ReasonCode, AdjustmentDate, CreatedBy
            )
            VALUES (
                @TransactionID, @TargetWarehouseID, @Quantity,
                @ReasonCode, GETDATE(), @CreatedBy
            );
            
            SET @StatusMessage = 'Successfully adjusted inventory by ' + CAST(@Quantity AS NVARCHAR(10)) + 
                               ' units in warehouse ' + CAST(@TargetWarehouseID AS NVARCHAR(10)) + '.';
        END
        ELSE IF @Action = 'RESERVE'
        BEGIN
            -- Reserve inventory for pending orders
            IF @TargetWarehouseID IS NULL
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Target warehouse ID is required for reservation.';
                SET @ErrorCode = 3012;
                GOTO ErrorHandler;
            END;
            
            -- Check availability
            SELECT @AvailableQty = ISNULL(QuantityAvailable, 0)
            FROM Inventory
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            IF @AvailableQty < @Quantity
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Insufficient inventory to reserve. Available: ' + CAST(@AvailableQty AS NVARCHAR(10));
                SET @ErrorCode = 3013;
                GOTO ErrorHandler;
            END;
            
            -- Move from available to reserved
            UPDATE Inventory
            SET QuantityAvailable = QuantityAvailable - @Quantity,
                QuantityReserved = QuantityReserved + @Quantity,
                LastModifiedDate = GETDATE(),
                LastModifiedBy = @CreatedBy
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            SET @StatusMessage = 'Successfully reserved ' + CAST(@Quantity AS NVARCHAR(10)) + 
                               ' units in warehouse ' + CAST(@TargetWarehouseID AS NVARCHAR(10)) + '.';
        END
        ELSE IF @Action = 'RELEASE'
        BEGIN
            -- Release reserved inventory back to available
            IF @TargetWarehouseID IS NULL
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Target warehouse ID is required for release.';
                SET @ErrorCode = 3014;
                GOTO ErrorHandler;
            END;
            
            -- Check reserved quantity
            DECLARE @ReservedQty INT;
            SELECT @ReservedQty = ISNULL(QuantityReserved, 0)
            FROM Inventory
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            IF @ReservedQty < @Quantity
            BEGIN
                SET @ValidationResult = 0;
                SET @StatusMessage = 'Insufficient reserved inventory to release. Reserved: ' + CAST(@ReservedQty AS NVARCHAR(10));
                SET @ErrorCode = 3015;
                GOTO ErrorHandler;
            END;
            
            -- Move from reserved back to available
            UPDATE Inventory
            SET QuantityAvailable = QuantityAvailable + @Quantity,
                QuantityReserved = QuantityReserved - @Quantity,
                LastModifiedDate = GETDATE(),
                LastModifiedBy = @CreatedBy
            WHERE ProductID = @ProductID AND WarehouseID = @TargetWarehouseID;
            
            SET @StatusMessage = 'Successfully released ' + CAST(@Quantity AS NVARCHAR(10)) + 
                               ' units back to available in warehouse ' + CAST(@TargetWarehouseID AS NVARCHAR(10)) + '.';
        END;
        
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ValidationResult = 0;
        SET @StatusMessage = 'Error in inventory management: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
        
        -- Log the error
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate, ProductID
        )
        VALUES (
            @ErrorCode, @StatusMessage, 'sp_ManageInventoryAcrossWarehouses',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @ProductID
        );
        
        RETURN -1;
    END CATCH;
    
    ErrorHandler:
    IF @ValidationResult = 0
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        RETURN @ErrorCode;
    END;
END;
GO

-- Procedure 3: Dynamic Pricing Engine with Complex Rules
CREATE PROCEDURE sp_CalculateDynamicPricing
    @ProductID INT,
    @CustomerID INT,
    @Quantity INT,
    @OrderDate DATETIME = NULL,
    @PromoCode NVARCHAR(20) = NULL,
    @ShippingZoneID INT = NULL,
    @CalculatedPrice DECIMAL(18,2) OUTPUT,
    @DiscountAmount DECIMAL(18,2) OUTPUT,
    @TaxAmount DECIMAL(18,2) OUTPUT,
    @ShippingCost DECIMAL(18,2) OUTPUT,
    @FinalAmount DECIMAL(18,2) OUTPUT,
    @PricingBreakdown NVARCHAR(MAX) OUTPUT,
    @StatusMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @BasePrice DECIMAL(18,2) = 0.00;
    DECLARE @CustomerTypeID INT;
    DECLARE @CustomerTierDiscount DECIMAL(4,2) = 0.00;
    DECLARE @VolumeDiscount DECIMAL(4,2) = 0.00;
    DECLARE @SeasonalAdjustment DECIMAL(4,2) = 0.00;
    DECLARE @PromoDiscount DECIMAL(4,2) = 0.00;
    DECLARE @LoyaltyDiscount DECIMAL(4,2) = 0.00;
    DECLARE @CompetitorPriceAdjustment DECIMAL(4,2) = 0.00;
    DECLARE @InventoryLevelAdjustment DECIMAL(4,2) = 0.00;
    DECLARE @DemandAdjustment DECIMAL(4,2) = 0.00;
    DECLARE @TotalWeight DECIMAL(10,2) = 0.00;
    DECLARE @TotalVolume DECIMAL(10,2) = 0.00;
    DECLARE @ShippingDistance INT = 0;
    DECLARE @ShippingMethodID INT = 1;
    DECLARE @IsRushOrder BIT = 0;
    DECLARE @OrderHistory INT = 0;
    DECLARE @LastOrderDate DATETIME;
    DECLARE @TotalSpent DECIMAL(18,2) = 0.00;
    DECLARE @ErrorCode INT = 0;
    
    BEGIN TRY
        -- Initialize defaults
        IF @OrderDate IS NULL
            SET @OrderDate = GETDATE();
        
        IF @ShippingZoneID IS NULL
            SET @ShippingZoneID = 1;
        
        -- Get base product information
        SELECT 
            @BasePrice = UnitPrice,
            @TotalWeight = Weight * @Quantity,
            @TotalVolume = Volume * @Quantity
        FROM Products
        WHERE ProductID = @ProductID AND IsActive = 1;
        
        IF @BasePrice IS NULL
        BEGIN
            SET @StatusMessage = 'Product not found or inactive.';
            RETURN -1;
        END;
        
        -- Get customer information and history
        SELECT 
            @CustomerTypeID = CustomerTypeID,
            @OrderHistory = (SELECT COUNT(*) FROM Orders WHERE CustomerID = @CustomerID),
            @LastOrderDate = (SELECT MAX(OrderDate) FROM Orders WHERE CustomerID = @CustomerID),
            @TotalSpent = (SELECT ISNULL(SUM(FinalAmount), 0) FROM Orders WHERE CustomerID = @CustomerID AND OrderStatusID IN (2, 3))
        FROM Customers
        WHERE CustomerID = @CustomerID AND IsDeleted = 0;
        
        -- Customer tier-based discount
        IF @CustomerTypeID = 2 -- VIP
            SET @CustomerTierDiscount = 0.15; -- 15% discount
        ELSE IF @CustomerTypeID = 5 -- Corporate
            SET @CustomerTierDiscount = 0.10; -- 10% discount
        ELSE IF @CustomerTypeID = 6 -- Wholesale
            SET @CustomerTierDiscount = 0.20; -- 20% discount
        
        -- Volume-based discount tiers
        IF @Quantity >= 100
            SET @VolumeDiscount = 0.15; -- 15% for 100+ units
        ELSE IF @Quantity >= 50
            SET @VolumeDiscount = 0.10; -- 10% for 50+ units
        ELSE IF @Quantity >= 20
            SET @VolumeDiscount = 0.05; -- 5% for 20+ units
        ELSE IF @Quantity >= 10
            SET @VolumeDiscount = 0.02; -- 2% for 10+ units
        
        -- Seasonal pricing adjustments
        DECLARE @Month INT = MONTH(@OrderDate);
        DECLARE @DayOfWeek INT = DATEPART(WEEKDAY, @OrderDate);
        
        IF @Month IN (11, 12) -- Holiday season
        BEGIN
            SET @SeasonalAdjustment = -0.10; -- 10% holiday discount
        END
        ELSE IF @Month IN (6, 7, 8) -- Summer peak
        BEGIN
            SET @SeasonalAdjustment = 0.05; -- 5% summer premium
        END
        ELSE IF @Month IN (1, 2) -- Post-holiday clearance
        BEGIN
            SET @SeasonalAdjustment = -0.15; -- 15% clearance discount
        END;
        
        -- Weekend premium
        IF @DayOfWeek IN (1, 7) -- Sunday or Saturday
            SET @SeasonalAdjustment = @SeasonalAdjustment + 0.03; -- 3% weekend premium
        
        -- Promotional code validation and discount
        IF @PromoCode IS NOT NULL
        BEGIN
            DECLARE @PromoValidFrom DATETIME, @PromoValidTo DATETIME;
            DECLARE @PromoDiscountPercent DECIMAL(4,2), @PromoMinQuantity INT;
            DECLARE @PromoMaxUses INT, @PromoCurrentUses INT;
            
            SELECT 
                @PromoDiscountPercent = DiscountPercent,
                @PromoMinQuantity = MinQuantity,
                @PromoValidFrom = ValidFrom,
                @PromoValidTo = ValidTo,
                @PromoMaxUses = MaxUses,
                @PromoCurrentUses = CurrentUses
            FROM PromotionalCodes
            WHERE PromoCode = @PromoCode AND IsActive = 1;
            
            IF @PromoDiscountPercent IS NOT NULL
            BEGIN
                -- Validate promo code conditions
                IF @OrderDate BETWEEN @PromoValidFrom AND @PromoValidTo
                   AND @Quantity >= @PromoMinQuantity
                   AND (@PromoMaxUses IS NULL OR @PromoCurrentUses < @PromoMaxUses)
                BEGIN
                    SET @PromoDiscount = @PromoDiscountPercent;
                    
                    -- Update promo code usage
                    UPDATE PromotionalCodes
                    SET CurrentUses = CurrentUses + 1
                    WHERE PromoCode = @PromoCode;
                END;
            END;
        END;
        
        -- Loyalty program discount based on customer history
        IF @OrderHistory > 0
        BEGIN
            DECLARE @DaysSinceLastOrder INT = DATEDIFF(DAY, @LastOrderDate, @OrderDate);
            
            IF @OrderHistory >= 50 AND @TotalSpent >= 10000
                SET @LoyaltyDiscount = 0.12; -- 12% for platinum customers
            ELSE IF @OrderHistory >= 25 AND @TotalSpent >= 5000
                SET @LoyaltyDiscount = 0.08; -- 8% for gold customers
            ELSE IF @OrderHistory >= 10 AND @TotalSpent >= 2000
                SET @LoyaltyDiscount = 0.05; -- 5% for silver customers
            ELSE IF @OrderHistory >= 5
                SET @LoyaltyDiscount = 0.02; -- 2% for bronze customers
            
            -- Bonus for recent activity
            IF @DaysSinceLastOrder <= 30
                SET @LoyaltyDiscount = @LoyaltyDiscount + 0.02; -- 2% bonus for recent customers
        END;
        
        -- Competitive pricing adjustment
        DECLARE @CompetitorAvgPrice DECIMAL(18,2);
        SELECT @CompetitorAvgPrice = AVG(CompetitorPrice)
        FROM CompetitorPricing
        WHERE ProductID = @ProductID 
          AND PriceDate >= DATEADD(DAY, -7, @OrderDate); -- Last 7 days
        
        IF @CompetitorAvgPrice IS NOT NULL AND @CompetitorAvgPrice > 0
        BEGIN
            DECLARE @PriceDifference DECIMAL(18,2) = @BasePrice - @CompetitorAvgPrice;
            DECLARE @PriceDifferencePercent DECIMAL(4,2) = @PriceDifference / @CompetitorAvgPrice;
            
            -- If we're significantly higher than competitors, apply discount
            IF @PriceDifferencePercent > 0.10 -- More than 10% higher
                SET @CompetitorPriceAdjustment = -0.05; -- 5% discount to stay competitive
            ELSE IF @PriceDifferencePercent > 0.05 -- More than 5% higher
                SET @CompetitorPriceAdjustment = -0.02; -- 2% discount
            -- If we're lower, maintain premium pricing
            ELSE IF @PriceDifferencePercent < -0.05 -- More than 5% lower
                SET @CompetitorPriceAdjustment = 0.03; -- 3% premium increase
        END;
        
        -- Inventory level-based pricing
        DECLARE @TotalInventory INT, @ReservedInventory INT;
        SELECT 
            @TotalInventory = SUM(QuantityAvailable + QuantityReserved),
            @ReservedInventory = SUM(QuantityReserved)
        FROM Inventory
        WHERE ProductID = @ProductID;
        
        DECLARE @InventoryTurnover DECIMAL(4,2) = CASE 
            WHEN @TotalInventory > 0 THEN CAST(@ReservedInventory AS DECIMAL(4,2)) / @TotalInventory
            ELSE 0
        END;
        
        -- Adjust pricing based on inventory levels
        IF @TotalInventory < 50 -- Low inventory
            SET @InventoryLevelAdjustment = 0.08; -- 8% premium for scarcity
        ELSE IF @TotalInventory < 100 -- Medium inventory
            SET @InventoryLevelAdjustment = 0.03; -- 3% premium
        ELSE IF @TotalInventory > 1000 -- Excess inventory
            SET @InventoryLevelAdjustment = -0.05; -- 5% discount to move inventory
        
        -- High demand adjustment
        IF @InventoryTurnover > 0.8 -- High demand (80%+ reserved)
            SET @DemandAdjustment = 0.10; -- 10% premium for high demand
        ELSE IF @InventoryTurnover > 0.6 -- Medium demand
            SET @DemandAdjustment = 0.05; -- 5% premium
        
        -- Calculate final pricing
        SET @CalculatedPrice = @BasePrice * @Quantity;
        
        -- Apply all discounts and adjustments
        DECLARE @TotalDiscountRate DECIMAL(4,2) = 
            @CustomerTierDiscount + @VolumeDiscount + @PromoDiscount + @LoyaltyDiscount + @CompetitorPriceAdjustment;
        
        DECLARE @TotalAdjustmentRate DECIMAL(4,2) = 
            @SeasonalAdjustment + @InventoryLevelAdjustment + @DemandAdjustment;
        
        -- Apply discounts first, then adjustments
        DECLARE @PriceAfterDiscounts DECIMAL(18,2) = @CalculatedPrice * (1 - @TotalDiscountRate);
        DECLARE @PriceAfterAdjustments DECIMAL(18,2) = @PriceAfterDiscounts * (1 + @TotalAdjustmentRate);
        
        SET @DiscountAmount = @CalculatedPrice - @PriceAfterDiscounts;
        SET @CalculatedPrice = @PriceAfterAdjustments;
        
        -- Calculate tax using the complex tax function
        DECLARE @TaxRate DECIMAL(8,4);
        SET @TaxRate = dbo.fn_CalculateComplexTax(@ProductID, @ShippingZoneID, @CustomerTypeID, @CalculatedPrice, @OrderDate);
        SET @TaxAmount = @CalculatedPrice * @TaxRate;
        
        -- Calculate shipping using the dynamic shipping function
        SET @ShippingCost = dbo.fn_CalculateDynamicShipping(
            @TotalWeight, @TotalVolume, @ShippingDistance, @ShippingMethodID,
            @CustomerTypeID, @CalculatedPrice, @IsRushOrder, @OrderDate
        );
        
        -- Final amount calculation
        SET @FinalAmount = @CalculatedPrice + @TaxAmount + @ShippingCost;
        
        -- Build detailed pricing breakdown
        SET @PricingBreakdown = 
            'Base Price: $' + CAST(@BasePrice * @Quantity AS NVARCHAR(20)) + 
            '; Customer Tier Discount: ' + CAST(@CustomerTierDiscount * 100 AS NVARCHAR(10)) + '%' +
            '; Volume Discount: ' + CAST(@VolumeDiscount * 100 AS NVARCHAR(10)) + '%' +
            '; Seasonal Adjustment: ' + CAST(@SeasonalAdjustment * 100 AS NVARCHAR(10)) + '%' +
            '; Promo Discount: ' + CAST(@PromoDiscount * 100 AS NVARCHAR(10)) + '%' +
            '; Loyalty Discount: ' + CAST(@LoyaltyDiscount * 100 AS NVARCHAR(10)) + '%' +
            '; Competitive Adjustment: ' + CAST(@CompetitorPriceAdjustment * 100 AS NVARCHAR(10)) + '%' +
            '; Inventory Adjustment: ' + CAST(@InventoryLevelAdjustment * 100 AS NVARCHAR(10)) + '%' +
            '; Demand Adjustment: ' + CAST(@DemandAdjustment * 100 AS NVARCHAR(10)) + '%' +
            '; Tax Rate: ' + CAST(@TaxRate * 100 AS NVARCHAR(10)) + '%' +
            '; Shipping: $' + CAST(@ShippingCost AS NVARCHAR(20));
        
        SET @StatusMessage = 'Pricing calculated successfully with ' + 
                           CAST((@TotalDiscountRate + ABS(@TotalAdjustmentRate)) * 100 AS NVARCHAR(10)) + 
                           '% total adjustments applied.';
        
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        SET @StatusMessage = 'Error in pricing calculation: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
        
        -- Log the error
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate, ProductID, CustomerID
        )
        VALUES (
            @ErrorCode, @StatusMessage, 'sp_CalculateDynamicPricing',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @ProductID, @CustomerID
        );
        
        RETURN -1;
    END CATCH;
END;
GO

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

-- =====================================================================================
-- ADDITIONAL COMPLEX PROCEDURES FOR RETURNS, ANALYTICS, AND REPORTING
-- =====================================================================================

-- Procedure 8: Complex Returns and Refunds Processing
CREATE PROCEDURE sp_ProcessComplexReturn
    @OrderID INT,
    @ReturnItems NVARCHAR(MAX), -- JSON: [{"ProductID":1,"Quantity":2,"Reason":"DEFECTIVE","Condition":"DAMAGED"}]
    @ReturnReason VARCHAR(50),
    @CustomerComments NVARCHAR(MAX) = NULL,
    @ReturnMethodID INT = 1, -- 1=Ship Back, 2=Store Return, 3=Pickup
    @RefundMethodID INT = 1, -- 1=Original Payment, 2=Store Credit, 3=Exchange
    @ProcessedBy INT,
    @NewReturnID INT OUTPUT,
    @RefundAmount DECIMAL(18,2) OUTPUT,
    @StatusMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorCode INT = 0;
    DECLARE @ValidationResult BIT = 1;
    DECLARE @CustomerID INT;
    DECLARE @OrderDate DATETIME;
    DECLARE @OrderTotal DECIMAL(18,2);
    DECLARE @OrderStatus INT;
    DECLARE @DaysAfterOrder INT;
    DECLARE @ReturnPolicyDays INT = 30;
    DECLARE @TotalRefundable DECIMAL(18,2) = 0.00;
    DECLARE @RestockingFee DECIMAL(18,2) = 0.00;
    DECLARE @ShippingRefund DECIMAL(18,2) = 0.00;
    DECLARE @ProcessingFee DECIMAL(18,2) = 0.00;
    DECLARE @ItemCount INT = 0;
    DECLARE @ValidItems INT = 0;
    DECLARE @InvalidItems INT = 0;
    DECLARE @ReturnStatus VARCHAR(20) = 'PENDING';
    DECLARE @RequiresApproval BIT = 0;
    DECLARE @AutoApproveLimit DECIMAL(18,2) = 500.00;
    
    -- Temporary table for return items
    CREATE TABLE #ReturnItems (
        RowID INT IDENTITY(1,1),
        ProductID INT,
        OrderLineItemID INT,
        RequestedQuantity INT,
        OriginalQuantity INT,
        OriginalUnitPrice DECIMAL(18,2),
        ReturnReason VARCHAR(50),
        ItemCondition VARCHAR(20),
        RefundableAmount DECIMAL(18,2),
        RestockingFee DECIMAL(18,2),
        IsRefundable BIT DEFAULT 1,
        ValidationMessage NVARCHAR(500),
        ProcessingStatus VARCHAR(20) DEFAULT 'PENDING'
    );
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Phase 1: Order Validation
        SELECT 
            @CustomerID = CustomerID,
            @OrderDate = OrderDate,
            @OrderTotal = FinalAmount,
            @OrderStatus = OrderStatusID
        FROM Orders
        WHERE OrderID = @OrderID;
        
        IF @CustomerID IS NULL
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Order not found.';
            SET @ErrorCode = 5001;
            GOTO ErrorHandler;
        END;
        
        -- Check if order is eligible for returns
        IF @OrderStatus NOT IN (2, 3, 6) -- Confirmed, Partial, Shipped
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Order status does not allow returns. Status must be Confirmed, Partial, or Shipped.';
            SET @ErrorCode = 5002;
            GOTO ErrorHandler;
        END;
        
        -- Check return time window
        SET @DaysAfterOrder = DATEDIFF(DAY, @OrderDate, GETDATE());
        
        -- Get customer-specific return policy
        SELECT @ReturnPolicyDays = CASE 
            WHEN ct.TypeName IN ('VIP', 'Corporate', 'Wholesale') THEN 60
            WHEN ct.TypeName = 'Regular' THEN 30
            ELSE 14
        END
        FROM Customers c
        INNER JOIN CustomerTypes ct ON c.CustomerTypeID = ct.TypeID
        WHERE c.CustomerID = @CustomerID;
        
        IF @DaysAfterOrder > @ReturnPolicyDays
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Return period expired. Returns must be initiated within ' + CAST(@ReturnPolicyDays AS NVARCHAR(10)) + ' days.';
            SET @ErrorCode = 5003;
            GOTO ErrorHandler;
        END;
        
        -- Parse return items (simplified JSON parsing)
        IF @ReturnItems IS NULL OR LEN(TRIM(@ReturnItems)) = 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'Return items are required.';
            SET @ErrorCode = 5004;
            GOTO ErrorHandler;
        END;
        
        -- Simplified parsing - in production use proper JSON parsing
        DECLARE @ItemPosition INT = 1;
        DECLARE @ProductID INT, @ReturnQuantity INT, @ItemReason VARCHAR(50), @ItemCondition VARCHAR(20);
        
        WHILE @ItemPosition <= 5 -- Demo: process up to 5 return items
        BEGIN
            SET @ProductID = @ItemPosition;
            SET @ReturnQuantity = @ItemPosition;
            SET @ItemReason = @ReturnReason;
            SET @ItemCondition = CASE @ItemPosition % 3 
                WHEN 0 THEN 'NEW' 
                WHEN 1 THEN 'USED' 
                ELSE 'DAMAGED' 
            END;
            
            -- Validate item was in original order
            DECLARE @OrderLineItemID INT, @OriginalQty INT, @OriginalPrice DECIMAL(18,2);
            SELECT 
                @OrderLineItemID = OrderLineItemID,
                @OriginalQty = Quantity,
                @OriginalPrice = UnitPrice
            FROM OrderLineItems
            WHERE OrderID = @OrderID AND ProductID = @ProductID;
            
            IF @OrderLineItemID IS NOT NULL
            BEGIN
                -- Check if quantity is valid
                DECLARE @AlreadyReturned INT = 0;
                SELECT @AlreadyReturned = ISNULL(SUM(ReturnedQuantity), 0)
                FROM ReturnItems ri
                INNER JOIN Returns r ON ri.ReturnID = r.ReturnID
                WHERE r.OrderID = @OrderID AND ri.ProductID = @ProductID 
                  AND r.ReturnStatus NOT IN ('CANCELLED', 'REJECTED');
                
                DECLARE @AvailableForReturn INT = @OriginalQty - @AlreadyReturned;
                
                IF @ReturnQuantity <= @AvailableForReturn
                BEGIN
                    INSERT INTO #ReturnItems (
                        ProductID, OrderLineItemID, RequestedQuantity, OriginalQuantity,
                        OriginalUnitPrice, ReturnReason, ItemCondition
                    )
                    VALUES (
                        @ProductID, @OrderLineItemID, @ReturnQuantity, @OriginalQty,
                        @OriginalPrice, @ItemReason, @ItemCondition
                    );
                    SET @ItemCount = @ItemCount + 1;
                END;
            END;
            
            SET @ItemPosition = @ItemPosition + 1;
        END;
        
        IF @ItemCount = 0
        BEGIN
            SET @ValidationResult = 0;
            SET @StatusMessage = 'No valid return items found.';
            SET @ErrorCode = 5005;
            GOTO ErrorHandler;
        END;
        
        -- Phase 2: Calculate Refunds and Fees for Each Item
        DECLARE item_cursor CURSOR FOR
        SELECT RowID, ProductID, RequestedQuantity, OriginalUnitPrice, ReturnReason, ItemCondition
        FROM #ReturnItems;
        
        DECLARE @CurrentRowID INT, @CurrentProductID INT, @CurrentQty INT, @CurrentPrice DECIMAL(18,2);
        DECLARE @CurrentReason VARCHAR(50), @CurrentCondition VARCHAR(20);
        
        OPEN item_cursor;
        FETCH NEXT FROM item_cursor INTO @CurrentRowID, @CurrentProductID, @CurrentQty, @CurrentPrice, @CurrentReason, @CurrentCondition;
        
        WHILE @@FETCH_STATUS = 0
        BEGIN
            DECLARE @ItemRefund DECIMAL(18,2) = @CurrentPrice * @CurrentQty;
            DECLARE @ItemRestocking DECIMAL(18,2) = 0.00;
            DECLARE @IsItemRefundable BIT = 1;
            DECLARE @ValidationMsg NVARCHAR(500) = 'Valid for return';
            
            -- Apply business rules for refund calculation
            -- Rule 1: Defective items get full refund, no restocking fee
            IF @CurrentReason IN ('DEFECTIVE', 'WRONG_ITEM', 'DAMAGED_SHIPPING')
            BEGIN
                SET @ItemRefund = @CurrentPrice * @CurrentQty;
                SET @ItemRestocking = 0.00;
            END
            -- Rule 2: Customer changed mind - condition affects refund
            ELSE IF @CurrentReason IN ('CHANGED_MIND', 'NO_LONGER_NEEDED')
            BEGIN
                IF @CurrentCondition = 'NEW'
                BEGIN
                    SET @ItemRefund = @CurrentPrice * @CurrentQty * 0.95; -- 5% restocking fee
                    SET @ItemRestocking = @CurrentPrice * @CurrentQty * 0.05;
                END
                ELSE IF @CurrentCondition = 'USED'
                BEGIN
                    SET @ItemRefund = @CurrentPrice * @CurrentQty * 0.80; -- 20% restocking fee
                    SET @ItemRestocking = @CurrentPrice * @CurrentQty * 0.20;
                END
                ELSE -- DAMAGED
                BEGIN
                    SET @ItemRefund = @CurrentPrice * @CurrentQty * 0.50; -- 50% refund
                    SET @ItemRestocking = @CurrentPrice * @CurrentQty * 0.50;
                    SET @ValidationMsg = 'Damaged item - partial refund only';
                END;
            END
            -- Rule 3: Size/fit issues
            ELSE IF @CurrentReason IN ('WRONG_SIZE', 'POOR_FIT')
            BEGIN
                IF @CurrentCondition = 'NEW'
                BEGIN
                    SET @ItemRefund = @CurrentPrice * @CurrentQty * 0.90; -- 10% restocking fee
                    SET @ItemRestocking = @CurrentPrice * @CurrentQty * 0.10;
                END
                ELSE
                BEGIN
                    SET @ItemRefund = @CurrentPrice * @CurrentQty * 0.70; -- 30% restocking fee
                    SET @ItemRestocking = @CurrentPrice * @CurrentQty * 0.30;
                END;
            END
            -- Rule 4: Special categories (electronics, software) - stricter rules
            ELSE
            BEGIN
                DECLARE @ProductCategory VARCHAR(50);
                SELECT @ProductCategory = c.CategoryName
                FROM Products p
                INNER JOIN Categories c ON p.CategoryID = c.CategoryID
                WHERE p.ProductID = @CurrentProductID;
                
                IF @ProductCategory IN ('Electronics', 'Software', 'Digital')
                BEGIN
                    IF @DaysAfterOrder > 14
                    BEGIN
                        SET @IsItemRefundable = 0;
                        SET @ValidationMsg = 'Electronics/Software returns must be within 14 days';
                    END
                    ELSE IF @CurrentCondition != 'NEW'
                    BEGIN
                        SET @ItemRefund = @CurrentPrice * @CurrentQty * 0.60; -- 40% restocking
                        SET @ItemRestocking = @CurrentPrice * @CurrentQty * 0.40;
                        SET @ValidationMsg = 'Used electronics - significant restocking fee applied';
                    END;
                END;
            END;
            
            -- Update the temporary table with calculations
            UPDATE #ReturnItems
            SET RefundableAmount = @ItemRefund,
                RestockingFee = @ItemRestocking,
                IsRefundable = @IsItemRefundable,
                ValidationMessage = @ValidationMsg,
                ProcessingStatus = CASE WHEN @IsItemRefundable = 1 THEN 'APPROVED' ELSE 'REJECTED' END
            WHERE RowID = @CurrentRowID;
            
            IF @IsItemRefundable = 1
            BEGIN
                SET @ValidItems = @ValidItems + 1;
                SET @TotalRefundable = @TotalRefundable + @ItemRefund;
                SET @RestockingFee = @RestockingFee + @ItemRestocking;
            END
            ELSE
            BEGIN
                SET @InvalidItems = @InvalidItems + 1;
            END;
            
            FETCH NEXT FROM item_cursor INTO @CurrentRowID, @CurrentProductID, @CurrentQty, @CurrentPrice, @CurrentReason, @CurrentCondition;
        END;
        
        CLOSE item_cursor;
        DEALLOCATE item_cursor;
        
        -- Phase 3: Calculate Additional Fees and Refunds
        -- Shipping refund logic
        IF @ReturnReason IN ('DEFECTIVE', 'WRONG_ITEM', 'DAMAGED_SHIPPING')
        BEGIN
            SELECT @ShippingRefund = ISNULL(ShippingAmount, 0)
            FROM Orders
            WHERE OrderID = @OrderID;
        END
        ELSE IF @TotalRefundable >= 100.00 -- Free return shipping for orders over $100
        BEGIN
            SET @ShippingRefund = 0.00; -- Customer covers return shipping
        END;
        
        -- Processing fee for certain return methods
        IF @ReturnMethodID = 3 AND @RefundMethodID = 1 -- Pickup with original payment refund
        BEGIN
            SET @ProcessingFee = 5.00;
        END;
        
        -- Final refund calculation
        SET @RefundAmount = @TotalRefundable + @ShippingRefund - @ProcessingFee;
        
        -- Phase 4: Approval Logic
        IF @RefundAmount > @AutoApproveLimit OR @InvalidItems > 0
        BEGIN
            SET @RequiresApproval = 1;
            SET @ReturnStatus = 'PENDING_APPROVAL';
        END
        ELSE IF @ValidItems > 0
        BEGIN
            SET @ReturnStatus = 'APPROVED';
        END
        ELSE
        BEGIN
            SET @ReturnStatus = 'REJECTED';
        END;
        
        -- Phase 5: Create Return Record
        INSERT INTO Returns (
            OrderID, CustomerID, ReturnReason, CustomerComments,
            ReturnMethodID, RefundMethodID, TotalRefundAmount,
            RestockingFeeAmount, ShippingRefundAmount, ProcessingFeeAmount,
            ReturnStatus, RequiresApproval, CreatedDate, CreatedBy
        )
        VALUES (
            @OrderID, @CustomerID, @ReturnReason, @CustomerComments,
            @ReturnMethodID, @RefundMethodID, @RefundAmount,
            @RestockingFee, @ShippingRefund, @ProcessingFee,
            @ReturnStatus, @RequiresApproval, GETDATE(), @ProcessedBy
        );
        
        SET @NewReturnID = SCOPE_IDENTITY();
        
        -- Phase 6: Create Return Line Items
        INSERT INTO ReturnItems (
            ReturnID, ProductID, OrderLineItemID, ReturnedQuantity,
            OriginalUnitPrice, RefundableAmount, RestockingFeeAmount,
            ReturnReason, ItemCondition, ProcessingStatus, CreatedDate, CreatedBy
        )
        SELECT 
            @NewReturnID, ProductID, OrderLineItemID, RequestedQuantity,
            OriginalUnitPrice, RefundableAmount, RestockingFee,
            ReturnReason, ItemCondition, ProcessingStatus, GETDATE(), @ProcessedBy
        FROM #ReturnItems
        WHERE IsRefundable = 1;
        
        -- Phase 7: Generate Return Authorization Number
        DECLARE @ReturnAuthNumber NVARCHAR(20);
        SET @ReturnAuthNumber = 'RMA' + CAST(@NewReturnID AS NVARCHAR(10)) + 
                               FORMAT(GETDATE(), 'yyyyMMdd') + 
                               RIGHT('00' + CAST(@CustomerID % 100 AS NVARCHAR(2)), 2);
        
        UPDATE Returns
        SET ReturnAuthorizationNumber = @ReturnAuthNumber
        WHERE ReturnID = @NewReturnID;
        
        -- Phase 8: Trigger Notifications and Workflows
        IF @ReturnStatus = 'APPROVED'
        BEGIN
            -- Auto-approve and process refund for small amounts
            IF @RefundAmount <= @AutoApproveLimit
            BEGIN
                EXEC sp_ProcessReturnRefund @NewReturnID, @ProcessedBy;
            END;
            
            -- Send customer notification
            EXEC sp_SendReturnConfirmationNotification @NewReturnID, @ProcessedBy;
        END
        ELSE IF @ReturnStatus = 'PENDING_APPROVAL'
        BEGIN
            -- Create approval task
            INSERT INTO ApprovalTasks (
                TaskType, ReferenceID, RequiredApprovalLevel,
                TaskDescription, CreatedDate, CreatedBy
            )
            VALUES (
                'RETURN_APPROVAL', @NewReturnID, 'MANAGER',
                'Return approval required for $' + CAST(@RefundAmount AS NVARCHAR(20)) + ' refund',
                GETDATE(), @ProcessedBy
            );
        END;
        
        -- Phase 9: Audit Logging
        INSERT INTO ReturnAuditLog (
            ReturnID, ActionType, ActionDescription, CreatedDate, CreatedBy
        )
        VALUES (
            @NewReturnID, 'RETURN_INITIATED',
            'Return created: ' + CAST(@ValidItems AS NVARCHAR(10)) + ' valid items, $' + 
            CAST(@RefundAmount AS NVARCHAR(20)) + ' refund, Status: ' + @ReturnStatus,
            GETDATE(), @ProcessedBy
        );
        
        -- Set success message
        SET @StatusMessage = 'Return ' + @ReturnAuthNumber + ' created successfully. ' +
                           'Valid Items: ' + CAST(@ValidItems AS NVARCHAR(10)) + 
                           ', Invalid Items: ' + CAST(@InvalidItems AS NVARCHAR(10)) + 
                           ', Refund Amount: $' + CAST(@RefundAmount AS NVARCHAR(20)) + 
                           ', Status: ' + @ReturnStatus;
        
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @ValidationResult = 0;
        SET @StatusMessage = 'Error processing return: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
        
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate, OrderID
        )
        VALUES (
            @ErrorCode, @StatusMessage, 'sp_ProcessComplexReturn',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE(), @OrderID
        );
        
        RETURN -1;
    END CATCH;
    
    ErrorHandler:
    IF @ValidationResult = 0
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        RETURN @ErrorCode;
    END;
    
    -- Cleanup
    IF OBJECT_ID('tempdb..#ReturnItems') IS NOT NULL
        DROP TABLE #ReturnItems;
END;
GO

-- Function 6: Advanced Customer Lifetime Value Calculation
CREATE FUNCTION dbo.fn_CalculateCustomerLifetimeValue
(
    @CustomerID INT,
    @PredictionMonths INT = 12
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @CLV DECIMAL(18,2) = 0.00;
    DECLARE @AverageOrderValue DECIMAL(18,2) = 0.00;
    DECLARE @PurchaseFrequency DECIMAL(10,4) = 0.00;
    DECLARE @CustomerLifespan DECIMAL(10,2) = 0.00;
    DECLARE @ProfitMargin DECIMAL(5,4) = 0.20; -- 20% default profit margin
    DECLARE @ChurnProbability DECIMAL(5,4) = 0.00;
    DECLARE @RetentionRate DECIMAL(5,4) = 0.00;
    DECLARE @TotalOrders INT = 0;
    DECLARE @FirstOrderDate DATETIME;
    DECLARE @LastOrderDate DATETIME;
    DECLARE @CustomerAge INT = 0; -- Days since first order
    
    -- Get customer order history
    SELECT 
        @TotalOrders = COUNT(*),
        @AverageOrderValue = AVG(FinalAmount),
        @FirstOrderDate = MIN(OrderDate),
        @LastOrderDate = MAX(OrderDate)
    FROM Orders
    WHERE CustomerID = @CustomerID 
      AND OrderStatusID IN (2, 3, 6); -- Confirmed, Partial, Shipped
    
    -- If no orders, return 0
    IF @TotalOrders = 0
        RETURN 0.00;
    
    -- Calculate customer age in days
    SET @CustomerAge = DATEDIFF(DAY, @FirstOrderDate, GETDATE());
    
    -- Calculate purchase frequency (orders per month)
    IF @CustomerAge > 0
    BEGIN
        SET @PurchaseFrequency = (@TotalOrders * 30.0) / @CustomerAge;
    END
    ELSE
    BEGIN
        SET @PurchaseFrequency = @TotalOrders; -- Same day registration and purchase
    END;
    
    -- Calculate customer lifespan and retention metrics
    IF @TotalOrders > 1
    BEGIN
        -- Average days between orders
        DECLARE @AvgDaysBetweenOrders DECIMAL(10,2);
        SET @AvgDaysBetweenOrders = CAST(@CustomerAge AS DECIMAL(10,2)) / (@TotalOrders - 1);
        
        -- Estimate retention rate based on order consistency
        DECLARE @DaysSinceLastOrder INT = DATEDIFF(DAY, @LastOrderDate, GETDATE());
        
        IF @DaysSinceLastOrder <= @AvgDaysBetweenOrders * 2
        BEGIN
            SET @RetentionRate = 0.90; -- High retention
        END
        ELSE IF @DaysSinceLastOrder <= @AvgDaysBetweenOrders * 4
        BEGIN
            SET @RetentionRate = 0.70; -- Medium retention
        END
        ELSE
        BEGIN
            SET @RetentionRate = 0.40; -- Low retention
        END;
        
        -- Calculate churn probability
        SET @ChurnProbability = 1 - @RetentionRate;
        
        -- Estimate customer lifespan in months
        IF @ChurnProbability > 0
        BEGIN
            SET @CustomerLifespan = (1 / @ChurnProbability) * (@AvgDaysBetweenOrders / 30.0);
        END
        ELSE
        BEGIN
            SET @CustomerLifespan = @PredictionMonths; -- Use prediction period if no churn expected
        END;
    END
    ELSE
    BEGIN
        -- New customer - use industry averages
        SET @CustomerLifespan = 6.0; -- 6 months average for new customers
        SET @RetentionRate = 0.60; -- Conservative estimate
    END;
    
    -- Adjust based on customer type and tier
    DECLARE @CustomerTypeID INT, @CustomerTier VARCHAR(20);
    SELECT 
        @CustomerTypeID = c.CustomerTypeID,
        @CustomerTier = ISNULL(cs.CustomerTier, 'STANDARD')
    FROM Customers c
    LEFT JOIN CustomerStatistics cs ON c.CustomerID = cs.CustomerID
    WHERE c.CustomerID = @CustomerID;
    
    -- Customer type adjustments
    IF @CustomerTypeID = 2 -- VIP
    BEGIN
        SET @CustomerLifespan = @CustomerLifespan * 1.5;
        SET @RetentionRate = @RetentionRate * 1.2;
        SET @ProfitMargin = @ProfitMargin * 1.1; -- Higher margin customers
    END
    ELSE IF @CustomerTypeID IN (5, 6) -- Corporate, Wholesale
    BEGIN
        SET @CustomerLifespan = @CustomerLifespan * 2.0;
        SET @RetentionRate = @RetentionRate * 1.3;
        SET @ProfitMargin = @ProfitMargin * 0.9; -- Lower margin but higher volume
    END;
    
    -- Tier-based adjustments
    IF @CustomerTier = 'PLATINUM'
    BEGIN
        SET @CustomerLifespan = @CustomerLifespan * 1.8;
        SET @ProfitMargin = @ProfitMargin * 1.15;
    END
    ELSE IF @CustomerTier = 'GOLD'
    BEGIN
        SET @CustomerLifespan = @CustomerLifespan * 1.4;
        SET @ProfitMargin = @ProfitMargin * 1.10;
    END
    ELSE IF @CustomerTier = 'SILVER'
    BEGIN
        SET @CustomerLifespan = @CustomerLifespan * 1.2;
        SET @ProfitMargin = @ProfitMargin * 1.05;
    END;
    
    -- Seasonal and trend adjustments
    DECLARE @SeasonalMultiplier DECIMAL(4,2) = 1.00;
    DECLARE @CurrentMonth INT = MONTH(GETDATE());
    
    IF @CurrentMonth IN (11, 12) -- Holiday season
        SET @SeasonalMultiplier = 1.20;
    ELSE IF @CurrentMonth IN (1, 2) -- Post-holiday
        SET @SeasonalMultiplier = 0.85;
    ELSE IF @CurrentMonth IN (6, 7, 8) -- Summer
        SET @SeasonalMultiplier = 1.10;
    
    -- Calculate final CLV using the formula:
    -- CLV = (AOV × Purchase Frequency × Gross Margin × Customer Lifespan) × Seasonal Adjustment
    SET @CLV = (@AverageOrderValue * @PurchaseFrequency * @ProfitMargin * @CustomerLifespan) * @SeasonalMultiplier;
    
    -- Apply prediction period constraints
    IF @CustomerLifespan > @PredictionMonths
    BEGIN
        -- Limit to prediction period but apply discount rate for longer term
        DECLARE @DiscountRate DECIMAL(5,4) = 0.95; -- 5% annual discount rate
        DECLARE @MonthlyDiscountRate DECIMAL(8,6) = POWER(@DiscountRate, 1.0/12.0);
        DECLARE @PresentValueFactor DECIMAL(10,6) = (1 - POWER(@MonthlyDiscountRate, @PredictionMonths)) / (1 - @MonthlyDiscountRate);
        
        SET @CLV = (@AverageOrderValue * @PurchaseFrequency * @ProfitMargin) * @PresentValueFactor * @SeasonalMultiplier;
    END;
    
    -- Ensure realistic bounds
    IF @CLV < 0
        SET @CLV = 0.00;
    ELSE IF @CLV > 100000.00 -- Cap at $100k for data quality
        SET @CLV = 100000.00;
    
    RETURN @CLV;
END;
GO

-- =====================================================================================
-- FINAL COMPLEX E-COMMERCE SYSTEM SUMMARY
-- Total Procedures: 8 (Customer Management, Inventory Management, Dynamic Pricing, 
--                     Complex Order Processing, Inventory Updates, Notifications, 
--                     Customer Statistics, Returns Processing)
-- Total Functions: 6 (Tax Calculation, Shipping Calculation, Credit Validation,
--                     Inventory Allocation, Fraud Detection, Customer Lifetime Value)
-- CURRENT TOTAL LINES: 3000+ (Target: 4000+)
-- ===================================================================================== 

-- Procedure 9: Comprehensive Sales Analytics and Reporting Engine
CREATE PROCEDURE sp_GenerateAdvancedSalesAnalytics
    @StartDate DATETIME,
    @EndDate DATETIME,
    @CustomerTypeFilter VARCHAR(50) = NULL,
    @ProductCategoryFilter VARCHAR(50) = NULL,
    @RegionFilter VARCHAR(50) = NULL,
    @AnalysisType VARCHAR(20) = 'COMPREHENSIVE', -- COMPREHENSIVE, TRENDS, FORECASTING, COHORT
    @ReportFormat VARCHAR(20) = 'SUMMARY', -- SUMMARY, DETAILED, EXECUTIVE
    @CreatedBy INT,
    @ReportResults NVARCHAR(MAX) OUTPUT,
    @StatusMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @TotalRevenue DECIMAL(18,2) = 0.00;
    DECLARE @TotalOrders INT = 0;
    DECLARE @TotalCustomers INT = 0;
    DECLARE @AverageOrderValue DECIMAL(18,2) = 0.00;
    DECLARE @TotalProducts INT = 0;
    DECLARE @RevenueGrowth DECIMAL(5,2) = 0.00;
    DECLARE @CustomerRetentionRate DECIMAL(5,2) = 0.00;
    DECLARE @TopPerformingCategory NVARCHAR(100);
    DECLARE @TopPerformingProduct NVARCHAR(100);
    DECLARE @PeakSalesDay DATETIME;
    DECLARE @SeasonalityIndex DECIMAL(5,2) = 0.00;
    DECLARE @ConversionRate DECIMAL(5,2) = 0.00;
    DECLARE @CustomerAcquisitionCost DECIMAL(18,2) = 0.00;
    DECLARE @AverageCustomerLifetimeValue DECIMAL(18,2) = 0.00;
    DECLARE @ChurnRate DECIMAL(5,2) = 0.00;
    DECLARE @InventoryTurnover DECIMAL(5,2) = 0.00;
    DECLARE @ProfitMargin DECIMAL(5,2) = 0.00;
    DECLARE @ReportID INT;
    
    -- Temporary tables for complex analytics
    CREATE TABLE #SalesData (
        OrderDate DATE,
        OrderID INT,
        CustomerID INT,
        CustomerTypeID INT,
        ProductID INT,
        CategoryID INT,
        RegionID INT,
        Quantity INT,
        UnitPrice DECIMAL(18,2),
        LineTotal DECIMAL(18,2),
        DiscountAmount DECIMAL(18,2),
        TaxAmount DECIMAL(18,2),
        OrderTotal DECIMAL(18,2),
        ProfitAmount DECIMAL(18,2),
        CustomerAcquisitionDate DATE,
        IsNewCustomer BIT
    );
    
    CREATE TABLE #AnalyticsResults (
        MetricCategory VARCHAR(50),
        MetricName VARCHAR(100),
        MetricValue DECIMAL(18,4),
        MetricText NVARCHAR(500),
        SortOrder INT,
        MetricType VARCHAR(20) -- KPI, TREND, FORECAST, INSIGHT
    );
    
    CREATE TABLE #TrendData (
        PeriodDate DATE,
        Revenue DECIMAL(18,2),
        OrderCount INT,
        CustomerCount INT,
        AOV DECIMAL(18,2),
        GrowthRate DECIMAL(5,2),
        NewCustomers INT,
        ReturningCustomers INT,
        ConversionRate DECIMAL(5,2)
    );
    
    CREATE TABLE #CohortAnalysis (
        CohortMonth DATE,
        Period INT,
        CustomersInCohort INT,
        Revenue DECIMAL(18,2),
        RetentionRate DECIMAL(5,2),
        CLV DECIMAL(18,2)
    );
    
    CREATE TABLE #ProductPerformance (
        ProductID INT,
        ProductName NVARCHAR(100),
        CategoryName NVARCHAR(100),
        TotalRevenue DECIMAL(18,2),
        TotalQuantity INT,
        AveragePrice DECIMAL(18,2),
        ProfitMargin DECIMAL(5,2),
        InventoryTurnover DECIMAL(5,2),
        CustomerSatisfactionScore DECIMAL(3,1),
        ReturnRate DECIMAL(5,2)
    );
    
    CREATE TABLE #CustomerSegmentation (
        CustomerID INT,
        CustomerTier VARCHAR(20),
        TotalSpent DECIMAL(18,2),
        OrderCount INT,
        AverageOrderValue DECIMAL(18,2),
        LastOrderDate DATE,
        DaysSinceLastOrder INT,
        CLV DECIMAL(18,2),
        ChurnProbability DECIMAL(5,2),
        RecommendedAction VARCHAR(100)
    );
    
    CREATE TABLE #ForecastData (
        ForecastDate DATE,
        PredictedRevenue DECIMAL(18,2),
        PredictedOrders INT,
        ConfidenceLevel DECIMAL(5,2),
        SeasonalFactor DECIMAL(5,2),
        TrendFactor DECIMAL(5,2)
    );
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Phase 1: Data Collection and Filtering
        INSERT INTO #SalesData
        SELECT 
            CAST(o.OrderDate AS DATE) as OrderDate,
            o.OrderID,
            o.CustomerID,
            c.CustomerTypeID,
            oli.ProductID,
            p.CategoryID,
            ISNULL(a.RegionID, 1) as RegionID,
            oli.Quantity,
            oli.UnitPrice,
            oli.LineTotal,
            oli.DiscountAmount,
            oli.TaxAmount,
            o.FinalAmount,
            oli.LineTotal * 0.25 as ProfitAmount, -- Estimated 25% profit margin
            CAST(c.CreatedDate AS DATE) as CustomerAcquisitionDate,
            CASE WHEN DATEDIFF(DAY, c.CreatedDate, o.OrderDate) <= 30 THEN 1 ELSE 0 END as IsNewCustomer
        FROM Orders o
        INNER JOIN OrderLineItems oli ON o.OrderID = oli.OrderID
        INNER JOIN Customers c ON o.CustomerID = c.CustomerID
        INNER JOIN Products p ON oli.ProductID = p.ProductID
        LEFT JOIN Addresses a ON o.ShippingAddressID = a.AddressID
        WHERE o.OrderDate BETWEEN @StartDate AND @EndDate
          AND o.OrderStatusID IN (2, 3, 6) -- Confirmed, Partial, Shipped
          AND (@CustomerTypeFilter IS NULL OR c.CustomerTypeID IN (
              SELECT TypeID FROM CustomerTypes WHERE TypeName = @CustomerTypeFilter
          ))
          AND (@ProductCategoryFilter IS NULL OR p.CategoryID IN (
              SELECT CategoryID FROM Categories WHERE CategoryName = @ProductCategoryFilter
          ))
          AND (@RegionFilter IS NULL OR a.RegionID IN (
              SELECT RegionID FROM Regions WHERE RegionName = @RegionFilter
          ));
        
        -- Phase 2: Basic Metrics Calculation
        SELECT 
            @TotalRevenue = SUM(DISTINCT OrderTotal),
            @TotalOrders = COUNT(DISTINCT OrderID),
            @TotalCustomers = COUNT(DISTINCT CustomerID),
            @TotalProducts = COUNT(DISTINCT ProductID)
        FROM #SalesData;
        
        SET @AverageOrderValue = CASE WHEN @TotalOrders > 0 THEN @TotalRevenue / @TotalOrders ELSE 0 END;
        
        -- Calculate profit margin
        DECLARE @TotalProfit DECIMAL(18,2);
        SELECT @TotalProfit = SUM(ProfitAmount) FROM #SalesData;
        SET @ProfitMargin = CASE WHEN @TotalRevenue > 0 THEN (@TotalProfit / @TotalRevenue) * 100 ELSE 0 END;
        
        -- Phase 3: Advanced Metrics Calculation
        IF @AnalysisType IN ('COMPREHENSIVE', 'TRENDS')
        BEGIN
            -- Growth Rate Calculation (vs previous period)
            DECLARE @PreviousPeriodRevenue DECIMAL(18,2) = 0.00;
            DECLARE @PeriodDays INT = DATEDIFF(DAY, @StartDate, @EndDate);
            DECLARE @PreviousStartDate DATETIME = DATEADD(DAY, -@PeriodDays - 1, @StartDate);
            DECLARE @PreviousEndDate DATETIME = DATEADD(DAY, -1, @StartDate);
            
            SELECT @PreviousPeriodRevenue = ISNULL(SUM(FinalAmount), 0)
            FROM Orders
            WHERE OrderDate BETWEEN @PreviousStartDate AND @PreviousEndDate
              AND OrderStatusID IN (2, 3, 6);
            
            SET @RevenueGrowth = CASE 
                WHEN @PreviousPeriodRevenue > 0 THEN ((@TotalRevenue - @PreviousPeriodRevenue) / @PreviousPeriodRevenue) * 100
                ELSE 0
            END;
            
            -- Customer Retention Rate
            DECLARE @ReturningCustomers INT = 0;
            SELECT @ReturningCustomers = COUNT(DISTINCT sd.CustomerID)
            FROM #SalesData sd
            WHERE EXISTS (
                SELECT 1 FROM Orders o 
                WHERE o.CustomerID = sd.CustomerID 
                  AND o.OrderDate < @StartDate
                  AND o.OrderStatusID IN (2, 3, 6)
            );
            
            SET @CustomerRetentionRate = CASE 
                WHEN @TotalCustomers > 0 THEN (@ReturningCustomers * 100.0) / @TotalCustomers
                ELSE 0
            END;
            
            -- Churn Rate Calculation
            DECLARE @TotalActiveCustomers INT;
            SELECT @TotalActiveCustomers = COUNT(DISTINCT CustomerID)
            FROM Orders
            WHERE OrderDate >= DATEADD(MONTH, -12, @StartDate)
              AND OrderStatusID IN (2, 3, 6);
            
            DECLARE @ChurnedCustomers INT;
            SELECT @ChurnedCustomers = COUNT(DISTINCT CustomerID)
            FROM Orders
            WHERE OrderDate BETWEEN DATEADD(MONTH, -12, @StartDate) AND DATEADD(MONTH, -6, @StartDate)
              AND OrderStatusID IN (2, 3, 6)
              AND CustomerID NOT IN (
                  SELECT DISTINCT CustomerID FROM Orders
                  WHERE OrderDate >= DATEADD(MONTH, -6, @StartDate)
                    AND OrderStatusID IN (2, 3, 6)
              );
            
            SET @ChurnRate = CASE 
                WHEN @TotalActiveCustomers > 0 THEN (@ChurnedCustomers * 100.0) / @TotalActiveCustomers
                ELSE 0
            END;
            
            -- Top Performing Category
            SELECT TOP 1 @TopPerformingCategory = cat.CategoryName
            FROM #SalesData sd
            INNER JOIN Categories cat ON sd.CategoryID = cat.CategoryID
            GROUP BY cat.CategoryName
            ORDER BY SUM(sd.LineTotal) DESC;
            
            -- Top Performing Product
            SELECT TOP 1 @TopPerformingProduct = p.ProductName
            FROM #SalesData sd
            INNER JOIN Products p ON sd.ProductID = p.ProductID
            GROUP BY p.ProductName
            ORDER BY SUM(sd.LineTotal) DESC;
            
            -- Peak Sales Day
            SELECT TOP 1 @PeakSalesDay = sd.OrderDate
            FROM #SalesData sd
            GROUP BY sd.OrderDate
            ORDER BY SUM(sd.OrderTotal) DESC;
            
            -- Conversion Rate (simplified - orders vs website visits)
            DECLARE @WebsiteVisits INT = @TotalOrders * 15; -- Estimated 15:1 visit to order ratio
            SET @ConversionRate = CASE WHEN @WebsiteVisits > 0 THEN (@TotalOrders * 100.0) / @WebsiteVisits ELSE 0 END;
            
            -- Customer Acquisition Cost (simplified)
            DECLARE @MarketingSpend DECIMAL(18,2) = @TotalRevenue * 0.08; -- Estimated 8% of revenue
            DECLARE @NewCustomers INT;
            SELECT @NewCustomers = COUNT(DISTINCT CustomerID) FROM #SalesData WHERE IsNewCustomer = 1;
            SET @CustomerAcquisitionCost = CASE WHEN @NewCustomers > 0 THEN @MarketingSpend / @NewCustomers ELSE 0 END;
            
            -- Average Customer Lifetime Value
            SELECT @AverageCustomerLifetimeValue = AVG(dbo.fn_CalculateCustomerLifetimeValue(CustomerID, 12))
            FROM (SELECT DISTINCT CustomerID FROM #SalesData) CustomerList;
            
            -- Daily Trend Analysis
            INSERT INTO #TrendData
            SELECT 
                OrderDate,
                SUM(DISTINCT OrderTotal) as Revenue,
                COUNT(DISTINCT OrderID) as OrderCount,
                COUNT(DISTINCT CustomerID) as CustomerCount,
                CASE WHEN COUNT(DISTINCT OrderID) > 0 
                     THEN SUM(DISTINCT OrderTotal) / COUNT(DISTINCT OrderID) 
                     ELSE 0 END as AOV,
                0.00 as GrowthRate, -- Will calculate separately
                SUM(CASE WHEN IsNewCustomer = 1 THEN 1 ELSE 0 END) as NewCustomers,
                COUNT(DISTINCT CustomerID) - SUM(CASE WHEN IsNewCustomer = 1 THEN 1 ELSE 0 END) as ReturningCustomers,
                0.00 as ConversionRate -- Simplified
            FROM #SalesData
            GROUP BY OrderDate
            ORDER BY OrderDate;
            
            -- Calculate daily growth rates
            UPDATE td1 
            SET GrowthRate = CASE 
                WHEN td2.Revenue > 0 THEN ((td1.Revenue - td2.Revenue) / td2.Revenue) * 100
                ELSE 0
            END
            FROM #TrendData td1
            LEFT JOIN #TrendData td2 ON td2.PeriodDate = DATEADD(DAY, -1, td1.PeriodDate);
            
            -- Inventory Turnover (simplified)
            DECLARE @AverageInventoryValue DECIMAL(18,2);
            SELECT @AverageInventoryValue = AVG(QuantityAvailable * CostPerUnit)
            FROM Inventory i
            INNER JOIN (SELECT DISTINCT ProductID FROM #SalesData) sp ON i.ProductID = sp.ProductID;
            
            DECLARE @COGS DECIMAL(18,2) = @TotalRevenue * 0.75; -- Estimated 75% COGS
            SET @InventoryTurnover = CASE WHEN @AverageInventoryValue > 0 THEN @COGS / @AverageInventoryValue ELSE 0 END;
        END;
        
        -- Phase 4: Product Performance Analysis
        IF @AnalysisType IN ('COMPREHENSIVE', 'TRENDS')
        BEGIN
            INSERT INTO #ProductPerformance
            SELECT 
                p.ProductID,
                p.ProductName,
                c.CategoryName,
                SUM(sd.LineTotal) as TotalRevenue,
                SUM(sd.Quantity) as TotalQuantity,
                AVG(sd.UnitPrice) as AveragePrice,
                AVG(sd.ProfitAmount / NULLIF(sd.LineTotal, 0)) * 100 as ProfitMargin,
                0.00 as InventoryTurnover, -- Simplified
                4.2 as CustomerSatisfactionScore, -- Mock data
                5.5 as ReturnRate -- Mock data
            FROM #SalesData sd
            INNER JOIN Products p ON sd.ProductID = p.ProductID
            INNER JOIN Categories c ON p.CategoryID = c.CategoryID
            GROUP BY p.ProductID, p.ProductName, c.CategoryName;
        END;
        
        -- Phase 5: Customer Segmentation Analysis
        IF @AnalysisType IN ('COMPREHENSIVE', 'COHORT')
        BEGIN
            INSERT INTO #CustomerSegmentation
            SELECT 
                c.CustomerID,
                CASE 
                    WHEN TotalSpent >= 10000 THEN 'PLATINUM'
                    WHEN TotalSpent >= 5000 THEN 'GOLD'
                    WHEN TotalSpent >= 2000 THEN 'SILVER'
                    WHEN TotalSpent >= 500 THEN 'BRONZE'
                    ELSE 'STANDARD'
                END as CustomerTier,
                TotalSpent,
                OrderCount,
                TotalSpent / NULLIF(OrderCount, 0) as AverageOrderValue,
                LastOrderDate,
                DATEDIFF(DAY, LastOrderDate, GETDATE()) as DaysSinceLastOrder,
                dbo.fn_CalculateCustomerLifetimeValue(c.CustomerID, 12) as CLV,
                CASE 
                    WHEN DATEDIFF(DAY, LastOrderDate, GETDATE()) > 180 THEN 85.0
                    WHEN DATEDIFF(DAY, LastOrderDate, GETDATE()) > 90 THEN 60.0
                    WHEN DATEDIFF(DAY, LastOrderDate, GETDATE()) > 30 THEN 25.0
                    ELSE 10.0
                END as ChurnProbability,
                CASE 
                    WHEN DATEDIFF(DAY, LastOrderDate, GETDATE()) > 180 THEN 'WIN_BACK_CAMPAIGN'
                    WHEN DATEDIFF(DAY, LastOrderDate, GETDATE()) > 90 THEN 'RETENTION_OFFER'
                    WHEN TotalSpent >= 5000 THEN 'VIP_PROGRAM'
                    WHEN OrderCount = 1 THEN 'SECOND_PURCHASE_INCENTIVE'
                    ELSE 'MAINTAIN_ENGAGEMENT'
                END as RecommendedAction
            FROM (
                SELECT 
                    sd.CustomerID,
                    SUM(sd.LineTotal) as TotalSpent,
                    COUNT(DISTINCT sd.OrderID) as OrderCount,
                    MAX(sd.OrderDate) as LastOrderDate
                FROM #SalesData sd
                GROUP BY sd.CustomerID
            ) c;
        END;
        
        -- Phase 6: Cohort Analysis
        IF @AnalysisType = 'COHORT'
        BEGIN
            INSERT INTO #CohortAnalysis
            SELECT 
                CohortMonth,
                Period,
                COUNT(DISTINCT CustomerID) as CustomersInCohort,
                SUM(Revenue) as Revenue,
                CASE 
                    WHEN Period = 0 THEN 100.0
                    ELSE (COUNT(DISTINCT CustomerID) * 100.0) / 
                         NULLIF((SELECT COUNT(DISTINCT CustomerID) 
                                FROM #SalesData sd2 
                                WHERE DATEFROMPARTS(YEAR(sd2.CustomerAcquisitionDate), MONTH(sd2.CustomerAcquisitionDate), 1) = CohortMonth), 0)
                END as RetentionRate,
                AVG(dbo.fn_CalculateCustomerLifetimeValue(CustomerID, 12)) as CLV
            FROM (
                SELECT 
                    DATEFROMPARTS(YEAR(sd.CustomerAcquisitionDate), MONTH(sd.CustomerAcquisitionDate), 1) as CohortMonth,
                    DATEDIFF(MONTH, sd.CustomerAcquisitionDate, sd.OrderDate) as Period,
                    sd.CustomerID,
                    SUM(sd.LineTotal) as Revenue
                FROM #SalesData sd
                GROUP BY 
                    DATEFROMPARTS(YEAR(sd.CustomerAcquisitionDate), MONTH(sd.CustomerAcquisitionDate), 1),
                    DATEDIFF(MONTH, sd.CustomerAcquisitionDate, sd.OrderDate),
                    sd.CustomerID
            ) CohortData
            GROUP BY CohortMonth, Period;
        END;
        
        -- Phase 7: Forecasting (if requested)
        IF @AnalysisType = 'FORECASTING'
        BEGIN
            -- Simple linear regression forecasting for next 30 days
            DECLARE @ForecastDays INT = 30;
            DECLARE @DayCounter INT = 1;
            DECLARE @BaseRevenue DECIMAL(18,2) = @TotalRevenue / NULLIF(@PeriodDays, 0);
            DECLARE @GrowthTrend DECIMAL(5,4) = @RevenueGrowth / 100.0 / 30.0; -- Daily growth rate
            
            WHILE @DayCounter <= @ForecastDays
            BEGIN
                DECLARE @ForecastDate DATE = DATEADD(DAY, @DayCounter, @EndDate);
                DECLARE @SeasonalFactor DECIMAL(5,2) = 1.0;
                DECLARE @TrendFactor DECIMAL(5,2) = 1.0 + (@GrowthTrend * @DayCounter);
                
                -- Apply seasonal factors
                DECLARE @ForecastMonth INT = MONTH(@ForecastDate);
                DECLARE @ForecastDayOfWeek INT = DATEPART(WEEKDAY, @ForecastDate);
                
                IF @ForecastMonth IN (11, 12) SET @SeasonalFactor = 1.4; -- Holiday boost
                ELSE IF @ForecastMonth IN (1, 2) SET @SeasonalFactor = 0.8; -- Post-holiday dip
                ELSE IF @ForecastMonth IN (6, 7, 8) SET @SeasonalFactor = 1.1; -- Summer increase
                
                IF @ForecastDayOfWeek IN (1, 7) SET @SeasonalFactor = @SeasonalFactor * 0.7; -- Weekend reduction
                
                DECLARE @PredictedRevenue DECIMAL(18,2) = @BaseRevenue * @TrendFactor * @SeasonalFactor;
                DECLARE @PredictedOrders INT = CAST(@PredictedRevenue / NULLIF(@AverageOrderValue, 0) AS INT);
                DECLARE @ConfidenceLevel DECIMAL(5,2) = CASE 
                    WHEN @DayCounter <= 7 THEN 85.0
                    WHEN @DayCounter <= 14 THEN 75.0
                    WHEN @DayCounter <= 21 THEN 65.0
                    ELSE 55.0
                END;
                
                INSERT INTO #ForecastData VALUES (
                    @ForecastDate, @PredictedRevenue, @PredictedOrders, 
                    @ConfidenceLevel, @SeasonalFactor, @TrendFactor
                );
                
                SET @DayCounter = @DayCounter + 1;
            END;
        END;
        
        -- Phase 8: Seasonality Analysis
        IF @AnalysisType IN ('COMPREHENSIVE', 'TRENDS')
        BEGIN
            DECLARE @AverageWeeklyRevenue DECIMAL(18,2);
            SELECT @AverageWeeklyRevenue = AVG(WeeklyRevenue)
            FROM (
                SELECT DATEPART(WEEK, OrderDate) as WeekNum, SUM(DISTINCT OrderTotal) as WeeklyRevenue
                FROM #SalesData
                GROUP BY DATEPART(WEEK, OrderDate)
            ) WeeklyData;
            
            DECLARE @CurrentWeekRevenue DECIMAL(18,2);
            SELECT @CurrentWeekRevenue = SUM(DISTINCT OrderTotal)
            FROM #SalesData
            WHERE DATEPART(WEEK, OrderDate) = DATEPART(WEEK, GETDATE());
            
            SET @SeasonalityIndex = CASE 
                WHEN @AverageWeeklyRevenue > 0 THEN (@CurrentWeekRevenue / @AverageWeeklyRevenue) * 100
                ELSE 100
            END;
        END;
        
        -- Phase 9: Compile Results
        INSERT INTO #AnalyticsResults VALUES
        ('Revenue', 'Total Revenue', @TotalRevenue, '$' + FORMAT(@TotalRevenue, 'N2'), 1, 'KPI'),
        ('Revenue', 'Revenue Growth', @RevenueGrowth, FORMAT(@RevenueGrowth, 'N2') + '%', 2, 'KPI'),
        ('Revenue', 'Profit Margin', @ProfitMargin, FORMAT(@ProfitMargin, 'N2') + '%', 3, 'KPI'),
        ('Orders', 'Total Orders', @TotalOrders, FORMAT(@TotalOrders, 'N0'), 4, 'KPI'),
        ('Orders', 'Average Order Value', @AverageOrderValue, '$' + FORMAT(@AverageOrderValue, 'N2'), 5, 'KPI'),
        ('Customers', 'Total Customers', @TotalCustomers, FORMAT(@TotalCustomers, 'N0'), 6, 'KPI'),
        ('Customers', 'Customer Retention Rate', @CustomerRetentionRate, FORMAT(@CustomerRetentionRate, 'N2') + '%', 7, 'KPI'),
        ('Customers', 'Churn Rate', @ChurnRate, FORMAT(@ChurnRate, 'N2') + '%', 8, 'KPI'),
        ('Customers', 'Customer Acquisition Cost', @CustomerAcquisitionCost, '$' + FORMAT(@CustomerAcquisitionCost, 'N2'), 9, 'KPI'),
        ('Customers', 'Average CLV', @AverageCustomerLifetimeValue, '$' + FORMAT(@AverageCustomerLifetimeValue, 'N2'), 10, 'KPI'),
        ('Performance', 'Conversion Rate', @ConversionRate, FORMAT(@ConversionRate, 'N2') + '%', 11, 'KPI'),
        ('Performance', 'Inventory Turnover', @InventoryTurnover, FORMAT(@InventoryTurnover, 'N2'), 12, 'KPI'),
        ('Products', 'Total Products Sold', @TotalProducts, FORMAT(@TotalProducts, 'N0'), 13, 'KPI'),
        ('Performance', 'Top Category', 0, @TopPerformingCategory, 14, 'INSIGHT'),
        ('Performance', 'Top Product', 0, @TopPerformingProduct, 15, 'INSIGHT'),
        ('Performance', 'Peak Sales Day', 0, FORMAT(@PeakSalesDay, 'yyyy-MM-dd'), 16, 'INSIGHT'),
        ('Trends', 'Seasonality Index', @SeasonalityIndex, FORMAT(@SeasonalityIndex, 'N2') + '%', 17, 'TREND');
        
        -- Phase 10: Format Output Based on Report Type
        IF @ReportFormat = 'EXECUTIVE'
        BEGIN
            SET @ReportResults = 
                'EXECUTIVE SALES DASHBOARD (' + FORMAT(@StartDate, 'yyyy-MM-dd') + ' to ' + FORMAT(@EndDate, 'yyyy-MM-dd') + ')' + CHAR(13) + CHAR(10) +
                '═══════════════════════════════════════════════════════════════' + CHAR(13) + CHAR(10) +
                'FINANCIAL PERFORMANCE:' + CHAR(13) + CHAR(10) +
                '  Total Revenue: $' + FORMAT(@TotalRevenue, 'N0') + CHAR(13) + CHAR(10) +
                '  Growth Rate: ' + FORMAT(@RevenueGrowth, 'N1') + '%' + CHAR(13) + CHAR(10) +
                '  Profit Margin: ' + FORMAT(@ProfitMargin, 'N1') + '%' + CHAR(13) + CHAR(10) +
                CHAR(13) + CHAR(10) +
                'CUSTOMER METRICS:' + CHAR(13) + CHAR(10) +
                '  Total Customers: ' + FORMAT(@TotalCustomers, 'N0') + CHAR(13) + CHAR(10) +
                '  Retention Rate: ' + FORMAT(@CustomerRetentionRate, 'N1') + '%' + CHAR(13) + CHAR(10) +
                '  Churn Rate: ' + FORMAT(@ChurnRate, 'N1') + '%' + CHAR(13) + CHAR(10) +
                '  Avg CLV: $' + FORMAT(@AverageCustomerLifetimeValue, 'N0') + CHAR(13) + CHAR(10) +
                CHAR(13) + CHAR(10) +
                'OPERATIONAL METRICS:' + CHAR(13) + CHAR(10) +
                '  Total Orders: ' + FORMAT(@TotalOrders, 'N0') + CHAR(13) + CHAR(10) +
                '  Average Order Value: $' + FORMAT(@AverageOrderValue, 'N2') + CHAR(13) + CHAR(10) +
                '  Conversion Rate: ' + FORMAT(@ConversionRate, 'N1') + '%' + CHAR(13) + CHAR(10) +
                '  Inventory Turnover: ' + FORMAT(@InventoryTurnover, 'N1') + CHAR(13) + CHAR(10) +
                CHAR(13) + CHAR(10) +
                'TOP PERFORMERS:' + CHAR(13) + CHAR(10) +
                '  Category: ' + ISNULL(@TopPerformingCategory, 'N/A') + CHAR(13) + CHAR(10) +
                '  Product: ' + ISNULL(@TopPerformingProduct, 'N/A') + CHAR(13) + CHAR(10) +
                '  Peak Sales Day: ' + FORMAT(@PeakSalesDay, 'yyyy-MM-dd');
        END
        ELSE IF @ReportFormat = 'DETAILED'
        BEGIN
            SET @ReportResults = 'DETAILED ANALYTICS REPORT' + CHAR(13) + CHAR(10) +
                               '═══════════════════════════════════════' + CHAR(13) + CHAR(10);
            
            -- Build detailed report from analytics results
            DECLARE @MetricCategory VARCHAR(50), @MetricName VARCHAR(100), @MetricText NVARCHAR(500), @MetricType VARCHAR(20);
            DECLARE @CurrentCategory VARCHAR(50) = '';
            
            DECLARE results_cursor CURSOR FOR
            SELECT MetricCategory, MetricName, MetricText, MetricType
            FROM #AnalyticsResults
            ORDER BY SortOrder;
            
            OPEN results_cursor;
            FETCH NEXT FROM results_cursor INTO @MetricCategory, @MetricName, @MetricText, @MetricType;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                IF @MetricCategory != @CurrentCategory
                BEGIN
                    SET @ReportResults = @ReportResults + CHAR(13) + CHAR(10) + @MetricCategory + ' METRICS:' + CHAR(13) + CHAR(10);
                    SET @CurrentCategory = @MetricCategory;
                END;
                
                SET @ReportResults = @ReportResults + '  ' + @MetricName + ': ' + @MetricText + 
                                   ' [' + @MetricType + ']' + CHAR(13) + CHAR(10);
                
                FETCH NEXT FROM results_cursor INTO @MetricCategory, @MetricName, @MetricText, @MetricType;
            END;
            
            CLOSE results_cursor;
            DEALLOCATE results_cursor;
            
            -- Add trend analysis if available
            IF EXISTS (SELECT 1 FROM #TrendData)
            BEGIN
                SET @ReportResults = @ReportResults + CHAR(13) + CHAR(10) + 'DAILY TRENDS:' + CHAR(13) + CHAR(10);
                
                DECLARE @TrendDate DATE, @TrendRevenue DECIMAL(18,2), @TrendGrowth DECIMAL(5,2);
                DECLARE trend_cursor CURSOR FOR
                SELECT TOP 10 PeriodDate, Revenue, GrowthRate FROM #TrendData ORDER BY PeriodDate DESC;
                
                OPEN trend_cursor;
                FETCH NEXT FROM trend_cursor INTO @TrendDate, @TrendRevenue, @TrendGrowth;
                
                WHILE @@FETCH_STATUS = 0
                BEGIN
                    SET @ReportResults = @ReportResults + '  ' + FORMAT(@TrendDate, 'yyyy-MM-dd') + 
                                       ': $' + FORMAT(@TrendRevenue, 'N0') + 
                                       ' (' + FORMAT(@TrendGrowth, 'N1') + '%)' + CHAR(13) + CHAR(10);
                    FETCH NEXT FROM trend_cursor INTO @TrendDate, @TrendRevenue, @TrendGrowth;
                END;
                
                CLOSE trend_cursor;
                DEALLOCATE trend_cursor;
            END;
        END
        ELSE -- SUMMARY
        BEGIN
            SET @ReportResults = 
                'Sales Analytics Summary: Revenue: $' + FORMAT(@TotalRevenue, 'N0') + 
                ', Orders: ' + FORMAT(@TotalOrders, 'N0') + 
                ', Customers: ' + FORMAT(@TotalCustomers, 'N0') + 
                ', AOV: $' + FORMAT(@AverageOrderValue, 'N2') + 
                ', Growth: ' + FORMAT(@RevenueGrowth, 'N1') + '%' +
                ', Retention: ' + FORMAT(@CustomerRetentionRate, 'N1') + '%' +
                ', CLV: $' + FORMAT(@AverageCustomerLifetimeValue, 'N0');
        END;
        
        -- Phase 11: Save Report to Database
        INSERT INTO AnalyticsReports (
            ReportType, ReportPeriodStart, ReportPeriodEnd,
            ReportParameters, ReportResults, TotalRevenue, TotalOrders,
            TotalCustomers, AverageOrderValue, RevenueGrowthRate,
            CustomerRetentionRate, CreatedDate, CreatedBy
        )
        VALUES (
            @AnalysisType + '_' + @ReportFormat,
            @StartDate, @EndDate,
            'CustomerType:' + ISNULL(@CustomerTypeFilter, 'ALL') + 
            ',Category:' + ISNULL(@ProductCategoryFilter, 'ALL') + 
            ',Region:' + ISNULL(@RegionFilter, 'ALL'),
            @ReportResults, @TotalRevenue, @TotalOrders, @TotalCustomers,
            @AverageOrderValue, @RevenueGrowth, @CustomerRetentionRate,
            GETDATE(), @CreatedBy
        );
        
        SET @ReportID = SCOPE_IDENTITY();
        
        -- Phase 12: Save Detailed Analytics Data
        IF @ReportFormat = 'DETAILED'
        BEGIN
            -- Save customer segmentation results
            INSERT INTO CustomerSegmentationResults (
                ReportID, CustomerID, CustomerTier, TotalSpent, OrderCount,
                AverageOrderValue, CLV, ChurnProbability, RecommendedAction,
                CreatedDate, CreatedBy
            )
            SELECT 
                @ReportID, CustomerID, CustomerTier, TotalSpent, OrderCount,
                AverageOrderValue, CLV, ChurnProbability, RecommendedAction,
                GETDATE(), @CreatedBy
            FROM #CustomerSegmentation;
            
            -- Save product performance results
            INSERT INTO ProductPerformanceResults (
                ReportID, ProductID, ProductName, CategoryName, TotalRevenue,
                TotalQuantity, AveragePrice, ProfitMargin, CreatedDate, CreatedBy
            )
            SELECT 
                @ReportID, ProductID, ProductName, CategoryName, TotalRevenue,
                TotalQuantity, AveragePrice, ProfitMargin, GETDATE(), @CreatedBy
            FROM #ProductPerformance;
        END;
        
        -- Phase 13: Generate Insights and Recommendations
        DECLARE @KeyInsights NVARCHAR(MAX) = '';
        
        IF @RevenueGrowth > 20
            SET @KeyInsights = @KeyInsights + 'Strong revenue growth indicates successful business expansion. ';
        ELSE IF @RevenueGrowth < -10
            SET @KeyInsights = @KeyInsights + 'Declining revenue requires immediate attention and strategy review. ';
        
        IF @CustomerRetentionRate < 60
            SET @KeyInsights = @KeyInsights + 'Low retention rate suggests need for customer loyalty programs. ';
        ELSE IF @CustomerRetentionRate > 80
            SET @KeyInsights = @KeyInsights + 'Excellent retention rate indicates strong customer satisfaction. ';
        
        IF @ConversionRate < 2
            SET @KeyInsights = @KeyInsights + 'Low conversion rate suggests website optimization opportunities. ';
        
        IF @AverageCustomerLifetimeValue > @CustomerAcquisitionCost * 3
            SET @KeyInsights = @KeyInsights + 'Healthy CLV to CAC ratio indicates profitable customer acquisition. ';
        
        -- Update report with insights
        UPDATE AnalyticsReports 
        SET KeyInsights = @KeyInsights
        WHERE ReportID = @ReportID;
        
        SET @StatusMessage = 'Advanced analytics report generated successfully. ' + 
                           'Revenue: $' + FORMAT(@TotalRevenue, 'N0') + 
                           ', Growth: ' + FORMAT(@RevenueGrowth, 'N1') + '%' +
                           ', Customers: ' + FORMAT(@TotalCustomers, 'N0') + 
                           ', Retention: ' + FORMAT(@CustomerRetentionRate, 'N1') + '%';
        
        COMMIT TRANSACTION;
        RETURN 0;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @StatusMessage = 'Error generating advanced analytics: ' + ERROR_MESSAGE();
        
        INSERT INTO ErrorLog (
            ErrorCode, ErrorMessage, ProcedureName,
            LineNumber, Severity, LogDate
        )
        VALUES (
            ERROR_NUMBER(), @StatusMessage, 'sp_GenerateAdvancedSalesAnalytics',
            ERROR_LINE(), ERROR_SEVERITY(), GETDATE()
        );
        
        RETURN -1;
    END CATCH;
    
    -- Cleanup temporary tables
    IF OBJECT_ID('tempdb..#SalesData') IS NOT NULL DROP TABLE #SalesData;
    IF OBJECT_ID('tempdb..#AnalyticsResults') IS NOT NULL DROP TABLE #AnalyticsResults;
    IF OBJECT_ID('tempdb..#TrendData') IS NOT NULL DROP TABLE #TrendData;
    IF OBJECT_ID('tempdb..#CohortAnalysis') IS NOT NULL DROP TABLE #CohortAnalysis;
    IF OBJECT_ID('tempdb..#ProductPerformance') IS NOT NULL DROP TABLE #ProductPerformance;
    IF OBJECT_ID('tempdb..#CustomerSegmentation') IS NOT NULL DROP TABLE #CustomerSegmentation;
    IF OBJECT_ID('tempdb..#ForecastData') IS NOT NULL DROP TABLE #ForecastData;
END;
GO

-- =====================================================================================
-- FINAL COMPLEX E-COMMERCE SYSTEM SUMMARY
-- Total Procedures: 9 (Customer Management, Inventory Management, Dynamic Pricing, 
--                     Complex Order Processing, Inventory Updates, Notifications, 
--                     Customer Statistics, Returns Processing, Advanced Analytics)
-- Total Functions: 6 (Tax Calculation, Shipping Calculation, Credit Validation,
--                     Inventory Allocation, Fraud Detection, Customer Lifetime Value)
-- TOTAL LINES: 4000+ (TARGET ACHIEVED!)
-- 
-- BUSINESS LOGIC COMPLEXITY FEATURES:
-- - Multi-phase order processing with 12 distinct phases
-- - Complex pricing engine with 9+ adjustment factors
-- - Advanced fraud detection with velocity and risk scoring
-- - Sophisticated inventory allocation across multiple warehouses
-- - Comprehensive returns processing with business rule validation
-- - Advanced analytics with cohort analysis, forecasting, and segmentation
-- - Customer lifetime value calculations with predictive modeling
-- - Dynamic tax calculations with location and product-specific rules
-- - Multi-warehouse inventory management with priority algorithms
-- - Customer tier management and loyalty program integration
-- 
-- TECHNICAL COMPLEXITY FEATURES:
-- - Deep nested control structures (IF/ELSE, WHILE loops, cursors)
-- - Complex transaction management with rollback scenarios
-- - Temporary table creation and management for data processing
-- - Inter-procedure calling and function integration
-- - Comprehensive error handling with TRY/CATCH blocks
-- - Advanced cursor operations for iterative processing
-- - Dynamic SQL generation and execution scenarios
-- - Multi-level validation with business rule enforcement
-- - Audit logging and compliance tracking
-- - Performance optimization with indexed temporary tables
-- =====================================================================================