# Universal Stored Procedure Analysis Guide
============================================================

## Overview
This stored procedure has been automatically broken into 9 logical chunks.
Each chunk represents a distinct logical operation or set of related operations.
Analyze each chunk independently to understand the complete business logic.

## Procedure Statistics
- **Total Chunks**: 9
- **Total Complexity Score**: 339
- **Average Complexity per Chunk**: 37.7

**Chunk Type Distribution:**
- Conditional Logic: 2
- Error Handling: 1
- General Logic: 1
- Variable Declaration: 5

## Recommended Analysis Order
Process chunks in this order to maintain logical flow:

1. **Chunk 1**: Variable & Parameter Declarations (CREATE)
   - Type: variable_declaration
   - Complexity: 3
   - Lines: 1-36

2. **Chunk 2**: Variable & Parameter Declarations - Part 2
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 36-67

3. **Chunk 3**: Variable & Parameter Declarations - Part 3
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 67-98

4. **Chunk 4**: Variable & Parameter Declarations - Part 4
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 98-174

5. **Chunk 5**: Error Handling & Exception Management (CONTROL_FLOW_START/TRY)
   - Type: error_handling
   - Complexity: 4
   - Lines: 174-179

6. **Chunk 6**: Variable & Parameter Declarations (INSERT/UPDATE)
   - Type: variable_declaration
   - Complexity: 293
   - Lines: 179-1190

7. **Chunk 7**: Conditional Logic & Branching (IF)
   - Type: conditional_logic
   - Complexity: 2
   - Lines: 1190-1196
   - Depends on Chunks: 6

8. **Chunk 8**: Conditional Logic & Branching (ELSE/IF)
   - Type: conditional_logic
   - Complexity: 37
   - Lines: 1196-1238
   - Depends on Chunks: 6

9. **Chunk 9**: General Business Logic (END/RETURN)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1238-1241
   - Depends on Chunks: 6

## Detailed Chunk Analysis

### Chunk 1: Variable & Parameter Declarations (CREATE)
**Type**: variable_declaration
**Complexity Score**: 3/10
**Lines**: 1-36
**SQL Operations**: CREATE
**Control Structures**: BEGIN
**Variables Declared**: @SUBTOTALAMOUNT
**Variables Used**: @TotalAmount, @OrderDate, @CustomerID, @PromoCode, @SubtotalAmount, @ProcessInventory, @ProcessRecommendations, @IsRushOrder, @ProcessReports, @WarningMessages, @ProcessLoyalty, @ProcessNotifications, @PaymentMethodID, @ShippingMethodID, @ShippingAddressID, @ErrorMessage, @ProcessPayment, @OrderID, @CartItems

