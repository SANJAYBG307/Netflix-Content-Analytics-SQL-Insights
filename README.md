# Netflix Content Strategy EDA (MySQL) 📊

> End-to-end SQL EDA project on the Netflix titles dataset, designed as a real analyst case study: clean data model, business questions, reproducible SQL, and quantified recommendations.

## 🔎 At A Glance

![MySQL](https://img.shields.io/badge/SQL-MySQL%208.0-005C84?logo=mysql&logoColor=white)
![EDA](https://img.shields.io/badge/Analysis-Exploratory%20Data%20Analysis-E50914)
![Dataset](https://img.shields.io/badge/Dataset-Netflix%20Titles-black)

## 🧭 Executive Summary

- Catalog size analyzed: 8,807 titles (all unique by `show_id`)
- Portfolio mix: 69.62% Movies (6,131) vs 30.38% TV Shows (2,676)
- Dominant maturity ratings: TV-MA (36.41%) and TV-14 (24.53%)
- Fast growth era: catalog additions peaked in 2019 (2,016), then declined in 2020-2021
- Content source concentration: United States and India lead by a large margin
- Genre concentration: International Movies and Dramas are the strongest content pillars

## 📌 Quick Metrics

| Metric | Value |
|---|---:|
| Total titles analyzed | 8,807 |
| Movies | 6,131 (69.62%) |
| TV Shows | 2,676 (30.38%) |
| Top rating | TV-MA (36.41%) |
| Peak additions year | 2019 (2,016 titles) |
| Largest country after split | United States (3,689) |

## ❓ Business Questions Answered

1. Is the catalog balanced across format, rating, and audience maturity?
2. How did Netflix content additions evolve over time (yearly and monthly)?
3. Which countries and genres drive catalog scale after splitting multi-value fields?
4. How quickly does content reach Netflix after release?
5. What portfolio freshness profile does the catalog show?

## 📈 Key Findings From SQL Outputs

### 1) 🧹 Data quality profile

- Duplicate IDs found: 0
- Missing values in raw data were concentrated in:
  - `director`: 2,634
  - `country`: 831
  - `cast`: 825
  - `date_added`: 10
- Minimal quality issues in critical identifiers (`show_id`, `title`, `type` had no missing values)

### 2) 🎬 Catalog composition

- Movies dominate: 6,131 titles
- TV Shows: 2,676 titles
- Maturity skew: TV-MA and TV-14 together account for 60.94% of catalog

### 3) 📅 Time trends (supply behavior)

- Additions accelerated sharply from 2016 onward:
  - 2016: 429
  - 2017: 1,188
  - 2018: 1,649
  - 2019: 2,016 (peak)
- Slowdown after peak:
  - 2020: -6.80% YoY
  - 2021: -20.28% YoY
- Strongest addition months: July (827), December (813), September (770), April (764)

### 4) 🌍 Geography insights

- Top single-country values in cleaned field:
  - United States: 2,818
  - India: 972
  - Unknown: 831
- After splitting multi-country rows:
  - United States: 3,689
  - India: 1,046
  - United Kingdom: 804
- Format split by country:
  - Movies: US (2,751), India (962), UK (532)
  - TV Shows: US (938), UK (272), Japan (199), South Korea (170)

### 5) 🎭 Genre landscape

- Most frequent genre tags after split:
  - International Movies: 2,752
  - Dramas: 2,427
  - Comedies: 1,674
  - International TV Shows: 1,351
- Multi-genre combinations are common, with global drama-comedy clusters dominating the top patterns.

### 6) 🎤 Talent and format depth

- Most frequent director in catalog: Rajiv Chilaka (19 titles)
- Most frequent cast names are led by Indian cinema talent (for example Anupam Kher, Shah Rukh Khan)
- Movie runtime summary:
  - Average: 99.58 minutes
  - Min: 3 minutes
  - Max: 312 minutes
- TV show season depth:
  - 1 season: 1,793 shows
  - 2 seasons: 425
  - 3 seasons: 199

### 7) ⏱️ Freshness and release lag

- Average release-to-platform lag:
  - Movies: 5.73 years
  - TV Shows: 2.30 years
- Freshness buckets:
  - 2-5 years old: 4,111
  - 6-10 years old: 1,622
  - 0-1 years old: 1,545
  - 10+ years old: 1,529

## 🧠 Business Interpretation

- The catalog is movie-heavy and mature-audience-heavy, indicating clear adult-content positioning.
- Growth deceleration after 2019 suggests a shift from rapid expansion to curation/optimization.
- Geographic exposure is high in the US and India; diversification opportunities exist in secondary regions.
- Genre concentration around International Movies + Dramas can be a strength, but also a discovery/redundancy risk.
- TV Shows reach the platform faster than Movies, supporting series-first freshness strategy.

## 🛠️ SQL Techniques Demonstrated

- Data quality auditing with conditional null/blank profiling
- Window functions (`LAG`, `ROW_NUMBER`, `DENSE_RANK`) for trend and ranking analysis
- CTE-based analytical pipelines for readability and reuse
- Multi-value text normalization using `JSON_TABLE` for country/genre/cast splitting
- Runtime and season parsing with `SUBSTRING_INDEX` and numeric casting

## 📂 Project Structure

```
Netflix EDA Project
├── data/
│   └── netflix_titles.csv
├── docs/
│   └── business_understanding.md
└── sql/
  ├── 01_create_tables.sql
  ├── 02_load_data.sql
  ├── 03_cleaning_views.sql
  ├── 04_data_exploration.sql
  └── 05_eda_queries.sql
```

## ▶️ Repro Steps

```bash
mysql -u root -p
```

Run scripts in this order:

1. `SOURCE sql/01_create_tables.sql;`
2. `SOURCE sql/02_load_data.sql;`
3. `SOURCE sql/03_cleaning_views.sql;`
4. `SOURCE sql/04_data_exploration.sql;`
5. `SOURCE sql/05_eda_queries.sql;`

## 💼 Recruiter Value

This project shows practical analyst skills expected in hiring screens:

- Turning ambiguous business questions into SQL analysis plans
- Handling messy, multi-value fields common in production data
- Combining technical depth with clear, decision-ready storytelling
- Building a structured, reproducible analytics workflow

## ✅ Status

- Analysis completed
- Key EDA outputs validated from MySQL execution
- README upgraded for portfolio and recruiter readability
