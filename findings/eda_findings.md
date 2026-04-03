# Netflix Catalog EDA Findings

Date of analysis: April 3, 2026  
Database: netflix_db  
Data source: Netflix titles CSV

## Executive Summary

This analysis evaluates Netflix catalog composition, maturity profile, growth pattern, and concentration risk using a cleaned analytical view. The final working dataset contains 8,807 unique titles after standardization and de-duplication.

Key conclusions:

1. The catalog is movie-led, with Movies representing 69.62% of all titles.
2. Content skews toward mature audiences; TV-MA and TV-14 jointly account for 60.94%.
3. Content additions accelerated rapidly from 2016 to 2019, then moderated in 2020 and 2021.
4. Country concentration is moderate, with the top five countries contributing 58.34% of known-country titles.
5. Genre concentration is low at the stored-combination level, with a top-five share of 17.95%.

## Scope and Method

1. SQL scripts were executed sequentially from table creation through EDA.
2. Analysis is performed on netflix_clean_final, produced by a cleaning pipeline that standardizes values and removes duplicates.
3. Country and genre metrics reflect values as stored in single text fields, without splitting multi-value strings into separate rows.

## Execution Validation

Scripts executed successfully in this order:

1. sql/01_create_tables.sql
2. sql/02_load_data.sql
3. sql/03_data_exploration.sql
4. sql/04_cleaning_views.sql
5. sql/05_eda_queries.sql

Result: All scripts completed without SQL errors.

## Data Quality and Pipeline Outcome

| Stage | Records |
|---|---:|
| Raw input rows | 17,614 |
| Standardized rows | 17,614 |
| De-duplicated rows | 8,807 |
| Final cleaned rows | 8,807 |
| Duplicate rows removed | 8,807 |

Post-cleaning missingness audit:

| Field | Missing Count |
|---|---:|
| Director | 2,634 |
| Cast | 825 |
| Country | 831 |
| Date Added | 10 |
| Rating | 4 |
| Genre | 0 |
| Release Year | 0 |

## Core Findings

### 1) Catalog Mix

| Type | Titles | Share |
|---|---:|---:|
| Movie | 6,131 | 69.62% |
| TV Show | 2,676 | 30.38% |

Interpretation: The catalog has materially higher depth in films than in episodic content.

### 2) Audience Rating Distribution

| Rating | Titles | Share |
|---|---:|---:|
| TV-MA | 3,207 | 36.41% |
| TV-14 | 2,160 | 24.53% |
| TV-PG | 863 | 9.80% |
| R | 799 | 9.07% |
| PG-13 | 490 | 5.56% |

Interpretation: Mature and teen-oriented categories dominate the rating profile.

### 3) Title Additions Over Time

| Metric | Value |
|---|---|
| Peak additions year | 2019 |
| Titles added in peak year | 2,016 |
| Titles added in 2021 | 1,498 |
| YoY change (2021 vs 2020) | -381 |

Interpretation: The platform experienced high expansion through 2019, followed by a slowdown.

### 4) Country Concentration

Top countries by title count:

| Country | Titles |
|---|---:|
| United States | 2,818 |
| India | 972 |
| United Kingdom | 419 |
| Japan | 245 |
| South Korea | 199 |

Top-5 country share: 58.34%  
Risk label: Medium concentration risk

Interpretation: Content supply is diversified, but still anchored by a small set of major countries.

### 5) Genre Concentration

Top genre combinations by title count:

| Genre Combination | Titles |
|---|---:|
| Dramas, International Movies | 362 |
| Documentaries | 359 |
| Stand-Up Comedy | 334 |
| Comedies, Dramas, International Movies | 274 |
| Dramas, Independent Movies, International Movies | 252 |

Top-5 genre share: 17.95%  
Risk label: Low concentration risk

Interpretation: No single genre combination dominates the catalog, indicating broad thematic variety.

## Limitations and Notes

1. Country and genre fields are multi-value text in source data; this report treats each row as stored for a beginner-friendly, single-table analysis.
2. A small number of rating anomalies remain in the source (for example, duration-like values in the rating field).
3. Missing director, cast, and country values are not imputed for analytical interpretation; they are tracked transparently in the audit view.

## Portfolio Relevance

This project demonstrates:

1. End-to-end SQL workflow execution with reproducible script order.
2. Data cleaning design using layered views and auditability.
3. KPI-oriented EDA with clear business interpretation.
4. Communication of findings in a concise, stakeholder-ready format.
