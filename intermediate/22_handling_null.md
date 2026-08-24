# SQL NULL - IS NULL, COALESCE and IFNULL

`NULL` represents a **missing or unknown value** in SQL. It is different from `0` or an empty string.

---

## 1. IS NULL

Use `IS NULL` to find rows where a column contains `NULL`.

```sql
SELECT *
FROM employees
WHERE department IS NULL;
```

### IS NOT NULL

Use `IS NOT NULL` to find rows where a column contains a value.

```sql
SELECT *
FROM employees
WHERE department IS NOT NULL;
```

> **Important:** Do not use `= NULL` or `!= NULL` to check for NULL values. Use `IS NULL` or `IS NOT NULL`.

---

## 2. COALESCE()

`COALESCE()` returns the **first non-NULL value** from a list of expressions.

### Syntax

```sql
COALESCE(value1, value2, value3, ...)
```

Example:

```sql
SELECT COALESCE(book_rating, 0) AS rating
FROM books;
```

If `book_rating` is `NULL`, the result is `0`. Otherwise, the original rating is returned.

### Multiple Values

```sql
SELECT COALESCE(phone, email, 'Not Available') AS contact
FROM customers;
```

SQL checks the values from left to right and returns the first one that is not `NULL`.

```text
phone → email → 'Not Available'
```

---

## 3. IFNULL()

`IFNULL()` replaces a `NULL` value with a specified value.

### Syntax

```sql
IFNULL(value, replacement)
```

Example:

```sql
SELECT IFNULL(book_rating, 0) AS rating
FROM books;
```

If `book_rating` is `NULL`, it returns `0`. Otherwise, it returns `book_rating`.

---

## 4. COALESCE() vs IFNULL()

| Function     | Purpose                                                    |
| ------------ | ---------------------------------------------------------- |
| `IS NULL`    | Checks whether a value is `NULL`                           |
| `COALESCE()` | Returns the first non-NULL value from multiple expressions |
| `IFNULL()`   | Replaces a `NULL` value with a specified value             |

### COALESCE()

Can work with multiple values:

```sql
COALESCE(value1, value2, value3)
```

Returns the first non-NULL value.

### IFNULL()

Works with two values:

```sql
IFNULL(value1, value2)
```

Returns `value2` if `value1` is `NULL`; otherwise, returns `value1`.

---

## Quick Examples

### Check for NULL

```sql
WHERE column_name IS NULL
```

### Replace NULL

```sql
COALESCE(column_name, 0)
```

### Replace NULL with IFNULL

```sql
IFNULL(column_name, 0)
```

### Remember

> `IS NULL` **checks** for NULL, while `COALESCE()` and `IFNULL()` **handle/replace** NULL values.
