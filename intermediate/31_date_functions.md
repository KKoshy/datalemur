# SQL Date & Time Functions

> PostgreSQL-focused quick reference for working with dates and timestamps.

## 1. Current Date & Time

| Function            | Returns             |
| ------------------- | ------------------- |
| `CURRENT_DATE`      | Current date        |
| `CURRENT_TIME`      | Current time        |
| `CURRENT_TIMESTAMP` | Current date + time |
| `NOW()`             | Current date + time |

```sql
SELECT
    CURRENT_DATE,
    CURRENT_TIME,
    CURRENT_TIMESTAMP;
```

---

## 2. Comparing Dates

Use normal comparison operators with dates/timestamps:

```sql
WHERE sent_date > '2022-08-10'
WHERE sent_date >= '2022-08-10'
WHERE sent_date < '2022-08-10'
WHERE sent_date <= '2022-08-10'
WHERE sent_date = '2022-08-10'
```

### Common use

```sql
SELECT *
FROM messages
WHERE sent_date >= '2022-08-10';
```

> `>=` and `<=` include the boundary value.

---

## 3. EXTRACT()

Use `EXTRACT()` to retrieve a specific component from a date/timestamp.

```sql
EXTRACT(YEAR FROM sent_date)
EXTRACT(MONTH FROM sent_date)
EXTRACT(DAY FROM sent_date)
EXTRACT(HOUR FROM sent_date)
EXTRACT(MINUTE FROM sent_date)
```

Example:

```sql
SELECT
    EXTRACT(YEAR FROM sent_date) AS year,
    EXTRACT(MONTH FROM sent_date) AS month,
    EXTRACT(DAY FROM sent_date) AS day
FROM messages;
```

### DATE_PART()

`DATE_PART()` can be used similarly:

```sql
DATE_PART('year', sent_date)
DATE_PART('month', sent_date)
DATE_PART('day', sent_date)
```

> **Remember:** `EXTRACT()` and `DATE_PART()` are used to **get a part** of a date.

---

## 4. DATE_TRUNC()

`DATE_TRUNC()` **rounds down** a date/timestamp to a specified level.

```sql
DATE_TRUNC('month', sent_date)
DATE_TRUNC('day', sent_date)
DATE_TRUNC('hour', sent_date)
```

Example:

```sql
SELECT DATE_TRUNC('month', sent_date)
FROM messages;
```

If:

```text
2022-08-03 16:43:00
```

Then:

```text
DATE_TRUNC('month', ...) → 2022-08-01 00:00:00
DATE_TRUNC('day', ...)   → 2022-08-03 00:00:00
DATE_TRUNC('hour', ...)  → 2022-08-03 16:00:00
```

> **EXTRACT = get a component**
> **DATE_TRUNC = round down to a component**

---

## 5. INTERVAL

Use `INTERVAL` to add or subtract time.

```sql
sent_date + INTERVAL '2 days'
sent_date - INTERVAL '3 days'

sent_date + INTERVAL '2 hours'
sent_date - INTERVAL '10 minutes'
```

Example:

```sql
SELECT
    sent_date,
    sent_date + INTERVAL '7 days' AS next_week,
    sent_date - INTERVAL '1 day' AS previous_day
FROM messages;
```

---

## 6. TO_CHAR()

`TO_CHAR()` converts a date/timestamp into a **formatted string**.

```sql
TO_CHAR(sent_date, 'YYYY-MM-DD')
```

Common formats:

| Format                     | Example                  |
| -------------------------- | ------------------------ |
| `'YYYY-MM-DD'`             | `2023-08-27`             |
| `'YYYY-MM-DD HH24:MI:SS'`  | `2023-08-27 14:30:00`    |
| `'YYYY-MM-DD HH:MI:SS AM'` | `2023-08-27 02:30:00 PM` |
| `'Mon DD, YYYY'`           | `Aug 27, 2023`           |
| `'DD Month YYYY'`          | `27 August 2023`         |
| `'Month'`                  | `August`                 |
| `'Day'`                    | `Sunday`                 |

Example:

```sql
SELECT TO_CHAR(
    sent_date,
    'YYYY-MM-DD HH24:MI:SS'
) AS formatted_date
FROM messages;
```

---

## 7. Convert Strings → Date / Timestamp

### String → DATE

```sql
'2023-08-27'::DATE
```

or:

```sql
TO_DATE('2023-08-27', 'YYYY-MM-DD')
```

### String → TIMESTAMP

```sql
'2023-08-27 10:30:00'::TIMESTAMP
```

or:

```sql
TO_TIMESTAMP(
    '2023-08-27 10:30:00',
    'YYYY-MM-DD HH:MI:SS'
)
```

### Quick comparison

| Operation               | Function                         |
| ----------------------- | -------------------------------- |
| String → Date           | `::DATE` / `TO_DATE()`           |
| String → Timestamp      | `::TIMESTAMP` / `TO_TIMESTAMP()` |
| Date → Formatted string | `TO_CHAR()`                      |

---

# ⭐ Quick Cheat Sheet

```text
CURRENT_DATE       → Today's date
CURRENT_TIME       → Current time
CURRENT_TIMESTAMP  → Current date + time

EXTRACT()          → Get part of date
DATE_PART()        → Get part of date

DATE_TRUNC()       → Round date down

INTERVAL            → Add/subtract time

TO_CHAR()           → Date → formatted string

::DATE              → Convert to date
TO_DATE()           → Convert string → date

::TIMESTAMP         → Convert to timestamp
TO_TIMESTAMP()      → Convert string → timestamp
```

## 🧠 Most Important Interview Patterns

### Get year/month/day

```sql
EXTRACT(YEAR FROM date_column)
EXTRACT(MONTH FROM date_column)
EXTRACT(DAY FROM date_column)
```

### Group by month

```sql
DATE_TRUNC('month', date_column)
```

### Add/subtract dates

```sql
date_column + INTERVAL '7 days'
date_column - INTERVAL '1 month'
```

### Find first/last date

```sql
MIN(date_column)
MAX(date_column)
```

### Format a date

```sql
TO_CHAR(date_column, 'YYYY-MM-DD')
```

### Filter by date

```sql
WHERE date_column >= '2023-01-01'
  AND date_column < '2024-01-01'
```

> **Key distinction to remember:**
> `EXTRACT()` **gets** a date component, while `DATE_TRUNC()` **rounds down** to that component.
