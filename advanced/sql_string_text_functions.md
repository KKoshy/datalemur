# SQL String & Text Functions

String functions are used to **clean, transform, search, extract, and combine text data**.

---

## 1. UPPER() and LOWER()

Convert text to uppercase or lowercase.

```sql
SELECT
    UPPER(name) AS upper_name,
    LOWER(name) AS lower_name
FROM customers;
```

| Function  | Purpose                    |
| --------- | -------------------------- |
| `UPPER()` | Converts text to uppercase |
| `LOWER()` | Converts text to lowercase |

**Use case:** Standardizing names/text before searching or comparing.

---

## 2. LEFT() and RIGHT()

Extract characters from the beginning or end of a string.

```sql
SELECT
    LEFT(product_code, 2),
    RIGHT(product_code, 3)
FROM products;
```

| Function           | Purpose              |
| ------------------ | -------------------- |
| `LEFT(string, n)`  | First `n` characters |
| `RIGHT(string, n)` | Last `n` characters  |

**Example:**

```text
'UA93'

LEFT(..., 2)  → 'UA'
```

Useful for extracting prefixes, suffixes, product codes, etc.

---

## 3. LENGTH()

Returns the number of characters in a string.

```sql
SELECT LENGTH('Iron Man');
-- 8
```

Spaces are included in the count.

**Use case:** Checking text length or filtering strings based on length.

---

## 4. POSITION()

Finds the position of the **first occurrence** of a substring.

```sql
SELECT POSITION('man' IN 'Ironman');
-- 5
```

Syntax:

```sql
POSITION(substring IN string)
```

**Remember:** Positions start at **1**, not 0.

---

## 5. TRIM(), LTRIM(), RTRIM(), BTRIM()

Used to remove unwanted spaces/characters.

| Function  | Removes from |
| --------- | ------------ |
| `TRIM()`  | Both sides   |
| `LTRIM()` | Left side    |
| `RTRIM()` | Right side   |
| `BTRIM()` | Both sides   |

```sql
SELECT TRIM('  Spider-Man  ');
-- 'Spider-Man'
```
TRIM() is standard SQL; BTRIM() is PostgreSQL-specific.

**Use case:** Cleaning user input, names, emails, imported data, etc.

---

## 6. CONCAT()

Combines multiple strings into one string.

```sql
SELECT CONCAT(first_name, ' ', last_name)
FROM employees;
```

Example:

```text
'Peter' + ' ' + 'Parker'
        ↓
'Peter Parker'
```

**Use case:** Creating full names, email addresses, IDs, labels, etc.

---

## 7. CONCAT_WS()

`CONCAT_WS` = **CONCAT With Separator**

Combines strings while automatically inserting a separator.

```sql
SELECT CONCAT_WS(' - ', actor, character, superhero_alias)
FROM superheroes;
```

Result:

```text
Robert Downey Jr. - Tony Stark - Iron Man
```

### CONCAT vs CONCAT_WS

```sql
CONCAT(a, b, c)
```

→ joins without automatically adding separators.

```sql
CONCAT_WS(' - ', a, b, c)
```

→ joins using `' - '` between values.

---

## 8. SUBSTRING()

Extracts part of a string using a starting position and length.

```sql
SELECT SUBSTRING('Spider-Man', 1, 6);
-- Spider
```

Syntax:

```sql
SUBSTRING(string, start_position, length)
```

Negative positions can be used to count from the **end** in PostgreSQL.

```text
-1 → last character
-2 → second-last character
```

**Use case:** Extracting portions of IDs, timestamps, error codes, etc.

---

## 9. SPLIT_PART()

Extracts a specific section of a string based on a delimiter.

Syntax:

```sql
SPLIT_PART(string, delimiter, position)
```

Example:

```sql
SELECT SPLIT_PART('Spider-Man', '-', 1);
-- Spider
```

Another example:

```sql
SELECT SPLIT_PART('john.doe@gmail.com', '@', 2);
-- gmail.com
```

Useful when data contains structured text separated by:

```text
-
,
@
.
/
|
```

In PostgreSQL, negative positions can be used to count from the end.

---

# Quick Cheat Sheet

| Function       | What it does                             |
| -------------- | ---------------------------------------- |
| `UPPER()`      | Convert to uppercase                     |
| `LOWER()`      | Convert to lowercase                     |
| `LEFT()`       | Extract from the left                    |
| `RIGHT()`      | Extract from the right                   |
| `LENGTH()`     | Count characters                         |
| `POSITION()`   | Find substring position                  |
| `TRIM()`       | Remove characters/spaces from both sides |
| `LTRIM()`      | Remove from left                         |
| `RTRIM()`      | Remove from right                        |
| `BTRIM()`      | Remove from both sides                   |
| `CONCAT()`     | Join strings                             |
| `CONCAT_WS()`  | Join strings with separator              |
| `SUBSTRING()`  | Extract a portion of a string            |
| `SPLIT_PART()` | Extract a portion using a delimiter      |

---

# 🧠 Interview Memory

Think of SQL string functions in this order:

**Clean → Find → Extract → Combine**

```text
CLEAN
TRIM / LTRIM / RTRIM
UPPER / LOWER

FIND
POSITION
LENGTH

EXTRACT
LEFT / RIGHT
SUBSTRING
SPLIT_PART

COMBINE
CONCAT
CONCAT_WS
```

### Most important ones to practice

```text
UPPER / LOWER
TRIM
LEFT / RIGHT
SUBSTRING
SPLIT_PART
CONCAT / CONCAT_WS
POSITION
LENGTH
```
