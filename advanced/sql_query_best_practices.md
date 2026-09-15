# 🧼 SQL Query Best Practices

Writing SQL isn't only about getting the **correct result**. Good SQL should also be **readable, consistent, and maintainable**.

## 1. 🔠 Use Uppercase for Keywords

Use uppercase for SQL keywords and functions.

```sql
SELECT
    name,
    COUNT(*) AS order_count
FROM customers
WHERE country = 'India'
GROUP BY name;
```

✅ `SELECT`, `FROM`, `WHERE`, `COUNT`, `GROUP BY`

---

## 2. 🐍 Use Lowercase / Snake Case for Names

Use lowercase or `snake_case` for:

* Tables
* Columns
* Schemas

```sql
customer_orders
order_date
customer_id
```

Avoid inconsistent naming styles.

> **Consistency is more important than the exact convention.**

---

## 3. 🏷️ Use Descriptive & Concise Aliases

Use aliases that clearly communicate what a table or calculated column represents.

```sql
SELECT
    c.name AS customer_name,
    COUNT(o.order_id) AS order_count
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
GROUP BY c.name;
```

✅ Good:

```text
c → customers
o → orders
order_count → meaningful calculated column
```

Avoid meaningless aliases such as:

```text
a, b, x, temp
```

unless the context is extremely simple.

---

## 4. 📐 Keep Formatting & Indentation Consistent

Format SQL so the query structure is easy to see.

```sql
SELECT
    customer_id,
    order_date,
    amount
FROM orders
WHERE amount > 1000
ORDER BY order_date DESC;
```

Good formatting makes complex queries easier to read and debug.

---

## 5. 🚫 Avoid `SELECT *`

Instead of:

```sql
SELECT *
FROM customers;
```

Prefer:

```sql
SELECT
    customer_id,
    name,
    email
FROM customers;
```

### Why?

* 🎯 Makes it clear which columns are required
* 📖 Improves readability
* ⚡ Can avoid retrieving unnecessary data
* 🛠️ Makes queries more maintainable

---

## 6. 🔗 Use JOINs Explicitly

Be explicit about how tables are joined.

```sql
SELECT
    c.name,
    o.order_id
FROM customers AS c
INNER JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

Avoid unclear or implicit join logic.

---

## 7. 🔀 Specify the JOIN Type

Don't rely on an unspecified/default join when clarity matters.

```sql
INNER JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN
```

For example:

```sql
FROM customers AS c
LEFT JOIN orders AS o
    ON c.customer_id = o.customer_id;
```

This makes your intention immediately clear.

---

## 8. 📅 Format Dates Consistently

Use an unambiguous date format such as:

```text
YYYY-MM-DD
```

Example:

```sql
WHERE order_date >= '2026-01-01'
```

Avoid ambiguous formats such as:

```text
01/02/2026
```

because different systems may interpret them differently.

---

## 9. 💬 Comment Wisely

Comments should explain **why** something is being done, not simply repeat the SQL.

### ❌ Not useful

```sql
-- Select customer name
SELECT name
FROM customers;
```

### ✅ Useful

```sql
-- Exclude test customers from production metrics
SELECT
    name
FROM customers
WHERE is_test_customer = FALSE;
```

Use comments when they provide useful context.

---

# 🧠 Quick Checklist

Before considering your SQL finished:

* [ ] 🔠 Keywords are uppercase
* [ ] 🐍 Names use consistent `snake_case`
* [ ] 🏷️ Aliases are short and meaningful
* [ ] 📐 Formatting and indentation are consistent
* [ ] 🚫 Avoid unnecessary `SELECT *`
* [ ] 🔗 JOINs are explicit
* [ ] 🔀 JOIN type is clear
* [ ] 📅 Dates use a consistent format
* [ ] 💬 Comments explain useful context

### ⭐ Remember

> **Good SQL = Correct + Readable + Consistent + Maintainable**
