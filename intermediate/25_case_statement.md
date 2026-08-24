# SQL CASE Statement — Quick Study Notes

`CASE` is SQL's way of applying **conditional logic** — similar to `if / elif / else` in Python.

It can be used to:

* Create new columns
* Categorize data
* Filter rows
* Perform conditional `COUNT()`, `SUM()`, and `AVG()`

---

## 1. CASE in SELECT

Use `CASE` in `SELECT` to **create a new column based on conditions**.

### Syntax

```sql
SELECT
    column_1,
    column_2,
    CASE
        WHEN condition_1 THEN result_1
        WHEN condition_2 THEN result_2
        ELSE result_3
    END AS new_column
FROM table_name;
```

### Example

```sql
SELECT
    actor,
    followers,
    CASE
        WHEN followers >= 500000 THEN 'Popular'
        ELSE 'Not Popular'
    END AS popularity
FROM marvel_avengers;
```

### Multiple Conditions

```sql
SELECT
    actor,
    engagement_rate,
    CASE
        WHEN engagement_rate >= 8.0 THEN 'High'
        WHEN engagement_rate >= 6.0 THEN 'Moderate'
        ELSE 'Low'
    END AS engagement_category
FROM marvel_avengers;
```

### Important

`CASE` evaluates conditions **from top to bottom** and returns the result of the **first condition that is TRUE**.

So:

```sql
CASE
    WHEN score >= 80 THEN 'A'
    WHEN score >= 60 THEN 'B'
    ELSE 'C'
END
```

A score of `85` gets `'A'`, because the first condition is already true.

---

## 2. CASE in WHERE

`CASE` can be used in `WHERE` when the filtering rule itself depends on another column.

### Example

Different follower requirements for different platforms:

```sql
SELECT
    actor,
    character,
    platform
FROM marvel_avengers
WHERE
    CASE
        WHEN platform = 'Instagram' THEN followers >= 500000
        WHEN platform = 'Twitter' THEN followers >= 200000
        ELSE followers >= 100000
    END;
```

### Logic

| Platform  | Required Followers |
| --------- | -----------------: |
| Instagram |         >= 500,000 |
| Twitter   |         >= 200,000 |
| Other     |         >= 100,000 |

Think of it as:

```text
IF Instagram → followers >= 500000
ELSE IF Twitter → followers >= 200000
ELSE → followers >= 100000
```

---

# 3. COUNT() with CASE

This is one of the **most useful SQL interview patterns**.

Use:

```sql
COUNT(
    CASE
        WHEN condition THEN 1
        ELSE NULL
    END
)
```

`COUNT()` counts **non-NULL values**, so only rows satisfying the condition are counted.

### Example

Count actors with 500,000+ followers:

```sql
SELECT
    platform,
    COUNT(
        CASE
            WHEN followers >= 500000 THEN 1
            ELSE NULL
        END
    ) AS popular_actor_count
FROM marvel_avengers
GROUP BY platform;
```

### Why `ELSE NULL`?

Suppose we have:

```text
followers
---------
500000
300000
700000
400000
200000
```

The `CASE` produces:

```text
1
NULL
1
NULL
NULL
```

`COUNT()` ignores `NULL`:

```text
COUNT(1, NULL, 1, NULL, NULL) = 2
```

### Counting Two Conditions

```sql
SELECT
    platform,

    COUNT(
        CASE
            WHEN followers >= 500000 THEN 1
            ELSE NULL
        END
    ) AS popular_count,

    COUNT(
        CASE
            WHEN followers < 500000 THEN 1
            ELSE NULL
        END
    ) AS less_popular_count

FROM marvel_avengers
GROUP BY platform;
```

### Remember

```sql
COUNT(CASE WHEN condition THEN 1 ELSE NULL END)
```

means:

> **Count the rows where the condition is TRUE.**

---

# 4. SUM() with CASE

`SUM()` + `CASE` is useful when you want to **add values conditionally**.

### Pattern

```sql
SUM(
    CASE
        WHEN condition THEN value
        ELSE 0
    END
)
```

### Example

Add followers of actors with high engagement:

```sql
SELECT
    platform,
    SUM(
        CASE
            WHEN engagement_rate >= 8.0
            THEN followers
            ELSE 0
        END
    ) AS high_engagement_followers
FROM marvel_avengers
GROUP BY platform;
```

If the rows are:

```text
engagement_rate | followers
----------------|----------
8.2             | 500000
7.8             | 700000
9.1             | 400000
```

The `CASE` produces:

```text
500000
0
400000
```

Then:

```text
SUM = 900000
```

### COUNT vs SUM

These two patterns are extremely important:

```sql
-- COUNT matching rows
COUNT(CASE WHEN condition THEN 1 ELSE NULL END)
```

```sql
-- SUM values from matching rows
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

---

# 5. AVG() with CASE

`AVG()` + `CASE` calculates an **average only for rows matching a condition**.

### Pattern

```sql
AVG(
    CASE
        WHEN condition THEN value
        ELSE NULL
    END
)
```

### Example

Calculate the average followers for highly engaged actors:

```sql
SELECT
    platform,
    AVG(
        CASE
            WHEN engagement_rate >= 8.0
            THEN followers
            ELSE NULL
        END
    ) AS avg_high_engagement_followers
