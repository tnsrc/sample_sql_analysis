# Universal Stored Procedure Analysis Guide
============================================================

## Overview
This stored procedure has been automatically broken into 39 logical chunks.
Each chunk represents a distinct logical operation or set of related operations.
Analyze each chunk independently to understand the complete business logic.

## Procedure Statistics
- **Total Chunks**: 39
- **Total Complexity Score**: 139
- **Average Complexity per Chunk**: 3.6

**Chunk Type Distribution:**
- Conditional Logic: 18
- Data Modification: 4
- Data Retrieval: 2
- Error Handling: 3
- General Logic: 3
- Loop Logic: 3
- Transaction Control: 4
- Variable Declaration: 2

## Recommended Analysis Order
Process chunks in this order to maintain logical flow:

1. **Chunk 1**: General Business Logic (CREATE)
   - Type: general_logic
   - Complexity: 1
   - Lines: 1-7

2. **Chunk 2**: General Business Logic (BEGIN)
   - Type: general_logic
   - Complexity: 2
   - Lines: 7-14

3. **Chunk 3**: Variable & Parameter Declarations - Part 3
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 14-38

4. **Chunk 4**: Variable & Parameter Declarations - Part 4
   - Type: variable_declaration
   - Complexity: 0
   - Lines: 38-47

5. **Chunk 5**: Error Handling & Exception Management (IF/BEGIN)
   - Type: error_handling
   - Complexity: 10
   - Lines: 47-52

6. **Chunk 6**: Conditional Logic & Branching (BEGIN/END)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 52-60

7. **Chunk 7**: Conditional Logic & Branching (BEGIN/END)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 60-68

8. **Chunk 8**: Conditional Logic & Branching (BEGIN/END)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 68-76

9. **Chunk 9**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 76-85

10. **Chunk 10**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 85-94

11. **Chunk 11**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 94-103

12. **Chunk 12**: Data Insert/Update/Delete (INSERT/SELECT)
   - Type: data_modification
   - Complexity: 2
   - Lines: 103-110

13. **Chunk 13**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 110-120

14. **Chunk 14**: Loop Processing & Iteration (SELECT)
   - Type: loop_logic
   - Complexity: 5
   - Lines: 120-130

15. **Chunk 15**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 5
   - Lines: 130-139

16. **Chunk 16**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 139-144

17. **Chunk 17**: Loop Processing & Iteration (GOTO/BEGIN)
   - Type: loop_logic
   - Complexity: 4
   - Lines: 144-152

18. **Chunk 18**: Data Insert/Update/Delete (UPDATE)
   - Type: data_modification
   - Complexity: 1
   - Lines: 152-161

19. **Chunk 19**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 161-166
   - Depends on Chunks: 18

20. **Chunk 20**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 7
   - Lines: 166-177
   - Depends on Chunks: 18

21. **Chunk 21**: Conditional Logic & Branching (BEGIN/END)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 177-185
   - Depends on Chunks: 18

22. **Chunk 22**: Loop Processing & Iteration (GOTO/BEGIN)
   - Type: loop_logic
   - Complexity: 4
   - Lines: 185-193
   - Depends on Chunks: 18

23. **Chunk 23**: Conditional Logic & Branching (END/IF)
   - Type: conditional_logic
   - Complexity: 2
   - Lines: 193-199
   - Depends on Chunks: 18

24. **Chunk 24**: Data Query & Retrieval (SELECT)
   - Type: data_retrieval
   - Complexity: 2
   - Lines: 199-204
   - Depends on Chunks: 18

25. **Chunk 25**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 204-209
   - Depends on Chunks: 18

26. **Chunk 26**: Conditional Logic & Branching (BEGIN/END)
   - Type: conditional_logic
   - Complexity: 4
   - Lines: 209-214
   - Depends on Chunks: 18

27. **Chunk 27**: Conditional Logic & Branching (SELECT)
   - Type: conditional_logic
   - Complexity: 3
   - Lines: 214-226
   - Depends on Chunks: 18

