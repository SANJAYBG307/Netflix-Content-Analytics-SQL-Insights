-- Basic Data Exploration (Beginner Friendly)
-- Only simple SQL concepts are used in this file.

USE netflix_db;

-- 1) Preview data
SELECT *
FROM netflix_raw
LIMIT 10;

-- 2) Total number of rows
SELECT COUNT(*) AS total_rows
FROM netflix_raw;

-- 3) Movie vs TV Show count
SELECT type, COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY type;

-- 4) Rating distribution
SELECT rating, COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY rating
ORDER BY total_titles DESC;

-- 5) Top 10 countries
SELECT country, COUNT(*) AS total_titles
FROM netflix_raw
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- 6) Top 10 genre combinations
SELECT listed_in, COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;

-- 7) Release year summary
SELECT
	MIN(release_year) AS min_release_year,
	MAX(release_year) AS max_release_year,
	AVG(release_year) AS avg_release_year
FROM netflix_raw;

-- 8) Titles by release year
SELECT release_year, COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY release_year
ORDER BY release_year;

-- 9) Titles added by year (date_added format: YYYY-MM-DD)
SELECT SUBSTRING(date_added, 1, 4) AS added_year, COUNT(*) AS total_titles
FROM netflix_raw
WHERE date_added IS NOT NULL
GROUP BY SUBSTRING(date_added, 1, 4)
ORDER BY added_year;

-- 10) Simple missing/default checks
SELECT COUNT(*) AS unknown_director_rows
FROM netflix_raw
WHERE director = 'Unknown';

SELECT COUNT(*) AS unknown_cast_rows
FROM netflix_raw
WHERE `cast` = 'Unknown';

SELECT COUNT(*) AS unknown_country_rows
FROM netflix_raw
WHERE country = 'Unknown';

SELECT COUNT(*) AS missing_date_added_rows
FROM netflix_raw
WHERE date_added IS NULL;