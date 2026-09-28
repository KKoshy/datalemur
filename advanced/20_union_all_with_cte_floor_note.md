# SQL Interview Prep: Prime Warehouse Storage

**Problem:** [DataLemur --- Prime Warehouse
Storage](https://datalemur.com/questions/prime-warehouse-storage)

## 1. Problem summary

A warehouse has a fixed storage capacity. It stores two inventory
categories:

-   **Prime-eligible items:** These must be prioritized.
-   **Not-prime items:** These can use only the space left after storing
    the maximum possible number of prime-eligible batches.

Items within each category are stored together as a complete batch. The
goal is to return the total number of individual items stored for each
category.

> Key idea: Calculate the area and item count of one batch per category,
> maximize prime batches first, then use the remaining area for
> not-prime batches.

## 2. Solution approach

Let the warehouse capacity be `500000` square feet.

### Step 1: Summarize each inventory category

For each `item_type`, calculate:

-   `SUM(square_footage)`: area required for one complete batch.
-   `COUNT(*)`: number of individual items in that batch.

``` sql
WITH inventory_summary AS (
    SELECT
        item_type,
        SUM(square_footage) AS total_sqft,
        COUNT(*) AS item_count
    FROM inventory
    GROUP BY item_type
)
SELECT *
FROM inventory_summary;
```

This produces one row per category, with the batch area and number of
items.

### Step 2: Find the maximum number of prime batches

Divide the warehouse capacity by the area of one prime batch. Use
`FLOOR()` because only complete batches can be stored.

``` sql
FLOOR(500000 / prime_total_sqft)
```

### Step 3: Calculate the remaining space

Subtract the area occupied by the prime batches from the total warehouse
capacity.

``` sql
500000 - (prime_batch_count * prime_total_sqft)
```

### Step 4: Find the maximum number of not-prime batches

Divide the remaining area by the area of one not-prime batch, again
using `FLOOR()`.

``` sql
FLOOR(remaining_sqft / not_prime_total_sqft)
```

### Step 5: Convert batches into individual item counts

For each category:

``` sql
batch_count * item_count
```

Do not confuse the number of batches with the number of individual
items.

## 3. Complete PostgreSQL solution

``` sql
WITH inventory_summary AS (
    SELECT
        item_type,
        SUM(square_footage) AS total_sqft,
        COUNT(*) AS item_count
    FROM inventory
    GROUP BY item_type
),

prime_batches AS (
    SELECT
        FLOOR(500000 / total_sqft) AS batch_count,
        total_sqft,
        item_count
    FROM inventory_summary
    WHERE item_type = 'prime_eligible'
),

remaining_space AS (
    SELECT
        500000 - (batch_count * total_sqft) AS sqft
    FROM prime_batches
),

non_prime_batches AS (
    SELECT
        FLOOR(r.sqft / i.total_sqft) AS batch_count,
        i.item_count
    FROM remaining_space AS r
    CROSS JOIN inventory_summary AS i
    WHERE i.item_type = 'not_prime'
)

SELECT
    'prime_eligible' AS item_type,
    p.batch_count * p.item_count AS item_count
FROM prime_batches AS p

UNION ALL

SELECT
    'not_prime' AS item_type,
    n.batch_count * n.item_count AS item_count
FROM non_prime_batches AS n

ORDER BY item_type DESC;
```

## 4. Understand the CTEs

  -----------------------------------------------------------------------
  CTE                                 Responsibility
  ----------------------------------- -----------------------------------
  `inventory_summary`                 Computes the total area and item
                                      count for one batch of each
                                      category.

  `prime_batches`                     Calculates how many complete prime
                                      batches fit in the full warehouse.

  `remaining_space`                   Computes the area left after
                                      storing those prime batches.

  `non_prime_batches`                 Calculates how many complete
                                      not-prime batches fit in the
                                      remaining area.
  -----------------------------------------------------------------------

The final query converts each batch count to an individual item count
and combines the two category results.

## 5. Why `CROSS JOIN`?

The `remaining_space` CTE returns one row containing the unused area.
The `inventory_summary` CTE contains one row for each item category.

The `CROSS JOIN` pairs the remaining-space value with the summary rows.
The `WHERE` clause then selects only the `not_prime` row.

Since the remaining-space CTE has one row, this is a simple way to make
that value available alongside the not-prime batch area and item count.

## 6. Why `UNION ALL` instead of `UNION`?

The final query combines the prime and not-prime results.

-   `UNION` combines results and removes duplicate complete rows.
-   `UNION ALL` combines results and retains all rows.

Here, the categories have different `item_type` values, so the two
result rows cannot be duplicates. `UNION ALL` avoids unnecessary
duplicate elimination.

## 7. Important SQL concepts

  -----------------------------------------------------------------------
  Concept                             Why it is used
  ----------------------------------- -----------------------------------
  `GROUP BY`                          Groups inventory by category.

  `SUM()`                             Calculates the area of a complete
                                      batch.

  `COUNT(*)`                          Counts individual items in a batch.

  `FLOOR()`                           Ensures only whole batches are
                                      counted.

  CTEs (`WITH`)                       Breaks the calculation into
                                      readable, logical steps.

  `CROSS JOIN`                        Makes the single remaining-space
                                      value available to the not-prime
                                      calculation.

  `UNION ALL`                         Combines the two category results
                                      without deduplication.
  -----------------------------------------------------------------------

## 8. Common mistakes

1.  **Counting batches instead of items.** Multiply the number of
    complete batches by the number of items in each batch.
2.  **Allocating not-prime items first.** Prime-eligible batches must be
    maximized before using the leftover space.
3.  **Using `ROUND()` instead of `FLOOR()`.** Rounding can produce a
    batch count that exceeds available capacity.
4.  **Forgetting that all items in a category form a batch.** The batch
    area is the sum of the category's item areas.
5.  **Using `UNION` unnecessarily.** If the output categories are
    distinct, `UNION ALL` is sufficient and avoids duplicate-removal
    work.

## 9. Interview-ready explanation

> First, I aggregate the inventory by item type to find the total square
> footage and number of items in each batch. I calculate the maximum
> number of prime-eligible batches that fit in the warehouse using
> `FLOOR()`. Then I subtract the space occupied by those batches to get
> the remaining capacity. I use that leftover space to calculate the
> maximum number of not-prime batches. Finally, I multiply each batch
> count by its item count and combine the two results with `UNION ALL`.

## 10. Quick revision checklist

-   [ ] Aggregate each category's batch area and item count.
-   [ ] Maximize prime-eligible batches using `FLOOR()`.
-   [ ] Calculate the leftover warehouse capacity.
-   [ ] Fit as many complete not-prime batches as possible.
-   [ ] Convert batch counts to individual item counts.
-   [ ] Return one row per category.

**Core pattern to remember:**
`Summarize → Prioritize → Calculate remainder → Fit next category → Convert batches to items`.
