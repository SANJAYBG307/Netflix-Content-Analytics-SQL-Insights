# Netflix EDA Portfolio Project (MySQL)

Focused SQL EDA project on the Netflix titles dataset. The scope is intentionally small so it is easy to explain in interviews.

## At A Glance

![MySQL](https://img.shields.io/badge/SQL-MySQL%208.0-005C84?logo=mysql&logoColor=white)
![EDA](https://img.shields.io/badge/Analysis-Exploratory%20Data%20Analysis-E50914)
![Dataset](https://img.shields.io/badge/Dataset-Netflix%20Titles-black)

## Project Goal

Use SQL to answer core business questions about catalog mix, growth trend, country contribution, and genre concentration.

## Business Questions (6)

1. What share of the catalog is Movies vs TV Shows?
2. Which audience ratings appear most often?
3. How many titles were added each year, and is the trend growing or slowing?
4. Which countries contribute the highest number of titles?
5. Which genres are most common in the catalog?
6. Are there concentration risks (too much content from a few countries or genres)?

## Core KPIs (5)

1. Type Mix %: percentage of Movies and TV Shows.
2. Top Rating Share %: share of the most common ratings.
3. Yearly Additions: number of titles added each year.
4. Country Concentration %: share of titles from top 5 countries.
5. Genre Concentration %: share of titles from top 5 genres.

## Current Results Snapshot

- Total titles analyzed: 8,807
- Type mix: Movies 69.62%, TV Shows 30.38%
- Top rating: TV-MA (36.41%)
- Peak additions year: 2019 (2,016 titles)
- Top country (as stored in single-table country field): United States (2,818)
- Top genre combinations (as stored in single-table listed_in field):
    - Dramas, International Movies (362)
    - Documentaries (359)
    - Stand-Up Comedy (334)
- Country concentration (Top 5 share): 58.34% (Medium risk)
- Genre concentration (Top 5 share): 17.95% (Low risk)

## SQL File Coverage

The focused KPI queries are in `sql/05_eda_queries.sql`:

1. Type mix query
2. Rating share query
3. Yearly additions + YoY trend query
4. Top countries + top-5 country concentration query (single-table values)
5. Top genres + top-5 genre concentration query (single-table values)
6. Concentration risk labels (low/medium/high)

## Project Structure

```
Netflix EDA Project
├── data/
│   └── netflix_titles.csv
├── docs/
│   └── business_understanding.md
└── sql/
    ├── 01_create_tables.sql
    ├── 02_load_data.sql
    ├── 03_data_exploration.sql
    ├── 04_cleaning_views.sql
    └── 05_eda_queries.sql
```

## Run Steps

```bash
mysql -u root -p
```

Run scripts in this order:

1. `SOURCE sql/01_create_tables.sql;`
2. `SOURCE sql/02_load_data.sql;`
3. `SOURCE sql/03_data_exploration.sql;`
4. `SOURCE sql/04_cleaning_views.sql;`
5. `SOURCE sql/05_eda_queries.sql;`

## Recruiter Value

This project demonstrates:

- Clean SQL problem framing from business questions
- Cleaned-view-first analysis (`netflix_clean_final`) for reliable EDA
- Beginner-friendly SQL with simple, interview-ready queries
- KPI-driven storytelling with a clear and limited scope
- Reproducible workflow from raw data to business insight
