-- Netflix EDA Queries (Beginner Friendly)
-- This file is plain SQL and can be executed directly in MySQL.
-- All analysis below uses the cleaned view: netflix_clean_final.

USE netflix_db;

-- ============================================================
-- 1) Basic descriptive statistics
-- Purpose: quickly understand the year range and dataset size.
-- ============================================================
SELECT
    MIN(release_year) AS min_year,
    MAX(release_year) AS max_year,
    ROUND(AVG(release_year), 2) AS avg_year,
    COUNT(*) AS total_titles
FROM netflix_clean_final;

-- Most common release year (mode)
SELECT
    release_year,
    COUNT(*) AS title_count
FROM netflix_clean_final
GROUP BY release_year
ORDER BY title_count DESC
LIMIT 1;

-- ============================================================
-- 2) Univariate analysis (one column at a time)
-- Purpose: see distribution of type, rating, and genre values.
-- ============================================================

-- Content type distribution (Movie vs TV Show)
SELECT
    type,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY type
ORDER BY total_titles DESC;

-- Rating distribution
SELECT
    rating,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY rating
ORDER BY total_titles DESC;

-- Top 10 genre combinations as stored in listed_in
SELECT
    listed_in,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY listed_in
ORDER BY total_titles DESC
LIMIT 10;

-- ============================================================
-- 3) Bivariate analysis (two columns together)
-- Purpose: check how one category changes with another.
-- ============================================================

-- Type by rating
SELECT
    type,
    rating,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY type, rating
ORDER BY type, total_titles DESC;

-- Type by release year
SELECT
    type,
    release_year,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY type, release_year
ORDER BY release_year, type;

-- ============================================================
-- 4) Multivariate analysis (three columns)
-- Purpose: view more detailed combinations in one result set.
-- ============================================================

-- Type + country + rating (top 10 combinations)
SELECT
    type,
    country,
    rating,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY type, country, rating
ORDER BY total_titles DESC
LIMIT 10;

-- Genre + type + release year (top 10 combinations)
SELECT
    listed_in,
    type,
    release_year,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY listed_in, type, release_year
ORDER BY total_titles DESC
LIMIT 10;

-- ============================================================
-- 5) Time-based analysis
-- Purpose: identify content growth over years and month pattern.
-- ============================================================

-- Titles added each year
SELECT
    YEAR(date_added) AS year_added,
    COUNT(*) AS total_titles
FROM netflix_clean_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- Titles added by month number (1 = Jan, 12 = Dec)
SELECT
    MONTH(date_added) AS month_added,
    COUNT(*) AS total_titles
FROM netflix_clean_final
WHERE date_added IS NOT NULL
GROUP BY MONTH(date_added)
ORDER BY month_added;

-- ============================================================
-- 6) Segmentation analysis
-- Purpose: identify top contributing countries and genres.
-- ============================================================

-- Top 10 countries (excluding Unknown)
SELECT
    country,
    COUNT(*) AS total_titles
FROM netflix_clean_final
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY total_titles DESC
LIMIT 10;

-- All genre combinations ranked
SELECT
    listed_in,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY listed_in
ORDER BY total_titles DESC;

-- ============================================================
-- 7) Distribution checks
-- Purpose: inspect year distribution and movie duration buckets.
-- ============================================================

-- Release year distribution
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY release_year
ORDER BY release_year;

-- Most common movie durations
SELECT
    duration,
    COUNT(*) AS total_titles
FROM netflix_clean_final
WHERE type = 'Movie'
GROUP BY duration
ORDER BY total_titles DESC
LIMIT 10;

-- ============================================================
-- 8) Simple trend proxy (basic correlation-style view)
-- Purpose: not true statistical correlation, but trend visibility.
-- ============================================================

-- Release year vs number of titles
SELECT
    release_year,
    COUNT(*) AS total_titles
FROM netflix_clean_final
GROUP BY release_year
ORDER BY release_year;

-- ============================================================
-- 9) Interview bonus queries
-- Purpose: quick highlights often asked in SQL interviews.
-- ============================================================

-- Top 10 directors (excluding Unknown)
SELECT
    director,
    COUNT(*) AS total_titles
FROM netflix_clean_final
WHERE director <> 'Unknown'
GROUP BY director
ORDER BY total_titles DESC
LIMIT 10;

-- Top 10 cast fields as stored (single text value)
SELECT
    `cast`,
    COUNT(*) AS total_titles
FROM netflix_clean_final
WHERE `cast` <> 'Unknown'
GROUP BY `cast`
ORDER BY total_titles DESC
LIMIT 10;
