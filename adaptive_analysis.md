# Adaptive SQL Stored Procedure Analysis Guide
======================================================================

**Chunking Strategy**: Hybrid
**Target Chunk Size**: 60 lines
**Max Chunk Size**: 120 lines

## Procedure Statistics
- **Total Chunks**: 74
- **Subdivided Chunks**: 69
- **Total Complexity Score**: 692
- **Average Complexity per Chunk**: 9.4
- **Business Functions Identified**: 0

**Chunk Type Distribution:**
- Conditional Logic: 34
- Cursor Operation: 2
- Data Modification: 3
- Data Retrieval: 2
- Error Handling: 2
- General Logic: 4
- Loop Logic: 9
- Transaction Control: 4
- Variable Declaration: 14

## Sequential Analysis Order
Analyze chunks in this exact order for complete understanding:

1. **Chunk 1**: General Business Logic (Math:PI/CREATE)
   - Type: general_logic
   - Complexity: 3
   - Lines: 1-26
   - Context: Performs math:pi, create operations

2. **Chunk 2**: General Business Logic (BEGIN)
   - Type: general_logic
   - Complexity: 2
   - Lines: 27-35
   - Context: Uses begin logic. Follows general logic

3. **Chunk 3**: Variable & Parameter Declarations (Math:PI/System:GETDATE) (Part 1)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 36-174
   - Context: Performs math:pi, system:getdate operations. Follows general logic
   - Subdivision: Part 1/1 of variable_declaration

4. **Chunk 4**: Error Handling & Exception Management (GOTO/IF) (Part 1)
   - Type: error_handling
   - Complexity: 10
   - Lines: 179-193
   - Context: Uses goto, if, end, try, begin logic. Follows variable declaration
   - Subdivision: Part 1/68 of variable_declaration

5. **Chunk 5**: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 2)
   - Type: conditional_logic
   - Complexity: 12
   - Lines: 194-209
   - Context: Performs math:pi, system:getdate operations. Uses if, goto, end, begin logic. Follows error handling
   - Subdivision: Part 2/68 of variable_declaration

6. **Chunk 6**: Conditional Logic & Branching (String:LEN) (Part 3)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 210-225
   - Context: Performs string:len operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 3/68 of variable_declaration

7. **Chunk 7**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 6)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 231-251
   - Context: Performs logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 6/68 of variable_declaration

8. **Chunk 8**: Conditional Logic & Branching (Aggregate:SUM/Conversion:ISNULL) (Part 7)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 252-269
   - Context: Performs aggregate:sum, conversion:isnull, select, aggregate:count operations. Uses if, when, else, begin, case, end logic. Follows conditional logic
   - Subdivision: Part 7/68 of variable_declaration

9. **Chunk 9**: Conditional Logic & Branching (END/IF) (Part 8)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 270-280
   - Context: Uses end, if, begin logic. Follows conditional logic
   - Subdivision: Part 8/68 of variable_declaration

10. **Chunk 10**: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 11)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 286-307
   - Context: Performs math:pi, logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 11/68 of variable_declaration

11. **Chunk 11**: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 12)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 308-320
   - Context: Performs math:pi, logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 12/68 of variable_declaration

12. **Chunk 12**: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 13)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 321-334
   - Context: Performs math:pi, logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 13/68 of variable_declaration

13. **Chunk 13**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 16)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 340-360
   - Context: Performs logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 16/68 of variable_declaration

14. **Chunk 14**: Loop Processing & Iteration (Math:PI/System:GETDATE) (Part 17)
   - Type: loop_logic
   - Complexity: 9
   - Lines: 361-374
   - Context: Performs math:pi, system:getdate, logical:not exists, select operations. Uses for, goto, end, begin, if logic. Follows conditional logic
   - Subdivision: Part 17/68 of variable_declaration

15. **Chunk 15**: Data Insert/Update/Delete (INSERT/SELECT) (Part 19)
   - Type: data_modification
   - Complexity: 4
   - Lines: 377-387
   - Context: Performs insert, select, aggregate:count operations. Follows loop logic
   - Subdivision: Part 19/68 of variable_declaration

16. **Chunk 16**: Loop Processing & Iteration (GOTO/WHILE) (Part 20)
   - Type: loop_logic
   - Complexity: 8
   - Lines: 388-398
   - Context: Uses goto, while, end, begin, if logic. Follows data modification
   - Subdivision: Part 20/68 of variable_declaration

17. **Chunk 17**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 21)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 399-413
   - Context: Performs logical:not exists, select operations. Uses if, begin logic. Follows loop logic
   - Subdivision: Part 21/68 of variable_declaration

18. **Chunk 18**: Data Query & Retrieval (Conversion:CAST/SELECT) (Part 22)
   - Type: data_retrieval
   - Complexity: 2
   - Lines: 414-428
   - Context: Performs conversion:cast, select operations. Uses end, goto logic. Follows conditional logic
   - Subdivision: Part 22/68 of variable_declaration

19. **Chunk 19**: Loop Processing & Iteration (Conversion:CAST) (Part 23)
   - Type: loop_logic
   - Complexity: 9
   - Lines: 429-440
   - Context: Performs conversion:cast operations. Uses for, goto, end, begin, if logic. Follows data retrieval
   - Subdivision: Part 23/68 of variable_declaration

20. **Chunk 20**: Loop Processing & Iteration (Logical:EXISTS/Conversion:CAST) (Part 24)
   - Type: loop_logic
   - Complexity: 12
   - Lines: 441-471
   - Context: Performs logical:exists, conversion:cast, update, select operations. Uses for, goto, end, else, begin, if logic. Follows loop logic
   - Subdivision: Part 24/68 of variable_declaration

21. **Chunk 21**: Variable & Parameter Declarations (INSERT/SELECT) (Part 27)
   - Type: variable_declaration
   - Complexity: 18
   - Lines: 476-501
   - Context: Performs insert, select, aggregate:sum, sp_call:dbo.fn_allocateinventoryacrosswarehouses, exec, math:pi operations. Uses if, while, begin logic. Follows loop logic
   - Subdivision: Part 27/68 of variable_declaration

22. **Chunk 22**: Loop Processing & Iteration (Conversion:CAST) (Part 28)
   - Type: loop_logic
   - Complexity: 5
   - Lines: 502-511
   - Context: Performs conversion:cast operations. Uses if, for, end, begin logic. Follows variable declaration
   - Subdivision: Part 28/68 of variable_declaration

23. **Chunk 23**: Conditional Logic & Branching (SELECT) (Part 31)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 520-534
   - Context: Performs select operations. Uses if, begin logic. Follows loop logic
   - Subdivision: Part 31/68 of variable_declaration

24. **Chunk 24**: Conditional Logic & Branching (IF/GOTO) (Part 32)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 535-546
   - Context: Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 32/68 of variable_declaration

