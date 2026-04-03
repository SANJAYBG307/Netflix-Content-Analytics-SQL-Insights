-- Portfolio EDA Script for Netflix dataset
-- Note: Some queries use MySQL 8 features (CTE, window functions, JSON_TABLE).

USE netflix_db;

-- ============================================================
-- 1) Dataset profile and quality checks
-- ============================================================

-- Total rows and unique IDs in the cleaned view
SELECT
	COUNT(*) AS total_rows,
	COUNT(DISTINCT show_id) AS unique_show_ids
FROM netflix_clean;

-- Duplicate ID check
SELECT
	show_id,
	COUNT(*) AS duplicate_count
FROM netflix_clean
GROUP BY show_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;

-- Raw null/blank profile by column
SELECT
	SUM(CASE WHEN show_id IS NULL OR TRIM(show_id) = '' THEN 1 ELSE 0 END) AS show_id_missing,
	SUM(CASE WHEN type IS NULL OR TRIM(type) = '' THEN 1 ELSE 0 END) AS type_missing,
	SUM(CASE WHEN title IS NULL OR TRIM(title) = '' THEN 1 ELSE 0 END) AS title_missing,
	SUM(CASE WHEN director IS NULL OR TRIM(director) = '' THEN 1 ELSE 0 END) AS director_missing,
	SUM(CASE WHEN `cast` IS NULL OR TRIM(`cast`) = '' THEN 1 ELSE 0 END) AS cast_missing,
	SUM(CASE WHEN country IS NULL OR TRIM(country) = '' THEN 1 ELSE 0 END) AS country_missing,
	SUM(CASE WHEN date_added IS NULL OR TRIM(date_added) = '' THEN 1 ELSE 0 END) AS date_added_missing,
	SUM(CASE WHEN release_year IS NULL THEN 1 ELSE 0 END) AS release_year_missing,
	SUM(CASE WHEN rating IS NULL OR TRIM(rating) = '' THEN 1 ELSE 0 END) AS rating_missing,
	SUM(CASE WHEN duration IS NULL OR TRIM(duration) = '' THEN 1 ELSE 0 END) AS duration_missing,
	SUM(CASE WHEN listed_in IS NULL OR TRIM(listed_in) = '' THEN 1 ELSE 0 END) AS listed_in_missing,
	SUM(CASE WHEN description IS NULL OR TRIM(description) = '' THEN 1 ELSE 0 END) AS description_missing
FROM netflix_raw;

-- ============================================================
-- 2) Core catalog composition
-- ============================================================

-- Content mix (Movie vs TV Show)
SELECT
	type,
	COUNT(*) AS total_titles,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_catalog
FROM netflix_clean
GROUP BY type
ORDER BY total_titles DESC;

-- Rating distribution
SELECT
	rating,
	COUNT(*) AS rating_count,
	ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (), 2) AS pct_of_catalog
FROM netflix_clean
GROUP BY rating
ORDER BY rating_count DESC;

-- Type by rating matrix
SELECT
	type,
	rating,
	COUNT(*) AS title_count
FROM netflix_clean
GROUP BY type, rating
ORDER BY type, title_count DESC;

-- ============================================================
-- 3) Time-based EDA
-- ============================================================

-- Titles added by year
SELECT
	YEAR(date_added) AS year_added,
	COUNT(*) AS titles_added
FROM netflix_clean
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- Year-over-year growth in additions
WITH additions AS (
	SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
	FROM netflix_clean
	WHERE date_added IS NOT NULL
	GROUP BY YEAR(date_added)
)
SELECT
	year_added,
	titles_added,
	LAG(titles_added) OVER (ORDER BY year_added) AS prev_year_added,
	titles_added - LAG(titles_added) OVER (ORDER BY year_added) AS yoy_change,
	ROUND(
		100 * (titles_added - LAG(titles_added) OVER (ORDER BY year_added))
		/ NULLIF(LAG(titles_added) OVER (ORDER BY year_added), 0),
		2
	) AS yoy_pct
FROM additions
ORDER BY year_added;

-- Monthly seasonality (all years combined)
SELECT
	MONTH(date_added) AS month_num,
	MONTHNAME(date_added) AS month_name,
	COUNT(*) AS titles_added