28. **Chunk 28**: Data Insert/Update/Delete (INSERT)
   - Type: data_modification
   - Complexity: 1
   - Lines: 226-251
   - Depends on Chunks: 18

29. **Chunk 29**: General Business Logic - Part 29
   - Type: general_logic
   - Complexity: 0
   - Lines: 251-259
   - Depends on Chunks: 18

30. **Chunk 30**: Data Insert/Update/Delete (INSERT/SELECT)
   - Type: data_modification
   - Complexity: 2
   - Lines: 259-267
   - Depends on Chunks: 18

31. **Chunk 31**: Data Query & Retrieval (SELECT)
   - Type: data_retrieval
   - Complexity: 1
   - Lines: 267-275
   - Depends on Chunks: 18

32. **Chunk 32**: Transaction Control (UPDATE)
   - Type: transaction_control
   - Complexity: 1
   - Lines: 275-281
   - Depends on Chunks: 18

33. **Chunk 33**: Transaction Control (INSERT)
   - Type: transaction_control
   - Complexity: 1
   - Lines: 281-299
   - Depends on Chunks: 18, 32

34. **Chunk 34**: Conditional Logic & Branching (UPDATE/INSERT)
   - Type: conditional_logic
   - Complexity: 6
   - Lines: 299-306
   - Depends on Chunks: 18, 32

35. **Chunk 35**: Transaction Control (INSERT)
   - Type: transaction_control
   - Complexity: 1
   - Lines: 306-318
   - Depends on Chunks: 18, 32, 34

36. **Chunk 36**: Error Handling & Exception Management (CATCH/BEGIN)
   - Type: error_handling
   - Complexity: 6
   - Lines: 318-325
   - Depends on Chunks: 18, 32, 34

37. **Chunk 37**: Error Handling & Exception Management (CATCH/END)
   - Type: error_handling
   - Complexity: 5
   - Lines: 325-334
   - Depends on Chunks: 18, 32, 34

38. **Chunk 38**: Conditional Logic & Branching (BEGIN/IF)
   - Type: conditional_logic
   - Complexity: 9
   - Lines: 334-339
   - Depends on Chunks: 18, 32, 34

39. **Chunk 39**: Transaction Control (INSERT)
   - Type: transaction_control
   - Complexity: 3
   - Lines: 339-360
   - Depends on Chunks: 18, 32, 34

## Detailed Chunk Analysis

### Chunk 1: General Business Logic (CREATE)
**Type**: general_logic
**Complexity Score**: 1/10
**Lines**: 1-7
**SQL Operations**: CREATE
**Variables Used**: @CartItems, @CustomerID, @PaymentMethodID, @ShippingAddressID, @OrderDate, @PromoCode

**Code:**
```sql
CREATE PROCEDURE sp_ProcessOrder
    @CustomerID INT,
    @OrderDate DATETIME,
    @ShippingAddressID INT,
    @PaymentMethodID INT,
    @CartItems NVARCHAR(MAX), -- JSON array of items: [{"ProductID": int, "Quantity": int}, ...]
    @PromoCode NVARCHAR(50),
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 2: General Business Logic (BEGIN)
**Type**: general_logic
**Complexity Score**: 2/10
**Lines**: 7-14
**Control Structures**: BEGIN
**Variables Used**: @PromoCode, @OrderID, @ErrorMessage

**Code:**
```sql
    @PromoCode NVARCHAR(50),
    @OrderID INT OUTPUT,
    @ErrorMessage NVARCHAR(500) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Declare variables
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
**Lines**: 14-38
**Variables Declared**: @FINALAMOUNT, @PROMOSTARTDATE, @PROMOENDDATE, @ISVALID, @QUANTITY, @UNITPRICE, @MAXDISCOUNT, @TRANSACTIONID, @CURRENTITEM, @TAXAMOUNT, @CUSTOMERORDERCOUNT, @DISCOUNTPERCENTAGE, @CUSTOMERTYPEID, @ERRORCODE, @ORDERSTATUSID, @AVAILABLESTOCK, @TOTALAMOUNT, @ITEMCOUNT, @SHIPPINGCOST, @PRODUCTID, @DISCOUNTAMOUNT, @PROMOID
**Variables Used**: @CustomerOrderCount, @ItemCount, @FinalAmount, @CurrentItem, @IsValid, @ErrorCode, @DiscountAmount, @DiscountPercentage, @TransactionID, @MaxDiscount, @OrderStatusID, @UnitPrice, @TaxAmount, @PromoStartDate, @PromoEndDate, @ShippingCost, @PromoID, @TotalAmount, @AvailableStock, @CustomerTypeID, @ProductID, @Quantity

