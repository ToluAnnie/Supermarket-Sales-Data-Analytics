
SELECT c.CustomerKey, CONCAT(Prefix, ' ', FirstName, ' ', LastName) AS FullName, round(SUM(ProductPrice * orderquantity),2) AS purchaseamount
FROM customer c
JOIN 
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON c.CustomerKey = sales_data.CustomerKey
JOIN product p ON p.ProductKey = sales_data.ProductKey
GROUP BY c.CustomerKey, CONCAT(Prefix, ' ', FirstName, ' ', LastName)
HAVING purchaseamount > 10000
ORDER BY purchaseamount DESC;

SELECT product_categories.CategoryName, round(SUM(ProductPrice * orderquantity),2) AS purchaseamount, COUNT(orderquantity)
FROM product_categories
JOIN product_categories pc ON pc.ProductCategoryKey = product_subcategories.ProductCategoryKey
JOIN product_subcategories ps ON ps.ProductSubcategoryKey = product.ProductSubcategoryKey
JOIN
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON product.ProductKey = sales_data.ProductKey
GROUP BY product_categories.CategoryName;


SELECT AVG(ProductPrice) as avgsellingprice
FROM product;

SELECT product.ProductName, SubCategoryName, CategoryName
From product 
JOIN product p ON p.ProductSubcategoryKey = product_subcategories.ProductSubcategoryKey
JOIN product_subcategories ps ON ps.ProductCategoryKey = product_categories.ProductCategoryKey
WHERE ProductPrice > (SELECT AVG(ProductPrice) as avgsellingprice);


SELECT customer.CustomerKey, CONCAT(Prefix, ' ', FirstName, ' ', LastName) AS FullName
FROM customer
JOIN customer c ON c.CustomerKey = sales_data.CustomerKey
JOIN
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON territory_lookup.SalesTerritoryKey = sales_data.TerritoryKey
WHERE territory_lookup.Country = 'canada';


SELECT returns_data.ProductKey, ProductName, count(ReturnQuantity) AS MostReturned
FROM returns_data 
JOIN returns_data ON returns_data.ProductKey = product.ProductKey
ORDER BY count(ReturnQuantity) DESC
LIMIT 10;


SELECT c.CustomerKey, CONCAT(Prefix, ' ', FirstName, ' ', LastName) AS FullName
FROM customer c
JOIN 
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON c.CustomerKey = sales_data.CustomerKey
JOIN territory_lookup tl ON tl.SalesTerritoryKey = sales_data.TerritoryKey
WHERE count(sales_data.TerritoryKey) > 1;


SELECT p.ProductKey,p.ProductName, SubcategoryName
FROM product p
JOIN product_subcategories ps ON ps.ProductSubcategoryKey = product.ProductSubcategoryKey
JOIN
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON product.ProductKey = sales_data.ProductKey
GROUP BY SubcategoryName
HAVING COUNT(ProductKey) >= 10;


SELECT c.Occupation, COUNT(c.Occupation), CONCAT(Prefix, ' ', FirstName, ' ', LastName) AS FullName
FROM customer c
JOIN
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON customer.CustomerKey =sales_data.CustomerKey
WHERE year(OrderDate) > 2021
GROUP BY c.Occupation;


SELECT ProductKey, ProductName, COUNT(OrderQuantity)
FROM product p
JOIN 
(SELECT * FROM sales_data_2020
UNION
SELECT * FROM sales_data_2021
UNION
SELECT * FROM sales_data_2022) AS sales_data 
ON product.ProductKey = sales_data.ProductKey
WHERE COUNT(sales_data.ProductKey) >= 5;


SELECT product.ProductName
FROM product
JOIN product p ON p.ProductSubcategoryKey = product_subcategories.ProductSubcategoryKey
JOIN product_subcategories ps ON ps.ProductCategoryKey = product_categories.ProductCategoryKey
WHERE (ProductName LIKE 'C%' OR ProductName LIKE 'H%') AND CategoryName = 'Clothing';

SELECT DISTINCT p.product_name
FROM product p
JOIN orders o ON p.product_id = o.product_id
WHERE o.country IN ('United States', 'Australia');