FROM netflix_clean
WHERE date_added IS NOT NULL
GROUP BY MONTH(date_added), MONTHNAME(date_added)
ORDER BY month_num;

-- Release year distribution and decade view
SELECT
	release_year,
	COUNT(*) AS titles_count
FROM netflix_clean
WHERE release_year IS NOT NULL
GROUP BY release_year
ORDER BY release_year;

SELECT
	decade,
	COUNT(*) AS titles_count
FROM (
	SELECT CONCAT(FLOOR(release_year / 10) * 10, 's') AS decade
	FROM netflix_clean
	WHERE release_year IS NOT NULL
) AS decade_data
GROUP BY decade
ORDER BY CAST(REPLACE(decade, 's', '') AS UNSIGNED);

-- Lag between release year and Netflix added year
SELECT
	type,
	ROUND(AVG(CAST(YEAR(date_added) AS SIGNED) - CAST(release_year AS SIGNED)), 2) AS avg_years_to_arrive,
	MIN(CAST(YEAR(date_added) AS SIGNED) - CAST(release_year AS SIGNED)) AS min_lag,
	MAX(CAST(YEAR(date_added) AS SIGNED) - CAST(release_year AS SIGNED)) AS max_lag
FROM netflix_clean
WHERE date_added IS NOT NULL
  AND release_year IS NOT NULL
GROUP BY type;

-- ============================================================
-- 4) Geography analysis
-- ============================================================

-- Top single-value countries as stored in cleaned view
SELECT
	country,
	COUNT(*) AS total_titles
FROM netflix_clean
GROUP BY country
ORDER BY total_titles DESC
LIMIT 20;

-- Country split analysis for multi-country rows
SELECT
	jt.country_name,
	COUNT(*) AS total_titles
FROM netflix_clean nc
JOIN JSON_TABLE(
	CONCAT('["', REPLACE(REPLACE(nc.country, '"', '\\"'), ', ', '","'), '"]'),
	'$[*]' COLUMNS (country_name VARCHAR(100) PATH '$')
) AS jt
WHERE nc.country <> 'Unknown'
GROUP BY jt.country_name
ORDER BY total_titles DESC
LIMIT 20;

-- Country share by content type (top countries)
WITH country_type AS (
	SELECT
		jt.country_name,
		nc.type,
		COUNT(*) AS titles_count
	FROM netflix_clean nc
	JOIN JSON_TABLE(
		CONCAT('["', REPLACE(REPLACE(nc.country, '"', '\\"'), ', ', '","'), '"]'),
		'$[*]' COLUMNS (country_name VARCHAR(100) PATH '$')
	) AS jt
	WHERE nc.country <> 'Unknown'
	GROUP BY jt.country_name, nc.type
), ranked AS (
	SELECT
		country_name,
		type,
		titles_count,
		DENSE_RANK() OVER (
			PARTITION BY type
			ORDER BY titles_count DESC
		) AS rnk
	FROM country_type
)
SELECT country_name, type, titles_count
FROM ranked
WHERE rnk <= 10
ORDER BY type, titles_count DESC;

-- ============================================================
-- 5) Genre analysis
-- ============================================================

-- Most common listed genre combinations
SELECT
	listed_in,
	COUNT(*) AS combo_count
FROM netflix_clean
GROUP BY listed_in
ORDER BY combo_count DESC
LIMIT 20;

-- Split genres and rank most frequent genres
SELECT
	jt.genre_name,
	COUNT(*) AS total_titles
FROM netflix_clean nc
JOIN JSON_TABLE(
	CONCAT('["', REPLACE(REPLACE(nc.listed_in, '"', '\\"'), ', ', '","'), '"]'),
	'$[*]' COLUMNS (genre_name VARCHAR(100) PATH '$')
) AS jt
GROUP BY jt.genre_name
ORDER BY total_titles DESC
LIMIT 20;

