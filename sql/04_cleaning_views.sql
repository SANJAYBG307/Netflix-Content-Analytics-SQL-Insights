-- Data cleaning pipeline for interview demonstration.
-- This script uses multiple views so each cleaning technique is visible step by step.

USE netflix_db;

-- Drop in dependency order.
DROP VIEW IF EXISTS netflix_clean_audit;
DROP VIEW IF EXISTS netflix_clean;
DROP VIEW IF EXISTS netflix_clean_final;
DROP VIEW IF EXISTS netflix_clean_enriched;
DROP VIEW IF EXISTS netflix_clean_dedup;
DROP VIEW IF EXISTS netflix_clean_standardized;

-- ============================================================
-- Step 1: Standardization and basic null handling
-- Techniques: TRIM, case normalization, placeholder to NULL, date parsing
-- ============================================================
CREATE VIEW netflix_clean_standardized AS
SELECT
	NULLIF(TRIM(show_id), '') AS show_id,

	CASE
		WHEN UPPER(TRIM(type)) = 'MOVIE' THEN 'Movie'
		WHEN UPPER(TRIM(type)) IN ('TV SHOW', 'TVSHOW') THEN 'TV Show'
		WHEN TRIM(type) IS NULL OR TRIM(type) = '' THEN NULL
		ELSE TRIM(type)
	END AS type,

	NULLIF(TRIM(title), '') AS title,

	CASE
		WHEN director IS NULL OR TRIM(director) = '' THEN NULL
		WHEN UPPER(TRIM(director)) IN ('N/A', 'NA', 'NONE', 'NULL') THEN NULL
		ELSE TRIM(director)
	END AS director,

	CASE
		WHEN `cast` IS NULL OR TRIM(`cast`) = '' THEN NULL
		WHEN UPPER(TRIM(`cast`)) IN ('N/A', 'NA', 'NONE', 'NULL') THEN NULL
		ELSE TRIM(`cast`)
	END AS `cast`,

	CASE
		WHEN country IS NULL OR TRIM(country) = '' THEN NULL
		WHEN UPPER(TRIM(country)) IN ('N/A', 'NA', 'NONE', 'NULL') THEN NULL
		ELSE TRIM(country)
	END AS country,

	STR_TO_DATE(NULLIF(TRIM(date_added), ''), '%M %d, %Y') AS date_added,

	CASE
		WHEN release_year IS NULL THEN NULL
		WHEN release_year < 1900 THEN NULL
		WHEN release_year > YEAR(CURDATE()) + 1 THEN NULL
		ELSE release_year
	END AS release_year,

	CASE
		WHEN rating IS NULL OR TRIM(rating) = '' THEN NULL
		WHEN UPPER(TRIM(rating)) IN ('N/A', 'NA', 'NONE', 'NULL') THEN NULL
		WHEN UPPER(TRIM(rating)) IN ('NR', 'UR') THEN 'Not Rated'
		ELSE TRIM(rating)
	END AS rating,

	NULLIF(TRIM(duration), '') AS duration,

	CASE
		WHEN listed_in IS NULL OR TRIM(listed_in) = '' THEN NULL
		WHEN UPPER(TRIM(listed_in)) IN ('N/A', 'NA', 'NONE', 'NULL') THEN NULL
		ELSE TRIM(listed_in)
	END AS listed_in,

	CASE
		WHEN description IS NULL OR TRIM(description) = '' THEN NULL
		WHEN UPPER(TRIM(description)) IN ('N/A', 'NA', 'NONE', 'NULL') THEN NULL
		ELSE TRIM(description)
	END AS description
FROM netflix_raw;

-- ============================================================
-- Step 2: De-duplication
-- Technique: ROW_NUMBER with a business key fallback when show_id is missing
-- ============================================================
CREATE VIEW netflix_clean_dedup AS
SELECT
	show_id,
	type,
	title,
	director,
	`cast`,
	country,
	date_added,
	release_year,
	rating,
	duration,
	listed_in,
	description
