### SQL Arithmetic Operator Summary

Here's a summary table that describes how the arithmetic operators in SQL work:

| **Operator** | **Description** | **Example** | **Result** |
|---|---|---:|---:|
| `+` | Addition | `15 + 5` | `20` |
| `-` | Subtraction | `15 - 5` | `10` |
| `*` | Multiplication | `15 * 5` | `75` |
| `/` | Division | `15 / 5` | `3` |
| `%` | Modulus (Remainder of Division) | `14 % 5` | `4` |
| `^` | Exponentiation (Not standard in all DBMS) | `15 ^ 2` | `225` |
| `-` (as a prefix) | Negation | `-15` | `-15` |

### SQL Arithmetic Order of Operations

Just like in standard arithmetic, SQL follows the order of operations of **PEMDAS**:

- **P:** Parentheses first
- **E:** Exponents (i.e., `^`)
- **MD:** Multiplication and Division (left-to-right)
- **AS:** Addition and Subtraction (left-to-right)

Here's some SQL examples of PEMDAS:

| **SQL Statement** | **Result** | **Explanation** |
|---|---:|---|
| `SELECT 3 + 7 * 2;` | `17` | Multiplication comes before addition. |
| `SELECT (3 + 7) * 2;` | `20` | Parentheses mean addition happens first. |
| `SELECT 10 / 2 + 3 * 4;` | `17` | `10 / 2 = 5`, `3 * 4 = 12`, so `5 + 12 = 17`. |
| `SELECT (10 / 2) + (3 * 4);` | `17` | Same as above, but more explicit with parentheses! |
