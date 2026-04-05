-- Data Cleaning and Data Preparation (Learning Version)
-- Goal: demonstrate every core cleaning skill using views.
-- Skills covered:
-- 1) Handling missing values
-- 2) Removing duplicates
-- 3) Fixing data types
-- 4) Standardizing formats (dates, text, units)
-- 5) Handling outliers
-- 6) Correcting inconsistencies
-- 7) Data validation after cleaning

USE netflix_db;

-- Drop views in reverse dependency order.
DROP VIEW IF EXISTS netflix_clean_audit;
DROP VIEW IF EXISTS netflix_clean;
DROP VIEW IF EXISTS netflix_clean_final;
DROP VIEW IF EXISTS netflix_clean_validated;
DROP VIEW IF EXISTS netflix_clean_pre_final;
DROP VIEW IF EXISTS netflix_clean_outlier_flags;
DROP VIEW IF EXISTS netflix_clean_consistent;
DROP VIEW IF EXISTS netflix_clean_typed;
DROP VIEW IF EXISTS netflix_clean_dedup;
DROP VIEW IF EXISTS netflix_clean_standardized;
DROP VIEW IF EXISTS netflix_clean_missing_handled;

-- ============================================================
-- Step 1: Handle missing values
-- What we do:
-- - Convert empty strings and placeholders to NULL
-- - Keep raw structure, only clean missing representations
-- ============================================================
CREATE VIEW netflix_clean_missing_handled AS
SELECT
    NULLIF(TRIM(show_id), '') AS show_id,
    NULLIF(TRIM(type), '') AS type,
    NULLIF(TRIM(title), '') AS title,

    CASE
        WHEN director IS NULL OR TRIM(director) = '' THEN NULL
        WHEN UPPER(TRIM(director)) IN ('N/A', 'NA', 'NONE', 'NULL', '-') THEN NULL
        ELSE TRIM(director)
    END AS director,

    CASE
        WHEN `cast` IS NULL OR TRIM(`cast`) = '' THEN NULL
        WHEN UPPER(TRIM(`cast`)) IN ('N/A', 'NA', 'NONE', 'NULL', '-') THEN NULL
        ELSE TRIM(`cast`)
    END AS `cast`,

    CASE
        WHEN country IS NULL OR TRIM(country) = '' THEN NULL
        WHEN UPPER(TRIM(country)) IN ('N/A', 'NA', 'NONE', 'NULL', '-') THEN NULL
        ELSE TRIM(country)
    END AS country,

    NULLIF(TRIM(date_added), '') AS date_added,
    release_year,

    CASE
        WHEN rating IS NULL OR TRIM(rating) = '' THEN NULL
        WHEN UPPER(TRIM(rating)) IN ('N/A', 'NA', 'NONE', 'NULL', '-') THEN NULL
        ELSE TRIM(rating)
    END AS rating,

    NULLIF(TRIM(duration), '') AS duration,

    CASE
        WHEN listed_in IS NULL OR TRIM(listed_in) = '' THEN NULL
        WHEN UPPER(TRIM(listed_in)) IN ('N/A', 'NA', 'NONE', 'NULL', '-') THEN NULL
        ELSE TRIM(listed_in)
    END AS listed_in,

    CASE
        WHEN description IS NULL OR TRIM(description) = '' THEN NULL
        WHEN UPPER(TRIM(description)) IN ('N/A', 'NA', 'NONE', 'NULL', '-') THEN NULL
        ELSE TRIM(description)
    END AS description
FROM netflix_raw;

