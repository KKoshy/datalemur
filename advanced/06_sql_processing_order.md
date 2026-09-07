# 🧠 SQL Query Processing Order

SQL does **not** execute a query in the same order that we write it.

The logical processing order is:

```text
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. DISTINCT
7. ORDER BY
8. LIMIT / OFFSET
```

> ⭐ **Important:** Window functions are logically evaluated **after the result set has been formed by `GROUP BY`/aggregates and before the final `ORDER BY`.**

---

## 🔄 The Basic Flow

```text
FROM
  ↓
WHERE
  ↓
GROUP BY
  ↓
HAVING
  ↓
SELECT
  ↓
Window Functions
  ↓
DISTINCT
  ↓
ORDER BY
  ↓
LIMIT / OFFSET
```

---

## 1️⃣ FROM

Determines **which tables/data** we're working with.

```sql
SELECT *
FROM employees;
```

---

## 2️⃣ WHERE

Filters **individual rows**.

```sql
SELECT *
FROM employees
WHERE salary > 50000;
```

❌ You generally cannot use aggregate results here:

```sql
WHERE AVG(salary) > 50000
```

Because `AVG()` hasn't been calculated yet.

---

## 3️⃣ GROUP BY

Groups rows together for aggregation.

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department;
```

Example:

```text
employees
    ↓
GROUP BY department
    ↓
one group per department
```

---

## 4️⃣ HAVING

Filters **groups after aggregation**.

```sql
SELECT department, AVG(salary)
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

### Remember:

```text
WHERE  → filters rows
HAVING → filters groups
```

---

## 5️⃣ SELECT

Determines what columns/calculations appear in the final result.

```sql
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
```

Aggregate functions such as:

```text
COUNT()
SUM()
AVG()
MIN()
MAX()
```

are calculated as part of the grouped result.

---

## 6️⃣ Window Functions 🪟

Window functions operate on the result **without collapsing rows**.

```sql
SELECT
    employee,
    department,
    salary,
    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
```

### Important distinction

```text
GROUP BY
→ collapses rows

PARTITION BY
→ keeps rows and performs a calculation within each partition
```

---

## ⚠️ Aggregate + Window Function

This is especially important:

❌ You generally cannot do:

```sql
MIN(
    FIRST_VALUE(amount) OVER (...)
)
```

because you're trying to use a window function inside an aggregate function at the same query level.

Instead, use separate query levels:

```sql
WITH aggregated AS (
    SELECT
        department,
        MIN(salary) AS min_salary
    FROM employees
    GROUP BY department
)
SELECT
    department,
    min_salary,
    RANK() OVER (
        ORDER BY min_salary
    ) AS ranking
FROM aggregated;
```

Think:

```text
GROUP BY
   ↓
MIN()
   ↓
CTE / Subquery
   ↓
Window Function
```

---

## 7️⃣ DISTINCT

Removes duplicate rows from the resulting data.

```sql
SELECT DISTINCT department
FROM employees;
```

---

## 8️⃣ ORDER BY

Sorts the final result.

```sql
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
ORDER BY avg_salary DESC;
```

---

## 9️⃣ LIMIT / OFFSET

Restricts the final number of rows.

```sql
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 10;
```

---

# ⭐ Quick Cheat Sheet

| Order | Clause           | Purpose                       |
| ----: | ---------------- | ----------------------------- |
|     1 | `FROM`           | Get the data                  |
|     2 | `WHERE`          | Filter rows                   |
|     3 | `GROUP BY`       | Create groups                 |
|     4 | `HAVING`         | Filter groups                 |
|     5 | `SELECT`         | Choose/calculations           |
|     6 | Window functions | Calculate across related rows |
|     7 | `DISTINCT`       | Remove duplicates             |
|     8 | `ORDER BY`       | Sort results                  |
|     9 | `LIMIT/OFFSET`   | Restrict output               |

---

# 🧠 Easy Way to Remember

```text
FROM       → Where does the data come from?
WHERE      → Which rows do I want?
GROUP BY   → How should I group them?
HAVING     → Which groups do I want?
SELECT     → What do I want to see?
WINDOW     → Calculate across rows/groups
DISTINCT   → Remove duplicates
ORDER BY   → How should I sort?
LIMIT      → How many rows do I want?
```

### 🚨 Most Important Takeaway

When a SQL query becomes complicated, ask:

> **"At which stage of SQL processing does this calculation happen?"**

This explains many common errors involving:

* `WHERE` vs `HAVING`
* `GROUP BY` vs `PARTITION BY`
* Aggregate functions vs window functions
* Why window functions often need a **CTE/subquery**
* Why an alias sometimes cannot be referenced where you expect
