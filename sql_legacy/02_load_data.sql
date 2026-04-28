-- This line tells MySQL to use the netflix_db database
USE netflix_db;

-- This line loads the CSV dataset into the netflix_raw table
-- Use an absolute path so MySQL can always locate the CSV file.
LOAD DATA LOCAL INFILE 'C:/ABSP/PIMS/PIMS Projects/Netflix EDA Project/data/netflix_titles.csv'
INTO TABLE netflix_raw
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(show_id, type, title, director, cast, country, date_added, release_year, rating, duration, listed_in, description);