25. **Chunk 25**: Loop Processing & Iteration (SELECT/Aggregate:COUNT) (Part 33)
   - Type: loop_logic
   - Complexity: 2
   - Lines: 547-557
   - Context: Performs select, aggregate:count operations. Uses end, for, goto logic. Follows conditional logic
   - Subdivision: Part 33/68 of variable_declaration

26. **Chunk 26**: Conditional Logic & Branching (SELECT/Aggregate:COUNT) (Part 34)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 558-573
   - Context: Performs select, aggregate:count operations. Uses if, goto, end, begin logic. Follows loop logic
   - Subdivision: Part 34/68 of variable_declaration

27. **Chunk 27**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 35)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 574-587
   - Context: Performs logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
   - Subdivision: Part 35/68 of variable_declaration

28. **Chunk 28**: Variable & Parameter Declarations (INSERT) (Part 36)
   - Type: variable_declaration
   - Complexity: 7
   - Lines: 588-599
   - Context: Performs insert operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 36/68 of variable_declaration

29. **Chunk 29**: Variable & Parameter Declarations (INSERT/SELECT) (Part 37)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 600-614
   - Context: Performs insert, select operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 37/68 of variable_declaration

30. **Chunk 30**: Variable & Parameter Declarations (Conversion:ISNULL/Math:FLOOR) (Part 38)
   - Type: variable_declaration
   - Complexity: 17
   - Lines: 615-633
   - Context: Performs conversion:isnull, math:floor, select operations. Uses end, else, when, begin, case, if logic. Follows variable declaration
   - Subdivision: Part 38/68 of variable_declaration

31. **Chunk 31**: Data Insert/Update/Delete (INSERT/UPDATE) (Part 39)
   - Type: data_modification
   - Complexity: 2
   - Lines: 634-646
   - Context: Performs insert, update operations. Uses end logic. Follows variable declaration
   - Subdivision: Part 39/68 of variable_declaration

32. **Chunk 32**: Variable & Parameter Declarations (UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX/Math:PI) (Part 42)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 653-674
   - Context: Performs udf_call:dbo.fn_calculatecomplextax, math:pi, select operations. Uses begin, while logic. Follows data modification
   - Subdivision: Part 42/68 of variable_declaration

33. **Chunk 33**: Conditional Logic & Branching (INSERT/Math:PI) (Part 43)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 675-693
   - Context: Performs insert, math:pi, update operations. Uses if, end logic. Follows variable declaration
   - Subdivision: Part 43/68 of variable_declaration

34. **Chunk 34**: Data Query & Retrieval (Math:PI/SELECT) (Part 45)
   - Type: data_retrieval
   - Complexity: 7
   - Lines: 696-709
   - Context: Performs math:pi, select, udf_call:dbo.fn_calculatedynamicshipping operations. Follows conditional logic
   - Subdivision: Part 45/68 of variable_declaration

35. **Chunk 35**: Conditional Logic & Branching (String:FORMAT/Math:PI) (Part 48)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 714-726
   - Context: Performs string:format, math:pi, conversion:cast, system:getdate operations. Uses if, end, begin logic. Follows data retrieval
   - Subdivision: Part 48/68 of variable_declaration

36. **Chunk 36**: Conditional Logic & Branching (INSERT/SELECT) (Part 53)
   - Type: conditional_logic
   - Complexity: 16
   - Lines: 745-819
   - Context: Performs insert, select, system:scope_identity, conversion:isnull, math:pi, system:getdate operations. Uses if logic. Follows conditional logic
   - Subdivision: Part 53/68 of variable_declaration

37. **Chunk 37**: Conditional Logic & Branching (INSERT/System:GETDATE) (Part 55)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 822-838
   - Context: Performs insert, system:getdate, update, select operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 55/68 of variable_declaration

38. **Chunk 38**: Conditional Logic & Branching (INSERT/System:GETDATE) (Part 58)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 843-867
   - Context: Performs insert, system:getdate operations. Uses if, begin logic. Follows conditional logic
   - Subdivision: Part 58/68 of variable_declaration

39. **Chunk 39**: Transaction Control (INSERT/UPDATE) (Part 62)
   - Type: transaction_control
   - Complexity: 10
   - Lines: 880-902
   - Context: Performs insert, update, select, conversion:isnull, math:floor, system:getdate operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 62/68 of variable_declaration

40. **Chunk 40**: Variable & Parameter Declarations (SELECT) (Part 64)
   - Type: variable_declaration
   - Complexity: 1
   - Lines: 905-921
   - Context: Performs select operations. Follows transaction control
   - Subdivision: Part 64/68 of variable_declaration

41. **Chunk 41**: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 65)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 922-938
   - Context: Performs insert, conversion:cast, update, math:log, system:getdate operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 65/68 of variable_declaration

42. **Chunk 42**: Conditional Logic & Branching (INSERT/SELECT) (Part 68)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 943-968
   - Context: Performs insert, select, aggregate:count, date:dateadd, system:getdate operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 68/68 of variable_declaration

43. **Chunk 43**: Transaction Control (INSERT/Conversion:CAST) (Part 70)
   - Type: transaction_control
   - Complexity: 13
   - Lines: 971-1020
   - Context: Performs insert, conversion:cast, math:log, date:datediff, system:scope_identity, system:getdate operations. Follows conditional logic
   - Subdivision: Part 70/68 of variable_declaration

44. **Chunk 44**: Loop Processing & Iteration (INSERT/Conversion:CAST) (Part 73)
   - Type: loop_logic
   - Complexity: 5
   - Lines: 1027-1045
   - Context: Performs insert, conversion:cast, system:getdate operations. Uses for logic. Follows transaction control
   - Subdivision: Part 73/68 of variable_declaration

45. **Chunk 45**: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 74)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 1046-1070
   - Context: Performs insert, conversion:cast, system:getdate operations. Uses if, end, begin logic. Follows loop logic
   - Subdivision: Part 74/68 of variable_declaration

46. **Chunk 46**: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 79)
   - Type: conditional_logic
   - Complexity: 15
   - Lines: 1079-1096
   - Context: Performs conversion:cast, update, select, logical:exists, math:pi, system:getdate operations. Uses if, end, else, begin logic. Follows conditional logic
   - Subdivision: Part 79/68 of variable_declaration

47. **Chunk 47**: Variable & Parameter Declarations (INSERT/Conversion:CAST) (Part 80)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 1097-1108
   - Context: Performs insert, conversion:cast, date:datepart, math:pi, system:getdate operations. Uses end logic. Follows conditional logic
   - Subdivision: Part 80/68 of variable_declaration

48. **Chunk 48**: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 81)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 1109-1120
   - Context: Performs conversion:cast, update, select, logical:exists, system:getdate operations. Uses end, when, else, begin, case, if logic. Follows variable declaration
   - Subdivision: Part 81/68 of variable_declaration

49. **Chunk 49**: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 82)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 1121-1141
   - Context: Performs insert, conversion:cast, update, system:getdate operations. Uses when, case, end, else logic. Follows conditional logic
   - Subdivision: Part 82/68 of variable_declaration

