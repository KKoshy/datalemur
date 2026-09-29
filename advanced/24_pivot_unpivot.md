# SQL Interview Prep: Pivoting and Unpivoting

**Study resource:** [DataLemur --- Pivoting and
Unpivoting](https://datalemur.com/sql-tutorial/pivoting-unpivoting)

## 1. Core idea

-   **Pivot:** Converts rows into columns.
-   **Unpivot:** Converts columns into rows.

Pivoting is useful for displaying categories side by side. Unpivoting
turns a wide table into a row-based structure.

## 2. Pivoting example

Suppose a `sales` table contains:

  store     product     units_sold
  --------- --------- ------------
  Store A   Laptop              10
  Store A   Phone               20
  Store B   Laptop              15
  Store B   Phone               25
  Store C   Laptop              12
  Store C   Phone               18

We want one row per store and separate columns for each product:

  store       Laptop   Phone
  --------- -------- -------
  Store A         10      20
  Store B         15      25
  Store C         12      18

### Conditional aggregation

A common way to pivot in SQL is to combine `CASE` expressions with an
aggregate function.

``` sql
SELECT
    store,
    SUM(CASE
        WHEN product = 'Laptop' THEN units_sold
        ELSE 0
    END) AS laptop,
    SUM(CASE
        WHEN product = 'Phone' THEN units_sold
        ELSE 0
    END) AS phone
FROM sales
GROUP BY store
ORDER BY store;
```

How it works: 1. `CASE` checks each row's product and returns its sales
value for the matching product. 2. `SUM()` aggregates those values for
each store. 3. `GROUP BY store` produces one output row per store. 4.
`ORDER BY` sorts the result; it is optional unless a particular order is
required.

**Remember:** `GROUP BY` determines the output rows, `CASE` determines
which values go into each output column, and the aggregate calculates
the result.

## 3. Choosing the aggregate function

  Function    Purpose
  ----------- ---------------------------------------------------
  `SUM()`     Total value per category
  `AVG()`     Average value per category
  `MAX()`     Highest value per category
  `MIN()`     Lowest value per category
  `COUNT()`   Count of matching records, with care around NULLs

### Example: average engagement by platform

Suppose a social-media table has `superhero_alias`, `platform`, and
`engagement_rate`. We want one row per superhero and a column for each
platform's average engagement rate.

``` sql
SELECT
    superhero_alias,
    AVG(CASE
        WHEN platform = 'Instagram' THEN engagement_rate
    END) AS instagram,
    AVG(CASE
        WHEN platform = 'Twitter' THEN engagement_rate
    END) AS twitter,
    AVG(CASE
        WHEN platform = 'TikTok' THEN engagement_rate
    END) AS tiktok,
    AVG(CASE
        WHEN platform = 'YouTube' THEN engagement_rate
    END) AS youtube
FROM sample_data
GROUP BY superhero_alias;
```

If a superhero has no records for a platform, that platform's result
will be `NULL`.

### Why omit `ELSE 0` when using `AVG()`?

``` sql
AVG(CASE
    WHEN platform = 'Instagram' THEN engagement_rate
END)
```

When the platform does not match, the `CASE` expression returns `NULL`.
`AVG()` ignores NULL values.

By contrast:

``` sql
AVG(CASE
    WHEN platform = 'Instagram' THEN engagement_rate
    ELSE 0
END)
```

This includes zeros for non-Instagram rows, which can incorrectly lower
the average. Omit `ELSE 0` for conditional averages unless zero is
genuinely intended.

## 4. Unpivoting example

Start with a wide, pivoted table:

  store       Laptop   Phone
  --------- -------- -------
  Store A         10      20
  Store B         15      25
  Store C         12      18

We want to convert it to:

  store     product     units_sold
  --------- --------- ------------
  Store A   Laptop              10
  Store A   Phone               20
  Store B   Laptop              15
  Store B   Phone               25
  Store C   Laptop              12
  Store C   Phone               18

### Unpivot with `UNION ALL`

A portable approach is to write one `SELECT` for each source column and
combine the results.

``` sql
SELECT
    store,
    'Laptop' AS product,
    laptop AS units_sold
FROM pivoted_sales

UNION ALL

SELECT
    store,
    'Phone' AS product,
    phone AS units_sold
FROM pivoted_sales

ORDER BY store, product;
```

How it works: 1. The first query converts the `Laptop` column into rows
and labels them `'Laptop'`. 2. The second query does the same for the
`Phone` column. 3. `UNION ALL` stacks the rows from both queries. 4.
`ORDER BY` sorts the final result.

Some database systems also provide a native `UNPIVOT` operator. Syntax
and support vary by database.

## 5. Pivot vs. unpivot

  -----------------------------------------------------------------------
  Pivot                               Unpivot
  ----------------------------------- -----------------------------------
  Rows → columns                      Columns → rows

  Often uses `CASE` with aggregation  Often uses `UNION ALL` or native
                                      `UNPIVOT`

  Commonly groups by an entity        Expands each selected column into
                                      labeled rows

  Useful for side-by-side summaries   Useful for normalizing wide data
                                      into row-based layout
  -----------------------------------------------------------------------

## 6. Important interview concepts

  -----------------------------------------------------------------------
  Interview question                  Key answer
  ----------------------------------- -----------------------------------
  Why use `GROUP BY` when pivoting?   To consolidate source rows into one
                                      row per entity, such as a store or
                                      superhero.

  Why use `CASE`?                     To route values into the
                                      appropriate output column based on
                                      a condition.

  Why use an aggregate?               Multiple source rows may contribute
                                      to the same output group and
                                      category.

  Why use `UNION ALL` for unpivoting? To stack rows generated from each
                                      original column without
                                      deduplicating them.

  Does unpivoting always restore the  Not always. Aggregation during
  exact original data?                pivoting may lose detail, and NULL
                                      handling can affect what is
                                      recovered.

  Is there a native `PIVOT` operator? Some databases, including SQL
                                      Server and Oracle, support it.
                                      Conditional aggregation is a widely
                                      applicable alternative; syntax
                                      varies by database.
  -----------------------------------------------------------------------

## 7. Common mistakes

1.  **Forgetting `GROUP BY`:** Without grouping, the query won't produce
    one row per entity as intended.
2.  **Using the wrong aggregate:** Choose `SUM`, `AVG`, `MAX`, `MIN`, or
    `COUNT` based on the requirement.
3.  **Using `ELSE 0` with `AVG()` carelessly:** Non-matching rows then
    contribute zeros and can distort the average.
4.  **Confusing pivot with sorting:** Pivoting changes the data's
    layout; `ORDER BY` only changes row order.
5.  **Assuming unpivot is lossless:** If the pivot aggregated several
    rows into one value, the original individual records cannot
    necessarily be reconstructed.
6.  **Using `UNION` instead of `UNION ALL` without a reason:** `UNION`
    removes duplicate complete rows; `UNION ALL` preserves them and is
    generally preferable when deduplication is unnecessary.

## 8. Quick practice questions

1.  You have sales records for many stores and products. You need one
    row per store and one column per product. Is this pivoting or
    unpivoting?
2.  What roles do `CASE`, `SUM()` and `GROUP BY` play in conditional
    aggregation?
3.  Why can `ELSE 0` produce a misleading conditional average?
4.  How can you turn `Laptop` and `Phone` columns into rows using
    standard SQL?
5.  Why might unpivoting a previously pivoted-and-aggregated table fail
    to reproduce every original row?

### Quick answers

1.  Pivoting.
2.  `CASE` selects values for each category, `SUM()` aggregates them,
    and `GROUP BY` defines the output groups.
3.  Zeros from non-matching rows are included in the average.
4.  Use separate `SELECT` statements with category labels and combine
    them using `UNION ALL`.
5.  Aggregation may have discarded the original row-level detail.

## 9. Interview-ready explanation

> Pivoting transforms row categories into columns, often using
> conditional aggregation: `CASE` selects values for each category, an
> aggregate such as `SUM()` or `AVG()` calculates them, and `GROUP BY`
> defines the output rows. Unpivoting reverses the layout by turning
> columns into labeled rows, commonly using `UNION ALL` or a
> database-specific `UNPIVOT` operator. The correct aggregate and NULL
> handling depend on the question.

## 10. One-minute revision

-   **Pivot:** rows → columns.
-   **Unpivot:** columns → rows.
-   **Conditional pivot pattern:** `GROUP BY` + `CASE` + aggregate.
-   **Conditional average:** usually omit `ELSE 0` so non-matching rows
    remain NULL and are ignored by `AVG()`.
-   **Unpivot pattern:** one `SELECT` per source column + `UNION ALL`.
-   **Caution:** Pivoting with aggregation can lose detail, so
    unpivoting may not reconstruct the exact original data.

**Memory aid:** *Pivot spreads categories across columns; unpivot stacks
those columns back into rows.*