FROM (
	SELECT
		ncs.*,
		ROW_NUMBER() OVER (
			PARTITION BY COALESCE(show_id, CONCAT(IFNULL(type, ''), '|', IFNULL(title, ''), '|', IFNULL(release_year, '')))
			ORDER BY date_added DESC, title
		) AS rn
	FROM netflix_clean_standardized ncs
) x
WHERE rn = 1;

-- ============================================================
-- Step 3: Enrichment and final null replacement
-- Techniques: default values, derived columns, validation flags
-- ============================================================
CREATE VIEW netflix_clean_enriched AS
SELECT
	COALESCE(show_id, 'UNKNOWN_ID') AS show_id,
	COALESCE(type, 'Unknown') AS type,
	COALESCE(title, 'Untitled') AS title,
	COALESCE(director, 'Unknown') AS director,
	COALESCE(`cast`, 'Unknown') AS `cast`,
	COALESCE(country, 'Unknown') AS country,
	date_added,
	release_year,
	COALESCE(rating, 'Not Rated') AS rating,
	COALESCE(duration, 'Unknown Duration') AS duration,
	COALESCE(listed_in, 'Unspecified') AS listed_in,
	COALESCE(description, 'No description available') AS description,

	YEAR(date_added) AS date_added_year,
	MONTH(date_added) AS date_added_month,

	CASE
		WHEN type = 'Movie' AND duration LIKE '%min%' THEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
		ELSE NULL
	END AS movie_minutes,

	CASE
		WHEN type = 'TV Show' AND duration LIKE '%Season%' THEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
		ELSE NULL
	END AS tv_seasons,

	CASE
		WHEN date_added IS NOT NULL AND release_year IS NOT NULL
			AND YEAR(date_added) >= release_year
		THEN YEAR(date_added) - release_year
		ELSE NULL
	END AS years_to_platform,

	CASE WHEN director IS NULL THEN 1 ELSE 0 END AS flag_director_missing,
	CASE WHEN `cast` IS NULL THEN 1 ELSE 0 END AS flag_cast_missing,
	CASE WHEN country IS NULL THEN 1 ELSE 0 END AS flag_country_missing,
	CASE WHEN date_added IS NULL THEN 1 ELSE 0 END AS flag_date_added_missing,
	CASE WHEN rating IS NULL THEN 1 ELSE 0 END AS flag_rating_missing,
	CASE WHEN listed_in IS NULL THEN 1 ELSE 0 END AS flag_genre_missing,
	CASE WHEN release_year IS NULL THEN 1 ELSE 0 END AS flag_release_year_missing
FROM netflix_clean_dedup;

-- ============================================================
-- Step 4: Final cleaned view for all downstream EDA
-- ============================================================
CREATE VIEW netflix_clean_final AS
SELECT *
FROM netflix_clean_enriched;

-- Keep compatibility with existing analysis scripts.
CREATE VIEW netflix_clean AS
SELECT *
FROM netflix_clean_final;

-- ============================================================
-- Step 5: Cleaning audit view for interview storytelling
-- ============================================================
CREATE VIEW netflix_clean_audit AS
SELECT
	(SELECT COUNT(*) FROM netflix_raw) AS raw_rows,
	(SELECT COUNT(*) FROM netflix_clean_standardized) AS standardized_rows,
	(SELECT COUNT(*) FROM netflix_clean_dedup) AS dedup_rows,
	(SELECT COUNT(*) FROM netflix_clean) AS clean_rows,
	(SELECT COUNT(*) FROM netflix_raw) - (SELECT COUNT(*) FROM netflix_clean_dedup) AS duplicates_removed,
	SUM(flag_director_missing) AS missing_director_after_clean,
	SUM(flag_cast_missing) AS missing_cast_after_clean,
	SUM(flag_country_missing) AS missing_country_after_clean,
	SUM(flag_date_added_missing) AS missing_date_added_after_clean,
	SUM(flag_rating_missing) AS missing_rating_after_clean,
	SUM(flag_genre_missing) AS missing_genre_after_clean,
	SUM(flag_release_year_missing) AS missing_release_year_after_clean
FROM netflix_clean;

-- Optional checks to run manually:
-- SELECT * FROM netflix_clean_audit;
-- SELECT * FROM netflix_clean LIMIT 10;
