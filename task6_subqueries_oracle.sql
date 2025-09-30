-- Task 6: Subqueries and Nested Queries (Oracle compatible)
SET DEFINE OFF;

-- 1) Subquery in SELECT (scalar subquery: average copies)
SELECT book_id, title, copies,
       (SELECT AVG(NVL(copies,0)) FROM books) AS avg_copies_all
FROM books;

-- 2) Subquery in WHERE with comparison
-- Find books with copies greater than average
SELECT book_id, title, copies
FROM books
WHERE copies > (SELECT AVG(NVL(copies,0)) FROM books)
ORDER BY copies DESC;

-- 3) Subquery with IN
-- Find members who borrowed books
SELECT member_id, name
FROM members
WHERE member_id IN (SELECT DISTINCT member_id FROM borrowings);

-- 4) Subquery with NOT IN
-- Find members who never borrowed any book
SELECT member_id, name
FROM members
WHERE member_id NOT IN (SELECT DISTINCT member_id FROM borrowings);

-- 5) Correlated subquery (per-book borrowing count)
SELECT b.book_id, b.title,
       (SELECT COUNT(*) FROM borrowings br WHERE br.book_id = b.book_id) AS borrow_count
FROM books b
ORDER BY borrow_count DESC;

-- 6) EXISTS example
-- Authors who have written at least one book
SELECT a.author_id, a.name
FROM authors a
WHERE EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.author_id = a.author_id
);

-- 7) Subquery in FROM (inline view)
-- Average copies per publisher
SELECT publisher, ROUND(AVG(copies),2) AS avg_copies
FROM (
    SELECT publisher, copies FROM books WHERE copies IS NOT NULL
) sub
GROUP BY publisher;

-- 8) Nested subquery with HAVING
-- Publishers with more than 1 book
SELECT publisher
FROM books
GROUP BY publisher
HAVING COUNT(*) > (
    SELECT COUNT(*) FROM books WHERE publisher = 'Bloomsbury'
);
