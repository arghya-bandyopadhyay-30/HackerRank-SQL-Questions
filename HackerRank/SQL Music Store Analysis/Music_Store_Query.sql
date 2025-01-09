-- Question Set 1 - Easy

-- 1. Who is the senior most employee based on job title?
SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1;

-- 2. Which countries have the most Invoices?
SELECT billing_country, COUNT(*) AS count
FROM invoice
GROUP BY billing_country
ORDER BY count DESC
LIMIT 1;

-- 3. What are top 3 values of total invoice?
SELECT total
FROM invoice
ORDER BY total DESC
LIMIT 3;

-- 4. Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. Return both the city name & sum of all invoice totals.
SELECT billing_city, SUM(total) AS total
FROM invoice
GROUP BY billing_city
ORDER BY total DESC;

-- 5. Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money
SELECT c.customer_id, c.first_name, c.last_name, SUM(i.total) AS total
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total DESC
LIMIT 1;



-- Question Set 2 – Moderate

-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A
SELECT DISTINCT c.email, c.first_name, c.last_name, g.name AS genre
FROM customer c
JOIN invoice i ON c.customer_id = i.customer_id
JOIN invoice_line il ON i.invoice_id = il.invoice_id
JOIN track t ON il.track_id = t.track_id
JOIN genre g ON t.genre_id = g.genre_id
WHERE g.name = 'Rock'
  AND LEFT(c.email, 1) = 'a'
ORDER BY c.email;

-- 2. Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands
SELECT 
    a.artist_id, 
    a.name, 
    COUNT(t.track_id) AS num_of_songs
FROM artist a
JOIN album al ON al.artist_id = a.artist_id
JOIN track t ON t.album_id = al.album_id
JOIN genre g ON g.genre_id = t.genre_id
WHERE g.name = 'Rock'
GROUP BY a.artist_id, a.name
ORDER BY num_of_songs DESC
LIMIT 10;

-- 3. Return all the track names that have a song length longer than the average song length.
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first
SELECT name, milliseconds
FROM track
WHERE milliseconds > (
    SELECT AVG(milliseconds) AS avg_track_length
    FROM track
)
ORDER BY milliseconds DESC;



-- Question Set 3 – Advance

-- 1. Find how much amount spent by each customer on artists? Write a query to return customer name, artist name and total spent


-- 2. We want to find out the most popular music Genre for each country. 
-- We determine the most popular genre as the genre with the highest amount of purchases. 
-- Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases is shared return all Genres

-- 3. Write a query that determines the customer that has spent the most on music for each country. 
-- Write a query that returns the country along with the top customer and how much they spent. 
-- For countries where the top amount spent is shared, provide all customers who spent this amount