-- ============================================================
-- Step 2: Standardize formats
-- What we do:
-- - Standardize text formats and category labels
-- - Parse date string to DATE type-friendly format
-- - Normalize duration unit text (min/mins -> min, season/seasons)
-- Note: Dataset has no currency column, so unit standardization is
-- demonstrated with duration values.
-- ============================================================
CREATE VIEW netflix_clean_standardized AS
SELECT
    show_id,

    CASE
        WHEN type IS NULL THEN NULL
        WHEN UPPER(type) = 'MOVIE' THEN 'Movie'
        WHEN UPPER(type) IN ('TV SHOW', 'TVSHOW') THEN 'TV Show'
        ELSE type
    END AS type,

    title,
    director,
    `cast`,
    country,

    STR_TO_DATE(date_added, '%M %d, %Y') AS date_added,
    release_year,

    CASE
        WHEN rating IS NULL THEN NULL
        WHEN UPPER(rating) IN ('NR', 'UR') THEN 'Not Rated'
        ELSE rating
    END AS rating,

    CASE
        WHEN duration IS NULL THEN NULL
        WHEN LOWER(duration) LIKE '%mins' THEN REPLACE(LOWER(duration), 'mins', 'min')
        WHEN LOWER(duration) LIKE '%mins.' THEN REPLACE(LOWER(duration), 'mins.', 'min')
        WHEN LOWER(duration) LIKE '%season' THEN REPLACE(LOWER(duration), 'season', 'seasons')
        ELSE duration
    END AS duration,

    listed_in,
    description
FROM netflix_clean_missing_handled;

-- ============================================================
-- Step 3: Fix data types
-- What we do:
-- - Validate release_year range
-- - Split duration into numeric + unit style columns
-- - Build numeric columns for analysis (movie_minutes, tv_seasons)
-- ============================================================
CREATE VIEW netflix_clean_typed AS
SELECT
    show_id,
    type,
    title,
    director,
    `cast`,
    country,
    date_added,

    CASE
        WHEN release_year BETWEEN 1900 AND YEAR(CURDATE()) + 1 THEN release_year
        ELSE NULL
    END AS release_year,

    rating,
    duration,
    listed_in,
    description,

    CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS duration_value,
    LOWER(TRIM(SUBSTRING_INDEX(duration, ' ', -1))) AS duration_unit,

    CASE
        WHEN type = 'Movie' AND LOWER(duration) LIKE '%min%' THEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
        ELSE NULL
    END AS movie_minutes,

    CASE
        WHEN type = 'TV Show' AND LOWER(duration) LIKE '%season%' THEN CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED)
        ELSE NULL
    END AS tv_seasons
FROM netflix_clean_standardized;

-- ============================================================
-- Step 4: Remove duplicates
-- What we do:
-- - Use show_id when available
-- - Fall back to type + title + release_year business key
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
    description,
    duration_value,
    duration_unit,
    movie_minutes,
    tv_seasons
FROM (
    SELECT
        nct.*,
        ROW_NUMBER() OVER (
            PARTITION BY COALESCE(show_id, CONCAT(IFNULL(type, ''), '|', IFNULL(title, ''), '|', IFNULL(release_year, '')))
            ORDER BY date_added DESC, title
        ) AS rn
    FROM netflix_clean_typed nct
) x
WHERE rn = 1;

-- ============================================================
-- Step 5: Correct inconsistencies
-- What we do:
-- - Re-map obvious misplaced rating values (e.g., '74 min')
-- - Normalize country fallback and title fallback in final stage
-- ============================================================
CREATE VIEW netflix_clean_consistent AS
SELECT
    show_id,
    type,
    title,
    director,
    `cast`,
    country,
    date_added,
    release_year,

    CASE
        WHEN rating REGEXP '^[0-9]+[[:space:]]*min$' THEN 'Not Rated'
        ELSE rating
    END AS rating,

    duration,
    listed_in,
    description,
    duration_value,
    duration_unit,
    movie_minutes,
    tv_seasons
FROM netflix_clean_dedup;

-- ============================================================
-- Step 6: Handle outliers
-- What we do:
-- - Flag suspicious movie durations (<40 or >240)
-- - Flag suspicious TV seasons (>20)
-- - Keep rows, but expose outlier flags for learning and review
-- ============================================================
CREATE VIEW netflix_clean_outlier_flags AS
SELECT
    *,
    CASE
        WHEN movie_minutes IS NOT NULL AND (movie_minutes < 40 OR movie_minutes > 240) THEN 1
        ELSE 0
    END AS flag_movie_duration_outlier,

    CASE
        WHEN tv_seasons IS NOT NULL AND tv_seasons > 20 THEN 1
        ELSE 0
    END AS flag_tv_seasons_outlier
FROM netflix_clean_consistent;

