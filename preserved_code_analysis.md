# Adaptive SQL Stored Procedure Analysis Guide
======================================================================

**Chunking Strategy**: Hybrid
**Target Chunk Size**: 60 lines
**Max Chunk Size**: 120 lines

## Procedure Statistics
- **Total Chunks**: 113
- **Subdivided Chunks**: 108
- **Total Complexity Score**: 722
- **Average Complexity per Chunk**: 6.4
- **Business Functions Identified**: 0

**Chunk Type Distribution:**
- Conditional Logic: 50
- Cursor Operation: 1
- Data Modification: 6
- Data Retrieval: 3
- Error Handling: 2
- General Logic: 17
- Loop Logic: 10
- Transaction Control: 5
- Variable Declaration: 19

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
   - Subdivision: Part 1/2 of variable_declaration

4. **Chunk 4**: General Business Logic (Part 2)
   - Type: general_logic
   - Complexity: 0
   - Lines: 175-178
   - Context: Follows variable declaration
   - Subdivision: Part 2/2 of variable_declaration

5. **Chunk 5**: Error Handling & Exception Management (BEGIN/TRY) (Part 1)
   - Type: error_handling
   - Complexity: 6
   - Lines: 179-185
   - Context: Uses begin, try logic. Follows general logic
   - Subdivision: Part 1/106 of variable_declaration

6. **Chunk 6**: Conditional Logic & Branching (System:GETDATE) (Part 2)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 186-201
   - Context: Performs system:getdate operations. Uses if, end, begin, goto logic. Follows error handling
   - Subdivision: Part 2/106 of variable_declaration

7. **Chunk 7**: Conditional Logic & Branching (Math:PI) (Part 3)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 202-217
   - Context: Performs math:pi operations. Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 3/106 of variable_declaration

8. **Chunk 8**: Conditional Logic & Branching (String:LEN) (Part 4)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 218-227
   - Context: Performs string:len operations. Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 4/106 of variable_declaration

9. **Chunk 9**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 5)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 228-251
   - Context: Performs logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 5/106 of variable_declaration

10. **Chunk 10**: Conditional Logic & Branching (Conversion:ISNULL/Aggregate:SUM) (Part 6)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 252-267
   - Context: Performs conversion:isnull, aggregate:sum, select, aggregate:count operations. Uses case, else, end, when logic. Follows conditional logic
   - Subdivision: Part 6/106 of variable_declaration

11. **Chunk 11**: Conditional Logic & Branching (IF/END) (Part 7)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 268-280
   - Context: Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 7/106 of variable_declaration

12. **Chunk 12**: General Business Logic (Part 8)
   - Type: general_logic
   - Complexity: 0
   - Lines: 281-285
   - Context: Follows conditional logic
   - Subdivision: Part 8/106 of variable_declaration

13. **Chunk 13**: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 9)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 286-307
   - Context: Performs math:pi, logical:not exists, select operations. Uses if, end, begin, goto logic. Follows general logic
   - Subdivision: Part 9/106 of variable_declaration

14. **Chunk 14**: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 10)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 308-320
   - Context: Performs math:pi, logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 10/106 of variable_declaration

15. **Chunk 15**: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 11)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 321-334
   - Context: Performs math:pi, logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 11/106 of variable_declaration

16. **Chunk 16**: General Business Logic (Part 12)
   - Type: general_logic
   - Complexity: 0
   - Lines: 335-339
   - Context: Follows conditional logic
   - Subdivision: Part 12/106 of variable_declaration

17. **Chunk 17**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 13)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 340-360
   - Context: Performs logical:not exists, select operations. Uses if, end, begin, goto logic. Follows general logic
   - Subdivision: Part 13/106 of variable_declaration

18. **Chunk 18**: Loop Processing & Iteration (Math:PI/System:GETDATE) (Part 14)
   - Type: loop_logic
   - Complexity: 9
   - Lines: 361-374
   - Context: Performs math:pi, system:getdate, logical:not exists, select operations. Uses end, for, if, begin, goto logic. Follows conditional logic
   - Subdivision: Part 14/106 of variable_declaration

19. **Chunk 19**: Data Insert/Update/Delete (SELECT/Aggregate:COUNT) (Part 15)
   - Type: data_modification
   - Complexity: 4
   - Lines: 375-387
   - Context: Performs select, aggregate:count, insert operations. Follows loop logic
   - Subdivision: Part 15/106 of variable_declaration

20. **Chunk 20**: Loop Processing & Iteration (END/WHILE) (Part 16)
   - Type: loop_logic
   - Complexity: 8
   - Lines: 388-398
   - Context: Uses end, while, if, begin, goto logic. Follows data modification
   - Subdivision: Part 16/106 of variable_declaration

21. **Chunk 21**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 17)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 399-413
   - Context: Performs logical:not exists, select operations. Uses if, begin logic. Follows loop logic
   - Subdivision: Part 17/106 of variable_declaration

22. **Chunk 22**: Data Query & Retrieval (SELECT/Conversion:CAST) (Part 18)
   - Type: data_retrieval
   - Complexity: 2
   - Lines: 414-428
   - Context: Performs select, conversion:cast operations. Uses end, goto logic. Follows conditional logic
   - Subdivision: Part 18/106 of variable_declaration

23. **Chunk 23**: Loop Processing & Iteration (Conversion:CAST) (Part 19)
   - Type: loop_logic
   - Complexity: 5
   - Lines: 429-437
   - Context: Performs conversion:cast operations. Uses end, for, if, begin, goto logic. Follows data retrieval
   - Subdivision: Part 19/106 of variable_declaration

24. **Chunk 24**: Conditional Logic & Branching (Conversion:CAST/SELECT) (Part 20)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 438-446
   - Context: Performs conversion:cast, select, logical:exists operations. Uses if, end, begin logic. Follows loop logic
   - Subdivision: Part 20/106 of variable_declaration

25. **Chunk 25**: Loop Processing & Iteration (UPDATE/Conversion:CAST) (Part 21)
   - Type: loop_logic
   - Complexity: 5
   - Lines: 447-471
   - Context: Performs update, conversion:cast operations. Uses end, for, else, begin, goto logic. Follows conditional logic
   - Subdivision: Part 21/106 of variable_declaration

26. **Chunk 26**: General Business Logic (Part 22)
   - Type: general_logic
   - Complexity: 0
   - Lines: 472-475
   - Context: Follows loop logic
   - Subdivision: Part 22/106 of variable_declaration

27. **Chunk 27**: Variable & Parameter Declarations (Math:PI/Aggregate:SUM) (Part 23)
   - Type: variable_declaration
   - Complexity: 18
   - Lines: 476-501
   - Context: Performs math:pi, aggregate:sum, sp_call:dbo.fn_allocateinventoryacrosswarehouses, select, exec, insert operations. Uses if, begin, while logic. Follows general logic
   - Subdivision: Part 23/106 of variable_declaration

28. **Chunk 28**: Loop Processing & Iteration (Conversion:CAST) (Part 24)
   - Type: loop_logic
   - Complexity: 5
   - Lines: 502-511
   - Context: Performs conversion:cast operations. Uses if, end, begin, for logic. Follows variable declaration
   - Subdivision: Part 24/106 of variable_declaration

29. **Chunk 29**: Data Query & Retrieval (Aggregate:SUM/SELECT) (Part 25)
   - Type: data_retrieval
   - Complexity: 2
   - Lines: 512-519
   - Context: Performs aggregate:sum, select operations. Follows loop logic
   - Subdivision: Part 25/106 of variable_declaration

30. **Chunk 30**: Conditional Logic & Branching (SELECT) (Part 26)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 520-534
   - Context: Performs select operations. Uses if, begin logic. Follows data retrieval
   - Subdivision: Part 26/106 of variable_declaration

31. **Chunk 31**: Conditional Logic & Branching (IF/END) (Part 27)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 535-546
   - Context: Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 27/106 of variable_declaration

32. **Chunk 32**: Loop Processing & Iteration (SELECT/Aggregate:COUNT) (Part 28)
   - Type: loop_logic
   - Complexity: 2
   - Lines: 547-557
   - Context: Performs select, aggregate:count operations. Uses end, goto, for logic. Follows conditional logic
   - Subdivision: Part 28/106 of variable_declaration

33. **Chunk 33**: Conditional Logic & Branching (SELECT/Aggregate:COUNT) (Part 29)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 558-573
   - Context: Performs select, aggregate:count operations. Uses if, end, begin, goto logic. Follows loop logic
   - Subdivision: Part 29/106 of variable_declaration

34. **Chunk 34**: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 30)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 574-587
   - Context: Performs logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
   - Subdivision: Part 30/106 of variable_declaration

35. **Chunk 35**: Variable & Parameter Declarations (INSERT) (Part 31)
   - Type: variable_declaration
   - Complexity: 7
   - Lines: 588-599
   - Context: Performs insert operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 31/106 of variable_declaration

36. **Chunk 36**: Variable & Parameter Declarations (SELECT/INSERT) (Part 32)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 600-614
   - Context: Performs select, insert operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 32/106 of variable_declaration

37. **Chunk 37**: Variable & Parameter Declarations (Conversion:ISNULL/SELECT) (Part 33)
   - Type: variable_declaration
   - Complexity: 11
   - Lines: 615-624
   - Context: Performs conversion:isnull, select, math:floor operations. Uses if, begin logic. Follows variable declaration
   - Subdivision: Part 33/106 of variable_declaration

38. **Chunk 38**: Variable & Parameter Declarations (CASE/ELSE) (Part 34)
   - Type: variable_declaration
   - Complexity: 2
   - Lines: 625-630
   - Context: Uses case, else, end, when logic. Follows variable declaration
   - Subdivision: Part 34/106 of variable_declaration

39. **Chunk 39**: Variable & Parameter Declarations (UPDATE/INSERT) (Part 35)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 631-646
   - Context: Performs update, insert operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 35/106 of variable_declaration

40. **Chunk 40**: General Business Logic (Part 36)
   - Type: general_logic
   - Complexity: 0
   - Lines: 647-652
   - Context: Follows variable declaration
   - Subdivision: Part 36/106 of variable_declaration

41. **Chunk 41**: Variable & Parameter Declarations (Math:PI/UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX) (Part 37)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 653-674
   - Context: Performs math:pi, udf_call:dbo.fn_calculatecomplextax, select operations. Uses begin, while logic. Follows general logic
   - Subdivision: Part 37/106 of variable_declaration

42. **Chunk 42**: Conditional Logic & Branching (UPDATE/Math:PI) (Part 38)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 675-693
   - Context: Performs update, math:pi, insert operations. Uses if, end logic. Follows variable declaration
   - Subdivision: Part 38/106 of variable_declaration

43. **Chunk 43**: Data Query & Retrieval (Math:PI/UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING) (Part 39)
   - Type: data_retrieval
   - Complexity: 7
   - Lines: 694-709
   - Context: Performs math:pi, udf_call:dbo.fn_calculatedynamicshipping, select operations. Follows conditional logic
   - Subdivision: Part 39/106 of variable_declaration

