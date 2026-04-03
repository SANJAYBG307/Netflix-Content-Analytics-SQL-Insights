-- This line creates a new database called netflix_db if it does not already exist
CREATE DATABASE IF NOT EXISTS netflix_db;

-- This line tells MySQL to use the netflix_db database for all following commands
USE netflix_db;

-- This line begins the creation of a table called netflix_raw that will store the raw dataset
CREATE TABLE IF NOT EXISTS netflix_raw (

-- This column stores the unique ID of each Netflix title
show_id VARCHAR(10),

-- This column stores whether the content is a Movie or TV Show
type VARCHAR(20),

-- This column stores the title of the movie or TV show
title VARCHAR(255),

-- This column stores the director name
director TEXT,

-- This column stores the list of actors in the content
cast TEXT,

-- This column stores the country where the content was produced
country TEXT,

-- This column stores the date the content was added to Netflix
date_added VARCHAR(50),

-- This column stores the year the content was originally released
release_year INT,

-- This column stores the audience rating classification
rating VARCHAR(20),

-- This column stores the duration of the movie or number of seasons
duration VARCHAR(50),

-- This column stores the genre categories of the content
listed_in TEXT,

-- This column stores the description of the content
description TEXT

-- This line ends the table creation command
);