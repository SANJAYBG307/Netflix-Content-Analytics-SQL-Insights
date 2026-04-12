# Netflix EDA Findings

Date: April 12, 2026  
Database: netflix_db  
Main table used for analysis: netflix_raw

## Scope

This report answers the KPIs and business questions defined in [docs/business_understanding.md](docs/business_understanding.md), using results validated by running [sql/04.DataAnalysis.sql](sql/04.DataAnalysis.sql).

## Scripts Run

1. [sql/01_create_tables.sql](sql/01_create_tables.sql)
2. [sql/02_load_data.sql](sql/02_load_data.sql)
3. [sql/04.DataAnalysis.sql](sql/04.DataAnalysis.sql)

## Data Summary

| Metric | Value |
|---|---:|
| Final rows analyzed | 8,807 |
| Missing country (Unknown) | 831 |
| Missing rating (Not Rated) | 90 |
| Missing date_added | 10 |

## KPI Answers

### KPI 1: Type Mix Percentage

| Type | Titles | Share |
|---|---:|---:|
| Movie | 6,131 | 69.62% |
| TV Show | 2,676 | 30.38% |

### KPI 2: Rating Share Percentage

| Rating | Titles | Share |
|---|---:|---:|
| TV-MA | 3,207 | 36.41% |
| TV-14 | 2,160 | 24.53% |
| TV-PG | 863 | 9.80% |
| R | 799 | 9.07% |
| PG-13 | 490 | 5.56% |

### KPI 3: Yearly Additions and YoY Change

| Metric | Value |
|---|---:|
| Peak year | 2019 |
| Titles added in peak year | 2,016 |
| Titles added in 2020 | 1,879 |
| Titles added in 2021 | 1,498 |
| YoY change (2021 vs 2020) | -381 |

### KPI 4: Top-5 Country Share Percentage

| Metric | Value |
|---|---:|
| Top-5 country share (excluding Unknown) | 58.34% |
| Risk level | Medium |

Top 5 countries:

| Country | Titles |
|---|---:|
| United States | 2,818 |
| India | 972 |
| United Kingdom | 419 |
| Japan | 245 |
| South Korea | 199 |

### KPI 5: Top-5 Genre Share Percentage

| Metric | Value |
|---|---:|
| Top-5 genre share | 17.95% |
| Risk level | Low |

Top 5 genre groups:

| Genre | Titles |
|---|---:|
| Dramas, International Movies | 362 |
| Documentaries | 359 |
| Stand-Up Comedy | 334 |
| Comedies, Dramas, International Movies | 274 |
| Dramas, Independent Movies, International Movies | 252 |

## Business Question Answers

1. Final split between Movies and TV Shows: 69.62% Movies and 30.38% TV Shows.
2. Most common ratings: TV-MA and TV-14.
3. Yearly growth trend: additions rose to a peak in 2019, then slowed in 2020 and 2021.
4. Catalog share from top 5 countries: 58.34% (excluding Unknown), which indicates medium concentration.
5. Catalog share from top 5 genre groups: 17.95%, which indicates low concentration.
6. Data quality issues affecting decisions:
	- 831 records with Unknown country
	- 90 records with Not Rated
	- 10 records missing date_added
	- 7 duplicate titles still present by title text check (each appears twice)

Duplicate titles found:

| Title | Duplicate Count |
|---|---:|
| Ares | 2 |
| Death Note | 2 |
| Esperando la carroza | 2 |
| FullMetal Alchemist | 2 |
| Love in a Puff | 2 |
| Sin senos si hay paraiso | 2 |
| Veronica | 2 |

## Recommendations

1. Keep strong movie supply but increase high-quality TV Show acquisition to improve balance.
2. Reduce country concentration risk by adding more titles from non-top-5 countries.
3. Continue investment in top genres while testing adjacent genres for diversification.
4. Add a recurring data quality check before each reporting cycle for country, rating, date_added, and title duplicates.

## Final Note

This analysis is based on catalog metadata and does not include watch-time, engagement, or revenue metrics.
