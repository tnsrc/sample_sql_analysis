# Adaptive SQL Stored Procedure Analysis Guide
======================================================================

**Chunking Strategy**: Hybrid
**Target Chunk Size**: 60 lines
**Max Chunk Size**: 120 lines

## Procedure Statistics
- **Total Chunks**: 29
- **Subdivided Chunks**: 23
- **Total Complexity Score**: 325
- **Average Complexity per Chunk**: 11.2
- **Business Functions Identified**: 0

**Chunk Type Distribution:**
- Conditional Logic: 10
- Data Retrieval: 1
- Error Handling: 2
- General Logic: 5
- Loop Logic: 3
- Transaction Control: 3
- Variable Declaration: 5

## Sequential Analysis Order
Analyze chunks in this exact order for complete understanding:

1. **Chunk 1**: General Business Logic
   - Type: general_logic
   - Complexity: 0
   - Lines: 1-6
   - Context: General processing logic

2. **Chunk 2**: General Business Logic (CREATE)
   - Type: general_logic
   - Complexity: 1
   - Lines: 7-26
   - Context: Performs create operations. Follows general logic

3. **Chunk 3**: General Business Logic (BEGIN)
   - Type: general_logic
   - Complexity: 2
   - Lines: 27-35
   - Context: Uses begin logic. Follows general logic

4. **Chunk 4**: Variable & Parameter Declarations (Part 1)
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 36-174
   - Context: Follows general logic
   - Subdivision: Part 1/3 of variable_declaration

5. **Chunk 5**: Error Handling & Exception Management (GOTO/BEGIN) (Part 1)
   - Type: error_handling
   - Complexity: 26
   - Lines: 179-225
   - Context: Uses goto, begin, end, if, try logic. Follows variable declaration
   - Subdivision: Part 1/43 of variable_declaration

6. **Chunk 6**: Conditional Logic & Branching (SELECT) (Part 3)
   - Type: conditional_logic
   - Complexity: 17
   - Lines: 228-280
   - Context: Performs select operations. Uses when, goto, case, else, end, if, begin logic. Follows error handling
   - Subdivision: Part 3/43 of variable_declaration

7. **Chunk 7**: Conditional Logic & Branching (SELECT) (Part 5)
   - Type: conditional_logic
   - Complexity: 16
   - Lines: 283-334
   - Context: Performs select operations. Uses goto, if, begin, end logic. Follows conditional logic
   - Subdivision: Part 5/43 of variable_declaration

8. **Chunk 8**: Loop Processing & Iteration (SELECT) (Part 7)
   - Type: loop_logic
   - Complexity: 11
   - Lines: 337-374
   - Context: Performs select operations. Uses goto, end, if, for, begin logic. Follows conditional logic
   - Subdivision: Part 7/43 of variable_declaration

9. **Chunk 9**: Loop Processing & Iteration (INSERT/UPDATE) (Part 9)
   - Type: loop_logic
   - Complexity: 34
   - Lines: 377-471
   - Context: Performs insert, update, select operations. Uses goto, while, else, end, if, for, begin logic. Follows loop logic
   - Subdivision: Part 9/43 of variable_declaration

10. **Chunk 10**: Variable & Parameter Declarations (INSERT/SELECT) (Part 11)
   - Type: variable_declaration
   - Complexity: 16
   - Lines: 474-511
   - Context: Performs insert, select, exec operations. Uses while, end, if, for, begin logic. Follows loop logic
   - Subdivision: Part 11/43 of variable_declaration

11. **Chunk 11**: Variable & Parameter Declarations (INSERT/UPDATE) (Part 13)
   - Type: variable_declaration
   - Complexity: 55
   - Lines: 514-646
   - Context: Performs insert, update, select operations. Uses when, goto, case, else, end, if, for, begin logic. Follows variable declaration
   - Subdivision: Part 13/43 of variable_declaration

12. **Chunk 12**: Variable & Parameter Declarations (INSERT/UPDATE) (Part 15)
   - Type: variable_declaration
   - Complexity: 10
   - Lines: 649-693
   - Context: Performs insert, update, select operations. Uses if, while, begin, end logic. Follows variable declaration
   - Subdivision: Part 15/43 of variable_declaration

