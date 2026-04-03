-- This line selects the netflix_db database so all queries run on the correct database
USE netflix_db;

-- This section checks how many total records exist in the dataset

-- This query counts the number of rows stored in the netflix_raw table
SELECT COUNT(*) AS total_records
FROM netflix_raw;

-- This section analyzes the distribution of content types

-- This query groups the dataset by type to count how many Movies and TV Shows exist
SELECT type, COUNT(*) AS total_titles
FROM netflix_raw
GROUP BY type;

-- This section checks for missing values in important columns

-- This query calculates how many rows have missing director values
SELECT COUNT(*) - COUNT(director) AS missing_director
FROM netflix_raw;

-- This query calculates how many rows have missing cast values
SELECT COUNT(*) - COUNT(cast) AS missing_cast
FROM netflix_raw;

-- This query calculates how many rows have missing country values
SELECT COUNT(*) - COUNT(country) AS missing_country
FROM netflix_raw;

-- This section inspects the unique genre combinations present in the dataset

-- This query retrieves distinct values from the listed_in column to understand genre categories
SELECT DISTINCT listed_in
FROM netflix_raw
LIMIT 20;

-- This section previews a small sample of the dataset

-- This query displays the first five rows to inspect raw data structure
SELECT *
FROM netflix_raw
LIMIT 5;