**Code:**
```sql
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
**Lines**: 36-67
**Variables Declared**: @TOTALWEIGHT, @RESERVEDSTOCK, @ORDERSTATUSID, @SHIPPINGCOST, @PROMOSTARTDATE, @PRODUCTID, @PRODUCTVOLUME, @UNITPRICE, @PRODUCTWEIGHT, @PROMOUSAGECOUNT, @ERRORCODE, @PROCESSINGFEE, @TOTALVOLUME, @PROMOENDDATE, @DISCOUNTAMOUNT, @BACKORDERQUANTITY, @MAXDISCOUNT, @DISCOUNTPERCENTAGE, @SUBTOTALAMOUNT, @ISVALID, @CURRENTITEM, @FINALAMOUNT, @TAXAMOUNT, @QUANTITY, @AVAILABLESTOCK, @ITEMCOUNT, @PROMOID, @WARNINGCODE
**Variables Used**: @BackorderQuantity, @ProcessingFee, @AvailableStock, @TotalWeight, @DiscountPercentage, @CurrentItem, @SubtotalAmount, @UnitPrice, @ProductVolume, @OrderStatusID, @ProductWeight, @FinalAmount, @TaxAmount, @MaxDiscount, @PromoID, @ItemCount, @ErrorCode, @IsValid, @TotalVolume, @PromoEndDate, @ProductID, @ReservedStock, @DiscountAmount, @ShippingCost, @PromoUsageCount, @WarningCode, @Quantity, @PromoStartDate

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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 3: Variable & Parameter Declarations - Part 3
**Type**: variable_declaration
**Complexity Score**: 0/10
**Lines**: 67-98
**Variables Declared**: @CUSTOMERPROMOUSAGE, @CUSTOMERORDERCOUNT, @CUSTOMERTIERID, @SHIPPINGDISTANCE, @PAYMENTTYPEID, @SHIPPINGZONEID, @LOCALTAXRATE, @CUSTOMERRISKSCORE, @CUSTOMERCURRENTBALANCE, @STATETAXRATE, @SHIPPINGTRACKINGNUMBER, @SHIPPINGSTATEID, @CUSTOMERLIFETIMEVALUE, @PROMOUSAGECOUNT, @CUSTOMERPRIORITYLEVEL, @CUSTOMERCREDITLIMIT, @SHIPPINGCOUNTRYID, @CUSTOMERLASTORDERDATE, @ESTIMATEDDELIVERYDAYS, @PROMOMAXUSAGE, @ISPROMOSTACKABLE, @CUSTOMERTYPEID, @ISTAXEXEMPT, @CALCULATEDTAXRATE
**Variables Used**: @CustomerOrderCount, @CustomerRiskScore, @ShippingCountryID, @IsTaxExempt, @PromoMaxUsage, @ShippingDistance, @CustomerCurrentBalance, @CustomerLifetimeValue, @CalculatedTaxRate, @CustomerTypeID, @ShippingTrackingNumber, @ShippingStateID, @PaymentTypeID, @EstimatedDeliveryDays, @CustomerLastOrderDate, @LocalTaxRate, @CustomerPriorityLevel, @IsPromoStackable, @CustomerCreditLimit, @CustomerTierID, @CustomerPromoUsage, @PromoUsageCount, @ShippingZoneID, @StateTaxRate

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 4: Variable & Parameter Declarations - Part 4
**Type**: variable_declaration
**Complexity Score**: 0/10
**Lines**: 98-174
**Variables Declared**: @CUSTOMERBEHAVIORSCORE, @AUDITLOGID, @ISPAYMENTPREAUTH, @PAYMENTTYPEID, @CROSSSELLOPPORTUNITIES, @RECOMMENDATIONSETID, @LOYALTYTIERMULTIPLIER, @TRANSACTIONID, @PRIMARYWAREHOUSEID, @REQUIRESINVENTORYALLOCATION, @LOYALTYPOINTSEARNED, @PAYMENTAUTHCODE, @NOTIFICATIONID, @PAYMENTREFERENCENUMBER, @INVENTORYRESERVATIONID, @LOYALTYPOINTS, @INVENTORYSHORTFALL, @ORDERPROCESSINGSTARTTIME, @REWARDSCASHBACK, @PAYMENTFEE, @PAYMENTSTATUSID, @INVENTORYALLOCATIONS, @TAXCALCULATIONS, @UPSELLVALUE, @APPLIEDPROMOTIONS, @CART, @WAREHOUSEID
**Variables Used**: @NotificationID, @AppliedPromotions, @RequiresInventoryAllocation, @LoyaltyPoints, @LoyaltyPointsEarned, @TransactionID, @IsPaymentPreAuth, @WarehouseID, @LoyaltyTierMultiplier, @CrossSellOpportunities, @PaymentTypeID, @PaymentAuthCode, @OrderProcessingStartTime, @RecommendationSetID, @Cart, @PaymentStatusID, @RewardsCashback, @PaymentFee, @PrimaryWarehouseID, @CustomerBehaviorScore, @UpSellValue, @TaxCalculations, @AuditLogID, @InventoryReservationID, @InventoryAllocations, @PaymentReferenceNumber, @InventoryShortfall

**Code:**
```sql
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

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 5: Error Handling & Exception Management (CONTROL_FLOW_START/TRY)
**Type**: error_handling
**Complexity Score**: 4/10
**Lines**: 174-179
**Control Structures**: CONTROL_FLOW_START, TRY, BEGIN

