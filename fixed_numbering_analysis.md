# Adaptive SQL Stored Procedure Analysis Guide
======================================================================

**Chunking Strategy**: Hybrid
**Target Chunk Size**: 60 lines
**Max Chunk Size**: 120 lines

## Procedure Statistics
- **Total Chunks**: 58
- **Subdivided Chunks**: 53
- **Total Complexity Score**: 435
- **Average Complexity per Chunk**: 7.5
- **Business Functions Identified**: 0

**Chunk Type Distribution:**
- Conditional Logic: 26
- Cursor Operation: 2
- Data Modification: 6
- Data Retrieval: 3
- General Logic: 4
- Loop Logic: 2
- Transaction Control: 4
- Variable Declaration: 11

## Sequential Analysis Order
Analyze chunks in this exact order for complete understanding:

1. **Chunk 1**: General Business Logic (CREATE/Math:PI)
   - Type: general_logic
   - Complexity: 3
   - Lines: 1-26
   - Context: Performs create, math:pi operations

2. **Chunk 2**: General Business Logic (BEGIN)
   - Type: general_logic
   - Complexity: 2
   - Lines: 27-35
   - Context: Uses begin logic. Follows general logic

3. **Chunk 3**: Variable & Parameter Declarations (System:GETDATE/Math:PI) (Part 1)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 36-174
   - Context: Performs system:getdate, math:pi operations. Follows general logic
   - Subdivision: Part 1/1 of variable_declaration

4. **Chunk 4**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 1)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 231-251
   - Context: Performs logical:not exists, select operations. Uses begin, goto, if, end logic. Follows variable declaration
   - Subdivision: Part 1/52 of variable_declaration

5. **Chunk 5**: Data Query & Retrieval (Aggregate:COUNT/Aggregate:SUM) (Part 2)
   - Type: data_retrieval
   - Complexity: 4
   - Lines: 256-267
   - Context: Performs aggregate:count, aggregate:sum, conversion:isnull, select operations. Uses else, end logic. Follows conditional logic
   - Subdivision: Part 2/52 of variable_declaration

6. **Chunk 6**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 3)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 286-307
   - Context: Performs logical:not exists, select, math:pi operations. Uses begin, goto, if, end logic. Follows data retrieval
   - Subdivision: Part 3/52 of variable_declaration

7. **Chunk 7**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 4)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 308-320
   - Context: Performs logical:not exists, select, math:pi operations. Uses begin, goto, if, end logic. Follows conditional logic
   - Subdivision: Part 4/52 of variable_declaration

8. **Chunk 8**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 5)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 321-334
   - Context: Performs logical:not exists, select, math:pi operations. Uses begin, goto, if, end logic. Follows conditional logic
   - Subdivision: Part 5/52 of variable_declaration

9. **Chunk 9**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 6)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 340-360
   - Context: Performs logical:not exists, select operations. Uses begin, goto, if, end logic. Follows conditional logic
   - Subdivision: Part 6/52 of variable_declaration

10. **Chunk 10**: Data Insert/Update/Delete (Aggregate:COUNT/SELECT) (Part 7)
   - Type: data_modification
   - Complexity: 4
   - Lines: 377-387
   - Context: Performs aggregate:count, select, insert operations. Follows conditional logic
   - Subdivision: Part 7/52 of variable_declaration

11. **Chunk 11**: Data Query & Retrieval (SELECT/Conversion:CAST) (Part 8)
   - Type: data_retrieval
   - Complexity: 2
   - Lines: 414-428
   - Context: Performs select, conversion:cast operations. Uses goto, end logic. Follows data modification
   - Subdivision: Part 8/52 of variable_declaration

12. **Chunk 12**: Loop Processing & Iteration (UPDATE/Conversion:CAST) (Part 9)
   - Type: loop_logic
   - Complexity: 3
   - Lines: 450-471
   - Context: Performs update, conversion:cast operations. Uses for, goto, end logic. Follows data retrieval
   - Subdivision: Part 9/52 of variable_declaration

13. **Chunk 13**: Variable & Parameter Declarations (SP_CALL:DBO.FN_ALLOCATEINVENTORYACROSSWAREHOUSES/SELECT) (Part 10)
   - Type: variable_declaration
   - Complexity: 14
   - Lines: 480-501
   - Context: Performs sp_call:dbo.fn_allocateinventoryacrosswarehouses, select, math:pi, insert, aggregate:sum, exec operations. Uses begin, while logic. Follows loop logic
   - Subdivision: Part 10/52 of variable_declaration

14. **Chunk 14**: Conditional Logic & Branching (SELECT) (Part 11)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 520-534
   - Context: Performs select operations. Uses begin, if logic. Follows variable declaration
   - Subdivision: Part 11/52 of variable_declaration

15. **Chunk 15**: Loop Processing & Iteration (Aggregate:COUNT/SELECT) (Part 12)
   - Type: loop_logic
   - Complexity: 2
   - Lines: 547-557
   - Context: Performs aggregate:count, select operations. Uses for, goto, end logic. Follows conditional logic
   - Subdivision: Part 12/52 of variable_declaration

16. **Chunk 16**: Conditional Logic & Branching (Aggregate:COUNT/SELECT) (Part 13)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 558-573
   - Context: Performs aggregate:count, select operations. Uses begin, goto, if, end logic. Follows loop logic
   - Subdivision: Part 13/52 of variable_declaration

