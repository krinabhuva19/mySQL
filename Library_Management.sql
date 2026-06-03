CREATE DATABASE LibraryDB;

USE LibraryDB;

CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50)
);

INSERT INTO Authors VALUES
(1,'Chetan Bhagat','chetan@gmail.com'),
(2,'R.K. Narayan','rk@gmail.com'),
(3,'APJ Abdul Kalam','apj@gmail.com');

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(100),
    author_id INT,
    category VARCHAR(50),
    isbn VARCHAR(20),
    published_date DATE,
    price DECIMAL(10,2),
    available_copies INT,
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

INSERT INTO Books VALUES
(101,'Wings of Fire',3,'Science','ISBN101','2021-01-10',450,5),
(102,'Five Point Someone',1,'Novel','ISBN102','2018-05-15',350,3),
(103,'Malgudi Days',2,'Story','ISBN103','2016-08-20',500,0),
(104,'Ignited Minds',3,'Science','ISBN104','2022-03-12',400,4);

CREATE TABLE Members (
    member_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(15),
    membership_date DATE
);

INSERT INTO Members VALUES
(1,'Krina','krina@gmail.com','9876543210','2023-01-15'),
(2,'Rahul','rahul@gmail.com','9876543211','2021-06-20'),
(3,'Priya','priya@gmail.com','9876543212','2024-02-10');


CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    fine_amount DECIMAL(10,2),
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

INSERT INTO Transactions VALUES
(1,1,101,'2025-01-01','2025-01-10',0),
(2,2,102,'2025-02-01','2025-02-15',50),
(3,1,104,'2025-03-01','2025-03-10',0);


-- 1.CRUD Operations

INSERT INTO Members
VALUES (4,'Amit','amit@gmail.com','9999999999','2025-01-01');

UPDATE Books
SET available_copies = 4
WHERE book_id = 101;

DELETE FROM Members
WHERE member_id = 4;

SELECT * FROM Books;


-- 2.WHERE, HAVING, LIMIT

SELECT * FROM Books
WHERE published_date > '2015-01-01';

SELECT * FROM Books
ORDER BY price DESC
LIMIT 5;

SELECT category,COUNT(*) AS total_books
FROM Books
GROUP BY  category
HAVING COUNT(*) >= 1;


-- 3.AND OR NOT

SELECT * FROM Books
WHERE category='Science'
AND price < 500;

SELECT * FROM Books
WHERE NOT available_copies > 0;

SELECT * FROM Members
WHERE membership_date > '2020-01-01'
OR member_id IN (SELECT member_id FROM Transactions);


-- 4.ORDER BY & GROUP BY

SELECT * FROM Books
ORDER BY title;

SELECT member_id,COUNT(*) AS books_borrowed
FROM Transactions
GROUP BY member_id;

SELECT category,COUNT(*) AS total_books
FROM Books
GROUP BY category;


-- 5.Aggregate Functions

SELECT category,COUNT(*) FROM Books
GROUP BY category;

SELECT AVG(price) AS average_price
FROM Books;

SELECT book_id,COUNT(*) AS borrow_count
FROM Transactions
GROUP BY book_id
ORDER BY borrow_count DESC
LIMIT 1;

SELECT SUM(fine_amount) AS total_fine
FROM Transactions;


-- 6.Establish Primary & Foreign Key Relationships

SELECT Books.title, Authors.name
FROM Books
JOIN Authors
ON Books.author_id = Authors.author_id;

SELECT Members.name, Transactions.transaction_id
FROM Members
JOIN Transactions
ON Members.member_id = Transactions.member_id;


-- 7.joins

SELECT b.title,a.name
FROM Books b
INNER JOIN Authors a
ON b.author_id=a.author_id;

SELECT m.name,t.transaction_id
FROM Members m
LEFT JOIN Transactions t
ON m.member_id=t.member_id;

SELECT b.title,t.transaction_id
FROM Transactions t
RIGHT JOIN Books b
ON t.book_id=b.book_id;

SELECT Members.name, Transactions.transaction_id
FROM Members
LEFT JOIN Transactions
ON Members.member_id = Transactions.member_id

UNION

SELECT Members.name, Transactions.transaction_id
FROM Members
RIGHT JOIN Transactions
ON Members.member_id = Transactions.member_id;


-- 8.Subqueries

SELECT title
FROM Books
WHERE book_id IN
(
SELECT book_id
FROM Transactions
);

SELECT *
FROM Members
WHERE member_id NOT IN
(
SELECT member_id
FROM Transactions
);

SELECT name
FROM Members
WHERE member_id NOT IN
(
SELECT member_id
FROM Transactions
);


-- 9.Date & Time Functions

SELECT YEAR(published_date)
FROM Books;

SELECT DATEDIFF(return_date, borrow_date)
FROM Transactions;

SELECT DATE_FORMAT(borrow_date,'%d-%m-%Y')
FROM Transactions;


-- 10.String Functions

SELECT UPPER(title)
FROM Books;

SELECT TRIM(name)
FROM Authors;

SELECT IFNULL(email,'Not Provided')
FROM Members;


-- 11.Window Functions

SELECT book_id,
COUNT(*) AS total,
RANK() OVER(ORDER BY COUNT(*) DESC) AS ranking
FROM Transactions
GROUP BY book_id;

SELECT member_id,
COUNT(*) AS total,
SUM(COUNT(*)) OVER(ORDER BY member_id) AS cumulative
FROM Transactions
GROUP BY member_id;

SELECT member_id,
AVG(member_id) OVER() AS average
FROM Transactions;


-- 12.CASE Expressions

SELECT name,
CASE
WHEN member_id IN (SELECT member_id FROM Transactions)
THEN 'Active'
ELSE 'Inactive'
END AS Status
FROM Members;

SELECT title,
CASE
WHEN YEAR(published_date) > 2020 THEN 'New Arrival'
WHEN YEAR(published_date) < 2000 THEN 'Classic'
ELSE 'Regular'
END AS Category
FROM Books;






    
    
    
	
