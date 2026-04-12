# 📺 Netflix EDA Project (MySQL)

## 🔎 Quick Glance

- Domain: OTT Content Analytics
- Database: MySQL 8+
- Focus: KPI and business-question driven EDA
- Final analysis script: [sql/04.DataAnalysis.sql](sql/04.DataAnalysis.sql)

## 🧭 Overview

This project analyzes Netflix catalog data with MySQL and answers business-focused questions using one main KPI/business query script.

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

## 🧹 Data Preparation

The table schema is defined in [sql/01_create_tables.sql](sql/01_create_tables.sql) and raw data is loaded using [sql/02_load_data.sql](sql/02_load_data.sql).

KPI and business analysis queries are executed from [sql/04.DataAnalysis.sql](sql/04.DataAnalysis.sql).

---

## 📊 KPI Coverage

The KPI queries are mapped in [sql/04.DataAnalysis.sql](sql/04.DataAnalysis.sql):

- 1. Type Mix Percentage
- 2. Rating Share Percentage
- 3. Yearly Additions
- 4. Top-5 Country Share Percentage
- 5. Top-5 Genre Share Percentage

---

## ❓ Key Business Questions

1. What share of the catalog is Movies vs TV Shows?
2. Which audience ratings are most common?
3. Is catalog growth increasing or slowing over time?
4. Which countries contribute the most titles?
5. Which genres are most common?
6. Is there concentration risk in countries or genres?

---

## 📌 Results Snapshot

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
- Approach: SQL-based KPI and business question analysis

---

## 🗂️ Project Structure

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
    └── 04.DataAnalysis.sql
```

---

## ▶️ How to Run

Open MySQL and run scripts in this exact order:

1. SOURCE sql/01_create_tables.sql;
2. SOURCE sql/02_load_data.sql;
3. SOURCE sql/04.DataAnalysis.sql;

Optional quick preview:

4. SOURCE sql/03_data_exploration.sql;

If loading fails with local infile error, enable it on server and run again.

---

## 💼 Recruiter Highlights

This project demonstrates:

- Strong SQL fundamentals with business framing
- Practical data cleaning and validation in MySQL
- KPI-first analysis with clear interpretation
- Reproducible and reviewer-friendly project structure
- Interview-ready storytelling from raw data to recommendations

## 🧩 Section Guide

- Project context: Overview, Business Objective
- Execution flow: Data Preparation, How to Run
- Analytical value: KPI Coverage, Results Snapshot
- Hiring signal: Recruiter Highlights
