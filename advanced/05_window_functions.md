# 📊 SQL Window Functions — Quick Study

## 🔍 What are Window Functions?

Window functions perform calculations across a **set of related rows** without collapsing them into a single row.

> 💡 **`GROUP BY` → collapses rows**
> 💡 **Window function → keeps the original rows**

---

## 🧩 Basic Syntax

```sql
FUNCTION(column) OVER (
    PARTITION BY column
    ORDER BY column
)
```

### 🔧 Components

| Component      | Purpose                                                       |
| -------------- | ------------------------------------------------------------- |
| `FUNCTION()`   | Aggregate/window function such as `SUM()`, `AVG()`, `COUNT()` |
| `OVER()`       | Turns the function into a window function                     |
| `PARTITION BY` | Divides rows into separate windows                            |
| `ORDER BY`     | Determines the order within each window                       |

### Example

```sql
SUM(spend) OVER (
    PARTITION BY user_id
    ORDER BY transaction_date
)
```

📌 Calculates a **running total for each user**.

---

# 📦 `PARTITION BY`

`PARTITION BY` divides the result into separate logical windows.

```sql
AVG(salary) OVER (
    PARTITION BY department
)
```

Each department gets its own average, while **every employee row remains**.

### 🚫 No `PARTITION BY`

```sql
AVG(salary) OVER ()
```

The calculation is performed across the **entire result set**.

---

# 🧮 Aggregate Window Functions

Common aggregate window functions:

| Function           | Purpose                                 |
| ------------------ | --------------------------------------- |
| `COUNT()` 🔢       | Counts rows/values within a window      |
| `SUM()` ➕          | Calculates a sum within a window        |
| `AVG()` 📊         | Calculates an average within a window   |
| `MIN()` ⬇️         | Finds the minimum value within a window |
| `MAX()` ⬆️         | Finds the maximum value within a window |
| `FIRST_VALUE()` 🥇 | Returns the first value in a window     |
| `LAST_VALUE()` 🏁  | Returns the last value in a window      |

---

## 🔢 `COUNT()`

Counts rows within a window.

### Entire dataset

```sql
COUNT(*) OVER ()
```

### Per category

```sql
COUNT(*) OVER (
    PARTITION BY category
)
```

### Multiple columns

```sql
COUNT(*) OVER (
    PARTITION BY category, product
)
```

💡 **Remember:**

> `COUNT(*) OVER (PARTITION BY x)` = count rows within each `x` group, while keeping every row.

---

## ➕ `SUM()`

Calculates a sum within a window.

### Total per user

```sql
SUM(spend) OVER (
    PARTITION BY user_id
)
```

### 🔄 Running total

```sql
SUM(spend) OVER (
    PARTITION BY user_id
    ORDER BY transaction_date
)
```

`ORDER BY` makes the calculation **cumulative/running**.

Example:

```text
$10
$10 + $20 = $30
$10 + $20 + $15 = $45
```

🔄 The running total **starts over for each partition**.

---

## 📊 `AVG()`

Calculates an average within a window.

```sql
AVG(spend) OVER (
    PARTITION BY user_id
    ORDER BY transaction_date
)
```

This can be used to calculate a **running/rolling average**.

Example:

```text
10
(10 + 20) / 2 = 15
(10 + 20 + 30) / 3 = 20
```

---

## ⬇️ `MIN()`

Returns the minimum value within a window.

```sql
MIN(spend) OVER (
    PARTITION BY user_id
)
```

Every row for the same user receives that user's minimum spend.

---

## ⬆️ `MAX()`

Returns the maximum value within a window.

```sql
MAX(spend) OVER (
    PARTITION BY user_id
)
```

Every row for the same user receives that user's maximum spend.

---

# 🥇 `FIRST_VALUE()`

Returns the value from the **first row** in the window.

```sql
FIRST_VALUE(product) OVER (
    PARTITION BY user_id
    ORDER BY transaction_date
)
```

Useful for questions such as:

