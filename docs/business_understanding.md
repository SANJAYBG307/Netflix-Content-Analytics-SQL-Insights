# Netflix Catalog Intelligence Business Understanding

## Business Problem

The raw Netflix data has many repeated rows and messy values. Because of this, direct reporting can give wrong results. The business needs clean and reliable numbers to understand content mix, growth over time, and whether too much content comes from only a few countries or genres.

## Stakeholders

1. Management team: tracks catalog growth and risk.
2. Content Strategy team: decides movie vs TV Show balance and rating focus.
3. Acquisition team: decides from which countries and genres to buy more content.
4. Data and BI team: prepares and tracks KPI reports regularly.

## Business Context

This project uses Netflix catalog data in MySQL. The raw table is cleaned using SQL views step by step. All final analysis is done on the cleaned view, netflix_clean_final, not on raw data.

Cleaning includes fixing missing values, standardizing fields, correcting data types, removing duplicates, flagging outliers, and validating data quality. After cleaning, we keep 8,807 unique titles from 26,421 raw rows.

## Business Objective

Create a repeatable SQL workflow that turns raw data into business-ready KPIs. The goal is to measure catalog mix, rating profile, growth trend, and concentration risk so teams can make better content and acquisition decisions.

## Business Questions

1. What is the final split between Movies and TV Shows?
2. Which ratings are most common?
3. How many titles are added each year, and how does this change year by year?
4. How much of the catalog comes from the top 5 countries?
5. How much of the catalog comes from the top 5 genre groups?
6. Are there any data quality issues that can affect business decisions?

## KPIs

1. Type Mix Percentage: Movie vs TV Show share.
2. Rating Share Percentage: share of titles by rating.
3. Yearly Additions and YoY Change: titles added per year and yearly increase/decrease.
4. Top-5 Country Share Percentage: share contributed by top 5 countries (excluding Unknown).
5. Top-5 Genre Share Percentage: share contributed by top 5 genre combinations.

## Analytical Focus

The analysis focuses on practical business use:

1. Content mix: Movie vs TV Show and rating breakdown.
2. Growth trend: yearly additions and slowdown after peak years.
3. Concentration risk: dependency on top countries and top genres.
4. Data trust: checks for missing values, defaults, duplicates, and outlier flags.

This business understanding is directly linked to the SQL cleaning and KPI queries, so findings and recommendations are based on one consistent data source.