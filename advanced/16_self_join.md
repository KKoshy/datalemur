# 🤝 SQL SELF JOIN

A **SELF JOIN** is when a table is joined **with itself**.

Think of it as treating the same table as **two different tables** by using aliases.

---

## 🧠 Basic Syntax

```sql
SELECT
    a.column1,
    b.column2
FROM table_name AS a
JOIN table_name AS b
    ON a.some_column = b.some_column;
```

### Key idea

```text
Same Table
    ↓
 ┌───────┐
 │   A   │ ← first copy
 └───────┘
     ↕ JOIN
 ┌───────┐
 │   B   │ ← second copy
 └───────┘
```

`A` and `B` are just **aliases** for the same table.

---

## 📚 Example: Find Books in the Same Genre

Suppose we have:

```text
books
--------------------------------
book_id | book_name | genre
1       | Book A    | Fiction
2       | Book B    | Fiction
3       | Book C    | History
```

We can use a self-join to find books belonging to the same genre:

```sql
SELECT
    a.genre,
    a.book_name AS current_book,
    b.book_name AS suggested_book
FROM books AS a
JOIN books AS b
    ON a.genre = b.genre
WHERE a.book_id <> b.book_id;
```

### Why `a.book_id <> b.book_id`?

Without this condition:

```text
Book A → Book A
Book B → Book B
```

A book could be recommended **to itself**.

So we exclude rows where both IDs are the same.

---

## 👨‍💼 Example: Employee vs Manager

Self-joins are especially useful for **hierarchical relationships**.

Example:

```text
employee_id | name  | salary | manager_id
1           | Emma  | 3800   | 6
6           | Liam  | 13000  | NULL
```

Here, `manager_id` refers back to another `employee_id` in the **same table**.

```sql
SELECT
    e.name AS employee,
    e.salary AS employee_salary,
    m.name AS manager,
    m.salary AS manager_salary
FROM employees AS e
JOIN employees AS m
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;
```

### 🧠 How to think about it

```text
employees table

       employee
          ↓
       ┌──────┐
       │  e   │
       └──┬───┘
          │ manager_id
          ↓
       ┌──────┐
       │  m   │
       └──────┘
        manager
```

We use:

* `e` → employee
* `m` → manager

Even though both come from the **same table**.

---

## 🔥 Common Uses

Self-joins are useful for:

* 👨‍💼 Employee → Manager relationships
* 👥 Finding related users
* 📚 Finding similar books/products
* 🔄 Comparing rows within the same table
* 🌳 Hierarchical data
* 🔍 Finding duplicate or related records

---

## ⚠️ Important: Self-Joins Can Create Many Rows

Joining a table with itself can produce a **large number of combinations**.

For example:

```text
A × B
```

If there are many matching rows, the result can grow quickly.

Therefore, use conditions carefully:

```sql
ON a.genre = b.genre
WHERE a.book_id <> b.book_id
```

The DataLemur example specifically warns that self-joins can create many matches on larger datasets.

---

## 🆚 SELF JOIN vs NORMAL JOIN

| Join        | Tables                       |
| ----------- | ---------------------------- |
| `JOIN`      | Usually two different tables |
| `SELF JOIN` | Same table joined to itself  |

Technically, **SELF JOIN isn't a separate SQL join type**.

It's simply a normal `JOIN` where the **same table appears twice with different aliases**.

---

## ⭐ Key Takeaways

1. **SELF JOIN = table joined with itself.**
2. Use **aliases** to distinguish the two copies.
3. `a` and `b` represent the same underlying table.
4. `WHERE a.id <> b.id` can prevent matching a row with itself.
5. Very useful for **hierarchical data** like employee → manager.
6. Can generate **many rows**, so choose join conditions carefully.
7. Self-join is especially common in **SQL interview questions**.

### 🧠 Easy way to remember

> **SELF JOIN = Same table, two roles.** 🤝
>
> Employee ↔ Manager
> Current Book ↔ Suggested Book
> User ↔ Related User
