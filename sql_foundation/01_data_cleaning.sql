-- ============================================================================
-- FILE: 01_data_cleaning.sql
-- PURPOSE: Learn Data Cleaning Skills - ONE simple example per skill
-- LEVEL: Foundation & Intermediate SQL
-- ============================================================================

USE netflix_eda;

-- ============================================================================
-- SKILL 1: HANDLING MISSING VALUES (NULL or empty strings)
-- ============================================================================

-- EXAMPLE: Find missing values in director column
-- Show records where director is NULL or empty
SELECT 
    show_id,
    title,
    director,
    CASE 
        WHEN director IS NULL THEN 'NULL value'
        WHEN director = '' THEN 'Empty string'
        ELSE 'Has value'
    END AS director_status
FROM netflix_titles
WHERE director IS NULL OR director = ''
LIMIT 10;

-- ============================================================================
-- SKILL 2: REMOVING DUPLICATES
-- ============================================================================

-- EXAMPLE: Find duplicate titles
-- Check if same title appears multiple times (potential duplicates)
SELECT 
    title,
    type,
    COUNT(*) AS duplicate_count
FROM netflix_titles
GROUP BY title, type
HAVING COUNT(*) > 1
LIMIT 10;

-- ============================================================================
-- SKILL 3: FIXING DATA TYPES
-- ============================================================================

-- EXAMPLE: Convert date string to proper DATE type
-- The date_added column is VARCHAR but should be DATE
-- Convert 'September 25, 2021' to DATE format
SELECT 
    show_id,
    title,
    date_added AS original_format,
    -- Convert to proper DATE type
    STR_TO_DATE(date_added, '%M %d, %Y') AS converted_to_date
FROM netflix_titles
WHERE date_added IS NOT NULL AND date_added != ''
LIMIT 5;

-- ============================================================================
-- SKILL 4: STANDARDIZING FORMATS (dates, numbers, text)
-- ============================================================================

-- EXAMPLE: Standardize text by trimming spaces and converting to uppercase
-- Remove leading/trailing spaces and make rating consistent
SELECT 
    show_id,
    rating AS original,
    TRIM(rating) AS trimmed,
    UPPER(TRIM(rating)) AS standardized
FROM netflix_titles
WHERE rating IS NOT NULL
LIMIT 10;

-- ============================================================================
-- SKILL 5: HANDLING OUTLIERS
-- ============================================================================

-- EXAMPLE: Find unusual release years (potential outliers)
-- Check for very old content that seems unusual
SELECT 
    show_id,
    title,
    release_year
FROM netflix_titles
WHERE release_year < 1950  -- Very old, potential outliers
ORDER BY release_year ASC
LIMIT 10;

-- ============================================================================
-- SKILL 6: CORRECTING INCONSISTENCIES
-- ============================================================================

-- EXAMPLE: Fix duration format inconsistencies
-- Some TV Shows might be stored as "2 Seasons" and some as just "2"
SELECT 
    show_id,
    title,
    type,
    duration AS original_duration,
    -- Correct: ensure TV Shows have "Seasons" label
    CASE 
        WHEN type = 'TV Show' AND duration LIKE '% Season%' THEN duration
        WHEN type = 'TV Show' THEN CONCAT(duration, ' Seasons')
        ELSE duration
    END AS corrected_duration
FROM netflix_titles
WHERE type = 'TV Show'
LIMIT 10;

-- ============================================================================
-- SKILL 7: MERGING DATASETS (combining data from different sources)
-- ============================================================================

-- EXAMPLE: Create a summary by joining type and rating information
-- Combine type and rating information to understand content better
SELECT 
    type,
    rating,
    COUNT(*) AS total_count
FROM netflix_titles
WHERE type IS NOT NULL AND rating IS NOT NULL
GROUP BY type, rating
ORDER BY total_count DESC
LIMIT 10;

-- ============================================================================
-- SKILL 8: FEATURE CREATION (basic - extracting useful info)
-- ============================================================================

-- EXAMPLE: Extract the primary (first) director from comma-separated list
-- Create a new feature: primary_director from director field
SELECT 
    show_id,
    title,
    director AS all_directors,
    -- Extract first director
    SUBSTRING_INDEX(director, ',', 1) AS primary_director,
    -- Count how many directors
    (LENGTH(director) - LENGTH(REPLACE(director, ',', '')) + 1) AS director_count
FROM netflix_titles
WHERE director IS NOT NULL AND director != ''
LIMIT 10;

-- ============================================================================
-- SKILL 9: DATA VALIDATION (verify data quality after cleaning)
-- ============================================================================

-- EXAMPLE: Create a data quality report
-- Check: How complete is our data? What needs attention?
SELECT 
    'Total Records' AS check_name,
    COUNT(*) AS count
FROM netflix_titles

UNION ALL

SELECT 
    'Records with Director',
    COUNT(*) 
FROM netflix_titles 
WHERE director IS NOT NULL AND director != ''

UNION ALL

SELECT 
    'Records with Cast',
    COUNT(*) 
FROM netflix_titles 
WHERE cast IS NOT NULL AND cast != ''

UNION ALL

SELECT 
    'Records with Valid Release Year',
    COUNT(*) 
FROM netflix_titles 
WHERE release_year IS NOT NULL

UNION ALL

SELECT 
    'Records with Valid Date Added',
    COUNT(*) 
FROM netflix_titles 
WHERE date_added IS NOT NULL AND date_added != ''

UNION ALL

SELECT 
    'Complete Records (all fields)',
    COUNT(*) 
FROM netflix_titles 
WHERE director IS NOT NULL AND director != ''
    AND cast IS NOT NULL AND cast != ''
    AND country IS NOT NULL AND country != ''
    AND date_added IS NOT NULL AND date_added != '';

-- ============================================================================
-- SUMMARY: Data Cleaning Concepts You've Learned
-- ============================================================================
-- 
-- 1. Missing Values: Use IS NULL and = '' to find and handle them
-- 2. Duplicates: Use GROUP BY with HAVING COUNT(*) > 1 to find them
-- 3. Data Types: Use STR_TO_DATE() to convert strings to dates
-- 4. Standardization: Use TRIM(), UPPER(), LOWER() for consistent formats
-- 5. Outliers: Use WHERE clause with MIN/MAX to find unusual values
-- 6. Inconsistencies: Use CASE WHEN to correct format differences
-- 7. Merging: Use GROUP BY and aggregation to combine related data
-- 8. Feature Creation: Use SUBSTRING_INDEX() to extract parts of text
-- 9. Validation: Count records and check completeness with aggregation
--
-- KEY FUNCTIONS USED:
-- - IS NULL / != '' : Check for missing data
-- - STR_TO_DATE() : Convert string to DATE
-- - TRIM() : Remove whitespace
-- - UPPER() / LOWER() : Convert case
-- - SUBSTRING_INDEX() : Extract part of text
-- - LENGTH() & REPLACE() : Count characters
-- - CASE WHEN : Conditional logic
-- - GROUP BY & COUNT() : Count occurrences
-- ============================================================================
