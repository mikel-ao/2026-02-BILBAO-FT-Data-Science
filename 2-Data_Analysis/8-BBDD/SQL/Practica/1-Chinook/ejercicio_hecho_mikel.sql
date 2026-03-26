-- 1. Obtén los clientes de brasil
SELECT * FROM customers WHERE customers.Country = "Brazil";

-- 2. Obtén los empleados que son agentes de ventas
SELECT * FROM employees WHERE employees.Title = "Sales Support Agent";

-- 3. Obtén las canciones de ‘AC/DC’
SELECT * FROM tracks WHERE tracks.composer = "AC/DC";

-- 4. Obtén los campos de los clientes que no sean de USA: Nombre completo, ID, País
SELECT FirstName, LastName, Address, City, State, Country, Email
FROM customers WHERE NOT customers.country = "USA";

-- 5. Obtén los empleados que son agentes de ventas: Nombre completo, Dirección (Ciudad, Estado, País) y email
SELECT FirstName, LastName, Address, City, State, Country, Email
FROM employees
WHERE Title = "Sales Support Agent";

-- 6. Obtén una lista con los países no repetidos a los que se han emitido facturas
SELECT DISTINCT BillingCountry FROM invoices;

-- 7. Obtén una lista con los estados de USA no repetidos de donde son los clientes y cuántos clientes en cada uno.
SELECT count(CustomerId), State 
FROM customers 
WHERE Country = "USA"
GROUP BY State;

-- 8. Cuántos artículos tiene la factura 37
SELECT count(Quantity)
FROM invoice_items
WHERE InvoiceId = 37;

-- 9. Cuántas canciones tiene ‘AC/DC’
 SELECT count(TrackId)
 FROM tracks
 WHERE Composer = "AC/DC";
 
 -- 10. Cuántos artículos tiene cada factura
SELECT InvoiceId, SUM(Quantity)
FROM invoice_items
GROUP BY InvoiceId;

--  11. Cuántas facturas hay de cada país
SELECT count(InvoiceId), BillingCountry
FROM invoices
GROUP BY BillingCountry;

-- 12. Cuántas facturas ha habido en 2009 y 2011
SELECT strftime('%Y', InvoiceDate) AS Anio, count(InvoiceId) AS TotalFacturas
FROM invoices
WHERE strftime('%Y', InvoiceDate) IN ('2009', '2011')
GROUP BY Anio;

-- 13. Cuántas facturas ha habido en 2009 y 2011 
SELECT count(InvoiceId), InvoiceDate
FROM invoices
WHERE InvoiceDate BETWEEN '2009-01-01' AND '2011-12-31';

-- 14. Cuántas clientes hay de España y de Brasil
SELECT count(CustomerId), Country
FROM customers
WHERE Country IN ("Spain", "Brazil")
GROUP BY Country;

-- 15. Obtén las canciones que su título empieza por ‘You’
SELECT Name
FROM tracks
WHERE Name LIKE "You%"