44. **Chunk 44**: General Business Logic (Part 40)
   - Type: general_logic
   - Complexity: 0
   - Lines: 710-713
   - Context: Follows data retrieval
   - Subdivision: Part 40/106 of variable_declaration

45. **Chunk 45**: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 41)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 714-726
   - Context: Performs math:pi, system:getdate, string:format, conversion:cast operations. Uses if, end, begin logic. Follows general logic
   - Subdivision: Part 41/106 of variable_declaration

46. **Chunk 46**: General Business Logic (Math:PI) (Part 42)
   - Type: general_logic
   - Complexity: 1
   - Lines: 727-734
   - Context: Performs math:pi operations. Follows conditional logic
   - Subdivision: Part 42/106 of variable_declaration

47. **Chunk 47**: Conditional Logic & Branching (IF/END) (Part 43)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 735-744
   - Context: Uses if, end, begin, goto logic. Follows general logic
   - Subdivision: Part 43/106 of variable_declaration

48. **Chunk 48**: Data Insert/Update/Delete (Math:PI/SELECT) (Part 44)
   - Type: data_modification
   - Complexity: 11
   - Lines: 745-809
   - Context: Performs math:pi, select, system:scope_identity, system:getdate, insert operations. Follows conditional logic
   - Subdivision: Part 44/106 of variable_declaration

49. **Chunk 49**: Conditional Logic & Branching (Conversion:ISNULL/SELECT) (Part 45)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 810-819
   - Context: Performs conversion:isnull, select, insert operations. Uses if logic. Follows data modification
   - Subdivision: Part 45/106 of variable_declaration

50. **Chunk 50**: General Business Logic (Part 46)
   - Type: general_logic
   - Complexity: 0
   - Lines: 820-823
   - Context: Follows conditional logic
   - Subdivision: Part 46/106 of variable_declaration

51. **Chunk 51**: Conditional Logic & Branching (UPDATE/System:GETDATE) (Part 47)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 824-838
   - Context: Performs update, system:getdate, select, insert operations. Uses if, end, begin logic. Follows general logic
   - Subdivision: Part 47/106 of variable_declaration

52. **Chunk 52**: General Business Logic (Part 48)
   - Type: general_logic
   - Complexity: 0
   - Lines: 839-842
   - Context: Follows conditional logic
   - Subdivision: Part 48/106 of variable_declaration

53. **Chunk 53**: Conditional Logic & Branching (System:GETDATE/INSERT) (Part 49)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 843-867
   - Context: Performs system:getdate, insert operations. Uses if, begin logic. Follows general logic
   - Subdivision: Part 49/106 of variable_declaration

54. **Chunk 54**: Conditional Logic & Branching (UPDATE) (Part 50)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 868-877
   - Context: Performs update operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 50/106 of variable_declaration

55. **Chunk 55**: Transaction Control (System:GETDATE/UPDATE) (Part 51)
   - Type: transaction_control
   - Complexity: 10
   - Lines: 878-902
   - Context: Performs system:getdate, update, select, math:floor, conversion:isnull, insert operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 51/106 of variable_declaration

56. **Chunk 56**: Variable & Parameter Declarations (SELECT) (Part 52)
   - Type: variable_declaration
   - Complexity: 1
   - Lines: 903-921
   - Context: Performs select operations. Follows transaction control
   - Subdivision: Part 52/106 of variable_declaration

57. **Chunk 57**: Conditional Logic & Branching (Math:LOG/UPDATE) (Part 53)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 922-938
   - Context: Performs math:log, update, conversion:cast, system:getdate, insert operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 53/106 of variable_declaration

58. **Chunk 58**: General Business Logic (Part 54)
   - Type: general_logic
   - Complexity: 0
   - Lines: 939-942
   - Context: Follows conditional logic
   - Subdivision: Part 54/106 of variable_declaration

59. **Chunk 59**: Conditional Logic & Branching (Aggregate:COUNT/SELECT) (Part 55)
   - Type: conditional_logic
   - Complexity: 14
   - Lines: 943-968
   - Context: Performs aggregate:count, select, date:dateadd, system:getdate, insert operations. Uses if, end, begin logic. Follows general logic
   - Subdivision: Part 55/106 of variable_declaration

60. **Chunk 60**: Transaction Control (Math:LOG/Date:DATEDIFF) (Part 56)
   - Type: transaction_control
   - Complexity: 13
   - Lines: 969-1020
   - Context: Performs math:log, date:datediff, conversion:cast, system:scope_identity, system:getdate, insert operations. Follows conditional logic
   - Subdivision: Part 56/106 of variable_declaration

61. **Chunk 61**: General Business Logic (Part 57)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1021-1024
   - Context: Follows transaction control
   - Subdivision: Part 57/106 of variable_declaration

62. **Chunk 62**: Conditional Logic & Branching (Conversion:CAST/INSERT) (Part 58)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 1025-1040
   - Context: Performs conversion:cast, insert operations. Uses if, begin logic. Follows general logic
   - Subdivision: Part 58/106 of variable_declaration

63. **Chunk 63**: Loop Processing & Iteration (System:GETDATE/Conversion:CAST) (Part 59)
   - Type: loop_logic
   - Complexity: 12
   - Lines: 1041-1070
   - Context: Performs system:getdate, conversion:cast, insert operations. Uses if, end, begin, for logic. Follows conditional logic
   - Subdivision: Part 59/106 of variable_declaration

64. **Chunk 64**: General Business Logic (Part 60)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1071-1074
   - Context: Follows loop logic
   - Subdivision: Part 60/106 of variable_declaration

65. **Chunk 65**: Conditional Logic & Branching (IF/BEGIN) (Part 61)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 1075-1078
   - Context: Uses if, begin logic. Follows general logic
   - Subdivision: Part 61/106 of variable_declaration

66. **Chunk 66**: Conditional Logic & Branching (Math:PI/UPDATE) (Part 62)
   - Type: conditional_logic
   - Complexity: 13
   - Lines: 1079-1094
   - Context: Performs math:pi, update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 62/106 of variable_declaration

67. **Chunk 67**: Variable & Parameter Declarations (Math:PI/Date:DATEPART) (Part 63)
   - Type: variable_declaration
   - Complexity: 8
   - Lines: 1095-1108
   - Context: Performs math:pi, date:datepart, conversion:cast, system:getdate, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 63/106 of variable_declaration

68. **Chunk 68**: Conditional Logic & Branching (UPDATE/SELECT) (Part 64)
   - Type: conditional_logic
   - Complexity: 12
   - Lines: 1109-1118
   - Context: Performs update, select, conversion:cast, logical:exists, system:getdate operations. Uses case, end, if, else, begin, when logic. Follows variable declaration
   - Subdivision: Part 64/106 of variable_declaration

69. **Chunk 69**: Conditional Logic & Branching (UPDATE/System:GETDATE) (Part 65)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 1119-1141
   - Context: Performs update, system:getdate, conversion:cast, insert operations. Uses case, end, else, begin, when logic. Follows conditional logic
   - Subdivision: Part 65/106 of variable_declaration

70. **Chunk 70**: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 66)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1142-1153
   - Context: Performs system:getdate, system:@@rowcount, insert operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 66/106 of variable_declaration

71. **Chunk 71**: Variable & Parameter Declarations (Part 67)
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 1154-1161
   - Context: Follows conditional logic
   - Subdivision: Part 67/106 of variable_declaration

72. **Chunk 72**: Loop Processing & Iteration (SELECT) (Part 68)
   - Type: loop_logic
   - Complexity: 9
   - Lines: 1162-1170
   - Context: Performs select operations. Uses begin, while, for logic. Follows variable declaration
   - Subdivision: Part 68/106 of variable_declaration

73. **Chunk 73**: Conditional Logic & Branching (UPDATE/Logical:EXISTS) (Part 69)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1171-1179
   - Context: Performs update, logical:exists, select, conversion:cast operations. Uses if, begin logic. Follows loop logic
   - Subdivision: Part 69/106 of variable_declaration

74. **Chunk 74**: Conditional Logic & Branching (System:GETDATE/Date:DATEDIFF) (Part 70)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 1180-1187
   - Context: Performs system:getdate, date:datediff, conversion:cast operations. Uses case, else, end, when logic. Follows conditional logic
   - Subdivision: Part 70/106 of variable_declaration

75. **Chunk 75**: Variable & Parameter Declarations (SELECT/System:GETDATE) (Part 71)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 1188-1203
   - Context: Performs select, system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 71/106 of variable_declaration

76. **Chunk 76**: Conditional Logic & Branching (Aggregate:SUM/UPDATE) (Part 72)
   - Type: conditional_logic
   - Complexity: 13
   - Lines: 1204-1215
   - Context: Performs aggregate:sum, update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 72/106 of variable_declaration

77. **Chunk 77**: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 73)
   - Type: data_modification
   - Complexity: 6
   - Lines: 1216-1231
   - Context: Performs update, system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 73/106 of variable_declaration

78. **Chunk 78**: Conditional Logic & Branching (System:GETDATE/Date:DATEDIFF) (Part 74)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 1232-1240
   - Context: Performs system:getdate, date:datediff operations. Uses case, else, end, when logic. Follows data modification
   - Subdivision: Part 74/106 of variable_declaration

79. **Chunk 79**: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 75)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1241-1254
   - Context: Performs system:getdate, system:@@rowcount, insert operations. Uses if, end, begin logic. Follows conditional logic
   - Subdivision: Part 75/106 of variable_declaration

80. **Chunk 80**: Variable & Parameter Declarations (Part 76)
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 1255-1265
   - Context: Follows conditional logic
   - Subdivision: Part 76/106 of variable_declaration

81. **Chunk 81**: Conditional Logic & Branching (Date:DATEDIFF) (Part 77)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 1266-1274
   - Context: Performs date:datediff operations. Uses case, else, end, when logic. Follows variable declaration
   - Subdivision: Part 77/106 of variable_declaration

82. **Chunk 82**: Conditional Logic & Branching (CASE/ELSE) (Part 78)
   - Type: conditional_logic
   - Complexity: 2
   - Lines: 1275-1283
   - Context: Uses case, else, end, when logic. Follows conditional logic
   - Subdivision: Part 78/106 of variable_declaration

83. **Chunk 83**: Conditional Logic & Branching (CASE/ELSE) (Part 79)
   - Type: conditional_logic
   - Complexity: 2
   - Lines: 1284-1294
   - Context: Uses case, else, end, when logic. Follows conditional logic
   - Subdivision: Part 79/106 of variable_declaration

84. **Chunk 84**: Conditional Logic & Branching (UPDATE/SELECT) (Part 80)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 1295-1302
   - Context: Performs update, select, logical:exists operations. Uses if, begin logic. Follows conditional logic
   - Subdivision: Part 80/106 of variable_declaration

