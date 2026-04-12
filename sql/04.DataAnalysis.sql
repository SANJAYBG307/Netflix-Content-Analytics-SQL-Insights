-- Business Questions

USE netflix_db;

-- Count how many titles exist for each type (Movie / TV Show)
SELECT 
    type,
    COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY type;


-- Count how many titles exist for each rating and sort by highest
SELECT 
    rating,
    COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY rating
ORDER BY total_titles DESC;


-- Extract year from date_added and count titles per year
-- date_added is standardized as YYYY-MM-DD string in netflix_raw
SELECT 
    YEAR(STR_TO_DATE(date_added, '%Y-%m-%d')) AS year_added,
    COUNT(*) AS titles_added
FROM netflix_raw
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- Count titles by country (excluding NULL values)
SELECT 
    country,
    COUNT(*) AS total_titles
FROM netflix_raw
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;


-- Count titles by genre (listed_in column)
SELECT 
    listed_in AS genre,
    COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 5;


-- Check missing important fields
SELECT 
    COUNT(*) AS total_rows,
    
    SUM(CASE WHEN country = 'Unknown' THEN 1 ELSE 0 END) AS missing_country,
    SUM(CASE WHEN rating = 'Not Rated' THEN 1 ELSE 0 END) AS missing_rating,
    SUM(CASE WHEN date_added IS NULL THEN 1 ELSE 0 END) AS missing_date_added
FROM netflix_raw;



-- Check duplicate titles (basic check)
SELECT 
    title,
    COUNT(*) AS duplicate_count
FROM netflix_raw
GROUP BY title
HAVING COUNT(*) > 1;


-- KPI's
-- Calculate percentage split between Movies and TV Shows
SELECT 
    type,
    COUNT(*) AS total_titles,
    
    -- Percentage calculation
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix_raw), 2) AS percentage
FROM netflix_raw
GROUP BY type;


-- Calculate percentage share of each rating
SELECT 
    rating,
    COUNT(*) AS total_titles,
    
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix_raw), 2) AS percentage
FROM netflix_raw
GROUP BY rating
ORDER BY percentage DESC;


-- Step 1: Titles added each year
SELECT 
    YEAR(STR_TO_DATE(date_added, '%Y-%m-%d')) AS year_added,
    COUNT(*) AS titles_added
FROM netflix_raw
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;



-- Calculate share of top 5 countries
SELECT 
    country,
    COUNT(*) AS total_titles,
    
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix_raw), 2) AS percentage
FROM netflix_raw
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 5;



-- Calculate share of top 5 genres
SELECT 
    listed_in AS genre,
    COUNT(*) AS total_titles,
    
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM netflix_raw), 2) AS percentage
FROM netflix_raw
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 5;
