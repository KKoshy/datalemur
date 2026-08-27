<div align="center">

# 🧮 DataLemur SQL Practice

**A structured collection of SQL solutions, notes, and cheat sheets based on [DataLemur](https://datalemur.com/sql-tutorial)'s interview-prep curriculum.**

![SQL](https://img.shields.io/badge/SQL-PostgreSQL-336791?style=flat-square&logo=postgresql&logoColor=white)
![Status](https://img.shields.io/badge/status-active-brightgreen?style=flat-square)
![Made with](https://img.shields.io/badge/made%20with-%E2%98%95%20and%20queries-blueviolet?style=flat-square)

</div>

---

## 📖 About

A collection of solved query files and hand-written study notes based on **DataLemur's SQL interview tutorial**. It's organized by difficulty, doubling as a quick-reference cheat sheet for SQL interview prep.

Many of the problems mirror real questions asked by companies like **LinkedIn** and **JPMorgan Chase**, so beyond syntax, the notes lean into the *reasoning* behind each solution — not just the query that passes.

**40+ solved problems** across 3 difficulty levels, plus concept write-ups for the trickier topics.

### Contents

- [Repo Structure](#️-repo-structure)
- [Basics](#-basics)
- [Intermediate](#️-intermediate)
- [Advanced](#-advanced)
- [Notes on style](#-notes-on-style)
- [Resources](#-resources)

## 🗂️ Repo Structure

```text
datalemur/
├── basic/         # Fundamentals — filtering, sorting, pattern matching
├── intermediate/  # Aggregates, GROUP BY / HAVING, joins, NULLs, dates
└── advanced/      # Deeper concepts — CTEs vs. subqueries, and beyond
```

Each folder mixes two file types:

| Type | Purpose |
| --- | --- |
| `*.sql` | A worked solution to a specific DataLemur problem |
| `*.md`  | A concept write-up — syntax, examples, comparison tables, and interview-style takeaways |

## 🧱 Basics

Core query fundamentals — `SELECT`, filtering, and sorting.

| # | Topic | File |
| --- | --- | --- |
| 01 | `SELECT` basics | [`01_select.sql`](basic/01_select.sql) |
| 02 | `WHERE` clause | [`02_where.sql`](basic/02_where.sql) |
| 03 | `AND` operator | [`03_and_operator.sql`](basic/03_and_operator.sql) |
| 04 | `OR` operator | [`04_or_operator.sql`](basic/04_or_operator.sql) |
| 05 | `BETWEEN` | [`05_between.sql`](basic/05_between.sql) |
| 06 | `IN` operator | [`06_in_operator.sql`](basic/06_in_operator.sql) |
| 07 | Wildcard `%` | [`07_wildcard%.sql`](basic/07_wildcard%25.sql) |
| 08 | Wildcard `_` | [`08_wilcard_.sql`](basic/08_wilcard_.sql) |
| 09 | Combined filtering | [`09_filtering.sql`](basic/09_filtering.sql) |
| 10 | `ORDER BY` | [`10_order_by.sql`](basic/10_order_by.sql) |

## ⚙️ Intermediate

Aggregation, grouping, joins, `NULL` handling, and date logic — the workhorses of most interview questions.

<details>
<summary><b>Aggregate functions</b></summary>

| Topic | File |
| --- | --- |
| `COUNT` | [`01_count.sql`](intermediate/01_count.sql) |
| `SUM` | [`02_sum.sql`](intermediate/02_sum.sql) |
| `AVG` | [`03_avg.sql`](intermediate/03_avg.sql) |
| `MIN` | [`04_min.sql`](intermediate/04_min.sql) |
| `MAX` | [`05_max.sql`](intermediate/05_max.sql) |
| Aggregate functions — notes | [`06_aggregate_functions.md`](intermediate/06_aggregate_functions.md) |

</details>

<details>
<summary><b>GROUP BY & HAVING</b></summary>

| Topic | File |
| --- | --- |
| `GROUP BY` (I) | [`07_group_by_01.sql`](intermediate/07_group_by_01.sql) |
| `GROUP BY` (II) | [`08_group_by_02.sql`](intermediate/08_group_by_02.sql) |
| `HAVING` vs. `WHERE` — notes | [`09_having_vs_where.md`](intermediate/09_having_vs_where.md) |
| `HAVING` (I) | [`10_having_01.sql`](intermediate/10_having_01.sql) |
| `HAVING` (II) | [`11_having_02.sql`](intermediate/11_having_02.sql) |
| `HAVING` — LinkedIn question | [`12_having_linkedin.sql`](intermediate/12_having_linkedin.sql) |
| `DISTINCT` | [`13_distinct.sql`](intermediate/13_distinct.sql) |

</details>

<details>
<summary><b>Arithmetic & math functions</b></summary>

| Topic | File |
| --- | --- |
| Arithmetic operators — notes | [`14_arithmetic_operators.md`](intermediate/14_arithmetic_operators.md) |
| Subtraction operator | [`15_sub_operator.sql`](intermediate/15_sub_operator.sql) |
| Arithmetic — JPMorgan Chase question | [`16_arithmetic_jp_morgan.sql`](intermediate/16_arithmetic_jp_morgan.sql) |
| `ABS` | [`17_abs.sql`](intermediate/17_abs.sql) |
| Math functions — notes | [`18_math_functions.md`](intermediate/18_math_functions.md) |
| `CEIL` | [`19_ceil.sql`](intermediate/19_ceil.sql) |
| Division — notes | [`20_division.md`](intermediate/20_division.md) |

</details>

<details>
<summary><b>NULLs & CASE logic</b></summary>

| Topic | File |
| --- | --- |
| `IS NULL` | [`21_is_null.sql`](intermediate/21_is_null.sql) |
| Handling `NULL` — notes | [`22_handling_null.md`](intermediate/22_handling_null.md) |
| `CASE` in `SELECT` | [`23_case_select.sql`](intermediate/23_case_select.sql) |
| `CASE` with `SUM` | [`24_case_select_sum.sql`](intermediate/24_case_select_sum.sql) |
| `CASE` statement — notes | [`25_case_statement.md`](intermediate/25_case_statement.md) |

</details>

<details>
<summary><b>Joins</b></summary>

| Topic | File |
| --- | --- |
| Basic `JOIN` | [`26_join.sql`](intermediate/26_join.sql) |
| `JOIN` + `GROUP BY` | [`27_join_groupby.sql`](intermediate/27_join_groupby.sql) |
| 4 types of joins — notes | [`28_joins.md`](intermediate/28_joins.md) |
| `JOIN` with `NULL` handling | [`29_join_null.sql`](intermediate/29_join_null.sql) |
| `JOIN` with `CASE` | [`30_join_with_case.sql`](intermediate/30_join_with_case.sql) |

</details>

<details>
<summary><b>Dates</b></summary>

| Topic | File |
| --- | --- |
| Date functions — notes | [`31_date_functions.md`](intermediate/31_date_functions.md) |
| `EXTRACT` | [`32_date_function_extract.sql`](intermediate/32_date_function_extract.sql) |
| `INTERVAL` | [`33_date_function_interval.sql`](intermediate/33_date_function_interval.sql) |

</details>

## 🚀 Advanced

More advanced topics will be added here over time.

| Topic | File |
| --- | --- |
| CTEs vs. subqueries — notes | [`cte_vs_subqueries.md`](advanced/cte_vs_subqueries.md) |

## 📝 Notes on style

- All solutions are written in **PostgreSQL** syntax (DataLemur's default execution environment).
- `.md` notes favor **comparison tables and "golden rule" summaries** over long prose — built to be skimmed the night before an interview.
- Files are numbered in the order the concepts were tackled, roughly following DataLemur's own tutorial progression from basic filtering to joins and date logic.

## 🔗 Resources

- [DataLemur SQL Tutorial](https://datalemur.com/sql-tutorial) — the source curriculum for every problem in this repo.

---

<div align="center">

*Practice repo — solutions are for personal learning. Try the problems yourself on DataLemur before peeking!*

</div>
