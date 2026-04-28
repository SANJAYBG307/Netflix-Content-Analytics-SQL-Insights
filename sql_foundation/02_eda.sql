-- ============================================================================
-- FILE: 02_eda.sql
-- PURPOSE: Learn Exploratory Data Analysis (EDA) - ONE simple example per skill
-- LEVEL: Foundation & Intermediate SQL
-- ============================================================================

USE netflix_eda;

-- ============================================================================
-- SKILL 1: DESCRIPTIVE STATISTICS
-- Mean, Median (middle value), Mode (most common), Standard Deviation (spread)
-- ============================================================================

-- EXAMPLE: Basic statistics for release_year
-- Find average, min, max year, and how spread out years are
SELECT 
    COUNT(*) AS total_titles,
    MIN(release_year) AS oldest_year,
    MAX(release_year) AS newest_year,
    ROUND(AVG(release_year), 0) AS average_year,
    ROUND(STDDEV(release_year), 2) AS year_spread
FROM netflix_titles
WHERE release_year IS NOT NULL;

-- ============================================================================
-- SKILL 2: UNIVARIATE ANALYSIS (analyze ONE variable at a time)
-- ============================================================================

-- EXAMPLE: Analyze the 'type' column independently
-- How many movies vs TV shows? What's the distribution?
SELECT 
    type,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles), 2) AS percentage
FROM netflix_titles
WHERE type IS NOT NULL
GROUP BY type
ORDER BY count DESC;

-- ============================================================================
-- SKILL 3: BIVARIATE ANALYSIS (analyze TWO variables together)
-- ============================================================================

-- EXAMPLE: How does rating differ between Movies and TV Shows?
-- Compare two variables: type vs rating
SELECT 
    type,
    rating,
    COUNT(*) AS count
FROM netflix_titles
WHERE type IS NOT NULL AND rating IS NOT NULL
GROUP BY type, rating
ORDER BY type, count DESC
LIMIT 15;

-- ============================================================================
-- SKILL 4: MULTIVARIATE ANALYSIS (analyze 3+ variables together)
-- ============================================================================

-- EXAMPLE: Analyze Type, Rating, and Release Year together
-- Create a profile: What's typical for each content type?
SELECT 
    type,
    COUNT(*) AS total_count,
    ROUND(AVG(release_year), 0) AS avg_year,
    (SELECT rating 
     FROM netflix_titles nt2 
     WHERE nt2.type = nt1.type 
     GROUP BY rating 
     ORDER BY COUNT(*) DESC 
     LIMIT 1) AS most_common_rating,
    -- Count records with director info
    SUM(CASE WHEN director IS NOT NULL AND director != '' THEN 1 ELSE 0 END) AS with_director
FROM netflix_titles nt1
WHERE type IS NOT NULL
GROUP BY type;

-- ============================================================================
-- SKILL 5: TIME-BASED ANALYSIS (analyze patterns over time)
-- ============================================================================

-- EXAMPLE: How much content was released each year? (Show trend over time)
-- See which years have most content
SELECT 
    release_year,
    COUNT(*) AS content_count
FROM netflix_titles
WHERE release_year >= 2010  -- Focus on recent years
GROUP BY release_year
ORDER BY release_year DESC
LIMIT 15;

-- ============================================================================
-- SKILL 6: SEGMENTATION ANALYSIS (divide data into meaningful groups)
-- ============================================================================

-- EXAMPLE: Segment Netflix content by release era
-- Group content into time periods and compare
SELECT 
    CASE 
        WHEN release_year >= 2020 THEN 'Very Recent (2020+)'
        WHEN release_year >= 2015 THEN 'Recent (2015-2019)'
        WHEN release_year >= 2010 THEN 'Established (2010-2014)'
        ELSE 'Older (Before 2010)'
    END AS era,
    type,
    COUNT(*) AS count
FROM netflix_titles
WHERE release_year IS NOT NULL
GROUP BY era, type
ORDER BY era DESC;

-- ============================================================================
-- SKILL 7: DISTRIBUTION ANALYSIS (understand how data spreads)
-- ============================================================================

-- EXAMPLE: How are ratings distributed? (What ratings are most common?)
-- See the spread of ratings in the dataset
SELECT 
    rating,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_titles WHERE rating IS NOT NULL), 2) AS percentage
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY count DESC;

-- ============================================================================
-- SKILL 8: CORRELATION ANALYSIS (find relationships between variables)
-- ============================================================================

-- EXAMPLE: Is there a relationship between type and having director info?
-- Do certain types have more/less director information?
SELECT 
    type,
    COUNT(*) AS total,
    SUM(CASE WHEN director IS NOT NULL AND director != '' THEN 1 ELSE 0 END) AS with_director,
    SUM(CASE WHEN director IS NULL OR director = '' THEN 1 ELSE 0 END) AS without_director,
    -- Calculate percentage with director
    ROUND(SUM(CASE WHEN director IS NOT NULL AND director != '' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS pct_with_director
FROM netflix_titles
WHERE type IS NOT NULL
GROUP BY type;

-- ============================================================================
-- SUMMARY: EDA Concepts You've Learned
-- ============================================================================
--
-- 1. Descriptive Stats: AVG(), MIN(), MAX(), STDDEV() show data characteristics
-- 
-- 2. Univariate: COUNT(), GROUP BY on ONE variable to see patterns
--
-- 3. Bivariate: Compare TWO variables using GROUP BY with two columns
--
-- 4. Multivariate: GROUP BY multiple columns to create detailed profiles
--
-- 5. Time-Based: Use ORDER BY year/time to see trends
--
-- 6. Segmentation: Use CASE WHEN to create groups, then GROUP BY
--
-- 7. Distribution: COUNT() and percentage to see how spread data is
--
-- 8. Correlation: Compare variables across groups to find relationships
--
-- KEY FUNCTIONS USED:
-- - COUNT() : Count records
-- - AVG() : Calculate average
-- - MIN() / MAX() : Find extremes
-- - STDDEV() : Measure spread
-- - GROUP BY : Organize by categories
-- - SUM() with CASE : Conditional counting
-- - ORDER BY : Sort results
-- - CASE WHEN : Create segments/categories
-- ============================================================================

-- ============================================================================
-- PRACTICE: Try These Modifications
-- ============================================================================
-- 
-- 1. Change "release_year >= 2010" to "release_year >= 2018" in Skill 5
-- 2. Add another column to the GROUP BY in any skill to see more details
-- 3. Change the era ranges in Skill 6 to create different segments
-- 4. Add "LIMIT 5" to queries to see top results
-- 5. Change WHERE conditions to filter specific data
--
-- These modifications help you understand what each part of the query does!
-- ============================================================================
