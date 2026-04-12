# Netflix EDA Findings

Date: April 12, 2026  
Database: netflix_db  
Main table used for analysis: netflix_raw

## Executive Story

Netflix's catalog in this dataset is movie-led, rating-heavy in mature segments, and showed strong expansion until 2019 before slowing. Country concentration is meaningful, while genre concentration is relatively spread out. The data is usable for business decisions, but a few quality gaps still need monitoring.

## Business Context

The objective was to answer the KPI and business questions defined in [docs/business_understanding.md](docs/business_understanding.md) using one consistent analysis workflow.

Executed scripts:

1. [sql/01_create_tables.sql](sql/01_create_tables.sql)
2. [sql/02_load_data.sql](sql/02_load_data.sql)
3. [sql/04.DataAnalysis.sql](sql/04.DataAnalysis.sql)

## Data Health at a Glance

| Metric | Value |
|---|---:|
| Final rows analyzed | 8,807 |
| Unknown country rows | 831 |
| Not Rated rows | 90 |
| Missing date_added rows | 10 |

Interpretation:

1. Coverage is strong for core analysis.
2. Country field needs attention for better geography-level planning.
3. Date completeness is high, so trend analysis is reliable.

## KPI Narrative

### KPI 1: Type Mix Percentage

| Type | Titles | Share |
|---|---:|---:|
| Movie | 6,131 | 69.62% |
| TV Show | 2,676 | 30.38% |

Story: The catalog is weighted toward Movies (about 7 out of 10 titles), indicating a stronger movie-first content strategy in this dataset period.

### KPI 2: Rating Share Percentage

| Rating | Titles | Share |
|---|---:|---:|
| TV-MA | 3,207 | 36.41% |
| TV-14 | 2,160 | 24.53% |
| TV-PG | 863 | 9.80% |
| R | 799 | 9.07% |
| PG-13 | 490 | 5.56% |

Story: Mature/teen-mature segments dominate (TV-MA + TV-14), which suggests strong focus on older youth and adult audiences.

### KPI 3: Yearly Additions and YoY Change

| Metric | Value |
|---|---:|
| Peak year | 2019 |
| Titles added in peak year | 2,016 |
| Titles added in 2020 | 1,879 |
| Titles added in 2021 | 1,498 |
| YoY change (2021 vs 2020) | -381 |

Story: Growth accelerated to 2019, then entered a slowdown phase. This signals that catalog expansion momentum weakened after peak scale-up.

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

Story: More than half of known-country catalog comes from 5 countries, showing concentration risk that can impact content variety and regional resilience.

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

Story: Genre composition is less concentrated than country composition, which is positive for content breadth.

## Direct Answers to Business Questions

### Q1) What is the split between Movies and TV Shows?
Movies: 69.62% (6,131 titles)  
TV Shows: 30.38% (2,676 titles)

### Q2) Which ratings are most common?
The catalog is dominated by:
1. TV-MA (36.41%)
2. TV-14 (24.53%)

### Q3) How are yearly additions changing?
Additions grew steadily until 2019 (peak: 2,016 titles), then declined:
1. 2020: 1,879
2. 2021: 1,498
3. YoY (2021 vs 2020): -381

### Q4) How much comes from top 5 countries?
Top-5 countries contribute 58.34% of known-country titles, indicating medium concentration risk.

### Q5) How much comes from top 5 genres?
Top-5 genre groups contribute 17.95% of all titles, indicating low concentration risk.

### Q6) Any data-quality issues that affect decisions?
Yes. Important quality gaps still exist:
1. Unknown country: 831 rows
2. Not Rated: 90 rows
3. Missing date_added: 10 rows
4. Duplicate titles by title-text check: 7

### Concentration Summary

| Area | Concentration | Risk | Why it matters |
|---|---:|---|---|
| Country (Top 5) | 58.34% | Medium | Sourcing depends heavily on a small set of countries |
| Genre (Top 5) | 17.95% | Low | Genre mix is relatively diversified |

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

## Actionable Recommendations

1. Protect movie strength but increase targeted TV Show acquisition to improve portfolio balance.
2. Reduce country concentration by expanding sourcing outside the top-5 suppliers.
3. Continue investing in strong genres while deliberately testing adjacent genres.
4. Add recurring quality checks for country completeness, rating normalization, date validity, and duplicate-title detection.

## Final Note

This analysis is based on catalog metadata only and does not include engagement, watch-time, or revenue outcomes.