**Code:**
```sql
    -- Declare variables
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
**Lines**: 38-47
**Variables Declared**: @CART
**Variables Used**: @Cart

**Code:**
```sql
    -- Temporary table for cart items
    DECLARE @Cart TABLE (
        RowNum INT IDENTITY(1,1),
        ProductID INT,
        Quantity INT,
        UnitPrice DECIMAL(18,2),
        LineTotal DECIMAL(18,2)
    );
    
    -- Begin transaction
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 5: Error Handling & Exception Management (IF/BEGIN)
**Type**: error_handling
**Complexity Score**: 10/10
**Lines**: 47-52
**Control Structures**: IF, BEGIN, TRY
**Variables Used**: @CustomerID

**Code:**
```sql
    -- Begin transaction
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Validate input parameters
        IF @CustomerID IS NULL OR @CustomerID <= 0
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 6: Conditional Logic & Branching (BEGIN/END)
**Type**: conditional_logic
**Complexity Score**: 6/10
**Lines**: 52-60
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @CustomerID, @ShippingAddressID, @IsValid, @ErrorCode, @ErrorMessage

**Code:**
```sql
        IF @CustomerID IS NULL OR @CustomerID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Customer ID.';
            SET @ErrorCode = 1001;
            GOTO ErrorHandler;
        END;
        
        IF @ShippingAddressID IS NULL OR @ShippingAddressID <= 0
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 7: Conditional Logic & Branching (BEGIN/END)
**Type**: conditional_logic
**Complexity Score**: 6/10
**Lines**: 60-68
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @PaymentMethodID, @ShippingAddressID, @IsValid, @ErrorCode, @ErrorMessage

**Code:**
```sql
        IF @ShippingAddressID IS NULL OR @ShippingAddressID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Shipping Address ID.';
            SET @ErrorCode = 1002;
            GOTO ErrorHandler;
        END;
        
        IF @PaymentMethodID IS NULL OR @PaymentMethodID <= 0
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 8: Conditional Logic & Branching (BEGIN/END)
**Type**: conditional_logic
**Complexity Score**: 4/10
**Lines**: 68-76
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @PaymentMethodID, @IsValid, @ErrorCode, @ErrorMessage

**Code:**
```sql
        IF @PaymentMethodID IS NULL OR @PaymentMethodID <= 0
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid Payment Method ID.';
            SET @ErrorCode = 1003;
            GOTO ErrorHandler;
        END;
        
        -- Validate customer exists and is active
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 9: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 5/10
**Lines**: 76-85
**SQL Operations**: SELECT
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @CustomerID, @IsValid, @ErrorCode, @ErrorMessage
**Tables/Views**: CUSTOMERS

**Code:**
```sql
        -- Validate customer exists and is active
        IF NOT EXISTS (SELECT 1 FROM Customers WHERE CustomerID = @CustomerID AND IsActive = 1)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Customer does not exist or is inactive.';
            SET @ErrorCode = 1004;
            GOTO ErrorHandler;
        END;
        
        -- Validate shipping address belongs to customer
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 10: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 5/10
**Lines**: 85-94
**SQL Operations**: SELECT
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @CustomerID, @ShippingAddressID, @IsValid, @ErrorCode, @ErrorMessage
**Tables/Views**: ADDRESSES

**Code:**
```sql
        -- Validate shipping address belongs to customer
        IF NOT EXISTS (SELECT 1 FROM Addresses WHERE AddressID = @ShippingAddressID AND CustomerID = @CustomerID)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Shipping address does not belong to the customer.';
            SET @ErrorCode = 1005;
            GOTO ErrorHandler;
        END;
        
        -- Validate payment method
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 11: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 5/10
**Lines**: 94-103
**SQL Operations**: SELECT
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @PaymentMethodID, @IsValid, @ErrorCode, @ErrorMessage
**Tables/Views**: PAYMENTMETHODS

