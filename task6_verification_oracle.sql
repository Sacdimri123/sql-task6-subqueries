SELECT book_id, title, copies,
       (SELECT AVG(NVL(copies,0)) FROM books) AS avg_copies_all
FROM books;

SELECT book_id, title, copies
FROM books
WHERE copies > (SELECT AVG(NVL(copies,0)) FROM books)
ORDER BY copies DESC;

SELECT member_id, name
FROM members
WHERE member_id IN (SELECT DISTINCT member_id FROM borrowings);

SELECT member_id, name
FROM members
WHERE member_id NOT IN (SELECT DISTINCT member_id FROM borrowings);

SELECT b.book_id, b.title,
       (SELECT COUNT(*) FROM borrowings br WHERE br.book_id = b.book_id) AS borrow_count
FROM books b
ORDER BY borrow_count DESC;

SELECT a.author_id, a.name
FROM authors a
WHERE EXISTS (
    SELECT 1 FROM book_authors ba
    WHERE ba.author_id = a.author_id
);

SELECT publisher, ROUND(AVG(copies),2) AS avg_copies
FROM (
    SELECT publisher, copies FROM books WHERE copies IS NOT NULL
) sub
GROUP BY publisher;

SELECT publisher
FROM books
GROUP BY publisher
HAVING COUNT(*) > (
    SELECT COUNT(*) FROM books WHERE publisher = 'Bloomsbury'
);