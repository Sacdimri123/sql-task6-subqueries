# Task 6 — Subqueries and Nested Queries (Oracle SQL)

This project is part of my SQL Developer Internship at Elevate Labs.  
It demonstrates the use of **subqueries** in SELECT, WHERE, FROM, and HAVING clauses, covering scalar, correlated, and nested query patterns.

---

## Objectives
- Use scalar subqueries in SELECT lists.
- Filter results with subqueries in WHERE (IN, NOT IN, comparison).
- Apply correlated subqueries for per-row calculations.
- Use EXISTS for existence checks.
- Create inline views (subquery in FROM).
- Write nested subqueries in HAVING for group-level filtering.

---

## Repository Structure
.
├── task6_subqueries_oracle.sql        # Core SQL queries (subqueries & nested)
├── task6_verification_oracle.sql      # Verification queries to validate outputs
├── screenshots/
│   ├── task6_scalar_select.png        # Scalar subquery (average copies)
│   ├── task6_where_comparison.png     # Copies greater than average
│   ├── task6_in_subquery.png          # Members who borrowed books
│   ├── task6_not_in_subquery.png      # Members who never borrowed books
│   ├── task6_correlated.png           # Correlated subquery (borrow count)
│   ├── task6_exists.png               # EXISTS example (authors with books)
│   ├── task6_inline_view.png          # Inline view (avg copies per publisher)
│   └── task6_nested_having.png        # Nested HAVING subquery

---

## Key Queries

### 1. Scalar subquery in SELECT
```sql
SELECT book_id, title, copies,
       (SELECT AVG(NVL(copies,0)) FROM books) AS avg_copies_all
FROM books;
2. Subquery in WHERE with comparison
SELECT book_id, title, copies
FROM books
WHERE copies > (SELECT AVG(NVL(copies,0)) FROM books)
ORDER BY copies DESC;
3. Subquery with IN
SELECT member_id, name
FROM members
WHERE member_id IN (SELECT DISTINCT member_id FROM borrowings);
4. Subquery with NOT IN
SELECT member_id, name
FROM members
WHERE member_id NOT IN (SELECT DISTINCT member_id FROM borrowings);
5. Correlated subquery
SELECT b.book_id, b.title,
       (SELECT COUNT(*) FROM borrowings br WHERE br.book_id = b.book_id) AS borrow_count
FROM books b
ORDER BY borrow_count DESC;
6. EXISTS example
SELECT a.author_id, a.name
FROM authors a
WHERE EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.author_id = a.author_id
);
7. Subquery in FROM (inline view)
SELECT publisher, ROUND(AVG(copies),2) AS avg_copies
FROM (
    SELECT publisher, copies FROM books WHERE copies IS NOT NULL
) sub
GROUP BY publisher;
8. Nested subquery with HAVING
SELECT publisher
FROM books
GROUP BY publisher
HAVING COUNT(*) > (
    SELECT COUNT(*) FROM books WHERE publisher = 'Bloomsbury'
);
Screenshots Mapping
task6_scalar_select.png → Scalar subquery
task6_where_comparison.png → WHERE with comparison
task6_in_subquery.png → Subquery with IN
task6_not_in_subquery.png → Subquery with NOT IN
task6_correlated.png → Correlated subquery (borrow count)
task6_exists.png → EXISTS subquery
task6_inline_view.png → Inline view
task6_nested_having.png → Nested HAVING
Outcome
Successfully demonstrated scalar, correlated, and nested subqueries in Oracle SQL.
Verified results with screenshots for documentation.
Organized outputs, scripts, and queries into a structured GitHub repository.
Author: Sachin Dimri
Internship @ Elevate Labs (SQL Developer Intern)
