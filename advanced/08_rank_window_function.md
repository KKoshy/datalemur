# 🥇 SQL `RANK()` Window Function

`RANK()` is a **window function** used to assign a rank to each row based on the ordering of values.

```sql
RANK() OVER (
    [PARTITION BY column]
    ORDER BY column
)
```

## 🔹 Basic Example

Suppose we have:

| employee | salary |
| -------- | -----: |
| Alice    | 100000 |
| Bob      |  90000 |
| Carol    |  90000 |
| David    |  80000 |

```sql
SELECT
    employee,
    salary,
    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank
FROM employees;
```

Result:

| employee | salary | salary_rank |
| -------- | -----: | ----------: |
| Alice    | 100000 |           1 |
| Bob      |  90000 |           2 |
| Carol    |  90000 |           2 |
| David    |  80000 |           4 |

### ⭐ Important

`RANK()` gives the **same rank to tied values**, but **leaves gaps** after a tie.

```text
100000 → 1
 90000 → 2
 90000 → 2
 80000 → 4  ← rank 3 is skipped
```

---

# 🪟 Why is `RANK()` a Window Function?

Because it operates on a **set/window of rows** while keeping every individual row in the result.

```sql
RANK() OVER (...)
```

The `OVER()` clause defines the window.

For example:

```sql
RANK() OVER (
    PARTITION BY department
    ORDER BY salary DESC
)
```

This means:

> Rank employees by salary **within each department**.

The ranking starts again for every department.

---

# ❓ Why isn't `RANK()` an Aggregate Function?

Aggregate functions **combine multiple rows into a single value**.

Examples:

```text
SUM()
AVG()
COUNT()
MIN()
MAX()
```

For example:

```sql
SELECT AVG(salary)
FROM employees;
```

Input:

```text
100000
90000
80000
```

Output:

```text
90000
```

Multiple rows → **one value**

---

`RANK()` does something different.

```text
100000 → 1
 90000 → 2
 80000 → 3
```

It produces **one result for every row**.

Multiple rows → **multiple results**

Therefore:

```text
Aggregate function
    ↓
Reduces rows

Window function
    ↓
Keeps rows
    +
Calculates using related rows
```

---

# 🧠 `GROUP BY` vs `RANK()`

This distinction is extremely important.

### `GROUP BY`

```sql
SELECT department, MAX(salary)
FROM employees
GROUP BY department;
```

Produces:

```text
department → one row per department
```

Rows are **collapsed**.

### `RANK()`

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

Produces:

```text
employee → remains
department → remains
salary → remains
rank → added
```

Rows are **not collapsed**.

---

# 🔥 RANK vs DENSE_RANK vs ROW_NUMBER

| Function       | Ties                          | Gaps? |
| -------------- | ----------------------------- | ----- |
| `ROW_NUMBER()` | Different number for each row | ❌     |
| `RANK()`       | Same rank                     | ✅     |
| `DENSE_RANK()` | Same rank                     | ❌     |

Example:

```text
Salary       ROW_NUMBER    RANK    DENSE_RANK
100000           1            1          1
90000            2            2          2
90000            3            2          2
80000            4            4          3
```

---

# ⭐ Key Takeaway

> **Aggregate functions reduce rows. Window functions calculate across rows without reducing them.**

So:

```text
SUM()       → Aggregate function
AVG()       → Aggregate function
COUNT()     → Aggregate function
MIN()       → Aggregate function
MAX()       → Aggregate function

RANK()      → Window function
DENSE_RANK()→ Window function
ROW_NUMBER()→ Window function
```

And remember:

```sql
RANK() OVER (...)
```

The `OVER()` clause is the giveaway that we're performing a **window operation**.
