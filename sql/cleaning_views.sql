-- This line selects the netflix_db database so the script runs on the correct database
USE netflix_db;

-- This line removes the existing view if it already exists to avoid duplication errors
DROP VIEW IF EXISTS netflix_clean;

-- This line begins the creation of a new SQL view called netflix_clean
CREATE VIEW netflix_clean AS

-- This section selects and cleans columns from the raw table
SELECT

-- This column trims the show_id value and converts blanks to NULL
NULLIF(TRIM(show_id), '') AS show_id,

-- This column normalizes type values and fills missing values with 'Unknown'
COALESCE(NULLIF(TRIM(type), ''), 'Unknown') AS type,

-- This column trims title text and keeps NULL when blank
NULLIF(TRIM(title), '') AS title,

-- This line trims director text and fills missing values with 'Unknown'
COALESCE(NULLIF(TRIM(director), ''), 'Unknown') AS director,

-- This line trims cast text and fills missing values with 'Unknown'
COALESCE(NULLIF(TRIM(`cast`), ''), 'Unknown') AS `cast`,

-- This line trims country text and fills missing values with 'Unknown'
COALESCE(NULLIF(TRIM(country), ''), 'Unknown') AS country,

-- This line converts date_added text into DATE and keeps NULL when blank
STR_TO_DATE(NULLIF(TRIM(date_added), ''), '%M %d, %Y') AS date_added,

-- This column keeps release_year and converts 0 to NULL if present
NULLIF(release_year, 0) AS release_year,

-- This line trims rating text and fills missing values with 'Not Rated'
COALESCE(NULLIF(TRIM(rating), ''), 'Not Rated') AS rating,

-- This column trims duration text and keeps NULL when blank
NULLIF(TRIM(duration), '') AS duration,

-- This line trims genre text and fills missing values with 'Unspecified'
COALESCE(NULLIF(TRIM(listed_in), ''), 'Unspecified') AS listed_in,

-- This line trims description text and fills missing values with a default message
COALESCE(NULLIF(TRIM(description), ''), 'No description available') AS description

-- This line specifies that the data source for the view is the raw Netflix table
FROM netflix_raw;