**Code:**
```sql
        -- Validate payment method
        IF NOT EXISTS (SELECT 1 FROM PaymentMethods WHERE PaymentMethodID = @PaymentMethodID AND IsActive = 1)
        BEGIN
            SET @IsValid = 0;
            SET @ErrorMessage = 'Invalid or inactive payment method.';
            SET @ErrorCode = 1006;
            GOTO ErrorHandler;
        END;
        
        -- Parse and validate cart items (assuming JSON input)
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 12: Data Insert/Update/Delete (INSERT/SELECT)
**Type**: data_modification
**Complexity Score**: 2/10
**Lines**: 103-110
**SQL Operations**: INSERT, SELECT
**Variables Used**: @Cart, @CartItems
**Tables/Views**: OPENJSON

**Code:**
```sql
        -- Parse and validate cart items (assuming JSON input)
        INSERT INTO @Cart (ProductID, Quantity)
        SELECT 
            JSON_VALUE(value, '$.ProductID'),
            JSON_VALUE(value, '$.Quantity')
        FROM OPENJSON(@CartItems);
        
        -- Get item count
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 13: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 5/10
**Lines**: 110-120
**SQL Operations**: SELECT
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @ItemCount, @Cart, @IsValid, @ErrorCode, @ErrorMessage

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 14: Loop Processing & Iteration (SELECT)
**Type**: loop_logic
**Complexity Score**: 5/10
**Lines**: 120-130
**SQL Operations**: SELECT
**Control Structures**: WHILE, BEGIN
**Variables Used**: @ItemCount, @Cart, @CurrentItem, @ProductID, @Quantity

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 15: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 5/10
**Lines**: 130-139
**SQL Operations**: SELECT
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @IsValid, @ErrorCode, @ProductID, @ErrorMessage
**Tables/Views**: PRODUCTS

**Code:**
```sql
            -- Check if product exists
            IF NOT EXISTS (SELECT 1 FROM Products WHERE ProductID = @ProductID AND IsActive = 1)
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + ' does not exist or is inactive.';
                SET @ErrorCode = 1008;
                GOTO ErrorHandler;
            END;
            
            -- Check stock availability
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 16: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 3/10
**Lines**: 139-144
**SQL Operations**: SELECT
**Control Structures**: IF
**Variables Used**: @AvailableStock, @UnitPrice, @Quantity, @ProductID
**Tables/Views**: PRODUCTS

**Code:**
```sql
            -- Check stock availability
            SELECT @AvailableStock = StockQuantity, @UnitPrice = UnitPrice
            FROM Products
            WHERE ProductID = @ProductID;
            
            IF @Quantity <= 0 OR @Quantity > @AvailableStock
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 17: Loop Processing & Iteration (GOTO/BEGIN)
**Type**: loop_logic
**Complexity Score**: 4/10
**Lines**: 144-152
**Control Structures**: GOTO, BEGIN, END, IF, FOR
**Variables Used**: @AvailableStock, @ProductID, @IsValid, @ErrorCode, @Quantity, @ErrorMessage

