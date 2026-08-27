# 4 Types of SQL Joins

A SQL `JOIN` is used to combine rows from two or more tables based on a related column.

> **Note:** `JOIN` by itself is shorthand for `INNER JOIN`.

## Overview

| JOIN Type         | Description                                                                  |
| ----------------- | ---------------------------------------------------------------------------- |
| `INNER JOIN`      | Returns only rows with matching values in both tables.                       |
| `LEFT JOIN`       | Returns all rows from the left table and matching rows from the right table. |
| `RIGHT JOIN`      | Returns all rows from the right table and matching rows from the left table. |
| `FULL OUTER JOIN` | Returns all rows from both tables. Unmatched columns contain `NULL`.         |

---

## 1. INNER JOIN

Returns **only the rows that have a match in both tables**.

### Syntax

```sql
SELECT columns
FROM table1
INNER JOIN table2
    ON table1.id = table2.id;
```

### Example

```sql
SELECT
    orders.order_id,
    orders.customer_id,
    goodreads.book_title,
    orders.quantity
FROM goodreads
INNER JOIN orders
    ON goodreads.book_id = orders.book_id
WHERE goodreads.price >= 20;
```

### Key idea

If a row exists in `goodreads` but has **no matching `book_id`** in `orders`, it will **not** appear in the result.

**Think:**

```text
Table A ∩ Table B
```

Only the **matching portion** is returned.

---

## 2. LEFT JOIN

Returns:

* **All rows from the left table**
* Matching rows from the right table
* `NULL` for right-table columns when there is no match

### Syntax

```sql
SELECT columns
FROM table1
LEFT JOIN table2
    ON table1.id = table2.id;
```

### Example

```sql
SELECT
    orders.order_id,
    deliveries.delivery_id,
    deliveries.delivery_date,
    deliveries.delivery_status
FROM orders
LEFT JOIN deliveries
    ON orders.order_id = deliveries.order_id;
```

Here:

* `orders` = **left table**
* `deliveries` = **right table**

Every order will appear, even if it doesn't have a delivery.

If an order has no matching delivery:

```text
delivery_id      → NULL
delivery_date    → NULL
delivery_status  → NULL
```

### Key idea

> **LEFT JOIN = Keep everything from the left table.**

---

## 3. RIGHT JOIN

`RIGHT JOIN` is the opposite of `LEFT JOIN`.

It returns:

* **All rows from the right table**
* Matching rows from the left table
* `NULL` for left-table columns when there is no match

### Syntax

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
    ON table1.id = table2.id;
```

### Example

```sql
SELECT
    orders.order_id,
    deliveries.delivery_id,
    deliveries.delivery_date,
    deliveries.delivery_status
FROM deliveries
RIGHT JOIN orders
    ON deliveries.order_id = orders.order_id;
```

Here:

* `deliveries` = left table
* `orders` = right table

Therefore, **all orders are retained**.

### Key idea

> **RIGHT JOIN = Keep everything from the right table.**

### Practical tip

`RIGHT JOIN` is rarely used because the same result can usually be achieved with a `LEFT JOIN` by swapping the table positions.

For example:

```sql
-- RIGHT JOIN
FROM deliveries
RIGHT JOIN orders
    ON deliveries.order_id = orders.order_id;
```

Can be rewritten as:

```sql
-- Equivalent LEFT JOIN
FROM orders
LEFT JOIN deliveries
    ON orders.order_id = deliveries.order_id;
```

---

## 4. FULL OUTER JOIN

Returns **all rows from both tables**.

* Matching rows are combined.
* Unmatched rows from the left table are still included.
* Unmatched rows from the right table are still included.
* `NULL` appears for columns where there is no match.

### Syntax

```sql
SELECT columns
FROM table1
FULL OUTER JOIN table2
    ON table1.id = table2.id;
```

### Example

```sql
SELECT
    orders.order_id,
    deliveries.delivery_id,
    deliveries.delivery_date,
    deliveries.delivery_status
FROM orders
FULL OUTER JOIN deliveries
    ON orders.order_id = deliveries.order_id;
```

### Key idea

> **FULL OUTER JOIN = Keep everything from both tables.**

Think of it as:

```text
Table A ∪ Table B
```

---

# JOIN Comparison

Suppose we have:

### Table A — `orders`

| order_id |
| -------: |
|        1 |
|        2 |
|        3 |

### Table B — `deliveries`

| order_id |
| -------: |
|        2 |
|        3 |
|        4 |

The results conceptually look like this:

| JOIN              | Result       |
| ----------------- | ------------ |
| `INNER JOIN`      | `2, 3`       |
| `LEFT JOIN`       | `1, 2, 3`    |
| `RIGHT JOIN`      | `2, 3, 4`    |
| `FULL OUTER JOIN` | `1, 2, 3, 4` |

---

# Quick Memory Trick

```text
INNER → Matching rows only

LEFT  → Everything on LEFT
        + matching RIGHT

RIGHT → Everything on RIGHT
        + matching LEFT

FULL  → Everything from BOTH
```

### Most Important Question to Ask

When writing a JOIN, ask:

> **"Which table's rows do I want to keep even when there is no match?"**

* Keep only matches → `INNER JOIN`
* Keep left table → `LEFT JOIN`
* Keep right table → `RIGHT JOIN`
* Keep both tables → `FULL OUTER JOIN`

---

# Important Note About NULL

For `LEFT`, `RIGHT`, and `FULL OUTER JOIN`, unmatched rows produce `NULL` values for columns belonging to the table where no match was found.

Example:

```text
orders.order_id = 1001
deliveries.order_id = NULL
```

This means the order exists, but there is no matching delivery record.

---

# Interview Cheat Sheet

| Requirement                         | JOIN                                   |
| ----------------------------------- | -------------------------------------- |
| Only matching records               | `INNER JOIN`                           |
| All records from first/left table   | `LEFT JOIN`                            |
| All records from second/right table | `RIGHT JOIN`                           |
| All records from both tables        | `FULL OUTER JOIN`                      |
| Find records with no match on right | `LEFT JOIN` + `WHERE right.id IS NULL` |
| Find records with no match on left  | `RIGHT JOIN` + `WHERE left.id IS NULL` |

**Golden rule:**

> `INNER` = intersection
> `LEFT` = everything on left
> `RIGHT` = everything on right
> `FULL` = everything