17. **Chunk 17**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 14)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 574-587
   - Context: Performs logical:not exists, select operations. Uses begin, goto, if, end logic. Follows conditional logic
   - Subdivision: Part 14/52 of variable_declaration

18. **Chunk 18**: Variable & Parameter Declarations (INSERT) (Part 15)
   - Type: variable_declaration
   - Complexity: 5
   - Lines: 604-614
   - Context: Performs insert operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 15/52 of variable_declaration

19. **Chunk 19**: Variable & Parameter Declarations (UPDATE/INSERT) (Part 16)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 631-646
   - Context: Performs update, insert operations. Uses begin, if, end logic. Follows variable declaration
   - Subdivision: Part 16/52 of variable_declaration

20. **Chunk 20**: Variable & Parameter Declarations (SELECT/UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX) (Part 17)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 653-674
   - Context: Performs select, udf_call:dbo.fn_calculatecomplextax, math:pi operations. Uses begin, while logic. Follows variable declaration
   - Subdivision: Part 17/52 of variable_declaration

21. **Chunk 21**: Conditional Logic & Branching (Math:PI/UPDATE) (Part 18)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 675-693
   - Context: Performs math:pi, update, insert operations. Uses if, end logic. Follows variable declaration
   - Subdivision: Part 18/52 of variable_declaration

22. **Chunk 22**: Data Query & Retrieval (UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING/SELECT) (Part 19)
   - Type: data_retrieval
   - Complexity: 7
   - Lines: 696-709
   - Context: Performs udf_call:dbo.fn_calculatedynamicshipping, select, math:pi operations. Follows conditional logic
   - Subdivision: Part 19/52 of variable_declaration

23. **Chunk 23**: Data Insert/Update/Delete (System:SCOPE_IDENTITY/SELECT) (Part 20)
   - Type: data_modification
   - Complexity: 11
   - Lines: 745-809
   - Context: Performs system:scope_identity, select, math:pi, system:getdate, insert operations. Follows data retrieval
   - Subdivision: Part 20/52 of variable_declaration

24. **Chunk 24**: Conditional Logic & Branching (Conversion:ISNULL/SELECT) (Part 21)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 810-819
   - Context: Performs conversion:isnull, select, insert operations. Uses if logic. Follows data modification
   - Subdivision: Part 21/52 of variable_declaration

25. **Chunk 25**: Conditional Logic & Branching (System:GETDATE/UPDATE) (Part 22)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 824-838
   - Context: Performs system:getdate, update, select, insert operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 22/52 of variable_declaration

26. **Chunk 26**: Conditional Logic & Branching (System:GETDATE/INSERT) (Part 23)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 843-867
   - Context: Performs system:getdate, insert operations. Uses begin, if logic. Follows conditional logic
   - Subdivision: Part 23/52 of variable_declaration

27. **Chunk 27**: Transaction Control (Math:FLOOR/UPDATE) (Part 24)
   - Type: transaction_control
   - Complexity: 10
   - Lines: 880-902
   - Context: Performs math:floor, update, select, system:getdate, insert, conversion:isnull operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 24/52 of variable_declaration

28. **Chunk 28**: Variable & Parameter Declarations (SELECT) (Part 25)
   - Type: variable_declaration
   - Complexity: 1
   - Lines: 905-921
   - Context: Performs select operations. Follows transaction control
   - Subdivision: Part 25/52 of variable_declaration

29. **Chunk 29**: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 26)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 922-938
   - Context: Performs update, conversion:cast, system:getdate, insert, math:log operations. Uses begin, if, end logic. Follows variable declaration
   - Subdivision: Part 26/52 of variable_declaration

30. **Chunk 30**: Conditional Logic & Branching (SELECT/Date:DATEADD) (Part 27)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 943-968
   - Context: Performs select, date:dateadd, aggregate:count, system:getdate, insert operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 27/52 of variable_declaration

31. **Chunk 31**: Transaction Control (System:SCOPE_IDENTITY/Conversion:CAST) (Part 28)
   - Type: transaction_control
   - Complexity: 13
   - Lines: 971-1020
   - Context: Performs system:scope_identity, conversion:cast, date:datediff, system:getdate, insert, math:log operations. Follows conditional logic
   - Subdivision: Part 28/52 of variable_declaration

32. **Chunk 32**: Conditional Logic & Branching (Conversion:CAST/INSERT) (Part 29)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 1025-1040
   - Context: Performs conversion:cast, insert operations. Uses begin, if logic. Follows transaction control
   - Subdivision: Part 29/52 of variable_declaration

33. **Chunk 33**: Conditional Logic & Branching (System:GETDATE/Conversion:CAST) (Part 30)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 1048-1070
   - Context: Performs system:getdate, conversion:cast, insert operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 30/52 of variable_declaration

34. **Chunk 34**: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 31)
   - Type: conditional_logic
   - Complexity: 13
   - Lines: 1082-1094
   - Context: Performs update, conversion:cast, select, math:pi, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 31/52 of variable_declaration

35. **Chunk 35**: Variable & Parameter Declarations (Date:DATEPART/Conversion:CAST) (Part 32)
   - Type: variable_declaration
   - Complexity: 8
   - Lines: 1095-1108
   - Context: Performs date:datepart, conversion:cast, math:pi, system:getdate, insert operations. Uses else, begin, end logic. Follows conditional logic
   - Subdivision: Part 32/52 of variable_declaration