**Code:**
```sql
            IF @Quantity <= 0 OR @Quantity > @AvailableStock
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Invalid quantity or insufficient stock for Product ID ' + CAST(@ProductID AS NVARCHAR(10)) + '.';
                SET @ErrorCode = 1009;
                GOTO ErrorHandler;
            END;
            
            -- Update cart with unit price and line total
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 18: Data Insert/Update/Delete (UPDATE)
**Type**: data_modification
**Complexity Score**: 1/10
**Lines**: 152-161
**SQL Operations**: UPDATE
**Control Structures**: END
**Variables Used**: @Quantity, @UnitPrice, @Cart, @CurrentItem

**Code:**
```sql
            -- Update cart with unit price and line total
            UPDATE @Cart
            SET UnitPrice = @UnitPrice,
                LineTotal = @Quantity * @UnitPrice
            WHERE RowNum = @CurrentItem;
            
            SET @CurrentItem = @CurrentItem + 1;
        END;
        
        -- Calculate total amount
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 19: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 3/10
**Lines**: 161-166
**SQL Operations**: SELECT
**Control Structures**: IF
**Variables Used**: @Cart, @TotalAmount, @PromoCode
**Dependencies**: Chunks 18

**Code:**
```sql
        -- Calculate total amount
        SELECT @TotalAmount = SUM(LineTotal)
        FROM @Cart;
        
        -- Apply promo code if provided
        IF @PromoCode IS NOT NULL AND @PromoCode != ''
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 20: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 7/10
**Lines**: 166-177
**SQL Operations**: SELECT
**Control Structures**: BEGIN, IF
**Variables Used**: @DiscountPercentage, @MaxDiscount, @PromoStartDate, @PromoEndDate, @PromoID, @PromoCode
**Tables/Views**: PROMOTIONS
**Dependencies**: Chunks 18

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 21: Conditional Logic & Branching (BEGIN/END)
**Type**: conditional_logic
**Complexity Score**: 6/10
**Lines**: 177-185
**Control Structures**: BEGIN, END, IF, GOTO
**Variables Used**: @PromoStartDate, @PromoEndDate, @PromoID, @OrderDate, @IsValid, @ErrorCode, @ErrorMessage
**Dependencies**: Chunks 18

**Code:**
```sql
            IF @PromoID IS NULL
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Invalid or inactive promo code.';
                SET @ErrorCode = 1010;
                GOTO ErrorHandler;
            END;
            
            IF @OrderDate < @PromoStartDate OR @OrderDate > @PromoEndDate
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 22: Loop Processing & Iteration (GOTO/BEGIN)
**Type**: loop_logic
**Complexity Score**: 4/10
**Lines**: 185-193
**Control Structures**: GOTO, BEGIN, END, IF, FOR
**Variables Used**: @PromoStartDate, @PromoEndDate, @OrderDate, @IsValid, @ErrorCode, @ErrorMessage
**Dependencies**: Chunks 18

**Code:**
```sql
            IF @OrderDate < @PromoStartDate OR @OrderDate > @PromoEndDate
            BEGIN
                SET @IsValid = 0;
                SET @ErrorMessage = 'Promo code is not valid for the current date.';
                SET @ErrorCode = 1011;
                GOTO ErrorHandler;
            END;
            
            -- Calculate discount
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 23: Conditional Logic & Branching (END/IF)
**Type**: conditional_logic
**Complexity Score**: 2/10
**Lines**: 193-199
**Control Structures**: END, IF
**Variables Used**: @DiscountAmount, @MaxDiscount, @DiscountPercentage, @TotalAmount
**Dependencies**: Chunks 18

**Code:**
```sql
            -- Calculate discount
            SET @DiscountAmount = @TotalAmount * (@DiscountPercentage / 100);
            IF @MaxDiscount IS NOT NULL AND @DiscountAmount > @MaxDiscount
                SET @DiscountAmount = @MaxDiscount;
        END;
        
        -- Get customer type and order history
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 24: Data Query & Retrieval (SELECT)
**Type**: data_retrieval
**Complexity Score**: 2/10
**Lines**: 199-204
**SQL Operations**: SELECT
**Variables Used**: @CustomerID, @CustomerOrderCount, @CustomerTypeID
**Tables/Views**: CUSTOMERS
**Dependencies**: Chunks 18

