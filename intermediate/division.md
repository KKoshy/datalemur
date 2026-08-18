# How to Divide Integers and Return Decimal/Float Output?

In SQL, dividing two integers can result in **integer division**, where the decimal portion is discarded.

```sql
SELECT 10 / 4;
```

Output:

```text
2
```

However, we may want:

```text
2.5
```

To get a decimal/float result, we can use one of the following approaches:

1. `CAST()`
2. Multiplication by `1.0`
3. Explicit type casting using `::DECIMAL` or `::FLOAT`

---

## 1. Using `CAST()`

`CAST()` converts an integer into another data type, such as `DECIMAL` or `FLOAT`.

```sql
SELECT CAST(10 AS DECIMAL) / 4;
```

Output:

```text
2.5
```

You only need to convert **one of the operands**.

```sql
SELECT 10 / CAST(4 AS DECIMAL);
```

The same concept can be used with `FLOAT`:

```sql
SELECT CAST(10 AS FLOAT) / 4;
```

### Key Point

> Convert at least one operand to a decimal/float before performing the division.

---

## 2. Multiplying by `1.0`

Another simple way to force decimal division is to multiply one of the operands by `1.0`.

```sql
SELECT 10 * 1.0 / 4;
```

Output:

```text
2.5
```

Why does this work?

```sql
10 * 1.0
```

converts the integer `10` into a decimal/float value.

The division then becomes:

```text
10.0 / 4
```

which produces:

```text
2.5
```

For example:

```sql
SELECT 10 / 6;
```

may produce:

```text
1
```

But:

```sql
SELECT 10 * 1.0 / 6;
```

produces:

```text
1.6666666666666667
```

### Key Point

> Multiplying an integer or expression by `1.0` converts it to a decimal/float type and allows decimal output.

---

## 3. Using `::DECIMAL` or `::FLOAT`

Some SQL databases, such as PostgreSQL, support the `::` syntax for explicitly converting data types.

### Using `::DECIMAL`

```sql
SELECT 10::DECIMAL / 4;
```

Output:

```text
2.5
```

### Using `::FLOAT`

```sql
SELECT 10::FLOAT / 4;
```

Output:

```text
2.5
```

Again, only one operand needs to be converted:

```sql
SELECT 10 / 4::DECIMAL;
```

or:

```sql
SELECT 10 / 4::FLOAT;
```

### Key Point

> `::DECIMAL` and `::FLOAT` explicitly tell SQL to perform the division using a decimal/float data type.

---

## 4. Quick Comparison

| Method            | Example                   | Result |
| ----------------- | ------------------------- | -----: |
| Integer division  | `10 / 4`                  |    `2` |
| `CAST()`          | `CAST(10 AS DECIMAL) / 4` |  `2.5` |
| Multiply by `1.0` | `10 * 1.0 / 4`            |  `2.5` |
| `::DECIMAL`       | `10::DECIMAL / 4`         |  `2.5` |
| `::FLOAT`         | `10::FLOAT / 4`           |  `2.5` |

---

## 5. Why This Matters for Percentages

This is particularly important when calculating percentages.

The basic formula is:

```text
(part / total) * 100
```

Suppose:

```text
part  = 3
total = 4
```

If both values are integers:

```sql
SELECT 3 / 4 * 100;
```

The integer division may produce:

```text
0
```

and therefore:

```text
0 * 100 = 0
```

Instead, make one operand a decimal:

```sql
SELECT 3 * 1.0 / 4 * 100;
```

Output:

```text
75.0
```

Or use `CAST()`:

```sql
SELECT CAST(3 AS DECIMAL) / 4 * 100;
```

Output:

```text
75.0
```

---

## 6. Division with `ROUND()`

If you want to control the number of decimal places, use `ROUND()` after performing decimal division.

```sql
SELECT ROUND(10 * 1.0 / 6, 2);
```

Output:

```text
1.67
```

Or:

```sql
SELECT ROUND(CAST(10 AS DECIMAL) / 6, 2);
```

Output:

```text
1.67
```

### Important

Make sure the conversion happens **before** the division.

Incorrect:

```sql
SELECT ROUND(10 / 6, 2);
```

If `10 / 6` performs integer division first, SQL gets:

```text
1
```

Rounding `1` cannot recover the lost decimal portion.

Correct:

```sql
SELECT ROUND(CAST(10 AS DECIMAL) / 6, 2);
```

The process is:

```text
Convert → Divide → Round
```

---

## 7. Common SQL Interview Pattern

A common SQL interview requirement is to calculate a ratio or percentage from two integer columns.

For example:

```sql
SELECT
    actual_sales,
    target_sales,
    actual_sales * 1.0 / target_sales * 100 AS percentage
FROM sales;
```

Alternatively:

```sql
SELECT
    actual_sales,
    target_sales,
    CAST(actual_sales AS DECIMAL) / target_sales * 100 AS percentage
FROM sales;
```

If the result needs to be rounded:

```sql
SELECT
    actual_sales,
    target_sales,
    ROUND(
        CAST(actual_sales AS DECIMAL) / target_sales * 100,
        2
    ) AS percentage
FROM sales;
```

---

## 8. Remember This

### Integer division

```sql
SELECT 10 / 4;
-- 2
```

### Decimal division using `CAST()`

```sql
SELECT CAST(10 AS DECIMAL) / 4;
-- 2.5
```

### Decimal division using `1.0`

```sql
SELECT 10 * 1.0 / 4;
-- 2.5
```

### Decimal division using `::DECIMAL`

```sql
SELECT 10::DECIMAL / 4;
-- 2.5
```

### Decimal division with rounding

```sql
SELECT ROUND(CAST(10 AS DECIMAL) / 6, 2);
-- 1.67
```

---

## Key Takeaway

> **When dividing integers in SQL, convert at least one operand to a decimal/float before performing the division if you need the decimal portion of the result.**

The three common approaches are:

```sql
-- 1. CAST()
CAST(value AS DECIMAL) / other_value

-- 2. Multiply by 1.0
value * 1.0 / other_value

-- 3. Explicit type casting
value::DECIMAL / other_value
```

For SQL interview questions, **`CAST()`** is generally the clearest and most explicit approach.