FROM marvel_avengers
GROUP BY platform;
```

### Why `ELSE NULL`?

`AVG()` ignores `NULL` values.

For example:

```text
followers
---------
500000
700000
400000
```

If only the first and third rows satisfy the condition:

```text
500000
NULL
400000
```

Then:

```text
AVG(500000, 400000)
= 450000
```

The `NULL` value is not included in the calculation.

---

# COUNT vs SUM vs AVG with CASE

| Goal                    | Pattern                                             |
| ----------------------- | --------------------------------------------------- |
| Count matching rows     | `COUNT(CASE WHEN condition THEN 1 ELSE NULL END)`   |
| Add matching values     | `SUM(CASE WHEN condition THEN value ELSE 0 END)`    |
| Average matching values | `AVG(CASE WHEN condition THEN value ELSE NULL END)` |

### Quick Memory Trick

```text
COUNT → How many?
SUM   → How much total?
AVG   → What's the average?
```

---

# 6. A Very Common Interview Pattern

Conditional counting can also be written using `SUM()`:

```sql
SUM(
    CASE
        WHEN condition THEN 1
        ELSE 0
    END
)
```

For example:

```sql
SELECT
    SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) AS laptop_views,
    SUM(CASE WHEN device_type IN ('tablet', 'phone') THEN 1 ELSE 0 END) AS mobile_views
FROM viewership;
```

This gives:

```text
laptop_views | mobile_views
-------------|-------------
2            | 3
```

### COUNT vs SUM for Conditional Counting

Both can count matching rows:

```sql
COUNT(CASE WHEN condition THEN 1 ELSE NULL END)
```

and

```sql
SUM(CASE WHEN condition THEN 1 ELSE 0 END)
```

The key difference is:

```text
COUNT → counts non-NULL values
SUM   → adds the 1s and 0s
```

---

# 7. CASE + GROUP BY

`CASE` becomes especially powerful when combined with `GROUP BY`.

Example:

```sql
SELECT
    platform,
    SUM(
        CASE
            WHEN engagement_rate >= 8.0
            THEN followers
            ELSE 0
        END
    ) AS high_engagement_followers
FROM marvel_avengers
GROUP BY platform;
```

Think:

```text
GROUP BY platform
        ↓
For each platform
        ↓
Check CASE condition for every row
        ↓
SUM the matching followers
```

---

# 8. CASE + NULL

Be careful about what you return from `CASE`.

### For COUNT()

Usually use:

```sql
ELSE NULL
```

because `COUNT()` ignores `NULL`.

```sql
COUNT(
    CASE
        WHEN condition THEN 1
        ELSE NULL
    END
)
```

### For SUM()

Usually use:

```sql
ELSE 0
```

because you don't want non-matching rows to affect the total.

```sql
SUM(
    CASE
        WHEN condition THEN value
        ELSE 0
    END
)
```

### For AVG()

Usually use:

```sql
ELSE NULL
```

because `AVG()` ignores `NULL`, allowing the average to be calculated only from matching values.

```sql
AVG(
    CASE
        WHEN condition THEN value
        ELSE NULL
    END
)
```

---

# 9. CASE Cheat Sheet

### Create a category

```sql
CASE
    WHEN condition THEN 'Category A'
    WHEN condition THEN 'Category B'
    ELSE 'Category C'
END
```

### Conditional COUNT

```sql
COUNT(
    CASE
        WHEN condition THEN 1
        ELSE NULL
    END
)
```

### Conditional SUM

```sql
SUM(
    CASE
        WHEN condition THEN value
        ELSE 0
    END
)
```

### Conditional AVG

```sql
AVG(
    CASE
        WHEN condition THEN value
        ELSE NULL
    END
)
```

### Conditional counting with SUM

```sql
SUM(
    CASE
        WHEN condition THEN 1
        ELSE 0
    END
)
```

---

# 10. Interview Mental Model

When you see a SQL question asking:

> **"Count the rows where..."**

Think:

```sql
COUNT(CASE WHEN ... THEN 1 ELSE NULL END)
```

When you see:

> **"Calculate the total/sum of X where..."**

Think:

```sql
SUM(CASE WHEN ... THEN X ELSE 0 END)
```

When you see:

> **"Calculate the average of X where..."**

Think:

```sql
AVG(CASE WHEN ... THEN X ELSE NULL END)
```

When you see:

> **"Categorize rows based on..."**

Think:

```sql
CASE
    WHEN ...
    WHEN ...
    ELSE ...
END
```

---

## ⭐ Most Important Patterns to Memorize

```sql
-- Conditional COUNT
COUNT(CASE WHEN condition THEN 1 ELSE NULL END)
```

```sql
-- Conditional SUM
SUM(CASE WHEN condition THEN value ELSE 0 END)
```

```sql
-- Conditional AVG
AVG(CASE WHEN condition THEN value ELSE NULL END)
```

```sql
-- Create a category
CASE
    WHEN condition THEN 'A'
    WHEN condition THEN 'B'
    ELSE 'C'
END
```

**The big idea:**

> `CASE` decides **which rows/values participate**, while `COUNT()`, `SUM()`, and `AVG()` perform the **aggregation**.