> 💭 "What was the first product purchased by each user?"

---

# 🏁 `LAST_VALUE()`

Returns the value from the **last row** in the window.

```sql
LAST_VALUE(product) OVER (
    PARTITION BY user_id
    ORDER BY transaction_date
)
```

Useful for questions such as:

> 💭 "What was the user's most recent product?"

⚠️ **Important:** `LAST_VALUE()` can be tricky because the **window frame** matters. When using it, pay attention to `ROWS` / `RANGE`.

---

# ⚔️ `GROUP BY` vs `PARTITION BY`

This is one of the **most important concepts**.

### `GROUP BY` 📦

```sql
SELECT
    department,
    AVG(salary)
FROM employees
GROUP BY department;
```

Produces **one row per department**.

### `PARTITION BY` 🪟

```sql
SELECT
    employee,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS dept_avg
FROM employees;
```

Keeps **every employee row** and adds the department average.

### 🧠 Remember

> 🔴 **`GROUP BY` → reduce rows**
> 🟢 **`PARTITION BY` → calculate across rows without reducing them**

---

# 🔀 `ORDER BY` in Window Functions

`ORDER BY` determines the order in which rows are processed within a window.

For example:

```sql
SUM(spend) OVER (
    PARTITION BY user_id
    ORDER BY transaction_date
)
```

Means:

1. 👥 Create a window for each `user_id`
2. 📅 Sort each user's rows by `transaction_date`
3. ➕ Calculate the running `SUM()`

### Without `ORDER BY`

```sql
SUM(spend) OVER (
    PARTITION BY user_id
)
```

You get the **total for the entire partition**, repeated on every row.

---

# 🧠 Quick Mental Model

Think of a window function as:

```text
📋 Original rows
       ↓
📦 Create windows with PARTITION BY
       ↓
🔀 Optionally sort with ORDER BY
       ↓
🧮 Perform calculation
       ↓
📋 Keep ALL original rows
```

### Example

```sql
SELECT
    user_id,
    spend,
    SUM(spend) OVER (
        PARTITION BY user_id
        ORDER BY transaction_date
    ) AS running_spend
FROM purchases;
```

Think:

> 🧠 **"For each user, sort their purchases by date and keep adding the spend as I move down the rows."**

---

# ⚡ Cheat Sheet

```sql
-- 🔢 Count
COUNT(*) OVER ()

-- 🔢 Count per group
COUNT(*) OVER (PARTITION BY category)

-- ➕ Total per group
SUM(amount) OVER (PARTITION BY category)

-- 🔄 Running total
SUM(amount) OVER (
    PARTITION BY category
    ORDER BY date
)

-- 📊 Average per group
AVG(amount) OVER (PARTITION BY category)

-- ⬇️ Minimum per group
MIN(amount) OVER (PARTITION BY category)

-- ⬆️ Maximum per group
MAX(amount) OVER (PARTITION BY category)

-- 🥇 First value
FIRST_VALUE(column) OVER (
    PARTITION BY category
    ORDER BY date
)

-- 🏁 Last value
LAST_VALUE(column) OVER (
    PARTITION BY category
    ORDER BY date
)
```

---

# 🎯 Key Takeaways

1. 🪟 **Window functions calculate across related rows without removing them.**
2. 🔗 **`OVER()` is required for a window function.**
3. 📦 **`PARTITION BY` creates separate windows.**
4. 🔀 **`ORDER BY` controls the order within a window.**
5. 🔄 `SUM() + ORDER BY` is commonly used for **running totals**.
6. 📊 `AVG() + ORDER BY` can be used for **running averages**.
7. ⚔️ `GROUP BY` collapses rows; `PARTITION BY` does **not**.
8. ⭐ The most important pattern to recognize is:

```sql
FUNCTION() OVER (
    PARTITION BY ...
    ORDER BY ...
)
```

> 🚀 **Master `PARTITION BY` + `ORDER BY` + `OVER()` and window functions become much easier to understand.**
