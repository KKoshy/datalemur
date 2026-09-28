# ⚙️ SQL Query Order of Execution

SQL queries are **written** in one order, but the database **processes** them in a different logical order.

Understanding this order helps with:

* 🐛 Debugging queries
* 🎯 Writing correct queries
* 🧠 Understanding `WHERE`, `GROUP BY`, `HAVING`, etc.
* ⚡ Writing more efficient SQL

---

## 🔢 Logical Execution Order

| Order | Clause           | What happens                      |
| ----: | ---------------- | --------------------------------- |
|   1️⃣ | `FROM`           | Get data from the table(s)        |
|   2️⃣ | `WHERE`          | Filter individual rows            |
|   3️⃣ | `GROUP BY`       | Group rows                        |
|   4️⃣ | `HAVING`         | Filter groups                     |
|   5️⃣ | `SELECT`         | Choose columns / calculate values |
|   6️⃣ | `ORDER BY`       | Sort the result                   |
|   7️⃣ | `LIMIT / OFFSET` | Restrict / skip rows              |

### 🧠 Easy way to remember

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
ORDER BY
  ↓
LIMIT / OFFSET
```

---

## 1️⃣ FROM — Get the Data

```sql
FROM orders
```

The database first determines **which table(s)** the data comes from.

If joins are present, the relevant tables are combined here as part of the `FROM`/`JOIN` processing.

---

## 2️⃣ WHERE — Filter Rows

```sql
WHERE amount > 1000
```

Filters **individual rows** before grouping.

```text
All rows
   ↓
WHERE
   ↓
Only matching rows
```

⚠️ Because `WHERE` happens before `GROUP BY`, you cannot use an aggregate result such as:

```sql
WHERE COUNT(*) > 5
```

For aggregate filtering, use `HAVING`.

---

## 3️⃣ GROUP BY — Create Groups

```sql
GROUP BY customer_id
```

Rows are grouped based on one or more columns.

Aggregate functions can then be calculated for each group:

```sql
COUNT()
SUM()
AVG()
MIN()
MAX()
```

Example:

```sql
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM orders
GROUP BY customer_id;
```

---

## 4️⃣ HAVING — Filter Groups

`HAVING` filters the **groups created by `GROUP BY`**.

```sql
HAVING COUNT(*) > 5
```

### 🆚 WHERE vs HAVING

| `WHERE`                              | `HAVING`                            |
| ------------------------------------ | ----------------------------------- |
| Filters rows                         | Filters groups                      |
| Before `GROUP BY`                    | After `GROUP BY`                    |
| Usually used with individual columns | Often used with aggregate functions |

```text
WHERE
  ↓
GROUP BY
  ↓
HAVING
```

---

## 5️⃣ SELECT — Choose the Output

```sql
SELECT
    customer_id,
    COUNT(*) AS order_count
```

The `SELECT` clause determines what appears in the final result.

This is also where calculated expressions and aliases are defined.

---

## 6️⃣ ORDER BY — Sort the Result

```sql
ORDER BY order_count DESC
```

The result is sorted after the selected result set has been produced.

Example:

```sql
ORDER BY order_count DESC;
```

→ Largest `order_count` first.

---

## 7️⃣ LIMIT / OFFSET — Restrict the Result

```sql
LIMIT 5
```

Returns only the specified number of rows.

```sql
LIMIT 5 OFFSET 10
```

→ Skip the first 10 rows and return the next 5.

---

# 🧪 Complete Example

```sql
SELECT
    customer_id,
    AVG(amount) AS avg_amount
FROM orders
WHERE amount > 100
GROUP BY customer_id
HAVING AVG(amount) > 500
ORDER BY avg_amount DESC
LIMIT 5;
```

### 🔍 How SQL logically processes it

```text
1. FROM orders
       ↓
2. WHERE amount > 100
       ↓
3. GROUP BY customer_id
       ↓
4. HAVING AVG(amount) > 500
       ↓
5. SELECT customer_id, AVG(amount)
       ↓
6. ORDER BY avg_amount DESC
       ↓
7. LIMIT 5
```

---

# ⭐ Key Interview Point

### Written order ≠ Execution order

We normally **write** SQL like this:

```sql
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
```

But logically it is processed like this:

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
ORDER BY
 ↓
LIMIT
```

### 🧠 One-line memory trick

> **FROM → WHERE → GROUP → HAVING → SELECT → ORDER → LIMIT**

🐺 Funny Wolves → Go Hunting → Steal Our Lunch

F → W → G → H → S → O → L

= FROM → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

---

## 🎯 Most Important Distinction

```text
WHERE  → Filter ROWS
HAVING → Filter GROUPS
```

This distinction is one of the most important things to understand when working with `GROUP BY` and aggregate functions.
