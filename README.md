# 📺 Netflix EDA Project (MySQL)

## 🚀 Project Overview

This project converts raw Netflix catalog data into a clean, analysis-ready dataset using a SQL-based cleaning pipeline and view-driven EDA workflow.

The main objective is to answer business-focused questions with clear KPIs and interview-ready insights.

---

## 🎯 Business Objective

Understand how the Netflix catalog is distributed and changing over time by analyzing:

- Content mix (Movie vs TV Show)
- Audience rating patterns
- Yearly content additions
- Top countries and genre combinations
- Concentration risk in supply

---

## 🧹 Data Preparation Workflow

Implemented in [sql/04_cleaning_views.sql](sql/04_cleaning_views.sql), the pipeline demonstrates key data-cleaning skills:

1. Handling missing values
2. Removing duplicates
3. Fixing data types
4. Standardizing formats (dates, labels, units)
5. Handling outliers with flags
6. Correcting inconsistencies
7. Validating cleaned output with audit checks

Final analytical view used for EDA: netflix_clean_final

---

## 📈 KPI Coverage

The KPI queries are clearly mapped in [sql/05_eda_queries.sql](sql/05_eda_queries.sql):

- 📊 KPI 1: Type Mix Percentage
- 🏷️ KPI 2: Rating Share Percentage
- 📅 KPI 3: Yearly Additions and YoY Change
- 🌍 KPI 4: Top-5 Country Share Percentage
- 🎬 KPI 5: Top-5 Genre Share Percentage

---

## 🔍 Key Business Questions

1. What share of the catalog is Movies vs TV Shows?
2. Which audience ratings are most common?
3. Is catalog growth increasing or slowing over time?
4. Which countries contribute the most titles?
5. Which genres are most common?
6. Is there concentration risk in countries or genres?

---

## 🧾 Current Results Snapshot

- Total cleaned titles analyzed: 8,807
- Movie share: 69.62%
- TV Show share: 30.38%
- Top rating: TV-MA (36.41%)
- Peak additions year: 2019 (2,016 titles)
- Top-5 country share: 58.34% (Medium risk)
- Top-5 genre share: 17.95% (Low risk)

Detailed report: [findings/eda_findings.md](findings/eda_findings.md)  
Business context: [docs/business_understanding.md](docs/business_understanding.md)

---

## 🛠️ Tech Stack

- Database: MySQL 8+
- Language: SQL
- Approach: View-based data cleaning + KPI-driven EDA

---

## 📂 Project Structure

```text
Netflix EDA Project
├── data/
│   └── netflix_titles.csv
├── docs/
│   └── business_understanding.md
├── findings/
│   └── eda_findings.md
└── sql/
    ├── 01_create_tables.sql
    ├── 02_load_data.sql
    ├── 03_data_exploration.sql
    ├── 04_cleaning_views.sql
    └── 05_eda_queries.sql
```

---

## ▶️ How to Run

Open MySQL and run scripts in this exact order:

1. SOURCE sql/01_create_tables.sql;
2. SOURCE sql/02_load_data.sql;
3. SOURCE sql/03_data_exploration.sql;
4. SOURCE sql/04_cleaning_views.sql;
5. SOURCE sql/05_eda_queries.sql;

If loading fails with local infile error, enable it on server and run again.

---

## 💼 Portfolio Value

This project demonstrates:

- Strong SQL fundamentals with business framing
- Practical data cleaning and validation in MySQL
- KPI-first analysis with clear interpretation
- Reproducible and reviewer-friendly project structure
- Interview-ready storytelling from raw data to recommendations
