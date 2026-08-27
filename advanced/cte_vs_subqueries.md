# SQL CTEs & Subqueries

CTEs and subqueries allow you to break complex SQL queries into smaller, more manageable pieces.

---

## 1. CTE — Common Table Expression

A **CTE** is a temporary result set that exists only while the main query runs.

### Syntax

```sql
WITH cte_name AS (
    SELECT ...
    FROM ...
    WHERE ...
)
SELECT *
FROM cte_name;
```

### Example

```sql
WITH high_earners AS (
    SELECT *
    FROM employees
    WHERE salary > 100000
)
SELECT *
FROM high_earners;
```

### Why use CTEs?

* Make complex queries easier to read.
* Break a large query into logical steps.
* Reuse the same result within a query.
* Useful for **recursive queries**.
* Easier to debug because each step can be understood separately.

---

## 2. Subquery

A **subquery** is a query nested inside another query.

It is usually enclosed in parentheses:

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

The inner query executes to provide a value/result used by the outer query.

---

## 3. CTE vs Subquery

| CTE                         | Subquery                             |
| --------------------------- | ------------------------------------ |
| Defined using `WITH`        | Written inside another query         |
| Usually easier to read      | Can be more compact                  |
| Good for multi-step queries | Good for simple one-off calculations |
| Can reuse its result        | Usually used once                    |
| Supports recursive queries  | Can be correlated with outer query   |

### Simple rule

> **Complex / multi-step query → CTE**
> **Small calculation or filter → Subquery**

---

## 4. Subquery in `WHERE`

Useful when comparing a value against the result of another query.

```sql
SELECT *
FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);
```

**Meaning:** Find employees whose salary is greater than the average salary.

---

## 5. Subquery with `IN`

Use `IN` when the subquery returns multiple values.

```sql
SELECT *
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'New York'
);
```

---

## 6. Subquery in `SELECT`

A subquery can be used to calculate a value for each row.

```sql
SELECT
    employee_name,
    salary,
    salary - (
        SELECT AVG(salary)
        FROM employees
    ) AS difference_from_avg
FROM employees;
```

---

## 7. Correlated Subquery

A **correlated subquery** references a column from the outer query.

```sql
SELECT e.employee_name,
       e.salary
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
);
```

Here, the inner query depends on the **current row of the outer query**.

> **Normal subquery:** Independent of the outer query.
> **Correlated subquery:** Depends on the outer query.

---

## 8. Multiple CTEs

You can define multiple CTEs using commas:

```sql
WITH sales AS (
    SELECT *
    FROM orders
),
high_sales AS (
    SELECT *
    FROM sales
    WHERE amount > 1000
)
SELECT *
FROM high_sales;
```

This is useful for building a query **step by step**.

---

# ⭐ Quick Cheat Sheet

```text
CTE
→ WITH name AS (...)
→ Best for complex / multi-step queries
→ Improves readability
→ Can be reused
→ Supports recursive queries

SUBQUERY
→ Query inside another query
→ Best for smaller calculations/filtering
→ Often used with WHERE, IN, etc.

CORRELATED SUBQUERY
→ Inner query references outer query
→ Evaluated based on each outer row
```

## 🧠 Remember

**CTE = Build the query in steps**

```sql
WITH step1 AS (...),
     step2 AS (...)
SELECT ...
FROM step2;
```

**Subquery = Put a query inside another query**

```sql
SELECT ...
FROM ...
WHERE column > (
    SELECT ...
);
```

> Both CTEs and subqueries help make complicated SQL problems easier to break down, understand, and debug.