13. **Chunk 13**: Data Query & Retrieval (SELECT) (Part 17)
   - Type: data_retrieval
   - Complexity: 1
   - Lines: 696-709
   - Context: Performs select operations. Follows variable declaration
   - Subdivision: Part 17/43 of variable_declaration

14. **Chunk 14**: Conditional Logic & Branching (IF/BEGIN) (Part 19)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 712-726
   - Context: Uses if, begin, end logic. Follows data retrieval
   - Subdivision: Part 19/43 of variable_declaration

15. **Chunk 15**: Conditional Logic & Branching (GOTO/IF) (Part 21)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 729-742
   - Context: Uses goto, if, begin, end logic. Follows conditional logic
   - Subdivision: Part 21/43 of variable_declaration

16. **Chunk 16**: Conditional Logic & Branching (INSERT/SELECT) (Part 23)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 745-819
   - Context: Performs insert, select operations. Uses if logic. Follows conditional logic
   - Subdivision: Part 23/43 of variable_declaration

17. **Chunk 17**: Conditional Logic & Branching (INSERT/UPDATE) (Part 25)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 822-838
   - Context: Performs insert, update, select operations. Uses if, begin, end logic. Follows conditional logic
   - Subdivision: Part 25/43 of variable_declaration

18. **Chunk 18**: Conditional Logic & Branching (INSERT/UPDATE) (Part 27)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 841-875
   - Context: Performs insert, update operations. Uses if, begin, end logic. Follows conditional logic
   - Subdivision: Part 27/43 of variable_declaration

19. **Chunk 19**: Transaction Control (INSERT/UPDATE) (Part 29)
   - Type: transaction_control
   - Complexity: 7
   - Lines: 878-902
   - Context: Performs insert, update, select operations. Uses if, begin, end logic. Follows conditional logic
   - Subdivision: Part 29/43 of variable_declaration

20. **Chunk 20**: Variable & Parameter Declarations (INSERT/UPDATE) (Part 31)
   - Type: variable_declaration
   - Complexity: 7
   - Lines: 905-938
   - Context: Performs insert, update, select operations. Uses if, begin, end logic. Follows transaction control
   - Subdivision: Part 31/43 of variable_declaration

21. **Chunk 21**: Conditional Logic & Branching (INSERT/SELECT) (Part 33)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 941-968
   - Context: Performs insert, select operations. Uses if, begin, end logic. Follows variable declaration
   - Subdivision: Part 33/43 of variable_declaration

22. **Chunk 22**: Transaction Control (INSERT) (Part 35)
   - Type: transaction_control
   - Complexity: 3
   - Lines: 971-1020
   - Context: Performs insert operations. Follows conditional logic
   - Subdivision: Part 35/43 of variable_declaration

23. **Chunk 23**: Loop Processing & Iteration (INSERT) (Part 37)
   - Type: loop_logic
   - Complexity: 10
   - Lines: 1023-1070
   - Context: Performs insert operations. Uses for, if, begin, end logic. Follows transaction control
   - Subdivision: Part 37/43 of variable_declaration

24. **Chunk 24**: Conditional Logic & Branching (INSERT/UPDATE) (Part 39)
   - Type: conditional_logic
   - Complexity: 20
   - Lines: 1073-1126
   - Context: Performs insert, update, select operations. Uses if, else, begin, end logic. Follows loop logic
   - Subdivision: Part 39/43 of variable_declaration

25. **Chunk 25**: Error Handling & Exception Management (CATCH/END) (Part 41)
   - Type: error_handling
   - Complexity: 8
   - Lines: 1129-1146
   - Context: Uses catch, end, if, begin, try, return logic. Follows conditional logic
   - Subdivision: Part 41/43 of variable_declaration

26. **Chunk 26**: Transaction Control (INSERT) (Part 43)
   - Type: transaction_control
   - Complexity: 4
   - Lines: 1149-1189
   - Context: Performs insert operations. Uses if, goto, end, catch logic. Follows error handling
   - Subdivision: Part 43/43 of variable_declaration

27. **Chunk 27**: General Business Logic
   - Type: general_logic
   - Complexity: 0
   - Lines: 1190-1195
   - Context: Follows transaction control

