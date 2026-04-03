# Netflix EDA SQL Project: Business Understanding

This project uses SQL-based Exploratory Data Analysis (EDA) on Netflix titles data to generate business insights for catalog strategy, regional expansion, and audience targeting.

## Business Context

Streaming platforms must balance catalog variety, freshness, and audience fit while controlling content investment risk. Understanding what is currently in the library and how it evolved over time helps answer:

1. Is the catalog balanced between Movies and TV Shows?
2. Are we overly concentrated in specific countries, genres, or ratings?
3. Is recent growth aligned with strategic priorities?
4. What talent and content formats appear most repeatedly?

## Problem Statement

Netflix needs a data-driven view of its content portfolio to inform acquisition, commissioning, localization, and merchandising decisions.

## Business Objectives

1. Profile catalog composition by type, rating, genre, geography, and talent.
2. Measure temporal patterns in content additions and release recency.
3. Identify concentration risks and diversification opportunities.
4. Build reusable EDA outputs for stakeholder reporting and portfolio storytelling.

## Scope of Analysis

The analysis covers:

1. Data quality and completeness checks.
2. Catalog mix and structural distribution.
3. Time-series trends (yearly additions, monthly seasonality, decade patterns).
4. Geographic spread (single-country and split multi-country analysis).
5. Genre footprint (combined genres and exploded genre-level trends).
6. Talent footprint (directors and cast frequency).
7. Format depth (movie minutes, TV seasons).
8. Advanced slices (YoY growth, release-to-platform lag, recency buckets).

## Key Stakeholders

1. Content Strategy Team: decides content mix and category priorities.
2. Acquisition Team: identifies high-performing source regions and genres.
3. Production/Commissioning Team: evaluates talent concentration and opportunities.
4. Marketing & Merchandising Team: aligns campaigns with audience ratings and genre trends.
5. Regional Leadership: assesses country-level catalog coverage.

## Key Business Questions

1. What percentage of the catalog is Movies vs TV Shows?
2. Which ratings dominate overall and within each content type?
3. How has title addition volume changed year over year?
4. Which months show stronger content addition seasonality?
5. Which countries contribute the most titles after splitting multi-country rows?
6. Which genres are most common, and how do top genres shift by year?
7. Which directors and cast members appear most frequently?
8. What is the runtime profile of movies and season profile of TV Shows?
9. How long after release are titles added to Netflix on average?
10. Is the catalog tilted toward older titles or newer releases?

## Analytical KPIs

1. Catalog size and unique title IDs.
2. Percent share by content type.
3. Percent share by audience rating.
4. Yearly additions and YoY growth percentage.
5. Top countries by title count (exploded country analysis).
6. Top genres by title count (exploded genre analysis).
7. Average years-to-arrive metric: `YEAR(date_added) - release_year`.
8. Runtime statistics: average/min/max movie duration.
9. TV season depth distribution.
10. Recency bucket distribution (0-1, 2-5, 6-10, 10+ years old).

## Data and Technical Assumptions

1. The cleaned view `netflix_clean` is the primary source for EDA queries.
2. Nulls/blanks are standardized in the cleaning layer (for example Unknown, Not Rated).
3. The SQL scripts are designed for MySQL 8+ (CTEs, window functions, JSON_TABLE).
4. Multi-value fields such as `country`, `listed_in`, and `cast` are comma-separated and require split logic for deeper analysis.

## Risks and Limitations

1. Country, genre, and cast are multi-valued text fields; split logic may still miss edge-case formatting.
2. This dataset captures catalog metadata, not direct engagement outcomes (watch time, completion, retention).
3. Frequent appearance of a director/actor does not imply performance impact.
4. Missing values replaced during cleaning can reduce granularity for root-cause diagnostics.

## Expected Business Outcomes

1. A clear view of current catalog composition and concentration.
2. Better prioritization of acquisition and commissioning by region/genre/type.
3. Improved release planning using seasonality and freshness insights.
4. Portfolio-ready SQL narrative demonstrating end-to-end analytics maturity.

## Query-to-Objective Mapping

1. Dataset quality profile: completeness, duplicate IDs, field-level missingness.
2. Composition analysis: type and rating shares, type-rating matrix.
3. Time analysis: yearly additions, YoY, monthly seasonality, decade distribution.
4. Geography analysis: top countries, split-country ranking, type-by-country leaders.
5. Genre analysis: genre combinations, exploded genre frequency, yearly top genres.
6. Talent analysis: directors, type-wise director distribution, exploded cast frequency.
7. Format analysis: movie runtime distribution, TV seasons distribution.
8. Advanced strategy slices: top ratings by type, release lag, recency bucket mix.