85. **Chunk 85**: Conditional Logic & Branching (Math:PI) (Part 81)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 1303-1312
   - Context: Performs math:pi operations. Uses case, when logic. Follows conditional logic
   - Subdivision: Part 81/106 of variable_declaration

86. **Chunk 86**: Data Insert/Update/Delete (System:GETDATE/Date:DATEADD) (Part 82)
   - Type: data_modification
   - Complexity: 5
   - Lines: 1313-1327
   - Context: Performs system:getdate, date:dateadd, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 82/106 of variable_declaration

87. **Chunk 87**: Conditional Logic & Branching (Math:PI) (Part 83)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 1328-1337
   - Context: Performs math:pi operations. Uses case, when logic. Follows data modification
   - Subdivision: Part 83/106 of variable_declaration

88. **Chunk 88**: Variable & Parameter Declarations (Math:PI/System:GETDATE) (Part 84)
   - Type: variable_declaration
   - Complexity: 3
   - Lines: 1338-1348
   - Context: Performs math:pi, system:getdate, date:dateadd operations. Uses else, end logic. Follows conditional logic
   - Subdivision: Part 84/106 of variable_declaration

89. **Chunk 89**: Conditional Logic & Branching (Math:PI) (Part 85)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 1349-1355
   - Context: Performs math:pi operations. Uses case, else, end, when logic. Follows variable declaration
   - Subdivision: Part 85/106 of variable_declaration

90. **Chunk 90**: Conditional Logic & Branching (Date:MONTH) (Part 86)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 1356-1362
   - Context: Performs date:month operations. Uses case, else, end, when logic. Follows conditional logic
   - Subdivision: Part 86/106 of variable_declaration

91. **Chunk 91**: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 87)
   - Type: conditional_logic
   - Complexity: 11
   - Lines: 1363-1382
   - Context: Performs math:pi, system:getdate, select, insert operations. Uses case, else, end, when logic. Follows conditional logic
   - Subdivision: Part 87/106 of variable_declaration

92. **Chunk 92**: Variable & Parameter Declarations (Part 88)
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 1383-1390
   - Context: Follows conditional logic
   - Subdivision: Part 88/106 of variable_declaration

93. **Chunk 93**: Loop Processing & Iteration (Aggregate:SUM/SELECT) (Part 89)
   - Type: loop_logic
   - Complexity: 10
   - Lines: 1391-1401
   - Context: Performs aggregate:sum, select operations. Uses begin, while, for logic. Follows variable declaration
   - Subdivision: Part 89/106 of variable_declaration

94. **Chunk 94**: Conditional Logic & Branching (UPDATE/SELECT) (Part 90)
   - Type: conditional_logic
   - Complexity: 10
   - Lines: 1402-1412
   - Context: Performs update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows loop logic
   - Subdivision: Part 90/106 of variable_declaration

95. **Chunk 95**: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 91)
   - Type: data_modification
   - Complexity: 6
   - Lines: 1413-1431
   - Context: Performs update, system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 91/106 of variable_declaration

96. **Chunk 96**: Conditional Logic & Branching (System:GETDATE/Date:DATEDIFF) (Part 92)
   - Type: conditional_logic
   - Complexity: 8
   - Lines: 1432-1464
   - Context: Performs system:getdate, date:datediff, select, insert operations. Uses case, else, end, when logic. Follows data modification
   - Subdivision: Part 92/106 of variable_declaration

97. **Chunk 97**: General Business Logic (Part 93)
   - Type: general_logic
   - Complexity: 0
   - Lines: 1465-1469
   - Context: Follows conditional logic
   - Subdivision: Part 93/106 of variable_declaration

98. **Chunk 98**: Variable & Parameter Declarations (SELECT/Logical:EXISTS) (Part 94)
   - Type: variable_declaration
   - Complexity: 10
   - Lines: 1470-1480
   - Context: Performs select, logical:exists operations. Uses if, begin, for logic. Follows general logic
   - Subdivision: Part 94/106 of variable_declaration

99. **Chunk 99**: Loop Processing & Iteration (UPDATE/SELECT) (Part 95)
   - Type: loop_logic
   - Complexity: 15
   - Lines: 1481-1497
   - Context: Performs update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin, while logic. Follows variable declaration
   - Subdivision: Part 95/106 of variable_declaration

100. **Chunk 100**: Data Insert/Update/Delete (System:GETDATE/Conversion:CAST) (Part 96)
   - Type: data_modification
   - Complexity: 5
   - Lines: 1498-1513
   - Context: Performs system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows loop logic
   - Subdivision: Part 96/106 of variable_declaration

101. **Chunk 101**: Conditional Logic & Branching (UPDATE/SELECT) (Part 97)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 1514-1523
   - Context: Performs update, select, logical:exists operations. Uses case, if, begin, when logic. Follows data modification
   - Subdivision: Part 97/106 of variable_declaration

102. **Chunk 102**: Cursor Operations & Row Processing (System:GETDATE/INSERT) (Part 98)
   - Type: cursor_operation
   - Complexity: 5
   - Lines: 1524-1547
   - Context: Performs system:getdate, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 98/106 of variable_declaration

103. **Chunk 103**: Variable & Parameter Declarations (Part 99)
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 1548-1557
   - Context: Follows cursor operation
   - Subdivision: Part 99/106 of variable_declaration

104. **Chunk 104**: Conditional Logic & Branching (Math:PI/Aggregate:SUM) (Part 100)
   - Type: conditional_logic
   - Complexity: 21
   - Lines: 1558-1582
   - Context: Performs math:pi, aggregate:sum, update, conversion:cast, select, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows variable declaration
   - Subdivision: Part 100/106 of variable_declaration

105. **Chunk 105**: Variable & Parameter Declarations (Math:PI/Aggregate:SUM) (Part 101)
   - Type: variable_declaration
   - Complexity: 9
   - Lines: 1583-1603
   - Context: Performs math:pi, aggregate:sum, select, conversion:cast, system:getdate, insert operations. Uses else, end, begin logic. Follows conditional logic
   - Subdivision: Part 101/106 of variable_declaration

106. **Chunk 106**: Variable & Parameter Declarations (Math:PI/INSERT) (Part 102)
   - Type: variable_declaration
   - Complexity: 6
   - Lines: 1604-1614
   - Context: Performs math:pi, insert operations. Uses case, else, end, when logic. Follows variable declaration
   - Subdivision: Part 102/106 of variable_declaration

107. **Chunk 107**: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 103)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 1615-1622
   - Context: Performs math:pi, system:getdate operations. Uses case, else, end, when logic. Follows variable declaration
   - Subdivision: Part 103/106 of variable_declaration

108. **Chunk 108**: Transaction Control (String:LEN/Conversion:CAST) (Part 104)
   - Type: transaction_control
   - Complexity: 6
   - Lines: 1623-1638
   - Context: Performs string:len, conversion:cast operations. Uses if, end, begin, return logic. Follows conditional logic
   - Subdivision: Part 104/106 of variable_declaration

109. **Chunk 109**: Error Handling & Exception Management (END/BEGIN) (Part 105)
   - Type: error_handling
   - Complexity: 4
   - Lines: 1639-1642
   - Context: Uses end, begin, catch, try logic. Follows transaction control
   - Subdivision: Part 105/106 of variable_declaration

110. **Chunk 110**: Transaction Control (Math:LOG/System:@@TRANCOUNT) (Part 106)
   - Type: transaction_control
   - Complexity: 9
   - Lines: 1643-1683
   - Context: Performs math:log, system:@@trancount, conversion:cast, system:getdate, insert operations. Uses if, end, catch, goto logic. Follows error handling
   - Subdivision: Part 106/106 of variable_declaration

111. **Chunk 111**: General Business Logic
   - Type: general_logic
   - Complexity: 0
   - Lines: 1684-1689
   - Context: Follows transaction control

112. **Chunk 112**: Transaction Control (Math:PI/System:@@TRANCOUNT)
   - Type: transaction_control
   - Complexity: 38
   - Lines: 1690-1731
   - Context: Performs math:pi, system:@@trancount operations. Uses end, if, else, return, begin logic. Follows general logic

113. **Chunk 113**: General Business Logic (END/RETURN)
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
**Variables Declared**: @ISVALID, @CUSTOMERPROMOUSAGE, @CUSTOMERRISKSCORE, @RECOMMENDATIONSETID, @INVENTORYSHORTFALL, @DISCOUNTPERCENTAGE, @CUSTOMERTIERID, @PROMOID, @ORDERSTATUSID, @CUSTOMERTYPEID
   (and 67 more...)
**Subdivision Info**: Part 1 of 2
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

### Chunk 4: General Business Logic (Part 2)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 175-178
**Context**: Follows variable declaration
**Subdivision Info**: Part 2 of 2
**Parent Block**: variable_declaration (lines 36-178)

