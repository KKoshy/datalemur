# INNER JOIN vs OUTER JOIN

## 🔗 JOIN Types

```text
JOIN
│
├── INNER JOIN
│
└── OUTER JOIN
    │
    ├── LEFT OUTER JOIN
    ├── RIGHT OUTER JOIN
    └── FULL OUTER JOIN
```

### 1. INNER JOIN

Returns **only matching rows** from both tables.

```sql
SELECT *
FROM artists
INNER JOIN songs
    ON artists.artist_id = songs.artist_id;
```

> **INNER JOIN → Only matching records**

---

### 2. OUTER JOIN

Outer joins preserve unmatched rows from one or both tables.

There are three types:

| Join               | Keeps                                                       |
| ------------------ | ----------------------------------------------------------- |
| `LEFT OUTER JOIN`  | All rows from the left table + matching rows from the right |
| `RIGHT OUTER JOIN` | All rows from the right table + matching rows from the left |
| `FULL OUTER JOIN`  | All rows from both tables                                   |

The keyword `OUTER` is optional:

```sql
LEFT JOIN          -- same as LEFT OUTER JOIN
RIGHT JOIN         -- same as RIGHT OUTER JOIN
FULL JOIN          -- same as FULL OUTER JOIN
```

---

## 🧠 Easy Mental Model

### INNER JOIN

```text
A ∩ B
```

Only the **intersection/matching rows**.

### LEFT JOIN

```text
A + matching rows from B
```

Everything from **A**, plus matching rows from B.

### RIGHT JOIN

```text
matching rows from A + B
```

Everything from **B**, plus matching rows from A.

### FULL OUTER JOIN

```text
A ∪ B
```

Everything from **both tables**.

---

## ⭐ Quick Summary

```text
INNER JOIN
→ Only matching rows

LEFT JOIN
→ Everything from LEFT + matching RIGHT

RIGHT JOIN
→ Everything from RIGHT + matching LEFT

FULL JOIN
→ Everything from BOTH
```

### Key Point

> **INNER JOIN is not an OUTER JOIN.**
>
> **LEFT, RIGHT, and FULL are types of OUTER JOIN.**
