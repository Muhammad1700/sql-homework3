tack 1
🔹1. What is BULK INSERT?
BULK INSERT is a command in SQL Server used to quickly load large volumes of data from external files (like .txt, .csv) into a database table. It's especially useful for importing raw data into a table without needing manual INSERT statements.

Purpose: It saves time and effort when dealing with massive datasets — ideal for initial data migrations or refreshing data lakes.

🔹2. Four File Formats for Importing
SQL Server can import data from a variety of formats. Here are four common ones:

.txt (plain text)

.csv (comma-separated values)

.xls / .xlsx (Excel spreadsheets)

.xml (Extensible Markup Language)

3.
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);
4.
INSERT INTO Products (ProductID, ProductName, Price)
VALUES 
(1, 'Keyboard', 49.99),
(2, 'Mouse', 19.99),
(3, 'Monitor', 199.99);
🔹 5. NULL vs NOT NULL
NULL: Means no value is stored — the data is missing or undefined.

NOT NULL: Restricts a column from having missing values; requires a value during insert.
6.
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
7.
-- This query adds a unique constraint to the ProductName column
8.
ALTER TABLE Products
ADD CategoryID INT;
9.
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
10.
An IDENTITY column automatically generates numeric values when inserting new rows. For example:
ProductID INT IDENTITY(1,1)

tack 2

Based on the surrounding content from the **Lesson 3 homework page**, this section is part of the **Medium-Level Tasks** designed to deepen your SQL Server skills by applying core concepts in a more hands-on way. Here’s an explanation of each item, grounded in the lesson's context:

---

### 🔹 `BULK INSERT` for Importing Data
You're asked to practice using `BULK INSERT` to load data from a **text file** directly into the `Products` table. This mirrors the earlier topic on importing data and is useful for handling large datasets efficiently, especially when migrating or initializing data.

```sql
BULK INSERT Products
FROM 'C:\\Data\\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
```

This assumes the file is comma-separated and skips a header row.

---

### 🔹 Creating a `FOREIGN KEY`
This task connects your `Products` table to the `Categories` table using a **foreign key**, enforcing referential integrity.

```sql
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);
```

---

### 🔹 PRIMARY KEY vs. UNIQUE KEY
Both keys enforce **uniqueness**, but:
- `PRIMARY KEY` is **mandatory NOT NULL** and **only one allowed** per table.
- `UNIQUE KEY` allows **multiple per table** and can accept **NULL** values.

This distinction is critical for designing flexible but reliable schemas.

---

### 🔹 Adding a `CHECK` Constraint for Price

```sql
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive
CHECK (Price > 0);
```

This ensures that products can’t be saved with zero or negative prices.

---

### 🔹 Add `Stock` Column with `NOT NULL`

```sql
ALTER TABLE Products
ADD Stock INT NOT NULL;
```

Ensures that every product record has a stock value defined.

---

### 🔹 Use `ISNULL` to Handle Null Prices

```sql
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
```

Replaces any `NULL` value in `Price` with `0` during query output.

---

### 🔹 Purpose of `FOREIGN KEY`
`FOREIGN KEY` constraints are used to:
- **Link related data** across tables (e.g., Products ➡ Categories).
- **Prevent orphaned records** (ensuring a product’s category exists).
- Support **data integrity** by enforcing valid relationships.

---

tack 3

Muhammad, this part of the lesson is from the **Hard-Level Tasks** section of Lesson 3, which builds on everything you've learned about keys, constraints, and handling NULLs. Here's a breakdown of each point based on the surrounding lesson context:

---

### 🧩 1. **Customers Table with a CHECK Constraint**
You're expected to apply a **CHECK constraint** to ensure customers are adults (Age ≥ 18):

```sql
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Age INT CHECK (Age >= 18)
);
```

This enforces a business rule directly at the table level.

---

### 🆔 2. **Table with Custom IDENTITY**
This tests your understanding of the `IDENTITY` property, controlling how auto-incrementing values behave:

```sql
CREATE TABLE ProductsWithCustomID (
    ProductID INT IDENTITY(100, 10) PRIMARY KEY,
    ProductName VARCHAR(50)
);
```

Starts at 100 and increases by 10 per new row.

---

### 🔑 3. **Composite PRIMARY KEY in OrderDetails**
A composite key ensures uniqueness based on a combination of two or more columns:

```sql
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
```

This is common in many-to-many relationships.

---

### 🧠 4. **COALESCE vs. ISNULL**
Both handle `NULL` values, but there's a nuance:
- `ISNULL(expr, replacement)`: Replaces only the first expression if it's NULL.
- `COALESCE(expr1, expr2, ...)`: Returns the first non-null expression from the list — more flexible and standard SQL.

Example:

```sql
SELECT COALESCE(Discount, 0) FROM Orders;
SELECT ISNULL(Price, 0) FROM Products;
```

---

### 👥 5. **Employees Table with PRIMARY and UNIQUE KEY**
Demonstrates combining constraints for identity and uniqueness:

```sql
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Email VARCHAR(100) UNIQUE,
    FullName VARCHAR(100)
);
```

---

### 🔄 6. **FOREIGN KEY with CASCADE Options**
This part checks advanced constraint behavior — how changes in one table affect another:

```sql
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
ON DELETE CASCADE
ON UPDATE CASCADE;
```

This means deleting/updating a customer affects linked orders accordingly.

---


