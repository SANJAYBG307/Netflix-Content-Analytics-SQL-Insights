# Netflix EDA Findings (Simple Report)

Date: April 5, 2026  
Database: netflix_db  
Main view used for analysis: netflix_clean_final

## What this report is about

This report gives clear answers to the business questions and KPIs from the project. All EDA numbers are taken from the cleaned view, not from the raw table.

## Scripts run

I ran these files in order:

1. sql/01_create_tables.sql
2. sql/02_load_data.sql
3. sql/03_data_exploration.sql
4. sql/04_cleaning_views.sql
5. sql/05_eda_queries.sql

Note:

1. LOAD DATA LOCAL INFILE worked after enabling local_infile on MySQL server.

## Data cleaning summary

| Stage | Rows |
|---|---:|
| Raw rows | 26,421 |
| After missing value handling | 26,421 |
| After standardization | 26,421 |
| After type fixes | 26,421 |
| After de-duplication | 8,807 |
| Final cleaned rows | 8,807 |
| Duplicates removed | 17,614 |

Quality checks after cleaning:

| Check | Value |
|---|---:|
| Missing director (set to Unknown) | 2,634 |
| Missing cast (set to Unknown) | 825 |
| Missing country (set to Unknown) | 831 |
| Missing date_added | 10 |
| Missing release_year | 0 |
| Not Rated defaults | 90 |
| Movie duration outliers flagged | 173 |
| TV season outliers flagged | 0 |

## KPI answers

### KPI 1: Type mix

| Type | Titles | Share |
|---|---:|---:|
| Movie | 6,131 | 69.62% |
| TV Show | 2,676 | 30.38% |

### KPI 2: Rating share

Top ratings:

| Rating | Titles | Share |
|---|---:|---:|
| TV-MA | 3,207 | 36.41% |
| TV-14 | 2,160 | 24.53% |
| TV-PG | 863 | 9.80% |
| R | 799 | 9.07% |
| PG-13 | 490 | 5.56% |

### KPI 3: Yearly additions and YoY

| Metric | Value |
|---|---|
| Peak year | 2019 |
| Titles added in peak year | 2,016 |
| Titles added in 2021 | 1,498 |
| YoY change (2021 vs 2020) | -381 |

### KPI 4: Top-5 country share

| Metric | Value |
|---|---:|
| Top-5 country share | 58.34% |
| Risk level | Medium |

Top countries:

| Country | Titles |
|---|---:|
| United States | 2,818 |
| India | 972 |
| United Kingdom | 419 |
| Japan | 245 |
| South Korea | 199 |

### KPI 5: Top-5 genre share

| Metric | Value |
|---|---:|
| Top-5 genre share | 17.95% |
| Risk level | Low |

Top genre combinations:

| Genre | Titles |
|---|---:|
| Dramas, International Movies | 362 |
| Documentaries | 359 |
| Stand-Up Comedy | 334 |
| Comedies, Dramas, International Movies | 274 |
| Dramas, Independent Movies, International Movies | 252 |

## Business question answers

1. Movie vs TV Show share: Movies are 69.62%, TV Shows are 30.38%.
2. Most common ratings: TV-MA and TV-14 are the top two.
3. Growth trend: strong growth up to 2019, then slowdown in 2020 and 2021.
4. Top countries: United States, India, United Kingdom, Japan, and South Korea.
5. Top genres: mostly drama/international combinations, documentaries, and stand-up comedy.
6. Concentration risk: medium by country and low by genre.

## Recommendations for stakeholders

### For Content Strategy

1. Keep movie strength, but increase selected TV Show investments to improve catalog balance.
2. Reduce country concentration risk by expanding content sourcing beyond top countries.
3. Continue investing in strong genre clusters, but test adjacent genres for growth.

### For Content Acquisition

1. Keep strong pipelines in top countries, but add targets for new or underrepresented regions.
2. Review top-5 country share every quarter to track concentration.
3. Use metadata quality checks before ingest completion.

### For Marketing

1. Focus major campaigns on dominant rating segments (TV-MA and TV-14).
2. Plan retention campaigns during slower catalog-addition periods.
3. Promote cross-genre bundles to improve discovery.

### For Data and Analytics Team

1. Add TRUNCATE before reload to avoid repeated appends in raw table.
2. Keep outlier flags active and review flagged rows regularly.
3. Keep validation checks for date parsing, rating cleanup, and required fields.

## Final note

This analysis is based on catalog metadata only. It does not include watch-time, engagement, or revenue behavior.