**Code:**
```sql
        -- Get customer type and order history
        SELECT @CustomerTypeID = CustomerTypeID
        FROM Customers
        WHERE CustomerID = @CustomerID;
        
        SELECT @CustomerOrderCount = COUNT(*)
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 25: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 3/10
**Lines**: 204-209
**SQL Operations**: SELECT
**Control Structures**: IF
**Variables Used**: @CustomerID, @CustomerOrderCount, @CustomerTypeID
**Tables/Views**: ORDERS
**Dependencies**: Chunks 18

**Code:**
```sql
        SELECT @CustomerOrderCount = COUNT(*)
        FROM Orders
        WHERE CustomerID = @CustomerID AND OrderStatusID IN (2, 3); -- Completed or Shipped
        
        -- Apply additional discount for VIP customers
        IF @CustomerTypeID = 2 -- VIP
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 26: Conditional Logic & Branching (BEGIN/END)
**Type**: conditional_logic
**Complexity Score**: 4/10
**Lines**: 209-214
**Control Structures**: BEGIN, END, IF
**Variables Used**: @DiscountAmount, @CustomerTypeID, @TotalAmount
**Dependencies**: Chunks 18

**Code:**
```sql
        IF @CustomerTypeID = 2 -- VIP
        BEGIN
            SET @DiscountAmount = @DiscountAmount + (@TotalAmount * 0.05); -- 5% extra discount
        END;
        
        -- Calculate tax (e.g., 8% tax rate)
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 27: Conditional Logic & Branching (SELECT)
**Type**: conditional_logic
**Complexity Score**: 3/10
**Lines**: 214-226
**SQL Operations**: SELECT
**Control Structures**: CASE, WHEN, ELSE, END
**Variables Used**: @DiscountAmount, @TaxAmount, @ShippingCost, @Cart, @TotalAmount
**Tables/Views**: PRODUCTS
**Dependencies**: Chunks 18

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 28: Data Insert/Update/Delete (INSERT)
**Type**: data_modification
**Complexity Score**: 1/10
**Lines**: 226-251
**SQL Operations**: INSERT
**Variables Used**: @DiscountAmount, @TaxAmount, @ShippingCost, @CustomerID, @PaymentMethodID, @ShippingAddressID, @FinalAmount, @OrderDate, @TotalAmount
**Tables/Views**: ORDERS
**Dependencies**: Chunks 18

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 29: General Business Logic - Part 29
**Type**: general_logic
**Complexity Score**: 0/10
**Lines**: 251-259
**Variables Used**: @OrderID, @ShippingCost, @OrderStatusID, @FinalAmount, @PromoID
**Dependencies**: Chunks 18

**Code:**
```sql
            @ShippingCost,
            @FinalAmount,
            @OrderStatusID,
            @PromoID
        );
        
        SET @OrderID = SCOPE_IDENTITY();
        
        -- Insert order items
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 30: Data Insert/Update/Delete (INSERT/SELECT)
**Type**: data_modification
**Complexity Score**: 2/10
**Lines**: 259-267
**SQL Operations**: INSERT, SELECT
**Tables/Views**: ORDERITEMS
**Dependencies**: Chunks 18

**Code:**
```sql
        -- Insert order items
        INSERT INTO OrderItems (
            OrderID,
            ProductID,
            Quantity,
            UnitPrice,
            LineTotal
        )
        SELECT 
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 31: Data Query & Retrieval (SELECT)
**Type**: data_retrieval
**Complexity Score**: 1/10
**Lines**: 267-275
**SQL Operations**: SELECT
**Variables Used**: @OrderID, @Cart
**Dependencies**: Chunks 18

**Code:**
```sql
        SELECT 
            @OrderID,
            ProductID,
            Quantity,
            UnitPrice,
            LineTotal
        FROM @Cart;
        
        -- Update inventory
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 32: Transaction Control (UPDATE)
**Type**: transaction_control
**Complexity Score**: 1/10
**Lines**: 275-281
**SQL Operations**: UPDATE
**Variables Used**: @Cart
**Tables/Views**: PRODUCTS, P
**Dependencies**: Chunks 18

