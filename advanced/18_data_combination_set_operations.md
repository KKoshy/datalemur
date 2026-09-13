# 🔀 SQL UNION, UNION ALL, INTERSECT, EXCEPT & JOIN

These operators are used to **combine or compare data from multiple queries/tables**.

The biggest distinction:

> **JOIN → combines columns horizontally**
> **UNION / INTERSECT / EXCEPT → work with result sets vertically**

---

## 🔗 JOIN

A `JOIN` combines rows from **two or more tables horizontally** based on a related column.

```sql
SELECT
    customers.name,
    orders.order_id
FROM customers
JOIN orders
    ON customers.customer_id = orders.customer_id;
```

### 🧠 Think

```text
Table A        Table B
┌───────┐      ┌───────┐
│ Name  │ ───→ │ Order │
│ ID    │      │ ID    │
└───────┘      └───────┘

       ↓ JOIN

┌───────┬────────┐
│ Name  │ Order  │
└───────┴────────┘
```

👉 **Adds columns** by matching rows.

---

# ⬇️ UNION

`UNION` combines the results of two or more `SELECT` statements **vertically** and removes duplicates.

```sql
SELECT name FROM employees
UNION
SELECT name FROM contractors;
```

### 🧠 Think

```text
Employees
Alice
Bob
Charlie

Contractors
Bob
David

      ↓ UNION

Alice
Bob
Charlie
David
```

👉 **Stacks rows + removes duplicates**

---

# 📦 UNION ALL

`UNION ALL` also stacks result sets vertically, but **keeps duplicates**.

```sql
SELECT name FROM employees
UNION ALL
SELECT name FROM contractors;
```

Result:

```text
Alice
Bob
Charlie
Bob
David
```

👉 **Stacks rows + keeps duplicates**

### ⭐ UNION vs UNION ALL

|                    | `UNION` | `UNION ALL` |
| ------------------ | ------- | ----------- |
| Combines results   | ✅       | ✅           |
| Removes duplicates | ✅       | ❌           |
| Keeps duplicates   | ❌       | ✅           |
| Usually faster     | ❌       | ✅           |

Use `UNION ALL` when you **don't need duplicate removal**.

---

# 🤝 INTERSECT

`INTERSECT` returns rows that exist in **both result sets**.

```sql
SELECT name FROM employees
INTERSECT
SELECT name FROM contractors;
```

Result:

```text
Bob
```

Because Bob exists in both.

### 🧠 Think

```text
Employees       Contractors
Alice           Bob
Bob       ∩     David
Charlie

        ↓

       Bob
```

👉 **Returns common rows**

`INTERSECT` removes duplicates.

---

# ➖ EXCEPT

`EXCEPT` returns rows from the **first query that don't exist in the second query**.

```sql
SELECT name FROM employees
EXCEPT
SELECT name FROM contractors;
```

Result:

```text
Alice
Charlie
```

### 🧠 Think

```text
Employees
Alice      ← keep
Bob        ← remove (exists in contractors)
Charlie    ← keep

        ↓ EXCEPT

Alice
Charlie
```

👉 **First result − second result**

⚠️ Order matters:

```sql
A EXCEPT B
```

is **not necessarily the same as**

```sql
B EXCEPT A
```

---

# 📋 Requirements for UNION / INTERSECT / EXCEPT

The `SELECT` statements must have:

1. ✅ Same number of columns
2. ✅ Compatible data types
3. ✅ Columns in the same order

Example:

```sql
SELECT name, age
FROM employees

UNION

SELECT name, age
FROM contractors;
```

This works because both queries return:

```text
name → VARCHAR
age  → INT
```

---

# 🆚 JOIN vs Set Operators

| Feature                    | `JOIN`                 | `UNION`                 | `UNION ALL`             | `INTERSECT`             | `EXCEPT`                |
| -------------------------- | ---------------------- | ----------------------- | ----------------------- | ----------------------- | ----------------------- |
| Main purpose               | Combine related tables | Combine results         | Combine results         | Find common rows        | Find differences        |
| Direction                  | ➡️ Horizontal          | ⬇️ Vertical             | ⬇️ Vertical             | ⬇️ Vertical             | ⬇️ Vertical             |
| Adds columns               | ✅                      | ❌                       | ❌                       | ❌                       | ❌                       |
| Adds rows                  | Sometimes              | ✅                       | ✅                       | ❌                       | ❌                       |
| Removes duplicates         | Depends on join        | ✅                       | ❌                       | ✅                       | ✅                       |
| Requires matching columns? | Join condition         | Same column count/types | Same column count/types | Same column count/types | Same column count/types |

---

# 🧠 Easy Mental Model

```text
                COMBINING DATA
                      │
          ┌───────────┴───────────┐
          │                       │
        JOIN                 SET OPERATORS
          │                       │
    Horizontal              Vertical
          │                       │
    Add columns        ┌──────────┼──────────┐
                       │          │          │
                    UNION     INTERSECT    EXCEPT
                       │
                   UNION ALL
```

### Remember:

* 🔗 **JOIN** → Combine **columns**
* ⬇️ **UNION** → Stack rows, **remove duplicates**
* 📦 **UNION ALL** → Stack rows, **keep duplicates**
* 🤝 **INTERSECT** → Rows in **both**
* ➖ **EXCEPT** → Rows in **first but not second**

> **JOIN = horizontally combine**
> **UNION = vertically stack**
> **INTERSECT = common**
> **EXCEPT = difference**