**Code:**
```sql
    -- =====================================================================================
    -- COMPREHENSIVE INPUT VALIDATION
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

### Chunk 5: Error Handling & Exception Management (BEGIN/TRY) (Part 1)
**Type**: error_handling
**Complexity Score**: 6
**Lines**: 179-185
**Context**: Uses begin, try logic. Follows general logic
**Control Structures**: BEGIN, TRY
**Subdivision Info**: Part 1 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
    BEGIN TRY
        BEGIN TRANSACTION;

            -- Initialize warning messages
            SET @WarningMessages = '';

            -- Validate customer information
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 6: Conditional Logic & Branching (System:GETDATE) (Part 2)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 186-201
**Context**: Performs system:getdate operations. Uses if, end, begin, goto logic. Follows error handling
**SQL Operations**: System:GETDATE
**Control Structures**: IF, END, BEGIN, GOTO
**Subdivision Info**: Part 2 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 7: Conditional Logic & Branching (Math:PI) (Part 3)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 202-217
**Context**: Performs math:pi operations. Uses if, end, begin, goto logic. Follows conditional logic
**SQL Operations**: Math:PI
**Control Structures**: IF, END, BEGIN, GOTO
**Subdivision Info**: Part 3 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 8: Conditional Logic & Branching (String:LEN) (Part 4)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 218-227
**Context**: Performs string:len operations. Uses if, end, begin, goto logic. Follows conditional logic
**SQL Operations**: String:LEN
**Control Structures**: IF, END, BEGIN, GOTO
**Subdivision Info**: Part 4 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                            IF @CartItems IS NULL OR LEN(@CartItems) = 0
                                BEGIN
                                    SET @IsValid = 0;
                                    SET @ErrorMessage = 'Cart items cannot be empty.';
                                    SET @ErrorCode = 1005;
                                    GOTO ErrorHandler;
                                END;

                                -- =====================================================================================
                                -- CUSTOMER VERIFICATION AND ANALYSIS
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 9: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 5)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 228-251
**Context**: Performs logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 5 of 106
**Parent Block**: variable_declaration (lines 179-1683)

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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 10: Conditional Logic & Branching (Conversion:ISNULL/Aggregate:SUM) (Part 6)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 252-267
**Context**: Performs conversion:isnull, aggregate:sum, select, aggregate:count operations. Uses case, else, end, when logic. Follows conditional logic
**SQL Operations**: Conversion:ISNULL, Aggregate:SUM, SELECT, Aggregate:COUNT
**Control Structures**: CASE, ELSE, END, WHEN
**Tables/Views**: ORDERS
**Subdivision Info**: Part 6 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 11: Conditional Logic & Branching (IF/END) (Part 7)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 268-280
**Context**: Uses if, end, begin logic. Follows conditional logic
**Control Structures**: IF, END, BEGIN
**Subdivision Info**: Part 7 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 12: General Business Logic (Part 8)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 281-285
**Context**: Follows conditional logic
**Subdivision Info**: Part 8 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                    -- =====================================================================================
                                    -- ADDRESS AND SHIPPING VALIDATION
                                    -- =====================================================================================

                                    -- Validate shipping address belongs to customer
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 13: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 9)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 286-307
**Context**: Performs math:pi, logical:not exists, select operations. Uses if, end, begin, goto logic. Follows general logic
**SQL Operations**: Math:PI, Logical:NOT EXISTS, SELECT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: ADDRESSES
**Subdivision Info**: Part 9 of 106
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

### Chunk 14: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 10)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 308-320
**Context**: Performs math:pi, logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
**SQL Operations**: Math:PI, Logical:NOT EXISTS, SELECT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: SHIPPINGMETHODS
**Subdivision Info**: Part 10 of 106
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

### Chunk 15: Conditional Logic & Branching (Math:PI/Logical:NOT EXISTS) (Part 11)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 321-334
**Context**: Performs math:pi, logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
**SQL Operations**: Math:PI, Logical:NOT EXISTS, SELECT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: SHIPPINGMETHODZONES, SHIPPINGMETHODS
**Subdivision Info**: Part 11 of 106
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

### Chunk 16: General Business Logic (Part 12)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 335-339
**Context**: Follows conditional logic
**Subdivision Info**: Part 12 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                -- =====================================================================================
                                                -- PAYMENT METHOD VALIDATION
                                                -- =====================================================================================

                                                -- Validate payment method
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 17: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 13)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 340-360
**Context**: Performs logical:not exists, select operations. Uses if, end, begin, goto logic. Follows general logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: PAYMENTMETHODS
**Subdivision Info**: Part 13 of 106
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

### Chunk 18: Loop Processing & Iteration (Math:PI/System:GETDATE) (Part 14)
**Type**: loop_logic
**Complexity Score**: 9
**Lines**: 361-374
**Context**: Performs math:pi, system:getdate, logical:not exists, select operations. Uses end, for, if, begin, goto logic. Follows conditional logic
**SQL Operations**: Math:PI, System:GETDATE, Logical:NOT EXISTS, SELECT
**Control Structures**: END, FOR, IF, BEGIN, GOTO
**Tables/Views**: CUSTOMERPAYMENTMETHODS
**Subdivision Info**: Part 14 of 106
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

### Chunk 19: Data Insert/Update/Delete (SELECT/Aggregate:COUNT) (Part 15)
**Type**: data_modification
**Complexity Score**: 4
**Lines**: 375-387
**Context**: Performs select, aggregate:count, insert operations. Follows loop logic
**SQL Operations**: SELECT, Aggregate:COUNT, INSERT
**Tables/Views**: OPENJSON
**Subdivision Info**: Part 15 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 20: Loop Processing & Iteration (END/WHILE) (Part 16)
**Type**: loop_logic
**Complexity Score**: 8
**Lines**: 388-398
**Context**: Uses end, while, if, begin, goto logic. Follows data modification
**Control Structures**: END, WHILE, IF, BEGIN, GOTO
**Subdivision Info**: Part 16 of 106
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

### Chunk 21: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 17)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 399-413
**Context**: Performs logical:not exists, select operations. Uses if, begin logic. Follows loop logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, BEGIN
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 17 of 106
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

### Chunk 22: Data Query & Retrieval (SELECT/Conversion:CAST) (Part 18)
**Type**: data_retrieval
**Complexity Score**: 2
**Lines**: 414-428
**Context**: Performs select, conversion:cast operations. Uses end, goto logic. Follows conditional logic
**SQL Operations**: SELECT, Conversion:CAST
**Control Structures**: END, GOTO
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 18 of 106
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

### Chunk 23: Loop Processing & Iteration (Conversion:CAST) (Part 19)
**Type**: loop_logic
**Complexity Score**: 5
**Lines**: 429-437
**Context**: Performs conversion:cast operations. Uses end, for, if, begin, goto logic. Follows data retrieval
**SQL Operations**: Conversion:CAST
**Control Structures**: END, FOR, IF, BEGIN, GOTO
**Subdivision Info**: Part 19 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 24: Conditional Logic & Branching (Conversion:CAST/SELECT) (Part 20)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 438-446
**Context**: Performs conversion:cast, select, logical:exists operations. Uses if, end, begin logic. Follows loop logic
**SQL Operations**: Conversion:CAST, SELECT, Logical:EXISTS
**Control Structures**: IF, END, BEGIN
**Tables/Views**: PRODUCTS
**Subdivision Info**: Part 20 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                    IF @Quantity > @AvailableStock
                                                                                        BEGIN
                                                                                            -- Check if backorder is allowed
                                                                                            IF EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND AllowBackorder = 1)
                                                                                            BEGIN
                                                                                                SET @BackorderQuantity = @BackorderQuantity + (@Quantity - @AvailableStock);
                                                                                                SET @WarningMessages = @WarningMessages + 'Product ' + CAST(@ProductID AS NVARCHAR(10)) + ' partially backordered. ';
                                                                                                SET @WarningCode = 5001;
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

### Chunk 25: Loop Processing & Iteration (UPDATE/Conversion:CAST) (Part 21)
**Type**: loop_logic
**Complexity Score**: 5
**Lines**: 447-471
**Context**: Performs update, conversion:cast operations. Uses end, for, else, begin, goto logic. Follows conditional logic
**SQL Operations**: UPDATE, Conversion:CAST
**Control Structures**: END, FOR, ELSE, BEGIN, GOTO
**Subdivision Info**: Part 21 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 26: General Business Logic (Part 22)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 472-475
**Context**: Follows loop logic
**Subdivision Info**: Part 22 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                        -- =====================================================================================
                                                                                        -- INVENTORY ALLOCATION AND WAREHOUSE MANAGEMENT
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

### Chunk 27: Variable & Parameter Declarations (Math:PI/Aggregate:SUM) (Part 23)
**Type**: variable_declaration
**Complexity Score**: 18
**Lines**: 476-501
**Context**: Performs math:pi, aggregate:sum, sp_call:dbo.fn_allocateinventoryacrosswarehouses, select, exec, insert operations. Uses if, begin, while logic. Follows general logic
**SQL Operations**: Math:PI, Aggregate:SUM, SP_CALL:DBO.FN_ALLOCATEINVENTORYACROSSWAREHOUSES, SELECT, EXEC, INSERT
**Control Structures**: IF, BEGIN, WHILE
**Variables Declared**: @ALLOCATEDTOTAL
**Subdivision Info**: Part 23 of 106
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

### Chunk 28: Loop Processing & Iteration (Conversion:CAST) (Part 24)
**Type**: loop_logic
**Complexity Score**: 5
**Lines**: 502-511
**Context**: Performs conversion:cast operations. Uses if, end, begin, for logic. Follows variable declaration
**SQL Operations**: Conversion:CAST
**Control Structures**: IF, END, BEGIN, FOR
**Subdivision Info**: Part 24 of 106
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

### Chunk 29: Data Query & Retrieval (Aggregate:SUM/SELECT) (Part 25)
**Type**: data_retrieval
**Complexity Score**: 2
**Lines**: 512-519
**Context**: Performs aggregate:sum, select operations. Follows loop logic
**SQL Operations**: Aggregate:SUM, SELECT
**Subdivision Info**: Part 25 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                        -- =====================================================================================
                                                                                                        -- PROMOTION AND DISCOUNT PROCESSING
                                                                                                        -- =====================================================================================

                                                                                                        -- Calculate subtotal before promotions
                                                                                                        SELECT @SubtotalAmount = SUM(LineTotal) FROM @Cart;

                                                                                                        -- Process promotion code if provided
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 30: Conditional Logic & Branching (SELECT) (Part 26)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 520-534
**Context**: Performs select operations. Uses if, begin logic. Follows data retrieval
**SQL Operations**: SELECT
**Control Structures**: IF, BEGIN
**Tables/Views**: PROMOTIONS
**Subdivision Info**: Part 26 of 106
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

### Chunk 31: Conditional Logic & Branching (IF/END) (Part 27)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 535-546
**Context**: Uses if, end, begin, goto logic. Follows conditional logic
**Control Structures**: IF, END, BEGIN, GOTO
**Subdivision Info**: Part 27 of 106
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

### Chunk 32: Loop Processing & Iteration (SELECT/Aggregate:COUNT) (Part 28)
**Type**: loop_logic
**Complexity Score**: 2
**Lines**: 547-557
**Context**: Performs select, aggregate:count operations. Uses end, goto, for logic. Follows conditional logic
**SQL Operations**: SELECT, Aggregate:COUNT
**Control Structures**: END, GOTO, FOR
**Tables/Views**: ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 28 of 106
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

### Chunk 33: Conditional Logic & Branching (SELECT/Aggregate:COUNT) (Part 29)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 558-573
**Context**: Performs select, aggregate:count operations. Uses if, end, begin, goto logic. Follows loop logic
**SQL Operations**: SELECT, Aggregate:COUNT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: ORDERPROMOTIONS, ORDERS
**Subdivision Info**: Part 29 of 106
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

### Chunk 34: Conditional Logic & Branching (Logical:NOT EXISTS/SELECT) (Part 30)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 574-587
**Context**: Performs logical:not exists, select operations. Uses if, end, begin, goto logic. Follows conditional logic
**SQL Operations**: Logical:NOT EXISTS, SELECT
**Control Structures**: IF, END, BEGIN, GOTO
**Tables/Views**: PROMOTIONS
**Subdivision Info**: Part 30 of 106
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

### Chunk 35: Variable & Parameter Declarations (INSERT) (Part 31)
**Type**: variable_declaration
**Complexity Score**: 7
**Lines**: 588-599
**Context**: Performs insert operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: INSERT
**Control Structures**: IF, END, BEGIN
**Variables Declared**: @TIERDISCOUNTPERCENTAGE
**Subdivision Info**: Part 31 of 106
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

### Chunk 36: Variable & Parameter Declarations (SELECT/INSERT) (Part 32)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 600-614
**Context**: Performs select, insert operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: SELECT, INSERT
**Control Structures**: IF, END, BEGIN
**Variables Declared**: @TIERDISCOUNT
**Tables/Views**: CUSTOMERTIERS
**Subdivision Info**: Part 32 of 106
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

### Chunk 37: Variable & Parameter Declarations (Conversion:ISNULL/SELECT) (Part 33)
**Type**: variable_declaration
**Complexity Score**: 11
**Lines**: 615-624
**Context**: Performs conversion:isnull, select, math:floor operations. Uses if, begin logic. Follows variable declaration
**SQL Operations**: Conversion:ISNULL, SELECT, Math:FLOOR
**Control Structures**: IF, BEGIN
**Variables Declared**: @MAXPOINTSREDEMPTION
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 33 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 38: Variable & Parameter Declarations (CASE/ELSE) (Part 34)
**Type**: variable_declaration
**Complexity Score**: 2
**Lines**: 625-630
**Context**: Uses case, else, end, when logic. Follows variable declaration
**Control Structures**: CASE, ELSE, END, WHEN
**Variables Declared**: @POINTSTOREDEEM
**Subdivision Info**: Part 34 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                            DECLARE @PointsToRedeem INT = CASE
                                                                                                                                                            WHEN @LoyaltyPoints > @MaxPointsRedemption * 100
                                                                                                                                                            THEN @MaxPointsRedemption * 100
                                                                                                                                                        ELSE (@LoyaltyPoints / 100) * 100
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

### Chunk 39: Variable & Parameter Declarations (UPDATE/INSERT) (Part 35)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 631-646
**Context**: Performs update, insert operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: UPDATE, INSERT
**Control Structures**: IF, END, BEGIN
**Variables Declared**: @POINTSDISCOUNT
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 35 of 106
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

### Chunk 40: General Business Logic (Part 36)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 647-652
**Context**: Follows variable declaration
**Subdivision Info**: Part 36 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                    -- =====================================================================================
                                                                                                                                                    -- TAX CALCULATION WITH COMPLEX RULES
                                                                                                                                                    -- =====================================================================================

                                                                                                                                                    -- Calculate tax for each product using complex tax function
                                                                                                                                                    SET @CurrentItem = 1;
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 41: Variable & Parameter Declarations (Math:PI/UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX) (Part 37)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 653-674
**Context**: Performs math:pi, udf_call:dbo.fn_calculatecomplextax, select operations. Uses begin, while logic. Follows general logic
**SQL Operations**: Math:PI, UDF_CALL:DBO.FN_CALCULATECOMPLEXTAX, SELECT
**Control Structures**: BEGIN, WHILE
**Variables Declared**: @LINETAXAMOUNT, @PRODUCTTAXRATE
**Subdivision Info**: Part 37 of 106
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

### Chunk 42: Conditional Logic & Branching (UPDATE/Math:PI) (Part 38)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 675-693
**Context**: Performs update, math:pi, insert operations. Uses if, end logic. Follows variable declaration
**SQL Operations**: UPDATE, Math:PI, INSERT
**Control Structures**: IF, END
**Subdivision Info**: Part 38 of 106
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

### Chunk 43: Data Query & Retrieval (Math:PI/UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING) (Part 39)
**Type**: data_retrieval
**Complexity Score**: 7
**Lines**: 694-709
**Context**: Performs math:pi, udf_call:dbo.fn_calculatedynamicshipping, select operations. Follows conditional logic
**SQL Operations**: Math:PI, UDF_CALL:DBO.FN_CALCULATEDYNAMICSHIPPING, SELECT
**Subdivision Info**: Part 39 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 44: General Business Logic (Part 40)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 710-713
**Context**: Follows data retrieval
**Subdivision Info**: Part 40 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                            -- =====================================================================================
                                                                                                                                                            -- PAYMENT PROCESSING AND FEES
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

### Chunk 45: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 41)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 714-726
**Context**: Performs math:pi, system:getdate, string:format, conversion:cast operations. Uses if, end, begin logic. Follows general logic
**SQL Operations**: Math:PI, System:GETDATE, String:FORMAT, Conversion:CAST
**Control Structures**: IF, END, BEGIN
**Subdivision Info**: Part 41 of 106
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

### Chunk 46: General Business Logic (Math:PI) (Part 42)
**Type**: general_logic
**Complexity Score**: 1
**Lines**: 727-734
**Context**: Performs math:pi operations. Follows conditional logic
**SQL Operations**: Math:PI
**Subdivision Info**: Part 42 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                    -- =====================================================================================
                                                                                                                                                                    -- FINAL AMOUNT CALCULATION
                                                                                                                                                                    -- =====================================================================================

                                                                                                                                                                    SET @FinalAmount = @SubtotalAmount - @DiscountAmount + @TaxAmount + @ShippingCost + @ProcessingFee;
                                                                                                                                                                    SET @TotalAmount = @FinalAmount;

                                                                                                                                                                    -- Validate final amount is positive
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 47: Conditional Logic & Branching (IF/END) (Part 43)
**Type**: conditional_logic
**Complexity Score**: 4
**Lines**: 735-744
**Context**: Uses if, end, begin, goto logic. Follows general logic
**Control Structures**: IF, END, BEGIN, GOTO
**Subdivision Info**: Part 43 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                    IF @FinalAmount <= 0
                                                                                                                                                                        BEGIN
                                                                                                                                                                            SET @IsValid = 0;
                                                                                                                                                                            SET @ErrorMessage = 'Final order amount cannot be zero or negative.';
                                                                                                                                                                            SET @ErrorCode = 7001;
                                                                                                                                                                            GOTO ErrorHandler;
                                                                                                                                                                        END;

                                                                                                                                                                        -- =====================================================================================
                                                                                                                                                                        -- ORDER CREATION AND PERSISTENCE
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 48: Data Insert/Update/Delete (Math:PI/SELECT) (Part 44)
**Type**: data_modification
**Complexity Score**: 11
**Lines**: 745-809
**Context**: Performs math:pi, select, system:scope_identity, system:getdate, insert operations. Follows conditional logic
**SQL Operations**: Math:PI, SELECT, System:SCOPE_IDENTITY, System:GETDATE, INSERT
**Tables/Views**: ORDERITEMS, ORDERS
**Subdivision Info**: Part 44 of 106
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

### Chunk 49: Conditional Logic & Branching (Conversion:ISNULL/SELECT) (Part 45)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 810-819
**Context**: Performs conversion:isnull, select, insert operations. Uses if logic. Follows data modification
**SQL Operations**: Conversion:ISNULL, SELECT, INSERT
**Control Structures**: IF
**Tables/Views**: ORDERPROMOTIONS
**Subdivision Info**: Part 45 of 106
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

### Chunk 50: General Business Logic (Part 46)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 820-823
**Context**: Follows conditional logic
**Subdivision Info**: Part 46 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                            -- =====================================================================================
                                                                                                                                                                            -- INVENTORY UPDATES AND RESERVATIONS
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

### Chunk 51: Conditional Logic & Branching (UPDATE/System:GETDATE) (Part 47)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 824-838
**Context**: Performs update, system:getdate, select, insert operations. Uses if, end, begin logic. Follows general logic
**SQL Operations**: UPDATE, System:GETDATE, SELECT, INSERT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: PRODUCTS, P, INVENTORYRESERVATIONS
**Subdivision Info**: Part 47 of 106
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

### Chunk 52: General Business Logic (Part 48)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 839-842
**Context**: Follows conditional logic
**Subdivision Info**: Part 48 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                -- =====================================================================================
                                                                                                                                                                                -- PAYMENT PROCESSING
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

### Chunk 53: Conditional Logic & Branching (System:GETDATE/INSERT) (Part 49)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 843-867
**Context**: Performs system:getdate, insert operations. Uses if, begin logic. Follows general logic
**SQL Operations**: System:GETDATE, INSERT
**Control Structures**: IF, BEGIN
**Tables/Views**: PAYMENTS
**Subdivision Info**: Part 49 of 106
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

### Chunk 54: Conditional Logic & Branching (UPDATE) (Part 50)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 868-877
**Context**: Performs update operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: UPDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERS
**Subdivision Info**: Part 50 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                        IF @PaymentTypeID = 5 -- Store Credit
                                                                                                                                                                                            BEGIN
                                                                                                                                                                                                UPDATE Customers
                                                                                                                                                                                                SET CurrentBalance = CurrentBalance + @FinalAmount
                                                                                                                                                                                                WHERE CustomerID = @CustomerID;
                                                                                                                                                                                            END;
                                                                                                                                                                                        END;

                                                                                                                                                                                        -- =====================================================================================
                                                                                                                                                                                        -- LOYALTY POINTS CALCULATION
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 55: Transaction Control (System:GETDATE/UPDATE) (Part 51)
**Type**: transaction_control
**Complexity Score**: 10
**Lines**: 878-902
**Context**: Performs system:getdate, update, select, math:floor, conversion:isnull, insert operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: System:GETDATE, UPDATE, SELECT, Math:FLOOR, Conversion:ISNULL, INSERT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERTIERS, CUSTOMERS, LOYALTYTRANSACTIONS
**Subdivision Info**: Part 51 of 106
**Parent Block**: variable_declaration (lines 179-1683)

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

### Chunk 56: Variable & Parameter Declarations (SELECT) (Part 52)
**Type**: variable_declaration
**Complexity Score**: 1
**Lines**: 903-921
**Context**: Performs select operations. Follows transaction control
**SQL Operations**: SELECT
**Variables Declared**: @NEWCUSTOMERTIERID
**Tables/Views**: CUSTOMERTIERS
**Subdivision Info**: Part 52 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 57: Conditional Logic & Branching (Math:LOG/UPDATE) (Part 53)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 922-938
**Context**: Performs math:log, update, conversion:cast, system:getdate, insert operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: Math:LOG, UPDATE, Conversion:CAST, System:GETDATE, INSERT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERS, TIER, CUSTOMERLOG
**Subdivision Info**: Part 53 of 106
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

### Chunk 58: General Business Logic (Part 54)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 939-942
**Context**: Follows conditional logic
**Subdivision Info**: Part 54 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                -- =====================================================================================
                                                                                                                                                                                                -- RECOMMENDATIONS AND ANALYTICS
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

### Chunk 59: Conditional Logic & Branching (Aggregate:COUNT/SELECT) (Part 55)
**Type**: conditional_logic
**Complexity Score**: 14
**Lines**: 943-968
**Context**: Performs aggregate:count, select, date:dateadd, system:getdate, insert operations. Uses if, end, begin logic. Follows general logic
**SQL Operations**: Aggregate:COUNT, SELECT, Date:DATEADD, System:GETDATE, INSERT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: ORDERITEMS, PRODUCTS, CUSTOMERRECOMMENDATIONS, ORDERS
**Subdivision Info**: Part 55 of 106
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

### Chunk 60: Transaction Control (Math:LOG/Date:DATEDIFF) (Part 56)
**Type**: transaction_control
**Complexity Score**: 13
**Lines**: 969-1020
**Context**: Performs math:log, date:datediff, conversion:cast, system:scope_identity, system:getdate, insert operations. Follows conditional logic
**SQL Operations**: Math:LOG, Date:DATEDIFF, Conversion:CAST, System:SCOPE_IDENTITY, System:GETDATE, INSERT
**Tables/Views**: AUDITLOG, TRANSACTIONLOG
**Subdivision Info**: Part 56 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 61: General Business Logic (Part 57)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1021-1024
**Context**: Follows transaction control
**Subdivision Info**: Part 57 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                    -- =====================================================================================
                                                                                                                                                                                                    -- NOTIFICATION PROCESSING
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

### Chunk 62: Conditional Logic & Branching (Conversion:CAST/INSERT) (Part 58)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 1025-1040
**Context**: Performs conversion:cast, insert operations. Uses if, begin logic. Follows general logic
**SQL Operations**: Conversion:CAST, INSERT
**Control Structures**: IF, BEGIN
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 58 of 106
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

### Chunk 63: Loop Processing & Iteration (System:GETDATE/Conversion:CAST) (Part 59)
**Type**: loop_logic
**Complexity Score**: 12
**Lines**: 1041-1070
**Context**: Performs system:getdate, conversion:cast, insert operations. Uses if, end, begin, for logic. Follows conditional logic
**SQL Operations**: System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: IF, END, BEGIN, FOR
**Tables/Views**: NOTIFICATIONQUEUE
**Subdivision Info**: Part 59 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 64: General Business Logic (Part 60)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1071-1074
**Context**: Follows loop logic
**Subdivision Info**: Part 60 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                -- =====================================================================================
                                                                                                                                                                                                                -- EXPANDED REPORTING AND ANALYTICS UPDATES (4X LARGER)
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

### Chunk 65: Conditional Logic & Branching (IF/BEGIN) (Part 61)
**Type**: conditional_logic
**Complexity Score**: 4
**Lines**: 1075-1078
**Context**: Uses if, begin logic. Follows general logic
**Control Structures**: IF, BEGIN
**Subdivision Info**: Part 61 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                IF @ProcessReports = 1
                                                                                                                                                                                                                    BEGIN
                                                                                                                                                                                                                        -- =====================================================================================
                                                                                                                                                                                                                        -- SECTION 1: BASIC SALES AND CUSTOMER ANALYTICS
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 66: Conditional Logic & Branching (Math:PI/UPDATE) (Part 62)
**Type**: conditional_logic
**Complexity Score**: 13
**Lines**: 1079-1094
**Context**: Performs math:pi, update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: Math:PI, UPDATE, SELECT, Conversion:CAST, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: DAILYSALESSUMMARY
**Subdivision Info**: Part 62 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 67: Variable & Parameter Declarations (Math:PI/Date:DATEPART) (Part 63)
**Type**: variable_declaration
**Complexity Score**: 8
**Lines**: 1095-1108
**Context**: Performs math:pi, date:datepart, conversion:cast, system:getdate, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: Math:PI, Date:DATEPART, Conversion:CAST, System:GETDATE, INSERT
**Control Structures**: ELSE, END, BEGIN
**Variables Declared**: @CURRENTHOUR
**Tables/Views**: DAILYSALESSUMMARY
**Subdivision Info**: Part 63 of 106
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

### Chunk 68: Conditional Logic & Branching (UPDATE/SELECT) (Part 64)
**Type**: conditional_logic
**Complexity Score**: 12
**Lines**: 1109-1118
**Context**: Performs update, select, conversion:cast, logical:exists, system:getdate operations. Uses case, end, if, else, begin, when logic. Follows variable declaration
**SQL Operations**: UPDATE, SELECT, Conversion:CAST, Logical:EXISTS, System:GETDATE
**Control Structures**: CASE, END, IF, ELSE, BEGIN, WHEN
**Tables/Views**: HOURLYSALESSUMMARY
**Subdivision Info**: Part 64 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 69: Conditional Logic & Branching (UPDATE/System:GETDATE) (Part 65)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 1119-1141
**Context**: Performs update, system:getdate, conversion:cast, insert operations. Uses case, end, else, begin, when logic. Follows conditional logic
**SQL Operations**: UPDATE, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: CASE, END, ELSE, BEGIN, WHEN
**Tables/Views**: CUSTOMERANALYTICS, HOURLYSALESSUMMARY
**Subdivision Info**: Part 65 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 70: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 66)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1142-1153
**Context**: Performs system:getdate, system:@@rowcount, insert operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: System:GETDATE, System:@@ROWCOUNT, INSERT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CUSTOMERANALYTICS
**Subdivision Info**: Part 66 of 106
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

### Chunk 71: Variable & Parameter Declarations (Part 67)
**Type**: variable_declaration
**Complexity Score**: 0
**Lines**: 1154-1161
**Context**: Follows conditional logic
**Variables Declared**: @CURRPRODUCTID, @PRODUCTANALYTICSCURSOR
**Subdivision Info**: Part 67 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                            -- =====================================================================================
                                                                                                                                                                                                                            -- SECTION 2: DETAILED PRODUCT AND CATEGORY ANALYTICS
                                                                                                                                                                                                                            -- =====================================================================================

                                                                                                                                                                                                                            -- Update product performance metrics for each item in cart
                                                                                                                                                                                                                            DECLARE @ProductAnalyticsCursor CURSOR;
                                                                                                                                                                                                                            DECLARE @CurrProductID INT, @CurrQuantity INT, @CurrLineTotal DECIMAL(18,2);

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 72: Loop Processing & Iteration (SELECT) (Part 68)
**Type**: loop_logic
**Complexity Score**: 9
**Lines**: 1162-1170
**Context**: Performs select operations. Uses begin, while, for logic. Follows variable declaration
**SQL Operations**: SELECT
**Control Structures**: BEGIN, WHILE, FOR
**Subdivision Info**: Part 68 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 73: Conditional Logic & Branching (UPDATE/Logical:EXISTS) (Part 69)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1171-1179
**Context**: Performs update, logical:exists, select, conversion:cast operations. Uses if, begin logic. Follows loop logic
**SQL Operations**: UPDATE, Logical:EXISTS, SELECT, Conversion:CAST
**Control Structures**: IF, BEGIN
**Tables/Views**: PRODUCTSALESSTATS
**Subdivision Info**: Part 69 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                                        IF EXISTS (SELECT 1 FROM ProductSalesStats WHERE ProductID = @CurrProductID AND SalesDate = CAST(@OrderDate AS DATE))
                                                                                                                                                                                                                                        BEGIN
                                                                                                                                                                                                                                            UPDATE ProductSalesStats
                                                                                                                                                                                                                                            SET
                                                                                                                                                                                                                                            UnitsSold = UnitsSold + @CurrQuantity,
                                                                                                                                                                                                                                            TotalRevenue = TotalRevenue + @CurrLineTotal,
                                                                                                                                                                                                                                            OrderCount = OrderCount + 1,
                                                                                                                                                                                                                                            AverageSellingPrice = TotalRevenue / UnitsSold,
                                                                                                                                                                                                                                            LastSoldDate = @OrderDate,
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 74: Conditional Logic & Branching (System:GETDATE/Date:DATEDIFF) (Part 70)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 1180-1187
**Context**: Performs system:getdate, date:datediff, conversion:cast operations. Uses case, else, end, when logic. Follows conditional logic
**SQL Operations**: System:GETDATE, Date:DATEDIFF, Conversion:CAST
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 70 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                                            Velocity = CASE
                                                                                                                                                                                                                                            WHEN DATEDIFF(DAY, FirstSoldDate, @OrderDate) > 0
                                                                                                                                                                                                                                            THEN UnitsSold / DATEDIFF(DAY, FirstSoldDate, @OrderDate)
                                                                                                                                                                                                                                        ELSE UnitsSold
                                                                                                                                                                                                                                        END,
                                                                                                                                                                                                                                        LastUpdated = GETDATE()
                                                                                                                                                                                                                                        WHERE ProductID = @CurrProductID AND SalesDate = CAST(@OrderDate AS DATE);
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

### Chunk 75: Variable & Parameter Declarations (SELECT/System:GETDATE) (Part 71)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 1188-1203
**Context**: Performs select, system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: SELECT, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, END, BEGIN
**Variables Declared**: @CATEGORYID
**Tables/Views**: PRODUCTSALESSTATS, PRODUCTS
**Subdivision Info**: Part 71 of 106
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

### Chunk 76: Conditional Logic & Branching (Aggregate:SUM/UPDATE) (Part 72)
**Type**: conditional_logic
**Complexity Score**: 13
**Lines**: 1204-1215
**Context**: Performs aggregate:sum, update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: Aggregate:SUM, UPDATE, SELECT, Conversion:CAST, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: CATEGORYSALESSTATS
**Subdivision Info**: Part 72 of 106
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

### Chunk 77: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 73)
**Type**: data_modification
**Complexity Score**: 6
**Lines**: 1216-1231
**Context**: Performs update, system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: UPDATE, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, END, BEGIN
**Tables/Views**: CATEGORYSALESSTATS, PRODUCTRECOMMENDATIONSCORES
**Subdivision Info**: Part 73 of 106
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

### Chunk 78: Conditional Logic & Branching (System:GETDATE/Date:DATEDIFF) (Part 74)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 1232-1240
**Context**: Performs system:getdate, date:datediff operations. Uses case, else, end, when logic. Follows data modification
**SQL Operations**: System:GETDATE, Date:DATEDIFF
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 74 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                                    RecentSalesWeight = CASE
                                                                                                                                                                                                                                    WHEN DATEDIFF(DAY, LastUpdated, GETDATE()) <= 7 THEN PopularityScore * 1.5
                                                                                                                                                                                                                                    WHEN DATEDIFF(DAY, LastUpdated, GETDATE()) <= 30 THEN PopularityScore * 1.2
                                                                                                                                                                                                                                ELSE PopularityScore
                                                                                                                                                                                                                                END,
                                                                                                                                                                                                                                CrossSellScore = CrossSellScore + 1,
                                                                                                                                                                                                                                LastUpdated = GETDATE()
                                                                                                                                                                                                                                WHERE ProductID = @CurrProductID;

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 79: Conditional Logic & Branching (System:GETDATE/System:@@ROWCOUNT) (Part 75)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1241-1254
**Context**: Performs system:getdate, system:@@rowcount, insert operations. Uses if, end, begin logic. Follows conditional logic
**SQL Operations**: System:GETDATE, System:@@ROWCOUNT, INSERT
**Control Structures**: IF, END, BEGIN
**Tables/Views**: PRODUCTRECOMMENDATIONSCORES
**Subdivision Info**: Part 75 of 106
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

### Chunk 80: Variable & Parameter Declarations (Part 76)
**Type**: variable_declaration
**Complexity Score**: 0
**Lines**: 1255-1265
**Context**: Follows conditional logic
**Variables Declared**: @FREQUENCYSCORE, @MONETARYSCORE, @RECENCYSCORE, @SEGMENTSCORE
**Subdivision Info**: Part 76 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                                -- =====================================================================================
                                                                                                                                                                                                                                -- SECTION 3: CUSTOMER SEGMENTATION AND BEHAVIOR ANALYSIS
                                                                                                                                                                                                                                -- =====================================================================================

                                                                                                                                                                                                                                -- Update customer segmentation scores
                                                                                                                                                                                                                                DECLARE @SegmentScore INT = 0;
                                                                                                                                                                                                                                DECLARE @FrequencyScore INT = 0;
                                                                                                                                                                                                                                DECLARE @MonetaryScore INT = 0;
                                                                                                                                                                                                                                DECLARE @RecencyScore INT = 0;

                                                                                                                                                                                                                                -- Calculate Recency score (days since last order)
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 81: Conditional Logic & Branching (Date:DATEDIFF) (Part 77)
**Type**: conditional_logic
**Complexity Score**: 6
**Lines**: 1266-1274
**Context**: Performs date:datediff operations. Uses case, else, end, when logic. Follows variable declaration
**SQL Operations**: Date:DATEDIFF
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 77 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                                SET @RecencyScore = CASE
                                                                                                                                                                                                                                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 30 THEN 5
                                                                                                                                                                                                                                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 90 THEN 4
                                                                                                                                                                                                                                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 180 THEN 3
                                                                                                                                                                                                                                WHEN DATEDIFF(DAY, @CustomerLastOrderDate, @OrderDate) <= 365 THEN 2
                                                                                                                                                                                                                            ELSE 1
                                                                                                                                                                                                                            END;

                                                                                                                                                                                                                            -- Calculate Frequency score (number of orders)
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 82: Conditional Logic & Branching (CASE/ELSE) (Part 78)
**Type**: conditional_logic
**Complexity Score**: 2
**Lines**: 1275-1283
**Context**: Uses case, else, end, when logic. Follows conditional logic
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 78 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                            SET @FrequencyScore = CASE
                                                                                                                                                                                                                            WHEN @CustomerOrderCount >= 50 THEN 5
                                                                                                                                                                                                                            WHEN @CustomerOrderCount >= 20 THEN 4
                                                                                                                                                                                                                            WHEN @CustomerOrderCount >= 10 THEN 3
                                                                                                                                                                                                                            WHEN @CustomerOrderCount >= 5 THEN 2
                                                                                                                                                                                                                        ELSE 1
                                                                                                                                                                                                                        END;

                                                                                                                                                                                                                        -- Calculate Monetary score (lifetime value)
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 83: Conditional Logic & Branching (CASE/ELSE) (Part 79)
**Type**: conditional_logic
**Complexity Score**: 2
**Lines**: 1284-1294
**Context**: Uses case, else, end, when logic. Follows conditional logic
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 79 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                        SET @MonetaryScore = CASE
                                                                                                                                                                                                                        WHEN @CustomerLifetimeValue >= 10000 THEN 5
                                                                                                                                                                                                                        WHEN @CustomerLifetimeValue >= 5000 THEN 4
                                                                                                                                                                                                                        WHEN @CustomerLifetimeValue >= 2000 THEN 3
                                                                                                                                                                                                                        WHEN @CustomerLifetimeValue >= 500 THEN 2
                                                                                                                                                                                                                    ELSE 1
                                                                                                                                                                                                                    END;

                                                                                                                                                                                                                    SET @SegmentScore = (@RecencyScore * 100) + (@FrequencyScore * 10) + @MonetaryScore;

                                                                                                                                                                                                                    -- Update customer RFM analysis
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 84: Conditional Logic & Branching (UPDATE/SELECT) (Part 80)
**Type**: conditional_logic
**Complexity Score**: 7
**Lines**: 1295-1302
**Context**: Performs update, select, logical:exists operations. Uses if, begin logic. Follows conditional logic
**SQL Operations**: UPDATE, SELECT, Logical:EXISTS
**Control Structures**: IF, BEGIN
**Tables/Views**: CUSTOMERRFMANALYSIS
**Subdivision Info**: Part 80 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                                    IF EXISTS (SELECT 1 FROM CustomerRFMAnalysis WHERE CustomerID = @CustomerID)
                                                                                                                                                                                                                    BEGIN
                                                                                                                                                                                                                        UPDATE CustomerRFMAnalysis
                                                                                                                                                                                                                        SET
                                                                                                                                                                                                                        RecencyScore = @RecencyScore,
                                                                                                                                                                                                                        FrequencyScore = @FrequencyScore,
                                                                                                                                                                                                                        MonetaryScore = @MonetaryScore,
                                                                                                                                                                                                                        RFMScore = @SegmentScore,
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 85: Conditional Logic & Branching (Math:PI) (Part 81)
**Type**: conditional_logic
**Complexity Score**: 3
**Lines**: 1303-1312
**Context**: Performs math:pi operations. Uses case, when logic. Follows conditional logic
**SQL Operations**: Math:PI
**Control Structures**: CASE, WHEN
**Subdivision Info**: Part 81 of 106
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

### Chunk 86: Data Insert/Update/Delete (System:GETDATE/Date:DATEADD) (Part 82)
**Type**: data_modification
**Complexity Score**: 5
**Lines**: 1313-1327
**Context**: Performs system:getdate, date:dateadd, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: System:GETDATE, Date:DATEADD, INSERT
**Control Structures**: ELSE, END, BEGIN
**Tables/Views**: CUSTOMERRFMANALYSIS
**Subdivision Info**: Part 82 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 87: Conditional Logic & Branching (Math:PI) (Part 83)
**Type**: conditional_logic
**Complexity Score**: 3
**Lines**: 1328-1337
**Context**: Performs math:pi operations. Uses case, when logic. Follows data modification
**SQL Operations**: Math:PI
**Control Structures**: CASE, WHEN
**Subdivision Info**: Part 83 of 106
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

### Chunk 88: Variable & Parameter Declarations (Math:PI/System:GETDATE) (Part 84)
**Type**: variable_declaration
**Complexity Score**: 3
**Lines**: 1338-1348
**Context**: Performs math:pi, system:getdate, date:dateadd operations. Uses else, end logic. Follows conditional logic
**SQL Operations**: Math:PI, System:GETDATE, Date:DATEADD
**Control Structures**: ELSE, END
**Variables Declared**: @SHOPPINGTIMEPREFERENCE, @PURCHASEPATTERN, @SEASONALTREND
**Subdivision Info**: Part 84 of 106
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

### Chunk 89: Conditional Logic & Branching (Math:PI) (Part 85)
**Type**: conditional_logic
**Complexity Score**: 3
**Lines**: 1349-1355
**Context**: Performs math:pi operations. Uses case, else, end, when logic. Follows variable declaration
**SQL Operations**: Math:PI
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 85 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                            SET @ShoppingTimePreference = CASE
                                                                                                                                                                                                            WHEN @CurrentHour BETWEEN 6 AND 12 THEN 'Morning Shopper'
                                                                                                                                                                                                            WHEN @CurrentHour BETWEEN 12 AND 17 THEN 'Afternoon Shopper'
                                                                                                                                                                                                            WHEN @CurrentHour BETWEEN 17 AND 22 THEN 'Evening Shopper'
                                                                                                                                                                                                        ELSE 'Night Owl'
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

### Chunk 90: Conditional Logic & Branching (Date:MONTH) (Part 86)
**Type**: conditional_logic
**Complexity Score**: 5
**Lines**: 1356-1362
**Context**: Performs date:month operations. Uses case, else, end, when logic. Follows conditional logic
**SQL Operations**: Date:MONTH
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 86 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                        SET @SeasonalTrend = CASE
                                                                                                                                                                                                        WHEN MONTH(@OrderDate) IN (12, 1, 2) THEN 'Winter'
                                                                                                                                                                                                        WHEN MONTH(@OrderDate) IN (3, 4, 5) THEN 'Spring'
                                                                                                                                                                                                        WHEN MONTH(@OrderDate) IN (6, 7, 8) THEN 'Summer'
                                                                                                                                                                                                    ELSE 'Fall'
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

### Chunk 91: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 87)
**Type**: conditional_logic
**Complexity Score**: 11
**Lines**: 1363-1382
**Context**: Performs math:pi, system:getdate, select, insert operations. Uses case, else, end, when logic. Follows conditional logic
**SQL Operations**: Math:PI, System:GETDATE, SELECT, INSERT
**Control Structures**: CASE, ELSE, END, WHEN
**Tables/Views**: PAYMENTTYPES, SHIPPINGMETHODS, CUSTOMERBEHAVIORTRACKING
**Subdivision Info**: Part 87 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

### Chunk 92: Variable & Parameter Declarations (Part 88)
**Type**: variable_declaration
**Complexity Score**: 0
**Lines**: 1383-1390
**Context**: Follows conditional logic
**Variables Declared**: @INVENTORYANALYTICSCURSOR, @CURRWAREHOUSEID
**Subdivision Info**: Part 88 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                -- =====================================================================================
                                                                                                                                                                                                -- SECTION 4: ADVANCED INVENTORY AND SUPPLY CHAIN ANALYTICS
                                                                                                                                                                                                -- =====================================================================================

                                                                                                                                                                                                -- Update inventory turnover analytics
                                                                                                                                                                                                DECLARE @InventoryAnalyticsCursor CURSOR;
                                                                                                                                                                                                DECLARE @CurrWarehouseID INT, @CurrAllocatedQty INT;

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 93: Loop Processing & Iteration (Aggregate:SUM/SELECT) (Part 89)
**Type**: loop_logic
**Complexity Score**: 10
**Lines**: 1391-1401
**Context**: Performs aggregate:sum, select operations. Uses begin, while, for logic. Follows variable declaration
**SQL Operations**: Aggregate:SUM, SELECT
**Control Structures**: BEGIN, WHILE, FOR
**Subdivision Info**: Part 89 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                SET @InventoryAnalyticsCursor = CURSOR FOR
                                                                                                                                                                                                    SELECT DISTINCT WarehouseID, SUM(AllocatedQuantity)
                                                                                                                                                                                                    FROM @InventoryAllocations
                                                                                                                                                                                                    GROUP BY WarehouseID;

                                                                                                                                                                                                    OPEN @InventoryAnalyticsCursor;
                                                                                                                                                                                                    FETCH NEXT FROM @InventoryAnalyticsCursor INTO @CurrWarehouseID, @CurrAllocatedQty;

                                                                                                                                                                                                    WHILE @@FETCH_STATUS = 0
                                                                                                                                                                                                        BEGIN
                                                                                                                                                                                                            -- Update warehouse performance metrics
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 94: Conditional Logic & Branching (UPDATE/SELECT) (Part 90)
**Type**: conditional_logic
**Complexity Score**: 10
**Lines**: 1402-1412
**Context**: Performs update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows loop logic
**SQL Operations**: UPDATE, SELECT, Conversion:CAST, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: WAREHOUSEPERFORMANCEMETRICS
**Subdivision Info**: Part 90 of 106
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

### Chunk 95: Data Insert/Update/Delete (UPDATE/System:GETDATE) (Part 91)
**Type**: data_modification
**Complexity Score**: 6
**Lines**: 1413-1431
**Context**: Performs update, system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: UPDATE, System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, END, BEGIN
**Tables/Views**: WAREHOUSEPERFORMANCEMETRICS, INVENTORYVELOCITYMETRICS
**Subdivision Info**: Part 91 of 106
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

### Chunk 96: Conditional Logic & Branching (System:GETDATE/Date:DATEDIFF) (Part 92)
**Type**: conditional_logic
**Complexity Score**: 8
**Lines**: 1432-1464
**Context**: Performs system:getdate, date:datediff, select, insert operations. Uses case, else, end, when logic. Follows data modification
**SQL Operations**: System:GETDATE, Date:DATEDIFF, SELECT, INSERT
**Control Structures**: CASE, ELSE, END, WHEN
**Tables/Views**: SUPPLYCHAINEVENTS
**Subdivision Info**: Part 92 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 97: General Business Logic (Part 93)
**Type**: general_logic
**Complexity Score**: 0
**Lines**: 1465-1469
**Context**: Follows conditional logic
**Subdivision Info**: Part 93 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                    -- =====================================================================================
                                                                                                                                                                                                    -- SECTION 5: MARKETING AND PROMOTION EFFECTIVENESS TRACKING
                                                                                                                                                                                                    -- =====================================================================================

                                                                                                                                                                                                    -- Track promotion usage and effectiveness
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 98: Variable & Parameter Declarations (SELECT/Logical:EXISTS) (Part 94)
**Type**: variable_declaration
**Complexity Score**: 10
**Lines**: 1470-1480
**Context**: Performs select, logical:exists operations. Uses if, begin, for logic. Follows general logic
**SQL Operations**: SELECT, Logical:EXISTS
**Control Structures**: IF, BEGIN, FOR
**Variables Declared**: @PROMOEFFECTIVENESSCURSOR, @CURRPROMOID
**Subdivision Info**: Part 94 of 106
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

### Chunk 99: Loop Processing & Iteration (UPDATE/SELECT) (Part 95)
**Type**: loop_logic
**Complexity Score**: 15
**Lines**: 1481-1497
**Context**: Performs update, select, conversion:cast, logical:exists, system:getdate operations. Uses if, end, begin, while logic. Follows variable declaration
**SQL Operations**: UPDATE, SELECT, Conversion:CAST, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, END, BEGIN, WHILE
**Tables/Views**: PROMOTIONEFFECTIVENESSMETRICS
**Subdivision Info**: Part 95 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 100: Data Insert/Update/Delete (System:GETDATE/Conversion:CAST) (Part 96)
**Type**: data_modification
**Complexity Score**: 5
**Lines**: 1498-1513
**Context**: Performs system:getdate, conversion:cast, insert operations. Uses else, end, begin logic. Follows loop logic
**SQL Operations**: System:GETDATE, Conversion:CAST, INSERT
**Control Structures**: ELSE, END, BEGIN
**Tables/Views**: PROMOTIONEFFECTIVENESSMETRICS
**Subdivision Info**: Part 96 of 106
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

### Chunk 101: Conditional Logic & Branching (UPDATE/SELECT) (Part 97)
**Type**: conditional_logic
**Complexity Score**: 9
**Lines**: 1514-1523
**Context**: Performs update, select, logical:exists operations. Uses case, if, begin, when logic. Follows data modification
**SQL Operations**: UPDATE, SELECT, Logical:EXISTS
**Control Structures**: CASE, IF, BEGIN, WHEN
**Tables/Views**: CUSTOMERPROMOTIONAFFINITY
**Subdivision Info**: Part 97 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 102: Cursor Operations & Row Processing (System:GETDATE/INSERT) (Part 98)
**Type**: cursor_operation
**Complexity Score**: 5
**Lines**: 1524-1547
**Context**: Performs system:getdate, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: System:GETDATE, INSERT
**Control Structures**: ELSE, END, BEGIN
**Tables/Views**: CUSTOMERPROMOTIONAFFINITY
**Subdivision Info**: Part 98 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 103: Variable & Parameter Declarations (Part 99)
**Type**: variable_declaration
**Complexity Score**: 0
**Lines**: 1548-1557
**Context**: Follows cursor operation
**Variables Declared**: @RECOGNIZEDREVENUE, @DEFERREDREVENUE, @REVENUERECOGNITIONDATE
**Subdivision Info**: Part 99 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                        -- =====================================================================================
                                                                                                                                                                                                        -- SECTION 6: FINANCIAL AND REVENUE ANALYTICS
                                                                                                                                                                                                        -- =====================================================================================

                                                                                                                                                                                                        -- Update revenue recognition and financial tracking
                                                                                                                                                                                                        DECLARE @RevenueRecognitionDate DATE = @OrderDate;
                                                                                                                                                                                                        DECLARE @DeferredRevenue DECIMAL(18,2) = 0;
                                                                                                                                                                                                        DECLARE @RecognizedRevenue DECIMAL(18,2) = @FinalAmount;

                                                                                                                                                                                                        -- Check for digital vs physical products for revenue recognition
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 104: Conditional Logic & Branching (Math:PI/Aggregate:SUM) (Part 100)
**Type**: conditional_logic
**Complexity Score**: 21
**Lines**: 1558-1582
**Context**: Performs math:pi, aggregate:sum, update, conversion:cast, select, logical:exists, system:getdate operations. Uses if, end, begin logic. Follows variable declaration
**SQL Operations**: Math:PI, Aggregate:SUM, UPDATE, Conversion:CAST, SELECT, Logical:EXISTS, System:GETDATE
**Control Structures**: IF, END, BEGIN
**Tables/Views**: FINANCIALSUMMARY
**Subdivision Info**: Part 100 of 106
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 105: Variable & Parameter Declarations (Math:PI/Aggregate:SUM) (Part 101)
**Type**: variable_declaration
**Complexity Score**: 9
**Lines**: 1583-1603
**Context**: Performs math:pi, aggregate:sum, select, conversion:cast, system:getdate, insert operations. Uses else, end, begin logic. Follows conditional logic
**SQL Operations**: Math:PI, Aggregate:SUM, SELECT, Conversion:CAST, System:GETDATE, INSERT
**Control Structures**: ELSE, END, BEGIN
**Variables Declared**: @TOTALCOGS, @GROSSPROFIT
**Tables/Views**: PRODUCTS, FINANCIALSUMMARY
**Subdivision Info**: Part 101 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
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
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 106: Variable & Parameter Declarations (Math:PI/INSERT) (Part 102)
**Type**: variable_declaration
**Complexity Score**: 6
**Lines**: 1604-1614
**Context**: Performs math:pi, insert operations. Uses case, else, end, when logic. Follows variable declaration
**SQL Operations**: Math:PI, INSERT
**Control Structures**: CASE, ELSE, END, WHEN
**Variables Declared**: @GROSSPROFITMARGIN
**Tables/Views**: PROFITMARGINANALYSIS
**Subdivision Info**: Part 102 of 106
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

### Chunk 107: Conditional Logic & Branching (Math:PI/System:GETDATE) (Part 103)
**Type**: conditional_logic
**Complexity Score**: 4
**Lines**: 1615-1622
**Context**: Performs math:pi, system:getdate operations. Uses case, else, end, when logic. Follows variable declaration
**SQL Operations**: Math:PI, System:GETDATE
**Control Structures**: CASE, ELSE, END, WHEN
**Subdivision Info**: Part 103 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                    CASE WHEN @FinalAmount > 0 THEN ((@GrossProfit - @ShippingCost - @ProcessingFee) / @FinalAmount) * 100 ELSE 0 END,
                                                                                                                                                                                                        GETDATE()
                                                                                                                                                                                                        );

                                                                                                                                                                                                    END;

                                                                                                                                                                                                    -- =====================================================================================
                                                                                                                                                                                                    -- SUCCESS COMPLETION
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 108: Transaction Control (String:LEN/Conversion:CAST) (Part 104)
**Type**: transaction_control
**Complexity Score**: 6
**Lines**: 1623-1638
**Context**: Performs string:len, conversion:cast operations. Uses if, end, begin, return logic. Follows conditional logic
**SQL Operations**: String:LEN, Conversion:CAST
**Control Structures**: IF, END, BEGIN, RETURN
**Subdivision Info**: Part 104 of 106
**Parent Block**: variable_declaration (lines 179-1683)

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

```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 109: Error Handling & Exception Management (END/BEGIN) (Part 105)
**Type**: error_handling
**Complexity Score**: 4
**Lines**: 1639-1642
**Context**: Uses end, begin, catch, try logic. Follows transaction control
**Control Structures**: END, BEGIN, CATCH, TRY
**Subdivision Info**: Part 105 of 106
**Parent Block**: variable_declaration (lines 179-1683)