**Code:**
```sql
        -- Update inventory
        UPDATE p
        SET p.StockQuantity = p.StockQuantity - c.Quantity
        FROM Products p
        JOIN @Cart c ON p.ProductID = c.ProductID;
        
        -- Log transaction
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 33: Transaction Control (INSERT)
**Type**: transaction_control
**Complexity Score**: 1/10
**Lines**: 281-299
**SQL Operations**: INSERT
**Variables Used**: @TransactionID, @OrderID, @CustomerID, @FinalAmount, @OrderDate
**Tables/Views**: TRANSACTIONLOG
**Dependencies**: Chunks 18, 32

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 34: Conditional Logic & Branching (UPDATE/INSERT)
**Type**: conditional_logic
**Complexity Score**: 6/10
**Lines**: 299-306
**SQL Operations**: UPDATE, INSERT
**Control Structures**: BEGIN, IF
**Variables Used**: @CustomerID, @CustomerOrderCount, @CustomerTypeID
**Tables/Views**: CUSTOMERS, CUSTOMERLOG
**Dependencies**: Chunks 18, 32

**Code:**
```sql
        -- Check if customer qualifies for upgrade to VIP
        IF @CustomerOrderCount >= 10 AND @CustomerTypeID != 2
        BEGIN
            UPDATE Customers
            SET CustomerTypeID = 2
            WHERE CustomerID = @CustomerID;
            
            INSERT INTO CustomerLog (
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 35: Transaction Control (INSERT)
**Type**: transaction_control
**Complexity Score**: 1/10
**Lines**: 306-318
**SQL Operations**: INSERT
**Control Structures**: END
**Variables Used**: @CustomerID, @OrderDate
**Tables/Views**: CUSTOMERLOG
**Dependencies**: Chunks 18, 32, 34

**Code:**
```sql
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
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 36: Error Handling & Exception Management (CATCH/BEGIN)
**Type**: error_handling
**Complexity Score**: 6/10
**Lines**: 318-325
**Control Structures**: CATCH, BEGIN, END, TRY
**Variables Used**: @ErrorMessage
**Dependencies**: Chunks 18, 32, 34

**Code:**
```sql
        -- Commit transaction
        COMMIT TRANSACTION;
        
        SET @ErrorMessage = 'Order processed successfully.';
        
    END TRY
    BEGIN CATCH
        -- Rollback transaction on error
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 37: Error Handling & Exception Management (CATCH/END)
**Type**: error_handling
**Complexity Score**: 5/10
**Lines**: 325-334
**Control Structures**: CATCH, END, IF
**Variables Used**: @IsValid, @TRANCOUNT, @ErrorCode, @ErrorMessage
**Dependencies**: Chunks 18, 32, 34

**Code:**
```sql
        -- Rollback transaction on error
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
            
        SET @IsValid = 0;
        SET @ErrorMessage = 'Error processing order: ' + ERROR_MESSAGE();
        SET @ErrorCode = ERROR_NUMBER();
    END CATCH;
    
    -- Error handling
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 38: Conditional Logic & Branching (BEGIN/IF)
**Type**: conditional_logic
**Complexity Score**: 9/10
**Lines**: 334-339
**Control Structures**: BEGIN, IF
**Variables Used**: @IsValid, @TRANCOUNT
**Dependencies**: Chunks 18, 32, 34

**Code:**
```sql
    -- Error handling
    ErrorHandler:
    IF @IsValid = 0
    BEGIN
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
```

**Universal Analysis Questions:**
1. What is the primary purpose of this code section?
2. What business rules or logic constraints are implemented?
3. What data transformations or validations occur?
4. What are the inputs and outputs of this section?
5. What error conditions could occur here?
6. How does this section fit into the overall procedure flow?

---

### Chunk 39: Transaction Control (INSERT)
**Type**: transaction_control
**Complexity Score**: 3/10
**Lines**: 339-360
**SQL Operations**: INSERT
**Control Structures**: RETURN, END
**Variables Used**: @CustomerID, @ErrorCode, @OrderID, @ErrorMessage
**Tables/Views**: ERRORLOG
**Dependencies**: Chunks 18, 32, 34

**Code:**
```sql
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
