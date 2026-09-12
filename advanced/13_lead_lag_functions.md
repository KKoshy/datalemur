# 📈 SQL Time-Series Window Functions: LEAD() & LAG()

`LEAD()` and `LAG()` are **window functions** used to access values from another row relative to the current row.

Think of:

* 🔮 `LEAD()` → Look **forward**
* ⏪ `LAG()` → Look **backward**

They are especially useful for **time-series data**.

---

## 🧠 Basic Syntax

```sql
LEAD(column, offset) OVER (
    ORDER BY column
)

LAG(column, offset) OVER (
    ORDER BY column
)
```

* `column` → Value you want to retrieve
* `offset` → Number of rows to move
* `ORDER BY` → Determines what "next" and "previous" mean
* Default `offset` = `1`

---

## 🔮 LEAD()

Returns a value from a row **after the current row**.

```sql
SELECT
    date,
    close,
    LEAD(close) OVER (ORDER BY date) AS next_close
FROM stocks;
```

| date | close | next_close |
| ---- | ----: | ---------: |
| Jan  |   100 |        110 |
| Feb  |   110 |        120 |
| Mar  |   120 |       NULL |

👉 `LEAD()` looks into the **future**.

---

## ⏪ LAG()

Returns a value from a row **before the current row**.

```sql
SELECT
    date,
    close,
    LAG(close) OVER (ORDER BY date) AS previous_close
FROM stocks;
```

| date | close | previous_close |
| ---- | ----: | -------------: |
| Jan  |   100 |           NULL |
| Feb  |   110 |            100 |
| Mar  |   120 |            110 |

👉 `LAG()` looks into the **past**.

---

## 🔢 Offset

The second argument controls how many rows to look ahead/behind.

```sql
LAG(close, 1) OVER (ORDER BY date)
```

→ Previous row

```sql
LAG(close, 3) OVER (ORDER BY date)
```

→ 3 rows earlier

Similarly:

```sql
LEAD(close, 2) OVER (ORDER BY date)
```

→ 2 rows later

---

## 📊 Comparing Consecutive Values

A common use is calculating the difference between rows.

### Current vs Previous

```sql
SELECT
    date,
    close,
    close - LAG(close) OVER (ORDER BY date) AS difference
FROM stocks;
```

### Current vs Next

```sql
SELECT
    date,
    close,
    LEAD(close) OVER (ORDER BY date) - close AS difference
FROM stocks;
```

This is useful for detecting:

* 📈 Growth
* 📉 Decline
* 🔄 Changes over time
* 📊 Trends

---

## 🗂️ LEAD vs LAG

| Function | Direction   | Meaning      |
| -------- | ----------- | ------------ |
| `LEAD()` | ➡️ Forward  | Next row     |
| `LAG()`  | ⬅️ Backward | Previous row |

### Easy way to remember

> **LEAD = Future 🔮**
> **LAG = Past ⏪**

---

## 💡 Real-World Uses

* 🛍️ **Sales** → Compare today's sales with tomorrow's
* 🌎 **Web analytics** → Compare current vs previous/next page views
* 🚚 **Logistics** → Compare current trip with previous trip
* 📈 **Stocks** → Compare current price with previous/next price
* 📚 **Education** → Compare current grade with previous semester

---

## ⭐ Key Takeaways

1. `LEAD()` → gets a value from a **future row**.
2. `LAG()` → gets a value from a **previous row**.
3. Both are **window functions**, not aggregate functions.
4. `ORDER BY` determines the row sequence.
5. Default offset is `1`.
6. Use the offset to look multiple rows away.
7. The first `LAG()` or last `LEAD()` row will normally return `NULL`.
8. Very useful for **time-series comparisons and trend analysis**.
