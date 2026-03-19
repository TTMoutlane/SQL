CREATE TABLE IF NOT EXISTS users (
	user_id INTEGER PRIMARY KEY AUTOINCREMENT,
	name VARCHAR(50),
	email VARCHAR(100) 
);

CREATE TABLE categories ( 
	category_id INTEGER PRIMARY KEY AUTOINCREMENT,
	category_name VARCHAR(50)
);

CREATE TABLE expenses (
	expense_id INTEGER PRIMARY KEY AUTOINCREMENT, 
	user_id INTEGER REFERENCES users(user_id),
	category_id INTEGER REFERENCES categories(category_id), 
	amount DECIMAL(10,2),
	expense_date DATE, 
	description VARCHAR(255)
); 

INSERT INTO users (name, email)
VALUES ('John Doe', 'john@email.com'),
	   ('Jane Smith', 'jane@email.com');
	   
INSERT INTO categories (category_name)
VALUES ('Food'),
	   ('Transport'),
	   ('Entertainment'),
	   ('Bills');
	   
INSERT INTO expenses (user_id, category_id, amount,expense_date,description) 
VALUES 
	(1, 1, 15.50, '2026=03-01', 'Lunch'),
	(1, 2, 7.00, '2026-03-01', 'Taxi'), 
	(2, 1, 20.00, '2026-03-02','Dinner'), 
	(1, 3, 12.00, '2026-03-03','Movie'),
	(2, 4, 50.00, '2026-03-04', 'Electricity bill');
	
SELECT * FROM expenses;

SELECT expenses.expense_id,
	   users.name, 
	   categories.category_name, 
	   expenses.amount,
	   expenses.expense_date 
FROM expenses 
JOIN users ON expenses.user_id = users.user_id 
JOIN categories ON expenses.category_id = categories.category_id;

SELECT SUM(amount) AS total_spent FROM expenses;

SELECT categories.category_name,
	   SUM(expenses.amount) AS total_spent
FROM expenses 
JOIN categories ON expenses.category_id = categories.category_id
GROUP BY categories.category_name;

SELECT * FROM expenses ORDER BY amount DESC LIMIT 1; 

SELECT strftime('%m', expense_date) AS month, 
	   SUM(amount) AS total_spent 
FROM expenses 
GROUP BY strftime('%m', expense_date);