# Netflix EDA SQL Project: Business Understanding

This is a portfolio project. The goal is to show that I can use SQL to turn raw Netflix catalog data into simple business insights.

## Business Context

Netflix has many titles across movie and TV content. To make better decisions, teams need a quick view of what is in the catalog, where it comes from, and how the catalog is changing over time.

## Problem Statement

Without clear analysis, it is hard to know:

1. If the catalog mix is balanced.
2. Which content ratings are most common.
3. Which countries and genres are leading.
4. Whether new content is being added consistently.

## Project Objective

Build a focused SQL EDA report that answers core catalog questions in a way that is easy for a beginner to explain in interviews.

## Scope (Kept Small on Purpose)

This project is limited to the most useful portfolio insights:

1. Content type mix (Movies vs TV Shows).
2. Rating distribution.
3. Yearly trend of titles added.
4. Top countries by title count.
5. Top genres by title count.

## Key Stakeholders

1. Content Strategy: understands mix and gaps.
2. Acquisition Team: sees strong countries and genres.
3. Marketing Team: aligns campaigns with rating and genre patterns.
4. Portfolio Reviewer/Recruiter: checks SQL thinking and business clarity.

## Key Business Questions (6)

1. What share of the catalog is Movies vs TV Shows?
2. Which audience ratings appear most often?
3. How many titles were added each year, and is the trend growing or slowing?
4. Which countries contribute the highest number of titles?
5. Which genres are most common in the catalog?
6. Are there concentration risks (for example, too much content from a few countries or genres)?

## Core KPIs (5)

1. Type Mix %: percentage of Movies and TV Shows.
2. Top Rating Share %: share of the most common audience ratings.
3. Yearly Additions: number of titles added per year.
4. Country Concentration: percentage share of titles from top 5 countries.
5. Genre Concentration: percentage share of titles from top 5 genres.

## Data and Technical Assumptions

1. The cleaned view `netflix_clean` is used for EDA.
2. Missing values are standardized in the cleaning step.
3. SQL runs on MySQL 8+.
4. Multi-value fields like country and genre are split for accurate counting.

## Risks and Limitations

1. This dataset shows catalog metadata, not user watch behavior.
2. Split logic for multi-value columns may miss rare text formatting issues.
3. High count does not mean high business performance.

## Expected Portfolio Outcome

1. A clear, interview-ready SQL story with focused scope.
2. Easy-to-explain KPIs and business questions.
3. A strong demonstration of practical EDA for business decisions.