-- Genre trend by year: top 5 genres each year
WITH genre_year AS (
	SELECT
		YEAR(nc.date_added) AS year_added,
		jt.genre_name,
		COUNT(*) AS titles_count
	FROM netflix_clean nc
	JOIN JSON_TABLE(
		CONCAT('["', REPLACE(REPLACE(nc.listed_in, '"', '\\"'), ', ', '","'), '"]'),
		'$[*]' COLUMNS (genre_name VARCHAR(100) PATH '$')
	) AS jt
	WHERE nc.date_added IS NOT NULL
	GROUP BY YEAR(nc.date_added), jt.genre_name
), ranked AS (
	SELECT
		year_added,
		genre_name,
		titles_count,
		ROW_NUMBER() OVER (
			PARTITION BY year_added
			ORDER BY titles_count DESC
		) AS genre_rank
	FROM genre_year
)
SELECT year_added, genre_name, titles_count, genre_rank
FROM ranked
WHERE genre_rank <= 5
ORDER BY year_added, genre_rank;

-- ============================================================
-- 6) Talent analysis (director and cast)
-- ============================================================

-- Most frequent directors
SELECT
	director,
	COUNT(*) AS total_titles
FROM netflix_clean
WHERE director <> 'Unknown'
GROUP BY director
ORDER BY total_titles DESC
LIMIT 20;

-- Director mix by content type
SELECT
	director,
	type,
	COUNT(*) AS titles_count
FROM netflix_clean
WHERE director <> 'Unknown'
GROUP BY director, type
ORDER BY titles_count DESC
LIMIT 30;

-- Most frequent cast members from split cast field
SELECT
	jt.actor_name,
	COUNT(*) AS total_titles
FROM netflix_clean nc
JOIN JSON_TABLE(
	CONCAT('["', REPLACE(REPLACE(nc.`cast`, '"', '\\"'), ', ', '","'), '"]'),
	'$[*]' COLUMNS (actor_name VARCHAR(150) PATH '$')
) AS jt
WHERE nc.`cast` <> 'Unknown'
GROUP BY jt.actor_name
ORDER BY total_titles DESC
LIMIT 25;

-- ============================================================
-- 7) Duration and runtime depth
-- ============================================================

-- Movie duration distribution in minutes
SELECT
	CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS minutes,
	COUNT(*) AS movie_count
FROM netflix_clean
WHERE type = 'Movie'
  AND duration LIKE '%min%'
GROUP BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
ORDER BY minutes;

-- Movie runtime summary statistics
SELECT
	ROUND(AVG(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)), 2) AS avg_minutes,
	MIN(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS min_minutes,
	MAX(CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)) AS max_minutes
FROM netflix_clean
WHERE type = 'Movie'
  AND duration LIKE '%min%';

-- TV Show season distribution
SELECT
	CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS seasons,
	COUNT(*) AS show_count
FROM netflix_clean
WHERE type = 'TV Show'
  AND duration LIKE '%Season%'
GROUP BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
ORDER BY seasons;

-- ============================================================
-- 8) Portfolio-ready advanced slices
-- ============================================================

-- Top ratings within each type
WITH rating_counts AS (
	SELECT
		type,
		rating,
		COUNT(*) AS titles_count
	FROM netflix_clean
	GROUP BY type, rating
), ranked AS (
	SELECT
		type,
		rating,
		titles_count,
		ROW_NUMBER() OVER (PARTITION BY type ORDER BY titles_count DESC) AS rnk
	FROM rating_counts
)
SELECT type, rating, titles_count
FROM ranked
WHERE rnk <= 5
ORDER BY type, titles_count DESC;

-- Description length analysis by type
SELECT
	type,
	ROUND(AVG(CHAR_LENGTH(description)), 2) AS avg_description_length,
	MIN(CHAR_LENGTH(description)) AS min_description_length,
	MAX(CHAR_LENGTH(description)) AS max_description_length
FROM netflix_clean
GROUP BY type;

-- Catalog freshness buckets based on release year
WITH max_year AS (
	SELECT MAX(release_year) AS latest_release_year FROM netflix_clean
)
SELECT
	CASE
		WHEN my.latest_release_year - nc.release_year <= 1 THEN '0-1 years old'
		WHEN my.latest_release_year - nc.release_year <= 5 THEN '2-5 years old'
		WHEN my.latest_release_year - nc.release_year <= 10 THEN '6-10 years old'
		ELSE '10+ years old'
	END AS recency_bucket,
	COUNT(*) AS titles_count
FROM netflix_clean nc
CROSS JOIN max_year my
WHERE nc.release_year IS NOT NULL
GROUP BY recency_bucket
ORDER BY titles_count DESC;