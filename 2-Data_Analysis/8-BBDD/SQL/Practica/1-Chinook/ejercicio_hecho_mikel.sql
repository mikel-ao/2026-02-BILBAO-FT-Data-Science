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
SELECT FirstName || " " || LastName AS NombreCompleto, Address, City, State, Country, Email
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
SELECT SUM(Quantity)
FROM invoice_items
WHERE InvoiceId = 37;

-- 9. Cuántas canciones tiene ‘AC/DC’
 SELECT artists.name, count(tracks.trackId)
 FROM tracks
 INNER JOIN albums ON tracks.albumid = albums.albumid
 INNER JOIN artists ON albums.artistid = artists.artistid
 WHERE artists.name = "AC/DC";

 
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
WHERE Anio IN ('2009', '2011')
GROUP BY Anio;

-- 12. Otra forma
SELECT strftime('%Y', InvoiceDate) AS Anio, count(InvoiceId) AS TotalFacturas
FROM invoices
WHERE Anio = "2009" or Anio = "2011"
--WHERE Anio IN ('2009', '2011')
GROUP BY Anio;

-- 13. Cuántas facturas ha habido entre 2009 y 2011 
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
WHERE Name LIKE "You%";

-- SEGUNDA PARTE

-- 1. Facturas de Clientes de Brasil, Nombre del cliente, Id de factura, fecha de la factura y el país de la factura
SELECT customers.FirstName, customers.LastName, invoices.InvoiceId, invoices.InvoiceDate, invoices.BillingCountry
FROM customers
JOIN invoices ON customers.CustomerId = invoices.CustomerId
WHERE customers.Country = 'Brazil';

-- 2. Obtén cada factura asociada a cada agente de ventas con su nombre completo
SELECT employees.FirstName || ' ' || employees.LastName AS SalesAgent, invoices.*
FROM employees
JOIN customers ON employees.EmployeeId = customers.SupportRepId
JOIN invoices ON customers.CustomerId = invoices.CustomerId;

-- 3. Obtén el nombre del cliente, el país, el nombre del agente y el total
SELECT customers.FirstName || ' ' || customers.LastName AS CustomerName, 
       customers.Country, 
       employees.FirstName || ' ' || employees.LastName AS SalesAgent, 
       invoices.Total
FROM customers
JOIN employees ON customers.SupportRepId = employees.EmployeeId
JOIN invoices ON customers.CustomerId = invoices.CustomerId
GROUP BY 1;


-- 4. Obtén cada artículo de la factura con el nombre de la canción
SELECT invoice_items.*, tracks.Name AS TrackName
FROM invoice_items
JOIN tracks ON invoice_items.TrackId = tracks.TrackId;

-- 5. Muestra todas las canciones con su nombre, formato, álbum y género
SELECT tracks.Name AS Song, 
       media_types.Name AS Format, 
       albums.Title AS Album, 
       genres.Name AS Genre
FROM tracks
JOIN media_types ON tracks.MediaTypeId = media_types.MediaTypeId
JOIN albums ON tracks.AlbumId = albums.AlbumId
JOIN genres ON tracks.GenreId = genres.GenreId;

-- 6. Cuántas canciones hay en cada playlist
SELECT playlists.Name AS PlaylistName, COUNT(playlist_track.TrackId) AS TotalTracks
FROM playlists
LEFT JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
GROUP BY playlists.PlaylistId;

-- 7. Cuánto ha vendido cada empleado
SELECT employees.FirstName || ' ' || employees.LastName AS EmployeeName, SUM(invoices.Total) AS TotalSales
FROM employees
JOIN customers ON employees.EmployeeId = customers.SupportRepId
JOIN invoices ON customers.CustomerId = invoices.CustomerId
GROUP BY employees.EmployeeId;

-- 8. ¿Quién ha sido el agente de ventas que más ha vendido en 2009?
SELECT employees.FirstName || ' ' || employees.LastName AS SalesAgent, SUM(invoices.Total) AS TotalSales
FROM employees
JOIN customers ON employees.EmployeeId = customers.SupportRepId
JOIN invoices ON customers.CustomerId = invoices.CustomerId
WHERE invoices.InvoiceDate BETWEEN '2009-01-01' AND '2009-12-31'
GROUP BY employees.EmployeeId
ORDER BY TotalSales DESC
LIMIT 1;

-- 9. ¿Cuáles son los 3 grupos que más han vendido?
SELECT artists.Name AS ArtistName, SUM(invoice_items.UnitPrice * invoice_items.Quantity) AS TotalSales
FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId
JOIN tracks ON albums.AlbumId = tracks.AlbumId
JOIN invoice_items ON tracks.TrackId = invoice_items.TrackId
GROUP BY artists.ArtistId
ORDER BY TotalSales DESC
LIMIT 3;