-- ============================================================
-- Step 7: Prepare final cleaned dataset
-- What we do:
-- - Fill remaining NULLs with clear defaults
-- - Add helper date columns and timeline metric
-- ============================================================
CREATE VIEW netflix_clean_pre_final AS
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
    movie_minutes,
    tv_seasons,

    CASE
        WHEN date_added IS NOT NULL AND release_year IS NOT NULL AND YEAR(date_added) >= release_year
        THEN YEAR(date_added) - release_year
        ELSE NULL
    END AS years_to_platform,

    flag_movie_duration_outlier,
    flag_tv_seasons_outlier
FROM netflix_clean_outlier_flags;

-- ============================================================
-- Step 8: Data validation after cleaning
-- What we do:
-- - Add validation flags to verify business rules
-- ============================================================
CREATE VIEW netflix_clean_validated AS
SELECT
    *,
    CASE WHEN release_year IS NULL THEN 1 ELSE 0 END AS flag_release_year_missing,
    CASE WHEN date_added IS NULL THEN 1 ELSE 0 END AS flag_date_added_missing,
    CASE WHEN rating = 'Not Rated' THEN 1 ELSE 0 END AS flag_rating_defaulted,
    CASE
        WHEN type = 'Movie' AND movie_minutes IS NULL AND duration <> 'Unknown Duration' THEN 1
        ELSE 0
    END AS flag_movie_duration_parse_issue,
    CASE
        WHEN type = 'TV Show' AND tv_seasons IS NULL AND duration <> 'Unknown Duration' THEN 1
        ELSE 0
    END AS flag_tv_seasons_parse_issue
FROM netflix_clean_pre_final;

-- Final views used by downstream scripts
CREATE VIEW netflix_clean_final AS
SELECT *
FROM netflix_clean_validated;

-- Compatibility alias
CREATE VIEW netflix_clean AS
SELECT *
FROM netflix_clean_final;

-- ============================================================
-- Step 9: Cleaning audit summary view
-- What we do:
-- - Summarize quality improvements and remaining issues
-- ============================================================
CREATE VIEW netflix_clean_audit AS
SELECT
    (SELECT COUNT(*) FROM netflix_raw) AS raw_rows,
    (SELECT COUNT(*) FROM netflix_clean_missing_handled) AS missing_handled_rows,
    (SELECT COUNT(*) FROM netflix_clean_standardized) AS standardized_rows,
    (SELECT COUNT(*) FROM netflix_clean_typed) AS typed_rows,
    (SELECT COUNT(*) FROM netflix_clean_dedup) AS dedup_rows,
    (SELECT COUNT(*) FROM netflix_clean_final) AS clean_rows,
    (SELECT COUNT(*) FROM netflix_raw) - (SELECT COUNT(*) FROM netflix_clean_dedup) AS duplicates_removed,

    SUM(CASE WHEN director = 'Unknown' THEN 1 ELSE 0 END) AS missing_director_after_clean,
    SUM(CASE WHEN `cast` = 'Unknown' THEN 1 ELSE 0 END) AS missing_cast_after_clean,
    SUM(CASE WHEN country = 'Unknown' THEN 1 ELSE 0 END) AS missing_country_after_clean,
    SUM(flag_date_added_missing) AS missing_date_added_after_clean,
    SUM(flag_release_year_missing) AS missing_release_year_after_clean,
    SUM(flag_rating_defaulted) AS rating_defaulted_after_clean,
    SUM(flag_movie_duration_outlier) AS movie_duration_outliers,
    SUM(flag_tv_seasons_outlier) AS tv_season_outliers,
    SUM(flag_movie_duration_parse_issue) AS movie_duration_parse_issues,
    SUM(flag_tv_seasons_parse_issue) AS tv_season_parse_issues
FROM netflix_clean_final;

-- Learning checks (run manually if needed):
-- SELECT * FROM netflix_clean_audit;
-- SELECT * FROM netflix_clean_final LIMIT 10;
-- SELECT * FROM netflix_clean_final WHERE flag_movie_duration_outlier = 1 LIMIT 10;
-- SELECT * FROM netflix_clean_final WHERE flag_tv_seasons_outlier = 1 LIMIT 10;