28. **Chunk 28**: Conditional Logic & Branching (ELSE/END)
   - Type: conditional_logic
   - Complexity: 35
   - Lines: 1196-1237
   - Context: Uses else, end, if, begin, return logic. Follows general logic

29. **Chunk 29**: General Business Logic (END/RETURN)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1238-1241
   - Context: Uses end, return logic. Follows conditional logic

## Detailed Sequential Analysis

### Chunk 1: General Business Logic
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1-6
**Context**: General processing logic

**Code:**
```sql
-- =====================================================================================
-- MEGA STORED PROCEDURE - Combined E-commerce System
-- Combines all stored procedures into one massive procedure for testing
-- Lines: 6000+ (All business logic combined)
-- =====================================================================================

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 2: General Business Logic (CREATE)
**Type**: general_logic
**Complexity Score**: 1
**Lines**: 7-26
**Context**: Performs create operations. Follows general logic
**SQL Operations**: CREATE

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 3: General Business Logic (BEGIN)
**Type**: general_logic
**Complexity Score**: 2
**Lines**: 27-35
**Context**: Uses begin logic. Follows general logic
**Control Structures**: BEGIN

**Code:**
```sql
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
    
    -- =====================================================================================
    -- MASSIVE VARIABLE DECLARATION SECTION
    -- =====================================================================================
    
    -- Core order variables
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 4: Variable & Parameter Declarations (Part 1)
**Type**: variable_declaration
**Complexity Score**: 0
**Lines**: 36-174
**Context**: Follows general logic
**Variables Declared**: @PROCESSINGFEE, @PROMOMAXUSAGE, @CUSTOMERORDERCOUNT, @SHIPPINGCOST, @AUDITLOGID, @PRODUCTVOLUME, @ISPAYMENTPREAUTH, @CROSSSELLOPPORTUNITIES, @CUSTOMERBEHAVIORSCORE, @PRIMARYWAREHOUSEID
   (and 67 more...)
**Subdivision Info**: Part 1 of 3
**Parent Block**: variable_declaration (lines 36-178)