36. **Chunk 36**: Conditional Logic & Branching (UPDATE/System:GETDATE) (Part 33)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 1127-1141
   - Context: Performs update, system:getdate operations. Uses else, when, case, end logic. Follows variable declaration
   - Subdivision: Part 33/52 of variable_declaration

37. **Chunk 37**: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 34)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1142-1153
   - Context: Performs system:getdate, system:@@rowcount, insert operations. Uses begin, if, end logic. Follows conditional logic
   - Subdivision: Part 34/52 of variable_declaration

38. **Chunk 38**: Variable & Parameter Declarations (SELECT/System:GETDATE) (Part 35)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 1188-1203
   - Context: Performs select, system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
   - Subdivision: Part 35/52 of variable_declaration

39. **Chunk 39**: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 36)
   - Type: conditional_logic
   - Complexity: 13
   - Lines: 1204-1215
   - Context: Performs update, conversion:cast, select, system:getdate, aggregate:sum, logical:exists operations. Uses begin, if, end logic. Follows variable declaration
   - Subdivision: Part 36/52 of variable_declaration

40. **Chunk 40**: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 37)
   - Type: data_modification
   - Complexity: 6
   - Lines: 1216-1231
   - Context: Performs update, system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
   - Subdivision: Part 37/52 of variable_declaration

41. **Chunk 41**: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 38)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1241-1254
   - Context: Performs system:getdate, system:@@rowcount, insert operations. Uses begin, if, end logic. Follows data modification
   - Subdivision: Part 38/52 of variable_declaration

42. **Chunk 42**: Conditional Logic & Branching (Math:PI) (Part 39)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 1303-1312
   - Context: Performs math:pi operations. Uses when, case logic. Follows conditional logic
   - Subdivision: Part 39/52 of variable_declaration

43. **Chunk 43**: Conditional Logic & Branching (Math:PI) (Part 40)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 1328-1337
   - Context: Performs math:pi operations. Uses when, case logic. Follows conditional logic
   - Subdivision: Part 40/52 of variable_declaration

44. **Chunk 44**: Variable & Parameter Declarations (Date:DATEADD/System:GETDATE) (Part 41)
   - Type: variable_declaration
   - Complexity: 3
   - Lines: 1338-1348
   - Context: Performs date:dateadd, system:getdate, math:pi operations. Uses else, end logic. Follows conditional logic
   - Subdivision: Part 41/52 of variable_declaration

45. **Chunk 45**: Data Insert/Update/Delete (Math:PI/System:GETDATE) (Part 42)
   - Type: data_modification
   - Complexity: 9
   - Lines: 1367-1382
   - Context: Performs math:pi, system:getdate, select, insert operations. Uses else, end logic. Follows variable declaration
   - Subdivision: Part 42/52 of variable_declaration

46. **Chunk 46**: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 43)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 1402-1412
   - Context: Performs update, conversion:cast, select, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows data modification
   - Subdivision: Part 43/52 of variable_declaration

47. **Chunk 47**: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 44)
   - Type: data_modification
   - Complexity: 6
   - Lines: 1413-1431
   - Context: Performs update, system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
   - Subdivision: Part 44/52 of variable_declaration

48. **Chunk 48**: Cursor Operations & Row Processing (Date:DATEDIFF/SELECT) (Part 45)
   - Type: cursor_operation
   - Complexity: 6
   - Lines: 1434-1464
   - Context: Performs date:datediff, select, system:getdate, insert operations. Uses else, end logic. Follows data modification
   - Subdivision: Part 45/52 of variable_declaration

49. **Chunk 49**: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 46)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 1484-1497
   - Context: Performs update, conversion:cast, select, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows cursor operation
   - Subdivision: Part 46/52 of variable_declaration

50. **Chunk 50**: Data Insert/Update/Delete (System:GETDATE/Conversion:CAST) (Part 47)
   - Type: data_modification
   - Complexity: 5
   - Lines: 1498-1513
   - Context: Performs system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
   - Subdivision: Part 47/52 of variable_declaration

51. **Chunk 51**: Cursor Operations & Row Processing (System:GETDATE/INSERT) (Part 48)
   - Type: cursor_operation
   - Complexity: 4
   - Lines: 1529-1547
   - Context: Performs system:getdate, insert operations. Uses else, begin, end logic. Follows data modification
   - Subdivision: Part 48/52 of variable_declaration

52. **Chunk 52**: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 49)
   - Type: conditional_logic
   - Complexity: 13
   - Lines: 1566-1582
   - Context: Performs update, conversion:cast, select, math:pi, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows cursor operation
   - Subdivision: Part 49/52 of variable_declaration

53. **Chunk 53**: Variable & Parameter Declarations (Conversion:CAST/SELECT) (Part 50)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 1584-1603
   - Context: Performs conversion:cast, select, math:pi, system:getdate, insert, aggregate:sum operations. Uses begin, end logic. Follows conditional logic
   - Subdivision: Part 50/52 of variable_declaration

54. **Chunk 54**: Variable & Parameter Declarations (Math:PI/INSERT) (Part 51)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 1604-1614
   - Context: Performs math:pi, insert operations. Uses else, when, case, end logic. Follows variable declaration
   - Subdivision: Part 51/52 of variable_declaration