**Code:**
```sql
                                                                                                                                                                                                        END TRY
                                                                                                                                                                                                        BEGIN CATCH
                                                                                                                                                                                                            -- =====================================================================================
                                                                                                                                                                                                            -- COMPREHENSIVE ERROR HANDLING
```

**Sequential Analysis Questions:**
1. How does this chunk build upon the previous chunks?
2. What specific business logic or data processing occurs here?
3. What variables or data from previous chunks are used?
4. What outputs or state changes prepare for subsequent chunks?
5. What error conditions or edge cases are handled?
6. How does this contribute to the overall procedure workflow?

---

### Chunk 110: Transaction Control (Math:LOG/System:@@TRANCOUNT) (Part 106)
**Type**: transaction_control
**Complexity Score**: 9
**Lines**: 1643-1683
**Context**: Performs math:log, system:@@trancount, conversion:cast, system:getdate, insert operations. Uses if, end, catch, goto logic. Follows error handling
**SQL Operations**: Math:LOG, System:@@TRANCOUNT, Conversion:CAST, System:GETDATE, INSERT
**Control Structures**: IF, END, CATCH, GOTO
**Tables/Views**: ERRORLOG
**Subdivision Info**: Part 106 of 106
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

### Chunk 111: General Business Logic
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

### Chunk 112: Transaction Control (Math:PI/System:@@TRANCOUNT)
**Type**: transaction_control
**Complexity Score**: 38
**Lines**: 1690-1731
**Context**: Performs math:pi, system:@@trancount operations. Uses end, if, else, return, begin logic. Follows general logic
**SQL Operations**: Math:PI, System:@@TRANCOUNT
**Control Structures**: END, IF, ELSE, RETURN, BEGIN

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

### Chunk 113: General Business Logic (END/RETURN)
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