**Code:**
```sql
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
    
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 5: Error Handling & Exception Management (GOTO/BEGIN) (Part 1)
**Type**: error_handling
**Complexity Score**: 26
**Lines**: 179-225
**Context**: Uses goto, begin, end, if, try logic. Follows variable declaration
**Control Structures**: GOTO, BEGIN, END, IF, TRY
**Subdivision Info**: Part 1 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 6: Conditional Logic & Branching (SELECT) (Part 3)
**Type**: conditional_logic
**Complexity Score**: 17
**Lines**: 228-280
**Context**: Performs select operations. Uses when, goto, case, else, end, if, begin logic. Follows error handling
**SQL Operations**: SELECT
**Control Structures**: WHEN, GOTO, CASE, ELSE, END, IF, BEGIN
**Tables/Views**: CUSTOMERS, ORDERS
**Subdivision Info**: Part 3 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 7: Conditional Logic & Branching (SELECT) (Part 5)
**Type**: conditional_logic
**Complexity Score**: 16
**Lines**: 283-334
**Context**: Performs select operations. Uses goto, if, begin, end logic. Follows conditional logic
**SQL Operations**: SELECT
**Control Structures**: GOTO, IF, BEGIN, END
**Tables/Views**: SHIPPINGMETHODZONES, SHIPPINGMETHODS, ADDRESSES
**Subdivision Info**: Part 5 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 8: Loop Processing & Iteration (SELECT) (Part 7)
**Type**: loop_logic
**Complexity Score**: 11
**Lines**: 337-374
**Context**: Performs select operations. Uses goto, end, if, for, begin logic. Follows conditional logic
**SQL Operations**: SELECT
**Control Structures**: GOTO, END, IF, FOR, BEGIN
**Tables/Views**: PAYMENTMETHODS, CUSTOMERPAYMENTMETHODS
**Subdivision Info**: Part 7 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 9: Loop Processing & Iteration (INSERT/UPDATE) (Part 9)
**Type**: loop_logic
**Complexity Score**: 34
**Lines**: 377-471
**Context**: Performs insert, update, select operations. Uses goto, while, else, end, if, for, begin logic. Follows loop logic
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: GOTO, WHILE, ELSE, END, IF, FOR, BEGIN
**Tables/Views**: OPENJSON, PRODUCTS
**Subdivision Info**: Part 9 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 10: Variable & Parameter Declarations (INSERT/SELECT) (Part 11)
**Type**: variable_declaration
**Complexity Score**: 16
**Lines**: 474-511
**Context**: Performs insert, select, exec operations. Uses while, end, if, for, begin logic. Follows loop logic
**SQL Operations**: INSERT, SELECT, EXEC
**Control Structures**: WHILE, END, IF, FOR, BEGIN
**Variables Declared**: @ALLOCATEDTOTAL
**Subdivision Info**: Part 11 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 11: Variable & Parameter Declarations (INSERT/UPDATE) (Part 13)
**Type**: variable_declaration
**Complexity Score**: 55
**Lines**: 514-646
**Context**: Performs insert, update, select operations. Uses when, goto, case, else, end, if, for, begin logic. Follows variable declaration
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: WHEN, GOTO, CASE, ELSE, END, IF, FOR, BEGIN
**Variables Declared**: @POINTSTOREDEEM, @POINTSDISCOUNT, @TIERDISCOUNTPERCENTAGE, @TIERDISCOUNT, @MAXPOINTSREDEMPTION
**Tables/Views**: CUSTOMERS, ORDERPROMOTIONS, PROMOTIONS, ORDERS, CUSTOMERTIERS
**Subdivision Info**: Part 13 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 12: Variable & Parameter Declarations (INSERT/UPDATE) (Part 15)
**Type**: variable_declaration
**Complexity Score**: 10
**Lines**: 649-693
**Context**: Performs insert, update, select operations. Uses if, while, begin, end logic. Follows variable declaration
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: IF, WHILE, BEGIN, END
**Variables Declared**: @PRODUCTTAXRATE, @LINETAXAMOUNT
**Subdivision Info**: Part 15 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 13: Data Query & Retrieval (SELECT) (Part 17)
**Type**: data_retrieval
**Complexity Score**: 1
**Lines**: 696-709
**Context**: Performs select operations. Follows variable declaration
**SQL Operations**: SELECT
**Subdivision Info**: Part 17 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 14: Conditional Logic & Branching (IF/BEGIN) (Part 19)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 712-726
**Context**: Uses if, begin, end logic. Follows data retrieval
**Control Structures**: IF, BEGIN, END
**Subdivision Info**: Part 19 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 15: Conditional Logic & Branching (GOTO/IF) (Part 21)
**Type**: conditional_logic
**Complexity Score**: 4
**Lines**: 729-742
**Context**: Uses goto, if, begin, end logic. Follows conditional logic
**Control Structures**: GOTO, IF, BEGIN, END
**Subdivision Info**: Part 21 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 16: Conditional Logic & Branching (INSERT/SELECT) (Part 23)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 745-819
**Context**: Performs insert, select operations. Uses if logic. Follows conditional logic
**SQL Operations**: INSERT, SELECT
**Control Structures**: IF
**Tables/Views**: ORDERS, ORDERPROMOTIONS, ORDERITEMS
**Subdivision Info**: Part 23 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 17: Conditional Logic & Branching (INSERT/UPDATE) (Part 25)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 822-838
**Context**: Performs insert, update, select operations. Uses if, begin, end logic. Follows conditional logic
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: IF, BEGIN, END
**Tables/Views**: PRODUCTS, P, INVENTORYRESERVATIONS
**Subdivision Info**: Part 25 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 18: Conditional Logic & Branching (INSERT/UPDATE) (Part 27)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 841-875
**Context**: Performs insert, update operations. Uses if, begin, end logic. Follows conditional logic
**SQL Operations**: INSERT, UPDATE
**Control Structures**: IF, BEGIN, END
**Tables/Views**: PAYMENTS, CUSTOMERS
**Subdivision Info**: Part 27 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 19: Transaction Control (INSERT/UPDATE) (Part 29)
**Type**: transaction_control
**Complexity Score**: 7
**Lines**: 878-902
**Context**: Performs insert, update, select operations. Uses if, begin, end logic. Follows conditional logic
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: IF, BEGIN, END
**Tables/Views**: CUSTOMERTIERS, LOYALTYTRANSACTIONS, CUSTOMERS
**Subdivision Info**: Part 29 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 20: Variable & Parameter Declarations (INSERT/UPDATE) (Part 31)
**Type**: variable_declaration
**Complexity Score**: 7
**Lines**: 905-938
**Context**: Performs insert, update, select operations. Uses if, begin, end logic. Follows transaction control
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: IF, BEGIN, END
**Variables Declared**: @NEWCUSTOMERTIERID
**Tables/Views**: CUSTOMERTIERS, CUSTOMERLOG, CUSTOMERS, TIER
**Subdivision Info**: Part 31 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 21: Conditional Logic & Branching (INSERT/SELECT) (Part 33)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 941-968
**Context**: Performs insert, select operations. Uses if, begin, end logic. Follows variable declaration
**SQL Operations**: INSERT, SELECT
**Control Structures**: IF, BEGIN, END
**Tables/Views**: PRODUCTS, CUSTOMERRECOMMENDATIONS, ORDERITEMS, ORDERS
**Subdivision Info**: Part 33 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 22: Transaction Control (INSERT) (Part 35)
**Type**: transaction_control
**Complexity Score**: 3
**Lines**: 971-1020
**Context**: Performs insert operations. Follows conditional logic
**SQL Operations**: INSERT
**Tables/Views**: TRANSACTIONLOG, AUDITLOG
**Subdivision Info**: Part 35 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 23: Loop Processing & Iteration (INSERT) (Part 37)
**Type**: loop_logic
**Complexity Score**: 10
**Lines**: 1023-1070
**Context**: Performs insert operations. Uses for, if, begin, end logic. Follows transaction control
**SQL Operations**: INSERT
**Control Structures**: FOR, IF, BEGIN, END
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 37 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 24: Conditional Logic & Branching (INSERT/UPDATE) (Part 39)
**Type**: conditional_logic
**Complexity Score**: 20
**Lines**: 1073-1126
**Context**: Performs insert, update, select operations. Uses if, else, begin, end logic. Follows loop logic
**SQL Operations**: INSERT, UPDATE, SELECT
**Control Structures**: IF, ELSE, BEGIN, END
**Tables/Views**: DAILYSALESSUMMARY, CUSTOMERANALYTICS
**Subdivision Info**: Part 39 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
        -- =====================================================================================
        
        IF @ProcessReports = 1
        BEGIN
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
        END;
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 25: Error Handling & Exception Management (CATCH/END) (Part 41)
**Type**: error_handling
**Complexity Score**: 8
**Lines**: 1129-1146
**Context**: Uses catch, end, if, begin, try, return logic. Follows conditional logic
**Control Structures**: CATCH, END, IF, BEGIN, TRY, RETURN
**Subdivision Info**: Part 41 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 26: Transaction Control (INSERT) (Part 43)
**Type**: transaction_control
**Complexity Score**: 4
**Lines**: 1149-1189
**Context**: Performs insert operations. Uses if, goto, end, catch logic. Follows error handling
**SQL Operations**: INSERT
**Control Structures**: IF, GOTO, END, CATCH
**Tables/Views**: ERRORLOG
**Subdivision Info**: Part 43 of 43
**Parent Block**: variable_declaration (lines 179-1189)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 27: General Business Logic
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1190-1195
**Context**: Follows transaction control

**Code:**
```sql
    
    -- =====================================================================================
    -- CUSTOM ERROR HANDLER
    -- =====================================================================================
    
    ErrorHandler:
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 28: Conditional Logic & Branching (ELSE/END)
**Type**: conditional_logic
**Complexity Score**: 35
**Lines**: 1196-1237
**Context**: Uses else, end, if, begin, return logic. Follows general logic
**Control Structures**: ELSE, END, IF, BEGIN, RETURN

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 29: General Business Logic (END/RETURN)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1238-1241
**Context**: Uses end, return logic. Follows conditional logic
**Control Structures**: END, RETURN

**Code:**
```sql
    
    RETURN 0; -- Success
END;
GO 
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---