55. **Chunk 55**: Transaction Control (Conversion:CAST/System:@@TRANCOUNT) (Part 52)
   - Type: transaction_control
   - Complexity: 9
   - Lines: 1646-1683
   - Context: Performs conversion:cast, system:@@trancount, system:getdate, insert, math:log operations. Uses goto, catch, if, end logic. Follows variable declaration
   - Subdivision: Part 52/52 of variable_declaration

56. **Chunk 56**: General Business Logic
   - Type: general_logic
   - Complexity: 0
   - Lines: 1684-1689
   - Context: Follows transaction control

57. **Chunk 57**: Transaction Control (System:@@TRANCOUNT/Math:PI)
   - Type: transaction_control
   - Complexity: 38
   - Lines: 1690-1731
   - Context: Performs system:@@trancount, math:pi operations. Uses end, else, begin, return, if logic. Follows general logic

58. **Chunk 58**: General Business Logic (RETURN/END)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1732-1735
   - Context: Uses return, end logic. Follows transaction control

## Detailed Sequential Analysis

### Chunk 1: General Business Logic (CREATE/Math:PI)
**Type**: general_logic
**Complexity Score**: 3
**Lines**: 1-26
**Context**: Performs create, math:pi operations
**SQL Operations**: CREATE, Math:PI

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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 2: General Business Logic (BEGIN)
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

### Chunk 3: Variable & Parameter Declarations (System:GETDATE/Math:PI) (Part 1)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 36-174
**Context**: Performs system:getdate, math:pi operations. Follows general logic
**SQL Operations**: System:GETDATE, Math:PI
**Variables Declared**: @PROMOSTARTDATE, @PAYMENTSTATUSID, @PRODUCTID, @CUSTOMERLIFETIMEVALUE, @PRIMARYWAREHOUSEID, @SUBTOTALAMOUNT, @LOCALTAXRATE, @AUDITLOGID, @ISTAXEXEMPT, @CUSTOMERCURRENTBALANCE
   (and 67 more...)
**Subdivision Info**: Part 1 of 1
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

