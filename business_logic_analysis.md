# Business Logic Analysis: sp_ProcessOrder

## Overview
- **Purpose**: Complete e-commerce order processing workflow from cart validation to order completion
- **Input Parameters**: 
  - Customer info (`@CustomerID`, `@OrderDate`)
  - Shipping/Payment (`@ShippingAddressID`, `@PaymentMethodID`)
  - Cart data (`@CartItems` as JSON)
  - Optional promo code (`@PromoCode`)
- **Output**: 
  - `@OrderID` (newly created order)
  - `@ErrorMessage` (success/failure message)
- **Key Tables**: Customers, Products, Orders, OrderItems, Addresses, PaymentMethods, Promotions, TransactionLog

## Control Flow Summary
```
1. INPUT VALIDATION PHASE
   ├── Validate required parameters
   ├── Validate customer exists and active
   ├── Validate shipping address ownership
   └── Validate payment method

2. CART PROCESSING PHASE
   ├── Parse JSON cart items
   ├── Validate each product exists
   ├── Check inventory availability
   └── Calculate line totals

3. PRICING CALCULATION PHASE
   ├── Calculate subtotal
   ├── Apply promo code (if provided)
   ├── Apply VIP customer discount
   ├── Calculate tax (8%)
   └── Calculate shipping cost

4. ORDER CREATION PHASE
   ├── Insert order record
   ├── Insert order items
   ├── Update inventory
   └── Log transaction

5. POST-PROCESSING PHASE
   ├── Check VIP upgrade eligibility
   └── Error handling and logging
```

## Business Logic Sections

### Section 1: Input Validation & Security
**Purpose**: Ensure all required data is valid and secure
**Business Rules**:
- Customer ID must be positive and exist in active customers
- Shipping address must belong to the customer (security rule)
- Payment method must be active
- Cart cannot be empty
**Error Codes**: 1001-1007

### Section 2: Inventory Management
**Purpose**: Validate product availability and reserve stock
**Business Rules**:
- Products must be active to be ordered
- Requested quantity cannot exceed available stock
- Quantity must be positive
- Stock is decremented immediately upon order creation
**Error Codes**: 1008-1009

### Section 3: Promotional Pricing System
**Purpose**: Apply discount codes with validation
**Business Rules**:
- Promo codes must be active and within date range
- Discount = `TotalAmount × (DiscountPercentage ÷ 100)`
- Maximum discount cap applies if specified
- Date validation: `OrderDate` must be between `StartDate` and `EndDate`
**Error Codes**: 1010-1011

### Section 4: Customer Loyalty Program
**Purpose**: Provide VIP benefits and manage customer upgrades
**Business Rules**:
- VIP customers (CustomerTypeID = 2) get additional 5% discount
- Customer becomes VIP after 10 completed/shipped orders
- VIP upgrade triggers automatic customer log entry
- Only considers orders with status 2 (Completed) or 3 (Shipped)

### Section 5: Tax and Shipping Calculation
**Purpose**: Calculate additional charges based on business rules
**Business Rules**:
- Tax Rate: 8% applied to `(TotalAmount - DiscountAmount)`
- Shipping Cost Tiers:
  - ≤ 5 lbs: $10.00
  - ≤ 20 lbs: $20.00  
  - > 20 lbs: $50.00
- Weight calculated as `SUM(Product.Weight × OrderQuantity)`

### Section 6: Financial Calculation Flow
**Purpose**: Determine final order amount
**Calculation Sequence**:
1. `TotalAmount` = Sum of all line totals
2. `DiscountAmount` = Promo discount + VIP discount (if applicable)
3. `TaxAmount` = `(TotalAmount - DiscountAmount) × 0.08`
4. `ShippingCost` = Weight-based tier pricing
5. `FinalAmount` = `TotalAmount - DiscountAmount + TaxAmount + ShippingCost`

## Data Transformations

### Cart Processing
- **Input**: JSON string `[{"ProductID": int, "Quantity": int}, ...]`
- **Process**: Parse JSON → Validate products → Enrich with pricing
- **Output**: Temporary table with ProductID, Quantity, UnitPrice, LineTotal

### Order Creation
- **Input**: Validated cart + calculated amounts  
- **Process**: Insert order header → Insert line items → Update inventory
- **Output**: New OrderID + updated stock levels

## Dependencies

### Required Tables
- **Customers**: Customer validation and type checking
- **Products**: Product validation, pricing, inventory, weight
- **Addresses**: Shipping address validation
- **PaymentMethods**: Payment validation
- **Promotions**: Discount code validation and calculation
- **Orders/OrderItems**: Order storage
- **TransactionLog**: Audit trail
- **CustomerLog**: VIP upgrade tracking
- **ErrorLog**: Error tracking

### External Dependencies
- JSON parsing functions (OPENJSON, JSON_VALUE)
- Transaction management (BEGIN/COMMIT/ROLLBACK)
- Error handling (TRY/CATCH blocks)

## Business Rules Summary

### Critical Business Rules
1. **Security**: Customers can only ship to their own addresses
2. **Inventory**: No overselling - stock checked and reserved atomically
3. **Pricing Integrity**: All discounts have maximum caps
4. **Data Consistency**: Full transaction rollback on any error
5. **Audit Trail**: All transactions and errors are logged
6. **Customer Loyalty**: Automatic VIP upgrade after 10 orders
7. **Tax Compliance**: Consistent 8% tax rate application

### Validation Rules
- All IDs must be positive integers
- All entities must exist and be active
- Promo codes must be within valid date range
- Quantities must be positive and within stock limits

### Calculation Rules
- VIP customers get additional 5% discount on top of promo discounts
- Tax calculated on discounted amount
- Shipping based on total weight, not item count
- Final amount includes all fees and taxes

## Error Handling Strategy
- **Validation Errors** (1001-1011): Business rule violations
- **System Errors**: Caught by TRY/CATCH, logged with SQL error details  
- **Transaction Safety**: All changes rolled back on any error
- **Error Logging**: All errors recorded with context for debugging

## Performance Considerations
- Uses temporary table variable for cart processing
- Single transaction scope for data consistency
- Inventory updates batched with JOINs
- Error handling uses GOTO for efficient flow control 