50. **Chunk 50**: Conditional Logic & Branching (INSERT/System:GETDATE) (Part 83)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1142-1153
   - Context: Performs insert, system:getdate, system:@@rowcount operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 83/68 of variable_declaration

51. **Chunk 51**: Loop Processing & Iteration (Logical:EXISTS/Conversion:CAST) (Part 86)
   - Type: loop_logic
   - Complexity: 16
   - Lines: 1162-1172
   - Context: Performs logical:exists, conversion:cast, select operations. Uses begin, for, while, if logic. Follows conditional logic
   - Subdivision: Part 86/68 of variable_declaration

52. **Chunk 52**: Conditional Logic & Branching (Date:DATEDIFF/Conversion:CAST) (Part 87)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 1173-1189
   - Context: Performs date:datediff, conversion:cast, update, system:getdate operations. Uses when, begin, else, case, end logic. Follows loop logic
   - Subdivision: Part 87/68 of variable_declaration

53. **Chunk 53**: Variable & Parameter Declarations (INSERT/Conversion:CAST) (Part 88)
   - Type: variable_declaration
   - Complexity: 4
   - Lines: 1190-1203
   - Context: Performs insert, conversion:cast, system:getdate, select operations. Uses end logic. Follows conditional logic
   - Subdivision: Part 88/68 of variable_declaration

54. **Chunk 54**: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 89)
   - Type: conditional_logic
   - Complexity: 15
   - Lines: 1204-1217
   - Context: Performs conversion:cast, update, select, aggregate:sum, logical:exists, system:getdate operations. Uses if, end, else, begin logic. Follows variable declaration
   - Subdivision: Part 89/68 of variable_declaration

55. **Chunk 55**: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 90)
   - Type: conditional_logic
   - Complexity: 17
   - Lines: 1218-1242
   - Context: Performs insert, conversion:cast, update, system:@@rowcount, date:datediff, system:getdate operations. Uses if, when, else, begin, case, end logic. Follows conditional logic
   - Subdivision: Part 90/68 of variable_declaration

56. **Chunk 56**: Cursor Operations & Row Processing (INSERT/System:GETDATE) (Part 91)
   - Type: cursor_operation
   - Complexity: 2
   - Lines: 1243-1254
   - Context: Performs insert, system:getdate operations. Uses end logic. Follows conditional logic
   - Subdivision: Part 91/68 of variable_declaration

57. **Chunk 57**: Variable & Parameter Declarations (Logical:EXISTS/Date:DATEDIFF) (Part 93)
   - Type: variable_declaration
   - Complexity: 16
   - Lines: 1257-1296
   - Context: Performs logical:exists, date:datediff, select operations. Uses if, when, else, begin, case, end logic. Follows cursor operation
   - Subdivision: Part 93/68 of variable_declaration

58. **Chunk 58**: Conditional Logic & Branching (Math:PI/Date:DATEADD) (Part 94)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1297-1321
   - Context: Performs math:pi, date:dateadd, update, system:getdate operations. Uses when, begin, else, case, end logic. Follows variable declaration
   - Subdivision: Part 94/68 of variable_declaration

59. **Chunk 59**: Variable & Parameter Declarations (INSERT/Math:PI) (Part 95)
   - Type: variable_declaration
   - Complexity: 7
   - Lines: 1322-1348
   - Context: Performs insert, math:pi, date:dateadd, system:getdate operations. Uses end, case, when, else logic. Follows conditional logic
   - Subdivision: Part 95/68 of variable_declaration

60. **Chunk 60**: Conditional Logic & Branching (INSERT/SELECT) (Part 96)
   - Type: conditional_logic
   - Complexity: 19
   - Lines: 1349-1382
   - Context: Performs insert, select, date:month, math:pi, system:getdate operations. Uses end, case, when, else logic. Follows variable declaration
   - Subdivision: Part 96/68 of variable_declaration

61. **Chunk 61**: Variable & Parameter Declarations (Conversion:CAST/UPDATE) (Part 98)
   - Type: variable_declaration
   - Complexity: 22
   - Lines: 1385-1414
   - Context: Performs conversion:cast, update, aggregate:sum, select, logical:exists, system:getdate operations. Uses for, if, while, end, else, begin logic. Follows conditional logic
   - Subdivision: Part 98/68 of variable_declaration

62. **Chunk 62**: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 99)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 1415-1447
   - Context: Performs insert, conversion:cast, update, system:getdate operations. Uses end, case, when, else logic. Follows variable declaration
   - Subdivision: Part 99/68 of variable_declaration

63. **Chunk 63**: Data Insert/Update/Delete (INSERT/System:GETDATE) (Part 100)
   - Type: data_modification
   - Complexity: 5
   - Lines: 1448-1464
   - Context: Performs insert, system:getdate, date:datediff, select operations. Follows conditional logic
   - Subdivision: Part 100/68 of variable_declaration

64. **Chunk 64**: Variable & Parameter Declarations (Logical:EXISTS/SELECT) (Part 103)
   - Type: variable_declaration
   - Complexity: 10
   - Lines: 1470-1480
   - Context: Performs logical:exists, select operations. Uses if, for, begin logic. Follows data modification
   - Subdivision: Part 103/68 of variable_declaration

65. **Chunk 65**: Loop Processing & Iteration (Conversion:CAST/UPDATE) (Part 104)
   - Type: loop_logic
   - Complexity: 17
   - Lines: 1481-1499
   - Context: Performs conversion:cast, update, select, logical:exists, system:getdate operations. Uses if, while, end, else, begin logic. Follows variable declaration
   - Subdivision: Part 104/68 of variable_declaration

66. **Chunk 66**: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 105)
   - Type: conditional_logic
   - Complexity: 15
   - Lines: 1500-1530
   - Context: Performs insert, conversion:cast, update, select, logical:exists, system:getdate operations. Uses if, when, begin, else, case, end logic. Follows loop logic
   - Subdivision: Part 105/68 of variable_declaration

67. **Chunk 67**: Cursor Operations & Row Processing (INSERT/System:GETDATE) (Part 106)
   - Type: cursor_operation
   - Complexity: 2
   - Lines: 1531-1547
   - Context: Performs insert, system:getdate operations. Uses end logic. Follows conditional logic
   - Subdivision: Part 106/68 of variable_declaration

68. **Chunk 68**: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 109)
   - Type: conditional_logic
   - Complexity: 23
   - Lines: 1558-1584
   - Context: Performs conversion:cast, update, aggregate:sum, select, logical:exists, math:pi, system:getdate operations. Uses if, end, else, begin logic. Follows cursor operation
   - Subdivision: Part 109/68 of variable_declaration

69. **Chunk 69**: Variable & Parameter Declarations (INSERT/Conversion:CAST) (Part 110)
   - Type: variable_declaration
   - Complexity: 17
   - Lines: 1585-1620
   - Context: Performs insert, conversion:cast, select, aggregate:sum, math:pi, system:getdate operations. Uses end, when, case, else logic. Follows conditional logic
   - Subdivision: Part 110/68 of variable_declaration

