# Netflix EDA SQL Project: Business Understanding

This portfolio project demonstrates how raw catalog metadata can be transformed into analysis-ready data and converted into practical business insights using MySQL.

## Business Context

Netflix maintains a large catalog of Movies and TV Shows across multiple countries, audience ratings, and genre categories. Teams need reliable, easy-to-interpret insights to understand catalog composition, growth behavior, and concentration risk.

## Problem Statement

Raw source data contains missing values, inconsistent text labels, duplicate records, mixed data formats, and potential outliers. If these issues are not handled first, EDA outputs can be misleading and less useful for decision-making.

## Project Objective

Build an end-to-end SQL workflow that:

1. Cleans and validates data using layered views.
2. Produces reproducible, beginner-friendly EDA outputs.
3. Answers core business questions in an interview-ready format.

## Scope

The project focuses on catalog-level EDA with a clear and controlled scope:

1. Content type mix (Movie vs TV Show).
2. Rating distribution.
3. Content additions trend over time.
4. Country contribution and concentration.
5. Genre contribution and concentration.

## Cleaning and Preparation Skills Demonstrated

The cleaning pipeline is intentionally designed for learning and explanation:

1. Handling missing values.
2. Removing duplicates.
3. Fixing data types.
4. Standardizing formats (dates, labels, units).
5. Handling outliers through explicit flags.
6. Correcting inconsistencies in categorical values.
7. Data validation after cleaning through audit and rule flags.

## Key Stakeholders

1. Content Strategy Team: reviews catalog balance and concentration.
2. Acquisition Team: identifies strong source countries and genre opportunities.
3. Marketing Team: aligns campaign messaging with rating and content mix.
4. Recruiters and Portfolio Reviewers: evaluate SQL quality, business framing, and clarity of communication.

## Key Business Questions

1. What percentage of the catalog is Movies vs TV Shows?
2. Which ratings dominate the catalog?
3. How has title addition changed year over year?
4. Which countries contribute most to the catalog?
5. Which genre combinations appear most frequently?
6. Is there concentration risk in countries or genres?

## Core KPIs

1. Type Mix Percentage.
2. Rating Share Percentage.
3. Yearly Additions and YoY Change.
4. Top-5 Country Share Percentage.
5. Top-5 Genre Share Percentage.

## Data and Technical Assumptions

1. EDA is performed on the cleaned analytical view `netflix_clean_final`.
2. MySQL 8+ is required (window functions are used in de-duplication logic).
3. `country` and `listed_in` are analyzed as stored single text values in this version (no row-level splitting).
4. Outliers are flagged for review rather than hard-deleted.

## Risks and Limitations

1. The dataset represents catalog metadata, not watch-time or revenue outcomes.
2. Some text fields are multi-value strings, which can understate granularity without split modeling.
3. A high count in a category does not automatically imply business impact.
4. Remaining unknown values are intentionally preserved with explicit defaults for transparency.

## Expected Portfolio Outcome

1. A clear and reproducible SQL workflow from raw data to validated analytical views.
2. A strong demonstration of practical data cleaning and preparation skills.
3. Business-focused EDA findings that are easy to discuss in interviews.

