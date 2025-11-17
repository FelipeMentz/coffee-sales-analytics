-- copy the original data into a different table

SELECT * FROM coffee_sales;

CREATE TABLE sales LIKE coffee_sales;

INSERT INTO sales
SELECT * FROM coffee_sales;

SELECT * FROM sales;