70. **Chunk 70**: Transaction Control (Conversion:CAST/System:@@TRANCOUNT) (Part 115)
   - Type: transaction_control
   - Complexity: 6
   - Lines: 1643-1655
   - Context: Performs conversion:cast, system:@@trancount operations. Uses if logic. Follows variable declaration
   - Subdivision: Part 115/68 of variable_declaration

71. **Chunk 71**: Error Handling & Exception Management (INSERT/Math:LOG) (Part 116)
   - Type: error_handling
   - Complexity: 3
   - Lines: 1656-1683
   - Context: Performs insert, math:log, system:getdate operations. Uses end, goto, catch logic. Follows transaction control
   - Subdivision: Part 116/68 of variable_declaration

72. **Chunk 72**: General Business Logic
   - Type: general_logic
   - Complexity: 0
   - Lines: 1684-1689
   - Context: Follows error handling

73. **Chunk 73**: Transaction Control (Math:PI/System:@@TRANCOUNT)
   - Type: transaction_control
   - Complexity: 38
   - Lines: 1690-1731
   - Context: Performs math:pi, system:@@trancount operations. Uses end, else, begin, return, if logic. Follows general logic

74. **Chunk 74**: General Business Logic (END/RETURN)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1732-1735
   - Context: Uses end, return logic. Follows transaction control

## Detailed Sequential Analysis

### Chunk 1: General Business Logic (Math:PI/CREATE)
**Type**: general_logic
**Complexity Score**: 3
**Lines**: 1-26
**Context**: Performs math:pi, create operations
**SQL Operations**: Math:PI, CREATE

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

### Chunk 3: Variable & Parameter Declarations (Math:PI/System:GETDATE) (Part 1)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 36-174
**Context**: Performs math:pi, system:getdate operations. Follows general logic
**SQL Operations**: Math:PI, System:GETDATE
**Variables Declared**: @ISVALID, @SUBTOTALAMOUNT, @WAREHOUSEID, @LOYALTYTIERMULTIPLIER, @TOTALVOLUME, @TAXCALCULATIONS, @UNITPRICE, @ESTIMATEDDELIVERYDAYS, @INVENTORYALLOCATIONS, @PRODUCTID
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

### Chunk 4: Error Handling & Exception Management (GOTO/IF) (Part 1)
**Type**: error_handling
**Complexity Score**: 10
**Lines**: 179-193
**Context**: Uses goto, if, end, try, begin logic. Follows variable declaration
**Control Structures**: GOTO, IF, END, TRY, BEGIN
**Subdivision Info**: Part 1 of 68
**Parent Block**: variable_declaration (lines 179-1683)

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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 5: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 2)
**Type**: conditional_logic
**Complexity Score**: 12
**Lines**: 194-209
**Context**: Performs math:pi, system:getdate operations. Uses if, goto, end, begin logic. Follows error handling
**SQL Operations**: Math:PI, System:GETDATE
**Control Structures**: IF, GOTO, END, BEGIN
**Subdivision Info**: Part 2 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 6: Conditional Logic & Branching (String:LEN) (Part 3)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 210-225
**Context**: Performs string:len operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: String:LEN
**Control Structures**: IF, GOTO, END, BEGIN
**Subdivision Info**: Part 3 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 7: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 6)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 231-251
**Context**: Performs logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 6 of 68
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

### Chunk 8: Conditional Logic & Branching (Aggregate:SUM/Conversion:ISNULL) (Part 7)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 252-269
**Context**: Performs aggregate:sum, conversion:isnull, select, aggregate:count operations. Uses if, when, else, begin, case, end logic. Follows conditional logic
**SQL Operations**: Aggregate:SUM, Conversion:ISNULL, SELECT, Aggregate:COUNT
**Control Structures**: IF, WHEN, ELSE, BEGIN, CASE, END
**Tables/Views**: ORDERS
**Subdivision Info**: Part 7 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 9: Conditional Logic & Branching (END/IF) (Part 8)
**Type**: conditional_logic
**Complexity Score**: 4
**Lines**: 270-280
**Context**: Uses end, if, begin logic. Follows conditional logic
**Control Structures**: END, IF, BEGIN
**Subdivision Info**: Part 8 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 10: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 11)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 286-307
**Context**: Performs math:pi, logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: Math:PI, Logical:NOT EXISTS, SELECT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: ADDRESSES
**Subdivision Info**: Part 11 of 68
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

### Chunk 11: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 12)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 308-320
**Context**: Performs math:pi, logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: Math:PI, Logical:NOT EXISTS, SELECT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: SHIPPINGMETHODS
**Subdivision Info**: Part 12 of 68
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

### Chunk 12: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 13)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 321-334
**Context**: Performs math:pi, logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: Math:PI, Logical:NOT EXISTS, SELECT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: SHIPPINGMETHODZONES, SHIPPINGMETHODS
**Subdivision Info**: Part 13 of 68
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

### Chunk 13: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 16)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 340-360
**Context**: Performs logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: PAYMENTMETHODS
**Subdivision Info**: Part 16 of 68
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

### Chunk 14: Loop Processing & Iteration (Math:PI/System:GETDATE) (Part 17)
**Type**: loop_logic
**Complexity Score**: 9
**Lines**: 361-374
**Context**: Performs math:pi, system:getdate, logical:not exists, select operations. Uses for, goto, end, begin, if logic. Follows conditional logic
**SQL Operations**: Math:PI, System:GETDATE, Logical:NOT EXISTS, SELECT
**Control Structures**: FOR, GOTO, END, BEGIN, IF
**Tables/Views**: CUSTOMERPAYMENTMETHODS
**Subdivision Info**: Part 17 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 15: Data Insert/Update/Delete (INSERT/SELECT) (Part 19)
**Type**: data_modification
**Complexity Score**: 4
**Lines**: 377-387
**Context**: Performs insert, select, aggregate:count operations. Follows loop logic
**SQL Operations**: INSERT, SELECT, Aggregate:COUNT
**Tables/Views**: OPENJSON
**Subdivision Info**: Part 19 of 68
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

### Chunk 16: Loop Processing & Iteration (GOTO/WHILE) (Part 20)
**Type**: loop_logic
**Complexity Score**: 8
**Lines**: 388-398
**Context**: Uses goto, while, end, begin, if logic. Follows data modification
**Control Structures**: GOTO, WHILE, END, BEGIN, IF
**Subdivision Info**: Part 20 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 17: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 21)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 399-413
**Context**: Performs logical:not exists, select operations. Uses if, begin logic. Follows loop logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, BEGIN
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 21 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 18: Data Query & Retrieval (Conversion:CAST/SELECT) (Part 22)
**Type**: data_retrieval
**Complexity Score**: 2
**Lines**: 414-428
**Context**: Performs conversion:cast, select operations. Uses end, goto logic. Follows conditional logic
**SQL Operations**: Conversion:CAST, SELECT
**Control Structures**: END, GOTO
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 22 of 68
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