**Code:**
```sql
    
    -- =====================================================================================
    -- COMPREHENSIVE INPUT VALIDATION
    -- =====================================================================================
    
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

### Chunk 6: Variable & Parameter Declarations (INSERT/UPDATE)
**Type**: variable_declaration
**Complexity Score**: 293/10
**Lines**: 179-1190
**SQL Operations**: INSERT, UPDATE, SELECT, EXEC
**Control Structures**: CASE, CONTROL_FLOW_START, WHEN, GOTO, WHILE, IF, ELSE, FOR, CATCH, TRY, END, RETURN, BEGIN
**Variables Declared**: @TIERDISCOUNTPERCENTAGE, @NEWCUSTOMERTIERID, @MAXPOINTSREDEMPTION, @ALLOCATEDTOTAL, @TIERDISCOUNT, @PRODUCTTAXRATE, @LINETAXAMOUNT, @POINTSDISCOUNT, @POINTSTOREDEEM
**Variables Used**: @OrderDate, @TransactionID, @ShippingCountryID, @LoyaltyPoints, @ProcessRecommendations, @CustomerTypeID, @TierDiscountPercentage, @ItemCount, @ErrorCode, @CustomerLastOrderDate, @PromoStartDate, @PaymentMethodID, @LineTaxAmount, @ShippingAddressID, @ErrorMessage, @ProductID, @ProcessPayment, @NewCustomerTierID, @OrderID, @Quantity, @InventoryShortfall, @PointsDiscount, @ProcessingFee, @CustomerID, @AvailableStock, @PromoCode, @TotalWeight, @CurrentItem, @SubtotalAmount, @CustomerCurrentBalance, @IsRushOrder, @OrderStatusID, @ProductWeight, @TaxAmount, @ShippingStateID, @MaxDiscount, @PaymentTypeID, @CrossSellOpportunities, @EstimatedDeliveryDays, @WarningMessages, @IsValid, @IsPromoStackable, @TotalVolume, @MaxPointsRedemption, @TierDiscount, @CustomerPromoUsage, @DiscountAmount, @PromoUsageCount, @ShippingZoneID, @PaymentReferenceNumber, @AllocatedTotal, @CartItems, @BackorderQuantity, @CustomerRiskScore, @TotalAmount, @DiscountPercentage, @UnitPrice, @IsPaymentPreAuth, @ProductTaxRate, @PromoMaxUsage, @ProcessNotifications, @Cart, @CustomerCreditLimit, @ShippingMethodID, @PaymentStatusID, @CustomerTierID, @ShippingCost, @CustomerOrderCount, @AppliedPromotions, @LoyaltyPointsEarned, @IsTaxExempt, @ProcessInventory, @ShippingDistance, @CustomerLifetimeValue, @FinalAmount, @LoyaltyTierMultiplier, @ROWCOUNT, @PromoID, @ProcessReports, @CustomerPriorityLevel, @OrderProcessingStartTime, @ProcessLoyalty, @PointsToRedeem, @PromoEndDate, @PaymentFee, @TaxCalculations, @InventoryAllocations, @WarningCode, @ProductVolume, @TRANCOUNT
**Tables/Views**: PROMOTIONS, CUSTOMERTIERS, NOTIFICATIONQUEUE, INVENTORYRESERVATIONS, AUDITLOG, CUSTOMERS, TRANSACTIONLOG, DAILYSALESSUMMARY, PAYMENTS, CUSTOMERANALYTICS, LOYALTYTRANSACTIONS, ORDERITEMS, TIER, OPENJSON, ORDERS, ADDRESSES, PRODUCTS, SHIPPINGMETHODS, CUSTOMERPAYMENTMETHODS, SHIPPINGMETHODZONES, PAYMENTMETHODS, ORDERPROMOTIONS, P, ERRORLOG, CUSTOMERLOG, CUSTOMERRECOMMENDATIONS

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
        -- REPORTING AND ANALYTICS UPDATES
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
    
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 7: Conditional Logic & Branching (IF)
**Type**: conditional_logic
**Complexity Score**: 2/10
**Lines**: 1190-1196
**Control Structures**: IF
**Variables Used**: @IsValid
**Dependencies**: Chunks 6

**Code:**
```sql
    
    -- =====================================================================================
    -- CUSTOM ERROR HANDLER
    -- =====================================================================================
    
    ErrorHandler:
    IF @IsValid = 0
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 8: Conditional Logic & Branching (ELSE/IF)
**Type**: conditional_logic
**Complexity Score**: 37/10
**Lines**: 1196-1238
**Control Structures**: ELSE, IF, END, RETURN, BEGIN
**Variables Used**: @ErrorMessage, @TotalAmount, @IsValid, @OrderID, @ErrorCode, @TRANCOUNT
**Dependencies**: Chunks 6

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

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 9: General Business Logic (END/RETURN)
**Type**: general_logic
**Complexity Score**: 0/10
**Lines**: 1238-1241
**Control Structures**: END, RETURN
**Dependencies**: Chunks 6

**Code:**
```sql
    
    RETURN 0; -- Success
END;
GO 
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---