### Chunk 4: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 1)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 231-251
**Context**: Performs logical:not exists, select operations. Uses begin, goto, if, end logic. Follows variable declaration
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 1 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 5: Data Query & Retrieval (Aggregate:COUNT/Aggregate:SUM) (Part 2)
**Type**: data_retrieval
**Complexity Score**: 4
**Lines**: 256-267
**Context**: Performs aggregate:count, aggregate:sum, conversion:isnull, select operations. Uses else, end logic. Follows conditional logic
**SQL Operations**: Aggregate:COUNT, Aggregate:SUM, Conversion:ISNULL, SELECT
**Control Structures**: ELSE, END
**Tables/Views**: ORDERS
**Subdivision Info**: Part 2 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 6: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 3)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 286-307
**Context**: Performs logical:not exists, select, math:pi operations. Uses begin, goto, if, end logic. Follows data retrieval
**SQL Operations**: Logical:NOT EXISTS, SELECT, Math:PI
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: ADDRESSES
**Subdivision Info**: Part 3 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 7: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 4)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 308-320
**Context**: Performs logical:not exists, select, math:pi operations. Uses begin, goto, if, end logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT, Math:PI
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: SHIPPINGMETHODS
**Subdivision Info**: Part 4 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 8: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 5)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 321-334
**Context**: Performs logical:not exists, select, math:pi operations. Uses begin, goto, if, end logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT, Math:PI
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: SHIPPINGMETHODS, SHIPPINGMETHODZONES
**Subdivision Info**: Part 5 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 9: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 6)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 340-360
**Context**: Performs logical:not exists, select operations. Uses begin, goto, if, end logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: PAYMENTMETHODS
**Subdivision Info**: Part 6 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 10: Data Insert/Update/Delete (Aggregate:COUNT/SELECT) (Part 7)
**Type**: data_modification
**Complexity Score**: 4
**Lines**: 377-387
**Context**: Performs aggregate:count, select, insert operations. Follows conditional logic
**SQL Operations**: Aggregate:COUNT, SELECT, INSERT
**Tables/Views**: OPENJSON
**Subdivision Info**: Part 7 of 52
**Parent Block**: variable_declaration (lines 179-1683)

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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 11: Data Query & Retrieval (SELECT/Conversion:CAST) (Part 8)
**Type**: data_retrieval
**Complexity Score**: 2
**Lines**: 414-428
**Context**: Performs select, conversion:cast operations. Uses goto, end logic. Follows data modification
**SQL Operations**: SELECT, Conversion:CAST
**Control Structures**: GOTO, END
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 8 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 12: Loop Processing & Iteration (UPDATE/Conversion:CAST) (Part 9)
**Type**: loop_logic
**Complexity Score**: 3
**Lines**: 450-471
**Context**: Performs update, conversion:cast operations. Uses for, goto, end logic. Follows data retrieval
**SQL Operations**: UPDATE, Conversion:CAST
**Control Structures**: FOR, GOTO, END
**Subdivision Info**: Part 9 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 13: Variable & Parameter Declarations (SP_CALL:DBO.FN_ALLOCATEINVENTORYACROSSWAREHOUSES/SELECT) (Part 10)
**Type**: variable_declaration
**Complexity Score**: 14
**Lines**: 480-501
**Context**: Performs sp_call:dbo.fn_allocateinventoryacrosswarehouses, select, math:pi, insert, aggregate:sum, exec operations. Uses begin, while logic. Follows loop logic
**SQL Operations**: SP_CALL:DBO.FN_ALLOCATEINVENTORYACROSSWAREHOUSES, SELECT, Math:PI, INSERT, Aggregate:SUM, EXEC
**Control Structures**: BEGIN, WHILE
**Variables Declared**: @ALLOCATEDTOTAL
**Subdivision Info**: Part 10 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 14: Conditional Logic & Branching (SELECT) (Part 11)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 520-534
**Context**: Performs select operations. Uses begin, if logic. Follows variable declaration
**SQL Operations**: SELECT
**Control Structures**: BEGIN, IF
**Tables/Views**: PROMOTIONS
**Subdivision Info**: Part 11 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 15: Loop Processing & Iteration (Aggregate:COUNT/SELECT) (Part 12)
**Type**: loop_logic
**Complexity Score**: 2
**Lines**: 547-557
**Context**: Performs aggregate:count, select operations. Uses for, goto, end logic. Follows conditional logic
**SQL Operations**: Aggregate:COUNT, SELECT
**Control Structures**: FOR, GOTO, END
**Tables/Views**: ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 12 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                            SET @ErrorMessage = 'Promotion code is not valid for the current date.';
                                                                                                                                SET @ErrorCode = 6002;
                                                                                                                                GOTO ErrorHandler;
                                                                                                                            END;

                                                                                                                            -- Check promotion usage limits
                                                                                                                            SELECT @PromoUsageCount = COUNT(*)
                                                                                                                            FROM Orders o
                                                                                                                            INNER JOIN OrderPromotions op ON o.OrderID = op.OrderID
                                                                                                                            WHERE op.PromoID = @PromoID;

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 16: Conditional Logic & Branching (Aggregate:COUNT/SELECT) (Part 13)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 558-573
**Context**: Performs aggregate:count, select operations. Uses begin, goto, if, end logic. Follows loop logic
**SQL Operations**: Aggregate:COUNT, SELECT
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 13 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 17: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 14)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 574-587
**Context**: Performs logical:not exists, select operations. Uses begin, goto, if, end logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: BEGIN, GOTO, IF, END
**Tables/Views**: PROMOTIONS
**Subdivision Info**: Part 14 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 18: Variable & Parameter Declarations (INSERT) (Part 15)
**Type**: variable_declaration
**Complexity Score**: 5
**Lines**: 604-614
**Context**: Performs insert operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: INSERT
**Control Structures**: BEGIN, IF, END
**Variables Declared**: @TIERDISCOUNT
**Subdivision Info**: Part 15 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                            IF @TierDiscountPercentage > 0
                                                                                                                                                BEGIN
                                                                                                                                                    DECLARE @TierDiscount DECIMAL(18,2) = @SubtotalAmount * (@TierDiscountPercentage / 100.0);
                                                                                                                                                    SET @DiscountAmount = @DiscountAmount + @TierDiscount;

                                                                                                                                                    INSERT INTO @AppliedPromotions VALUES
                                                                                                                                                    (NULL, 'TIER_DISCOUNT', @TierDiscount, @TierDiscountPercentage, NULL, 1);
                                                                                                                                                END;
                                                                                                                                            END;

                                                                                                                                            -- Apply loyalty points discount if applicable
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 19: Variable & Parameter Declarations (UPDATE/INSERT) (Part 16)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 631-646
**Context**: Performs update, insert operations. Uses begin, if, end logic. Follows variable declaration
**SQL Operations**: UPDATE, INSERT
**Control Structures**: BEGIN, IF, END
**Variables Declared**: @POINTSDISCOUNT
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 16 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 20: Variable & Parameter Declarations (SELECT/UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX) (Part 17)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 653-674
**Context**: Performs select, udf_call:dbo.fn_calculatecomplextax, math:pi operations. Uses begin, while logic. Follows variable declaration
**SQL Operations**: SELECT, UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX, Math:PI
**Control Structures**: BEGIN, WHILE
**Variables Declared**: @LINETAXAMOUNT, @PRODUCTTAXRATE
**Subdivision Info**: Part 17 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 21: Conditional Logic & Branching (Math:PI/UPDATE) (Part 18)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 675-693
**Context**: Performs math:pi, update, insert operations. Uses if, end logic. Follows variable declaration
**SQL Operations**: Math:PI, UPDATE, INSERT
**Control Structures**: IF, END
**Subdivision Info**: Part 18 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 22: Data Query & Retrieval (UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING/SELECT) (Part 19)
**Type**: data_retrieval
**Complexity Score**: 7
**Lines**: 696-709
**Context**: Performs udf_call:dbo.fn_calculatedynamicshipping, select, math:pi operations. Follows conditional logic
**SQL Operations**: UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING, SELECT, Math:PI
**Subdivision Info**: Part 19 of 52
**Parent Block**: variable_declaration (lines 179-1683)

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