### Chunk 19: Loop Processing & Iteration (Conversion:CAST) (Part 23)
**Type**: loop_logic
**Complexity Score**: 9
**Lines**: 429-440
**Context**: Performs conversion:cast operations. Uses for, goto, end, begin, if logic. Follows data retrieval
**SQL Operations**: Conversion:CAST
**Control Structures**: FOR, GOTO, END, BEGIN, IF
**Subdivision Info**: Part 23 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 20: Loop Processing & Iteration (Logical:EXISTS/Conversion:CAST) (Part 24)
**Type**: loop_logic
**Complexity Score**: 12
**Lines**: 441-471
**Context**: Performs logical:exists, conversion:cast, update, select operations. Uses for, goto, end, else, begin, if logic. Follows loop logic
**SQL Operations**: Logical:EXISTS, Conversion:CAST, UPDATE, SELECT
**Control Structures**: FOR, GOTO, END, ELSE, BEGIN, IF
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 24 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 21: Variable & Parameter Declarations (INSERT/SELECT) (Part 27)
**Type**: variable_declaration
**Complexity Score**: 18
**Lines**: 476-501
**Context**: Performs insert, select, aggregate:sum, sp_call:dbo.fn_allocateinventoryacrosswarehouses, exec, math:pi operations. Uses if, while, begin logic. Follows loop logic
**SQL Operations**: INSERT, SELECT, Aggregate:SUM, SP_CALL:DBO.FN_ALLOCATEINVENTORYACROSSWAREHOUSES, EXEC, Math:PI
**Control Structures**: IF, WHILE, BEGIN
**Variables Declared**: @ALLOCATEDTOTAL
**Subdivision Info**: Part 27 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
                
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 22: Loop Processing & Iteration (Conversion:CAST) (Part 28)
**Type**: loop_logic
**Complexity Score**: 5
**Lines**: 502-511
**Context**: Performs conversion:cast operations. Uses if, for, end, begin logic. Follows variable declaration
**SQL Operations**: Conversion:CAST
**Control Structures**: IF, FOR, END, BEGIN
**Subdivision Info**: Part 28 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 23: Conditional Logic & Branching (SELECT) (Part 31)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 520-534
**Context**: Performs select operations. Uses if, begin logic. Follows loop logic
**SQL Operations**: SELECT
**Control Structures**: IF, BEGIN
**Tables/Views**: PROMOTIONS
**Subdivision Info**: Part 31 of 68
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

### Chunk 24: Conditional Logic & Branching (IF/GOTO) (Part 32)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 535-546
**Context**: Uses if, goto, end, begin logic. Follows conditional logic
**Control Structures**: IF, GOTO, END, BEGIN
**Subdivision Info**: Part 32 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 25: Loop Processing & Iteration (SELECT/Aggregate:COUNT) (Part 33)
**Type**: loop_logic
**Complexity Score**: 2
**Lines**: 547-557
**Context**: Performs select, aggregate:count operations. Uses end, for, goto logic. Follows conditional logic
**SQL Operations**: SELECT, Aggregate:COUNT
**Control Structures**: END, FOR, GOTO
**Tables/Views**: ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 33 of 68
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

### Chunk 26: Conditional Logic & Branching (SELECT/Aggregate:COUNT) (Part 34)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 558-573
**Context**: Performs select, aggregate:count operations. Uses if, goto, end, begin logic. Follows loop logic
**SQL Operations**: SELECT, Aggregate:COUNT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 34 of 68
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

### Chunk 27: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 35)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 574-587
**Context**: Performs logical:not exists, select operations. Uses if, goto, end, begin logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, GOTO, END, BEGIN
**Tables/Views**: PROMOTIONS
**Subdivision Info**: Part 35 of 68
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

### Chunk 28: Variable & Parameter Declarations (INSERT) (Part 36)
**Type**: variable_declaration
**Complexity Score**: 7
**Lines**: 588-599
**Context**: Performs insert operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: INSERT
**Control Structures**: IF, END, BEGIN
**Variables Declared**: @TIERDISCOUNTPERCENTAGE
**Subdivision Info**: Part 36 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 29: Variable & Parameter Declarations (INSERT/SELECT) (Part 37)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 600-614
**Context**: Performs insert, select operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: INSERT, SELECT
**Control Structures**: IF, END, BEGIN
**Variables Declared**: @TIERDISCOUNT
**Tables/Views**: CUSTOMERTIERS
**Subdivision Info**: Part 37 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 30: Variable & Parameter Declarations (Conversion:ISNULL/Math:FLOOR) (Part 38)
**Type**: variable_declaration
**Complexity Score**: 17
**Lines**: 615-633
**Context**: Performs conversion:isnull, math:floor, select operations. Uses end, else, when, begin, case, if logic. Follows variable declaration
**SQL Operations**: Conversion:ISNULL, Math:FLOOR, SELECT
**Control Structures**: END, ELSE, WHEN, BEGIN, CASE, IF
**Variables Declared**: @POINTSTOREDEEM, @MAXPOINTSREDEMPTION, @POINTSDISCOUNT
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 38 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 31: Data Insert/Update/Delete (INSERT/UPDATE) (Part 39)
**Type**: data_modification
**Complexity Score**: 2
**Lines**: 634-646
**Context**: Performs insert, update operations. Uses end logic. Follows variable declaration
**SQL Operations**: INSERT, UPDATE
**Control Structures**: END
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 39 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 32: Variable & Parameter Declarations (UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX/Math:PI) (Part 42)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 653-674
**Context**: Performs udf_call:dbo.fn_calculatecomplextax, math:pi, select operations. Uses begin, while logic. Follows data modification
**SQL Operations**: UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX, Math:PI, SELECT
**Control Structures**: BEGIN, WHILE
**Variables Declared**: @LINETAXAMOUNT, @PRODUCTTAXRATE
**Subdivision Info**: Part 42 of 68
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

### Chunk 33: Conditional Logic & Branching (INSERT/Math:PI) (Part 43)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 675-693
**Context**: Performs insert, math:pi, update operations. Uses if, end logic. Follows variable declaration
**SQL Operations**: INSERT, Math:PI, UPDATE
**Control Structures**: IF, END
**Subdivision Info**: Part 43 of 68
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

### Chunk 34: Data Query & Retrieval (Math:PI/SELECT) (Part 45)
**Type**: data_retrieval
**Complexity Score**: 7
**Lines**: 696-709
**Context**: Performs math:pi, select, udf_call:dbo.fn_calculatedynamicshipping operations. Follows conditional logic
**SQL Operations**: Math:PI, SELECT, UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING
**Subdivision Info**: Part 45 of 68
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

