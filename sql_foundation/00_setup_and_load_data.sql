-- ============================================================================
-- FILE: 00_setup_and_load_data.sql
-- PURPOSE: Create Netflix database and load data from CSV file
-- SKILL: Database setup, data import preparation
-- ============================================================================

-- Drop existing database if it exists (for fresh start)
DROP DATABASE IF EXISTS netflix_eda;

-- Create a new database for Netflix EDA
CREATE DATABASE netflix_eda;

-- Use the newly created database
USE netflix_eda;

-- ============================================================================
-- CREATE TABLE: netflix_titles
-- This table will store all Netflix shows and movies data
-- ============================================================================
CREATE TABLE netflix_titles (
    show_id VARCHAR(20) PRIMARY KEY,           -- Unique identifier (s1, s2, etc.)
    type VARCHAR(50) NOT NULL,                 -- Movie or TV Show
    title TEXT NOT NULL,                       -- Title of the show/movie (TEXT for long titles)
    director TEXT,                             -- Director(s) - can be NULL (multiple directors, comma-separated)
    cast TEXT,                                 -- Cast members - can be NULL (multiple actors, comma-separated)
    country TEXT,                              -- Country/Countries - can be NULL (TEXT for multiple values)
    date_added VARCHAR(50),                    -- When added to Netflix - can be NULL
    release_year INT,                          -- Year the content was released
    rating VARCHAR(20),                        -- Content rating (PG, TV-MA, etc.)
    duration VARCHAR(50),                      -- Duration (can be "90 min" or "2 Seasons")
    listed_in TEXT,                            -- Categories/Genres (comma-separated, TEXT for multiple values)
    description TEXT                           -- Full description of the content
);

-- ============================================================================
-- LOAD DATA FROM CSV FILE
-- This loads the netflix_titles.csv file into the table
-- NOTE: Adjust the file path based on your actual file location
-- ============================================================================
LOAD DATA LOCAL INFILE 'C:/ABSP/PIMS/PIMS Projects/Netflix EDA Project/data/netflix_titles.csv'
INTO TABLE netflix_titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description);

-- ============================================================================
-- VERIFICATION QUERIES
-- ============================================================================

-- Check total number of records loaded
SELECT COUNT(*) AS total_records FROM netflix_titles;

-- Display first 5 records to verify data loaded correctly
SELECT * FROM netflix_titles LIMIT 5;

-- Check the data types and structure
DESCRIBE netflix_titles;

-- Check basic statistics about the data
SELECT 
    'Total Records' AS metric,
    COUNT(*) AS value
FROM netflix_titles
UNION ALL
SELECT 
    'Movies',
    COUNT(*) 
FROM netflix_titles 
WHERE type = 'Movie'
UNION ALL
SELECT 
    'TV Shows',
    COUNT(*) 
FROM netflix_titles 
WHERE type = 'TV Show'
UNION ALL
SELECT 
    'Missing Directors',
    COUNT(*) 
FROM netflix_titles 
WHERE director IS NULL OR director = ''
UNION ALL
SELECT 
    'Missing Cast',
    COUNT(*) 
FROM netflix_titles 
WHERE cast IS NULL OR cast = ''
UNION ALL
SELECT 
    'Missing Countries',
    COUNT(*) 
FROM netflix_titles 
WHERE country IS NULL OR country = '';