### Chunk 23: Data Insert/Update/Delete (System:SCOPE_IDENTITY/SELECT) (Part 20)
**Type**: data_modification
**Complexity Score**: 11
**Lines**: 745-809
**Context**: Performs system:scope_identity, select, math:pi, system:getdate, insert operations. Follows data retrieval
**SQL Operations**: System:SCOPE_IDENTITY, SELECT, Math:PI, System:GETDATE, INSERT
**Tables/Views**: ORDERITEMS, ORDERS
**Subdivision Info**: Part 20 of 52
**Parent Block**: variable_declaration (lines 179-1683)

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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 24: Conditional Logic & Branching (Conversion:ISNULL/SELECT) (Part 21)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 810-819
**Context**: Performs conversion:isnull, select, insert operations. Uses if logic. Follows data modification
**SQL Operations**: Conversion:ISNULL, SELECT, INSERT
**Control Structures**: IF
**Tables/Views**: ORDERPROMOTIONS
**Subdivision Info**: Part 21 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 25: Conditional Logic & Branching (System:GETDATE/UPDATE) (Part 22)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 824-838
**Context**: Performs system:getdate, update, select, insert operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: System:GETDATE, UPDATE, SELECT, INSERT
**Control Structures**: BEGIN, IF, END
**Tables/Views**: PRODUCTS, P, INVENTORYRESERVATIONS
**Subdivision Info**: Part 22 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 26: Conditional Logic & Branching (System:GETDATE/INSERT) (Part 23)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 843-867
**Context**: Performs system:getdate, insert operations. Uses begin, if logic. Follows conditional logic
**SQL Operations**: System:GETDATE, INSERT
**Control Structures**: BEGIN, IF
**Tables/Views**: PAYMENTS
**Subdivision Info**: Part 23 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 27: Transaction Control (Math:FLOOR/UPDATE) (Part 24)
**Type**: transaction_control
**Complexity Score**: 10
**Lines**: 880-902
**Context**: Performs math:floor, update, select, system:getdate, insert, conversion:isnull operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: Math:FLOOR, UPDATE, SELECT, System:GETDATE, INSERT, Conversion:ISNULL
**Control Structures**: BEGIN, IF, END
**Tables/Views**: CUSTOMERTIERS, LOYALTYTRANSACTIONS, CUSTOMERS
**Subdivision Info**: Part 24 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 28: Variable & Parameter Declarations (SELECT) (Part 25)
**Type**: variable_declaration
**Complexity Score**: 1
**Lines**: 905-921
**Context**: Performs select operations. Follows transaction control
**SQL Operations**: SELECT
**Variables Declared**: @NEWCUSTOMERTIERID
**Tables/Views**: CUSTOMERTIERS
**Subdivision Info**: Part 25 of 52
**Parent Block**: variable_declaration (lines 179-1683)

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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 29: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 26)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 922-938
**Context**: Performs update, conversion:cast, system:getdate, insert, math:log operations. Uses begin, if, end logic. Follows variable declaration
**SQL Operations**: UPDATE, Conversion:CAST, System:GETDATE, INSERT, Math:LOG
**Control Structures**: BEGIN, IF, END
**Tables/Views**: CUSTOMERLOG, TIER, CUSTOMERS
**Subdivision Info**: Part 26 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 30: Conditional Logic & Branching (SELECT/Date:DATEADD) (Part 27)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 943-968
**Context**: Performs select, date:dateadd, aggregate:count, system:getdate, insert operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: SELECT, Date:DATEADD, Aggregate:COUNT, System:GETDATE, INSERT
**Control Structures**: BEGIN, IF, END
**Tables/Views**: PRODUCTS, ORDERITEMS, ORDERS, CUSTOMERRECOMMENDATIONS
**Subdivision Info**: Part 27 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 31: Transaction Control (System:SCOPE_IDENTITY/Conversion:CAST) (Part 28)
**Type**: transaction_control
**Complexity Score**: 13
**Lines**: 971-1020
**Context**: Performs system:scope_identity, conversion:cast, date:datediff, system:getdate, insert, math:log operations. Follows conditional logic
**SQL Operations**: System:SCOPE_IDENTITY, Conversion:CAST, Date:DATEDIFF, System:GETDATE, INSERT, Math:LOG
**Tables/Views**: AUDITLOG, TRANSACTIONLOG
**Subdivision Info**: Part 28 of 52
**Parent Block**: variable_declaration (lines 179-1683)

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