### Chunk 35: Conditional Logic & Branching (String:FORMAT/Math:PI) (Part 48)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 714-726
**Context**: Performs string:format, math:pi, conversion:cast, system:getdate operations. Uses if, end, begin logic. Follows data retrieval
**SQL Operations**: String:FORMAT, Math:PI, Conversion:CAST, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Subdivision Info**: Part 48 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 36: Conditional Logic & Branching (INSERT/SELECT) (Part 53)
**Type**: conditional_logic
**Complexity Score**: 16
**Lines**: 745-819
**Context**: Performs insert, select, system:scope_identity, conversion:isnull, math:pi, system:getdate operations. Uses if logic. Follows conditional logic
**SQL Operations**: INSERT, SELECT, System:SCOPE_IDENTITY, Conversion:ISNULL, Math:PI, System:GETDATE
**Control Structures**: IF
**Tables/Views**: ORDERITEMS, ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 53 of 68
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

### Chunk 37: Conditional Logic & Branching (INSERT/System:GETDATE) (Part 55)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 822-838
**Context**: Performs insert, system:getdate, update, select operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: INSERT, System:GETDATE, UPDATE, SELECT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: INVENTORYRESERVATIONS, P, PRODUCTS
**Subdivision Info**: Part 55 of 68
**Parent Block**: variable_declaration (lines 179-1683)

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

### Chunk 38: Conditional Logic & Branching (INSERT/System:GETDATE) (Part 58)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 843-867
**Context**: Performs insert, system:getdate operations. Uses if, begin logic. Follows conditional logic
**SQL Operations**: INSERT, System:GETDATE
**Control Structures**: IF, BEGIN
**Tables/Views**: PAYMENTS
**Subdivision Info**: Part 58 of 68
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

### Chunk 39: Transaction Control (INSERT/UPDATE) (Part 62)
**Type**: transaction_control
**Complexity Score**: 10
**Lines**: 880-902
**Context**: Performs insert, update, select, conversion:isnull, math:floor, system:getdate operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: INSERT, UPDATE, SELECT, Conversion:ISNULL, Math:FLOOR, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: LOYALTYTRANSACTIONS, CUSTOMERTIERS, CUSTOMERS
**Subdivision Info**: Part 62 of 68
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

### Chunk 40: Variable & Parameter Declarations (SELECT) (Part 64)
**Type**: variable_declaration
**Complexity Score**: 1
**Lines**: 905-921
**Context**: Performs select operations. Follows transaction control
**SQL Operations**: SELECT
**Variables Declared**: @NEWCUSTOMERTIERID
**Tables/Views**: CUSTOMERTIERS
**Subdivision Info**: Part 64 of 68
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

### Chunk 41: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 65)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 922-938
**Context**: Performs insert, conversion:cast, update, math:log, system:getdate operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: INSERT, Conversion:CAST, UPDATE, Math:LOG, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERS, TIER, CUSTOMERLOG
**Subdivision Info**: Part 65 of 68
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

### Chunk 42: Conditional Logic & Branching (INSERT/SELECT) (Part 68)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 943-968
**Context**: Performs insert, select, aggregate:count, date:dateadd, system:getdate operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: INSERT, SELECT, Aggregate:COUNT, Date:DATEADD, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERRECOMMENDATIONS, ORDERITEMS, PRODUCTS, ORDERS
**Subdivision Info**: Part 68 of 68
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

### Chunk 43: Transaction Control (INSERT/Conversion:CAST) (Part 70)
**Type**: transaction_control
**Complexity Score**: 13
**Lines**: 971-1020
**Context**: Performs insert, conversion:cast, math:log, date:datediff, system:scope_identity, system:getdate operations. Follows conditional logic
**SQL Operations**: INSERT, Conversion:CAST, Math:LOG, Date:DATEDIFF, System:SCOPE_IDENTITY, System:GETDATE
**Tables/Views**: AUDITLOG, TRANSACTIONLOG
**Subdivision Info**: Part 70 of 68
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

### Chunk 44: Loop Processing & Iteration (INSERT/Conversion:CAST) (Part 73)
**Type**: loop_logic
**Complexity Score**: 5
**Lines**: 1027-1045
**Context**: Performs insert, conversion:cast, system:getdate operations. Uses for logic. Follows transaction control
**SQL Operations**: INSERT, Conversion:CAST, System:GETDATE
**Control Structures**: FOR
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 73 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 45: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 74)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 1046-1070
**Context**: Performs insert, conversion:cast, system:getdate operations. Uses if, end, begin logic. Follows loop logic
**SQL Operations**: INSERT, Conversion:CAST, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 74 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
            
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

### Chunk 46: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 79)
**Type**: conditional_logic
**Complexity Score**: 15
**Lines**: 1079-1096
**Context**: Performs conversion:cast, update, select, logical:exists, math:pi, system:getdate operations. Uses if, end, else, begin logic. Follows conditional logic
**SQL Operations**: Conversion:CAST, UPDATE, SELECT, Logical:EXISTS, Math:PI, System:GETDATE
**Control Structures**: IF, END, ELSE, BEGIN
**Tables/Views**: DAILYSALESSUMMARY
**Subdivision Info**: Part 79 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 47: Variable & Parameter Declarations (INSERT/Conversion:CAST) (Part 80)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 1097-1108
**Context**: Performs insert, conversion:cast, date:datepart, math:pi, system:getdate operations. Uses end logic. Follows conditional logic
**SQL Operations**: INSERT, Conversion:CAST, Date:DATEPART, Math:PI, System:GETDATE
**Control Structures**: END
**Variables Declared**: @CURRENTHOUR
**Tables/Views**: DAILYSALESSUMMARY
**Subdivision Info**: Part 80 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 48: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 81)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 1109-1120
**Context**: Performs conversion:cast, update, select, logical:exists, system:getdate operations. Uses end, when, else, begin, case, if logic. Follows variable declaration
**SQL Operations**: Conversion:CAST, UPDATE, SELECT, Logical:EXISTS, System:GETDATE
**Control Structures**: END, WHEN, ELSE, BEGIN, CASE, IF
**Tables/Views**: HOURLYSALESSUMMARY
**Subdivision Info**: Part 81 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 49: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 82)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 1121-1141
**Context**: Performs insert, conversion:cast, update, system:getdate operations. Uses when, case, end, else logic. Follows conditional logic
**SQL Operations**: INSERT, Conversion:CAST, UPDATE, System:GETDATE
**Control Structures**: WHEN, CASE, END, ELSE
**Tables/Views**: HOURLYSALESSUMMARY, CUSTOMERANALYTICS
**Subdivision Info**: Part 82 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 50: Conditional Logic & Branching (INSERT/System:GETDATE) (Part 83)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1142-1153
**Context**: Performs insert, system:getdate, system:@@rowcount operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: INSERT, System:GETDATE, System:@@ROWCOUNT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERANALYTICS
**Subdivision Info**: Part 83 of 68
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

