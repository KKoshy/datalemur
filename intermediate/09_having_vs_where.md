### WHERE vs. HAVING

The difference between **WHERE** vs. **HAVING** is a common conceptual SQL interview question, so we'd figured we'd cover it a bit more explicitly:

- **WHERE** filters on values in individual rows.
- **HAVING** filters values aggregated from groups of rows.

Here's a summary table on the difference between `WHERE` & `HAVING`:

| **Aspect** | **WHERE** | **HAVING** |
|---|---|---|
| **When It Filters** | Values **BEFORE** Grouping | Values **AFTER** Grouping |
| **Operates On Data From** | Individual Rows | Aggregated Values from Groups of Rows |
| **Example** | `SELECT username, followers FROM instagram_data WHERE followers > 1000;` | `SELECT country FROM instagram_data GROUP BY country HAVING AVG(followers) > 100;` |

### Where should HAVING be placed in a query?
It's CRUCIAL to write clauses in the correct order, otherwise, your SQL query won't run!

Here's the order for the commands you've learned so far:

- SELECT
- FROM
- WHERE
- GROUP BY
- HAVING
- ORDER BY