### Chunk 32: Conditional Logic & Branching (Conversion:CAST/INSERT) (Part 29)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 1025-1040
**Context**: Performs conversion:cast, insert operations. Uses begin, if logic. Follows transaction control
**SQL Operations**: Conversion:CAST, INSERT
**Control Structures**: BEGIN, IF
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 29 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 33: Conditional Logic & Branching (System:GETDATE/Conversion:CAST) (Part 30)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 1048-1070
**Context**: Performs system:getdate, conversion:cast, insert operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: BEGIN, IF, END
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 30 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 34: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 31)
**Type**: conditional_logic
**Complexity Score**: 13
**Lines**: 1082-1094
**Context**: Performs update, conversion:cast, select, math:pi, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: UPDATE, Conversion:CAST, SELECT, Math:PI, System:GETDATE, Logical:EXISTS
**Control Structures**: BEGIN, IF, END
**Tables/Views**: DAILYSALESSUMMARY
**Subdivision Info**: Part 31 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 35: Variable & Parameter Declarations (Date:DATEPART/Conversion:CAST) (Part 32)
**Type**: variable_declaration
**Complexity Score**: 8
**Lines**: 1095-1108
**Context**: Performs date:datepart, conversion:cast, math:pi, system:getdate, insert operations. Uses else, begin, end logic. Follows conditional logic
**SQL Operations**: Date:DATEPART, Conversion:CAST, Math:PI, System:GETDATE, INSERT
**Control Structures**: ELSE, BEGIN, END
**Variables Declared**: @CURRENTHOUR
**Tables/Views**: DAILYSALESSUMMARY
**Subdivision Info**: Part 32 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 36: Conditional Logic & Branching (UPDATE/System:GETDATE) (Part 33)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 1127-1141
**Context**: Performs update, system:getdate operations. Uses else, when, case, end logic. Follows variable declaration
**SQL Operations**: UPDATE, System:GETDATE
**Control Structures**: ELSE, WHEN, CASE, END
**Tables/Views**: CUSTOMERANALYTICS
**Subdivision Info**: Part 33 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 37: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 34)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1142-1153
**Context**: Performs system:getdate, system:@@rowcount, insert operations. Uses begin, if, end logic. Follows conditional logic
**SQL Operations**: System:GETDATE, System:@@ROWCOUNT, INSERT
**Control Structures**: BEGIN, IF, END
**Tables/Views**: CUSTOMERANALYTICS
**Subdivision Info**: Part 34 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 38: Variable & Parameter Declarations (SELECT/System:GETDATE) (Part 35)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 1188-1203
**Context**: Performs select, system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
**SQL Operations**: SELECT, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, BEGIN, END
**Variables Declared**: @CATEGORYID
**Tables/Views**: PRODUCTS, PRODUCTSALESSTATS
**Subdivision Info**: Part 35 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 39: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 36)
**Type**: conditional_logic
**Complexity Score**: 13
**Lines**: 1204-1215
**Context**: Performs update, conversion:cast, select, system:getdate, aggregate:sum, logical:exists operations. Uses begin, if, end logic. Follows variable declaration
**SQL Operations**: UPDATE, Conversion:CAST, SELECT, System:GETDATE, Aggregate:SUM, Logical:EXISTS
**Control Structures**: BEGIN, IF, END
**Tables/Views**: CATEGORYSALESSTATS
**Subdivision Info**: Part 36 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 40: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 37)
**Type**: data_modification
**Complexity Score**: 6
**Lines**: 1216-1231
**Context**: Performs update, system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
**SQL Operations**: UPDATE, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, BEGIN, END
**Tables/Views**: PRODUCTRECOMMENDATIONSCORES, CATEGORYSALESSTATS
**Subdivision Info**: Part 37 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 41: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 38)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1241-1254
**Context**: Performs system:getdate, system:@@rowcount, insert operations. Uses begin, if, end logic. Follows data modification
**SQL Operations**: System:GETDATE, System:@@ROWCOUNT, INSERT
**Control Structures**: BEGIN, IF, END
**Tables/Views**: PRODUCTRECOMMENDATIONSCORES
**Subdivision Info**: Part 38 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 42: Conditional Logic & Branching (Math:PI) (Part 39)
**Type**: conditional_logic
**Complexity Score**: 3
**Lines**: 1303-1312
**Context**: Performs math:pi operations. Uses when, case logic. Follows conditional logic
**SQL Operations**: Math:PI
**Control Structures**: WHEN, CASE
**Subdivision Info**: Part 39 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 43: Conditional Logic & Branching (Math:PI) (Part 40)
**Type**: conditional_logic
**Complexity Score**: 3
**Lines**: 1328-1337
**Context**: Performs math:pi operations. Uses when, case logic. Follows conditional logic
**SQL Operations**: Math:PI
**Control Structures**: WHEN, CASE
**Subdivision Info**: Part 40 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 44: Variable & Parameter Declarations (Date:DATEADD/System:GETDATE) (Part 41)
**Type**: variable_declaration
**Complexity Score**: 3
**Lines**: 1338-1348
**Context**: Performs date:dateadd, system:getdate, math:pi operations. Uses else, end logic. Follows conditional logic
**SQL Operations**: Date:DATEADD, System:GETDATE, Math:PI
**Control Structures**: ELSE, END
**Variables Declared**: @SEASONALTREND, @SHOPPINGTIMEPREFERENCE, @PURCHASEPATTERN
**Subdivision Info**: Part 41 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                ELSE 'Hibernating'
                                                                                                                                                                                                                END,
                                                                                                                                                                                                                @OrderDate, DATEADD(DAY, 30, @OrderDate), GETDATE()
                                                                                                                                                                                                                );
                                                                                                                                                                                                            END;

                                                                                                                                                                                                            -- Update customer behavior tracking
                                                                                                                                                                                                            DECLARE @PurchasePattern NVARCHAR(100);
                                                                                                                                                                                                            DECLARE @ShoppingTimePreference NVARCHAR(50);
                                                                                                                                                                                                            DECLARE @SeasonalTrend NVARCHAR(50);

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 45: Data Insert/Update/Delete (Math:PI/System:GETDATE) (Part 42)
**Type**: data_modification
**Complexity Score**: 9
**Lines**: 1367-1382
**Context**: Performs math:pi, system:getdate, select, insert operations. Uses else, end logic. Follows variable declaration
**SQL Operations**: Math:PI, System:GETDATE, SELECT, INSERT
**Control Structures**: ELSE, END
**Tables/Views**: SHIPPINGMETHODS, CUSTOMERBEHAVIORTRACKING, PAYMENTTYPES
**Subdivision Info**: Part 42 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 46: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 43)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 1402-1412
**Context**: Performs update, conversion:cast, select, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows data modification
**SQL Operations**: UPDATE, Conversion:CAST, SELECT, System:GETDATE, Logical:EXISTS
**Control Structures**: BEGIN, IF, END
**Tables/Views**: WAREHOUSEPERFORMANCEMETRICS
**Subdivision Info**: Part 43 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 47: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 44)
**Type**: data_modification
**Complexity Score**: 6
**Lines**: 1413-1431
**Context**: Performs update, system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
**SQL Operations**: UPDATE, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, BEGIN, END
**Tables/Views**: WAREHOUSEPERFORMANCEMETRICS, INVENTORYVELOCITYMETRICS
**Subdivision Info**: Part 44 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 48: Cursor Operations & Row Processing (Date:DATEDIFF/SELECT) (Part 45)
**Type**: cursor_operation
**Complexity Score**: 6
**Lines**: 1434-1464
**Context**: Performs date:datediff, select, system:getdate, insert operations. Uses else, end logic. Follows data modification
**SQL Operations**: Date:DATEDIFF, SELECT, System:GETDATE, INSERT
**Control Structures**: ELSE, END
**Tables/Views**: SUPPLYCHAINEVENTS
**Subdivision Info**: Part 45 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 49: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 46)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 1484-1497
**Context**: Performs update, conversion:cast, select, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows cursor operation
**SQL Operations**: UPDATE, Conversion:CAST, SELECT, System:GETDATE, Logical:EXISTS
**Control Structures**: BEGIN, IF, END
**Tables/Views**: PROMOTIONEFFECTIVENESSMETRICS
**Subdivision Info**: Part 46 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 50: Data Insert/Update/Delete (System:GETDATE/Conversion:CAST) (Part 47)
**Type**: data_modification
**Complexity Score**: 5
**Lines**: 1498-1513
**Context**: Performs system:getdate, conversion:cast, insert operations. Uses else, begin, end logic. Follows conditional logic
**SQL Operations**: System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, BEGIN, END
**Tables/Views**: PROMOTIONEFFECTIVENESSMETRICS
**Subdivision Info**: Part 47 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 51: Cursor Operations & Row Processing (System:GETDATE/INSERT) (Part 48)
**Type**: cursor_operation
**Complexity Score**: 4
**Lines**: 1529-1547
**Context**: Performs system:getdate, insert operations. Uses else, begin, end logic. Follows data modification
**SQL Operations**: System:GETDATE, INSERT
**Control Structures**: ELSE, BEGIN, END
**Tables/Views**: CUSTOMERPROMOTIONAFFINITY
**Subdivision Info**: Part 48 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 52: Conditional Logic & Branching (UPDATE/Conversion:CAST) (Part 49)
**Type**: conditional_logic
**Complexity Score**: 13
**Lines**: 1566-1582
**Context**: Performs update, conversion:cast, select, math:pi, system:getdate, logical:exists operations. Uses begin, if, end logic. Follows cursor operation
**SQL Operations**: UPDATE, Conversion:CAST, SELECT, Math:PI, System:GETDATE, Logical:EXISTS
**Control Structures**: BEGIN, IF, END
**Tables/Views**: FINANCIALSUMMARY
**Subdivision Info**: Part 49 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 53: Variable & Parameter Declarations (Conversion:CAST/SELECT) (Part 50)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 1584-1603
**Context**: Performs conversion:cast, select, math:pi, system:getdate, insert, aggregate:sum operations. Uses begin, end logic. Follows conditional logic
**SQL Operations**: Conversion:CAST, SELECT, Math:PI, System:GETDATE, INSERT, Aggregate:SUM
**Control Structures**: BEGIN, END
**Variables Declared**: @GROSSPROFIT, @TOTALCOGS
**Tables/Views**: PRODUCTS, FINANCIALSUMMARY
**Subdivision Info**: Part 50 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 54: Variable & Parameter Declarations (Math:PI/INSERT) (Part 51)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 1604-1614
**Context**: Performs math:pi, insert operations. Uses else, when, case, end logic. Follows variable declaration
**SQL Operations**: Math:PI, INSERT
**Control Structures**: ELSE, WHEN, CASE, END
**Variables Declared**: @GROSSPROFITMARGIN
**Tables/Views**: PROFITMARGINANALYSIS
**Subdivision Info**: Part 51 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 55: Transaction Control (Conversion:CAST/System:@@TRANCOUNT) (Part 52)
**Type**: transaction_control
**Complexity Score**: 9
**Lines**: 1646-1683
**Context**: Performs conversion:cast, system:@@trancount, system:getdate, insert, math:log operations. Uses goto, catch, if, end logic. Follows variable declaration
**SQL Operations**: Conversion:CAST, System:@@TRANCOUNT, System:GETDATE, INSERT, Math:LOG
**Control Structures**: GOTO, CATCH, IF, END
**Tables/Views**: ERRORLOG
**Subdivision Info**: Part 52 of 52
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 56: General Business Logic
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1684-1689
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

### Chunk 57: Transaction Control (System:@@TRANCOUNT/Math:PI)
**Type**: transaction_control
**Complexity Score**: 38
**Lines**: 1690-1731
**Context**: Performs system:@@trancount, math:pi operations. Uses end, else, begin, return, if logic. Follows general logic
**SQL Operations**: System:@@TRANCOUNT, Math:PI
**Control Structures**: END, ELSE, BEGIN, RETURN, IF

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

### Chunk 58: General Business Logic (RETURN/END)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1732-1735
**Context**: Uses return, end logic. Follows transaction control
**Control Structures**: RETURN, END

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