### Chunk 51: Loop Processing & Iteration (Logical:EXISTS/Conversion:CAST) (Part 86)
**Type**: loop_logic
**Complexity Score**: 16
**Lines**: 1162-1172
**Context**: Performs logical:exists, conversion:cast, select operations. Uses begin, for, while, if logic. Follows conditional logic
**SQL Operations**: Logical:EXISTS, Conversion:CAST, SELECT
**Control Structures**: BEGIN, FOR, WHILE, IF
**Tables/Views**: PRODUCTSALESSTATS
**Subdivision Info**: Part 86 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
            SET @ProductAnalyticsCursor = CURSOR FOR
            SELECT ProductID, Quantity, LineTotal FROM @Cart;
            
            OPEN @ProductAnalyticsCursor;
            FETCH NEXT FROM @ProductAnalyticsCursor INTO @CurrProductID, @CurrQuantity, @CurrLineTotal;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                -- Update product sales statistics
                IF EXISTS (SELECT 1 FROM ProductSalesStats WHERE ProductID = @CurrProductID AND SalesDate = CAST(@OrderDate AS DATE))
                BEGIN
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 52: Conditional Logic & Branching (Date:DATEDIFF/Conversion:CAST) (Part 87)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 1173-1189
**Context**: Performs date:datediff, conversion:cast, update, system:getdate operations. Uses when, begin, else, case, end logic. Follows loop logic
**SQL Operations**: Date:DATEDIFF, Conversion:CAST, UPDATE, System:GETDATE
**Control Structures**: WHEN, BEGIN, ELSE, CASE, END
**Tables/Views**: PRODUCTSALESSTATS
**Subdivision Info**: Part 87 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 53: Variable & Parameter Declarations (INSERT/Conversion:CAST) (Part 88)
**Type**: variable_declaration
**Complexity Score**: 4
**Lines**: 1190-1203
**Context**: Performs insert, conversion:cast, system:getdate, select operations. Uses end logic. Follows conditional logic
**SQL Operations**: INSERT, Conversion:CAST, System:GETDATE, SELECT
**Control Structures**: END
**Variables Declared**: @CATEGORYID
**Tables/Views**: PRODUCTS, PRODUCTSALESSTATS
**Subdivision Info**: Part 88 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 54: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 89)
**Type**: conditional_logic
**Complexity Score**: 15
**Lines**: 1204-1217
**Context**: Performs conversion:cast, update, select, aggregate:sum, logical:exists, system:getdate operations. Uses if, end, else, begin logic. Follows variable declaration
**SQL Operations**: Conversion:CAST, UPDATE, SELECT, Aggregate:SUM, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, END, ELSE, BEGIN
**Tables/Views**: CATEGORYSALESSTATS
**Subdivision Info**: Part 89 of 68
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
                ELSE
                BEGIN
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 55: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 90)
**Type**: conditional_logic
**Complexity Score**: 17
**Lines**: 1218-1242
**Context**: Performs insert, conversion:cast, update, system:@@rowcount, date:datediff, system:getdate operations. Uses if, when, else, begin, case, end logic. Follows conditional logic
**SQL Operations**: INSERT, Conversion:CAST, UPDATE, System:@@ROWCOUNT, Date:DATEDIFF, System:GETDATE
**Control Structures**: IF, WHEN, ELSE, BEGIN, CASE, END
**Tables/Views**: PRODUCTRECOMMENDATIONSCORES, CATEGORYSALESSTATS
**Subdivision Info**: Part 90 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 56: Cursor Operations & Row Processing (INSERT/System:GETDATE) (Part 91)
**Type**: cursor_operation
**Complexity Score**: 2
**Lines**: 1243-1254
**Context**: Performs insert, system:getdate operations. Uses end logic. Follows conditional logic
**SQL Operations**: INSERT, System:GETDATE
**Control Structures**: END
**Tables/Views**: PRODUCTRECOMMENDATIONSCORES
**Subdivision Info**: Part 91 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 57: Variable & Parameter Declarations (Logical:EXISTS/Date:DATEDIFF) (Part 93)
**Type**: variable_declaration
**Complexity Score**: 16
**Lines**: 1257-1296
**Context**: Performs logical:exists, date:datediff, select operations. Uses if, when, else, begin, case, end logic. Follows cursor operation
**SQL Operations**: Logical:EXISTS, Date:DATEDIFF, SELECT
**Control Structures**: IF, WHEN, ELSE, BEGIN, CASE, END
**Variables Declared**: @FREQUENCYSCORE, @MONETARYSCORE, @SEGMENTSCORE, @RECENCYSCORE
**Tables/Views**: CUSTOMERRFMANALYSIS
**Subdivision Info**: Part 93 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 58: Conditional Logic & Branching (Math:PI/Date:DATEADD) (Part 94)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1297-1321
**Context**: Performs math:pi, date:dateadd, update, system:getdate operations. Uses when, begin, else, case, end logic. Follows variable declaration
**SQL Operations**: Math:PI, Date:DATEADD, UPDATE, System:GETDATE
**Control Structures**: WHEN, BEGIN, ELSE, CASE, END
**Tables/Views**: CUSTOMERRFMANALYSIS
**Subdivision Info**: Part 94 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 59: Variable & Parameter Declarations (INSERT/Math:PI) (Part 95)
**Type**: variable_declaration
**Complexity Score**: 7
**Lines**: 1322-1348
**Context**: Performs insert, math:pi, date:dateadd, system:getdate operations. Uses end, case, when, else logic. Follows conditional logic
**SQL Operations**: INSERT, Math:PI, Date:DATEADD, System:GETDATE
**Control Structures**: END, CASE, WHEN, ELSE
**Variables Declared**: @PURCHASEPATTERN, @SHOPPINGTIMEPREFERENCE, @SEASONALTREND
**Tables/Views**: CUSTOMERRFMANALYSIS
**Subdivision Info**: Part 95 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
            
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 60: Conditional Logic & Branching (INSERT/SELECT) (Part 96)
**Type**: conditional_logic
**Complexity Score**: 19
**Lines**: 1349-1382
**Context**: Performs insert, select, date:month, math:pi, system:getdate operations. Uses end, case, when, else logic. Follows variable declaration
**SQL Operations**: INSERT, SELECT, Date:MONTH, Math:PI, System:GETDATE
**Control Structures**: END, CASE, WHEN, ELSE
**Tables/Views**: CUSTOMERBEHAVIORTRACKING, PAYMENTTYPES, SHIPPINGMETHODS
**Subdivision Info**: Part 96 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
            
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 61: Variable & Parameter Declarations (Conversion:CAST/UPDATE) (Part 98)
**Type**: variable_declaration
**Complexity Score**: 22
**Lines**: 1385-1414
**Context**: Performs conversion:cast, update, aggregate:sum, select, logical:exists, system:getdate operations. Uses for, if, while, end, else, begin logic. Follows conditional logic
**SQL Operations**: Conversion:CAST, UPDATE, Aggregate:SUM, SELECT, Logical:EXISTS, System:GETDATE
**Control Structures**: FOR, IF, WHILE, END, ELSE, BEGIN
**Variables Declared**: @CURRWAREHOUSEID, @INVENTORYANALYTICSCURSOR
**Tables/Views**: WAREHOUSEPERFORMANCEMETRICS
**Subdivision Info**: Part 98 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 62: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 99)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 1415-1447
**Context**: Performs insert, conversion:cast, update, system:getdate operations. Uses end, case, when, else logic. Follows variable declaration
**SQL Operations**: INSERT, Conversion:CAST, UPDATE, System:GETDATE
**Control Structures**: END, CASE, WHEN, ELSE
**Tables/Views**: INVENTORYVELOCITYMETRICS, WAREHOUSEPERFORMANCEMETRICS
**Subdivision Info**: Part 99 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 63: Data Insert/Update/Delete (INSERT/System:GETDATE) (Part 100)
**Type**: data_modification
**Complexity Score**: 5
**Lines**: 1448-1464
**Context**: Performs insert, system:getdate, date:datediff, select operations. Follows conditional logic
**SQL Operations**: INSERT, System:GETDATE, Date:DATEDIFF, SELECT
**Tables/Views**: SUPPLYCHAINEVENTS
**Subdivision Info**: Part 100 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 64: Variable & Parameter Declarations (Logical:EXISTS/SELECT) (Part 103)
**Type**: variable_declaration
**Complexity Score**: 10
**Lines**: 1470-1480
**Context**: Performs logical:exists, select operations. Uses if, for, begin logic. Follows data modification
**SQL Operations**: Logical:EXISTS, SELECT
**Control Structures**: IF, FOR, BEGIN
**Variables Declared**: @PROMOEFFECTIVENESSCURSOR, @CURRPROMOID
**Subdivision Info**: Part 103 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
            IF EXISTS (SELECT 1 FROM @AppliedPromotions)
            BEGIN
                DECLARE @PromoEffectivenessCursor CURSOR;
                DECLARE @CurrPromoID INT, @CurrDiscountAmount DECIMAL(18,2);
                
                SET @PromoEffectivenessCursor = CURSOR FOR
                SELECT PromoID, DiscountAmount FROM @AppliedPromotions;
                
                OPEN @PromoEffectivenessCursor;
                FETCH NEXT FROM @PromoEffectivenessCursor INTO @CurrPromoID, @CurrDiscountAmount;
                
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 65: Loop Processing & Iteration (Conversion:CAST/UPDATE) (Part 104)
**Type**: loop_logic
**Complexity Score**: 17
**Lines**: 1481-1499
**Context**: Performs conversion:cast, update, select, logical:exists, system:getdate operations. Uses if, while, end, else, begin logic. Follows variable declaration
**SQL Operations**: Conversion:CAST, UPDATE, SELECT, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, WHILE, END, ELSE, BEGIN
**Tables/Views**: PROMOTIONEFFECTIVENESSMETRICS
**Subdivision Info**: Part 104 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 66: Conditional Logic & Branching (INSERT/Conversion:CAST) (Part 105)
**Type**: conditional_logic
**Complexity Score**: 15
**Lines**: 1500-1530
**Context**: Performs insert, conversion:cast, update, select, logical:exists, system:getdate operations. Uses if, when, begin, else, case, end logic. Follows loop logic
**SQL Operations**: INSERT, Conversion:CAST, UPDATE, SELECT, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, WHEN, BEGIN, ELSE, CASE, END
**Tables/Views**: CUSTOMERPROMOTIONAFFINITY, PROMOTIONEFFECTIVENESSMETRICS
**Subdivision Info**: Part 105 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 67: Cursor Operations & Row Processing (INSERT/System:GETDATE) (Part 106)
**Type**: cursor_operation
**Complexity Score**: 2
**Lines**: 1531-1547
**Context**: Performs insert, system:getdate operations. Uses end logic. Follows conditional logic
**SQL Operations**: INSERT, System:GETDATE
**Control Structures**: END
**Tables/Views**: CUSTOMERPROMOTIONAFFINITY
**Subdivision Info**: Part 106 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 68: Conditional Logic & Branching (Conversion:CAST/UPDATE) (Part 109)
**Type**: conditional_logic
**Complexity Score**: 23
**Lines**: 1558-1584
**Context**: Performs conversion:cast, update, aggregate:sum, select, logical:exists, math:pi, system:getdate operations. Uses if, end, else, begin logic. Follows cursor operation
**SQL Operations**: Conversion:CAST, UPDATE, Aggregate:SUM, SELECT, Logical:EXISTS, Math:PI, System:GETDATE
**Control Structures**: IF, END, ELSE, BEGIN
**Tables/Views**: FINANCIALSUMMARY
**Subdivision Info**: Part 109 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 69: Variable & Parameter Declarations (INSERT/Conversion:CAST) (Part 110)
**Type**: variable_declaration
**Complexity Score**: 17
**Lines**: 1585-1620
**Context**: Performs insert, conversion:cast, select, aggregate:sum, math:pi, system:getdate operations. Uses end, when, case, else logic. Follows conditional logic
**SQL Operations**: INSERT, Conversion:CAST, SELECT, Aggregate:SUM, Math:PI, System:GETDATE
**Control Structures**: END, WHEN, CASE, ELSE
**Variables Declared**: @TOTALCOGS, @GROSSPROFITMARGIN, @GROSSPROFIT
**Tables/Views**: PROFITMARGINANALYSIS, FINANCIALSUMMARY, PRODUCTS
**Subdivision Info**: Part 110 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
        
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 70: Transaction Control (Conversion:CAST/System:@@TRANCOUNT) (Part 115)
**Type**: transaction_control
**Complexity Score**: 6
**Lines**: 1643-1655
**Context**: Performs conversion:cast, system:@@trancount operations. Uses if logic. Follows variable declaration
**SQL Operations**: Conversion:CAST, System:@@TRANCOUNT
**Control Structures**: IF
**Subdivision Info**: Part 115 of 68
**Parent Block**: variable_declaration (lines 179-1683)

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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 71: Error Handling & Exception Management (INSERT/Math:LOG) (Part 116)
**Type**: error_handling
**Complexity Score**: 3
**Lines**: 1656-1683
**Context**: Performs insert, math:log, system:getdate operations. Uses end, goto, catch logic. Follows transaction control
**SQL Operations**: INSERT, Math:LOG, System:GETDATE
**Control Structures**: END, GOTO, CATCH
**Tables/Views**: ERRORLOG
**Subdivision Info**: Part 116 of 68
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 72: General Business Logic
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1684-1689
**Context**: Follows error handling

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

### Chunk 73: Transaction Control (Math:PI/System:@@TRANCOUNT)
**Type**: transaction_control
**Complexity Score**: 38
**Lines**: 1690-1731
**Context**: Performs math:pi, system:@@trancount operations. Uses end, else, begin, return, if logic. Follows general logic
**SQL Operations**: Math:PI, System:@@TRANCOUNT
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

### Chunk 74: General Business Logic (END/RETURN)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1732-1735
**Context**: Uses end, return logic. Follows transaction control
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
