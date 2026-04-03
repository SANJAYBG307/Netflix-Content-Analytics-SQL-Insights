-- Beginner EDA Queries (Single Table Only)
-- No CTE, no window functions, no JSON split.
-- Note: country and listed_in are used as stored in the table.

USE netflix_db;

-- ============================================================
-- Basic dataset size
-- ============================================================

SELECT COUNT(*) AS total_titles
FROM netflix_clean_final;

-- ============================================================
-- Q1 + KPI 1: Movies vs TV Shows
-- ============================================================

SELECT
	type,
	COUNT(*) AS title_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_clean_final), 2) AS type_mix_pct
FROM netflix_clean_final
GROUP BY type
ORDER BY title_count DESC;

-- ============================================================
-- Q2 + KPI 2: Most common ratings
-- ============================================================

SELECT
	rating,
	COUNT(*) AS title_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_clean_final), 2) AS rating_share_pct
FROM netflix_clean_final
GROUP BY rating
ORDER BY title_count DESC;

-- Top 5 ratings only
SELECT
	rating,
	COUNT(*) AS title_count,
	ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM netflix_clean_final), 2) AS rating_share_pct
FROM netflix_clean_final
GROUP BY rating
ORDER BY title_count DESC
LIMIT 5;

-- ============================================================
-- Q3 + KPI 3: Titles added each year
-- ============================================================

SELECT
	YEAR(date_added) AS year_added,
	COUNT(*) AS titles_added
FROM netflix_clean_final
WHERE date_added IS NOT NULL
GROUP BY YEAR(date_added)
ORDER BY year_added;

-- Simple growth/slowdown view (compare one year to previous year)
SELECT
	a.year_added,
	a.titles_added,
	b.titles_added AS prev_year_titles,
	(a.titles_added - IFNULL(b.titles_added, 0)) AS yoy_change
FROM (
	SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
	FROM netflix_clean_final
	WHERE date_added IS NOT NULL
	GROUP BY YEAR(date_added)
) a
LEFT JOIN (
	SELECT YEAR(date_added) AS year_added, COUNT(*) AS titles_added
	FROM netflix_clean_final
	WHERE date_added IS NOT NULL
	GROUP BY YEAR(date_added)
) b
ON a.year_added = b.year_added + 1
ORDER BY a.year_added;

-- ============================================================
-- Q4 + KPI 4: Top countries (single-table value)
-- ============================================================

SELECT
	country,
	COUNT(*) AS title_count
FROM netflix_clean_final
WHERE country <> 'Unknown'
GROUP BY country
ORDER BY title_count DESC
LIMIT 10;

-- KPI 4 (simple): top 5 country share without splitting country values
SELECT
	ROUND(SUM(top5.title_count) * 100.0 / MAX(totals.total_count), 2) AS top_5_country_share_pct
FROM (
	SELECT country, COUNT(*) AS title_count
	FROM netflix_clean_final
	WHERE country <> 'Unknown'
	GROUP BY country
	ORDER BY title_count DESC
	LIMIT 5
) top5
CROSS JOIN (
	SELECT COUNT(*) AS total_count
	FROM netflix_clean_final
	WHERE country <> 'Unknown'
) totals;

-- ============================================================
-- Q5 + KPI 5: Top genres (single-table value)
-- ============================================================

SELECT
	listed_in,
	COUNT(*) AS title_count
FROM netflix_clean_final
GROUP BY listed_in
ORDER BY title_count DESC
LIMIT 10;

-- KPI 5 (simple): top 5 genre share without splitting listed_in values
SELECT
	ROUND(SUM(top5.title_count) * 100.0 / MAX(totals.total_count), 2) AS top_5_genre_share_pct
FROM (
	SELECT listed_in, COUNT(*) AS title_count
	FROM netflix_clean_final
	GROUP BY listed_in
	ORDER BY title_count DESC
	LIMIT 5
) top5
CROSS JOIN (
	SELECT COUNT(*) AS total_count
	FROM netflix_clean_final
) totals;

-- ============================================================
-- Q6: Concentration risk (simple labels)
-- ============================================================

-- Country concentration risk label
SELECT
	country_kpi.top_5_country_share_pct,
	CASE
		WHEN country_kpi.top_5_country_share_pct >= 70 THEN 'High concentration risk'
		WHEN country_kpi.top_5_country_share_pct >= 50 THEN 'Medium concentration risk'
		ELSE 'Low concentration risk'
	END AS country_risk_level
FROM (
	SELECT ROUND(SUM(top5.title_count) * 100.0 / MAX(totals.total_count), 2) AS top_5_country_share_pct
	FROM (
		SELECT country, COUNT(*) AS title_count
		FROM netflix_clean_final
		WHERE country <> 'Unknown'
		GROUP BY country
		ORDER BY title_count DESC
		LIMIT 5
	) top5
	CROSS JOIN (
		SELECT COUNT(*) AS total_count
		FROM netflix_clean_final
		WHERE country <> 'Unknown'
	) totals
) country_kpi;

-- Genre concentration risk label
SELECT
	genre_kpi.top_5_genre_share_pct,
	CASE
		WHEN genre_kpi.top_5_genre_share_pct >= 70 THEN 'High concentration risk'
		WHEN genre_kpi.top_5_genre_share_pct >= 50 THEN 'Medium concentration risk'
		ELSE 'Low concentration risk'
	END AS genre_risk_level
FROM (
	SELECT ROUND(SUM(top5.title_count) * 100.0 / MAX(totals.total_count), 2) AS top_5_genre_share_pct
	FROM (
		SELECT listed_in, COUNT(*) AS title_count
		FROM netflix_clean_final
		GROUP BY listed_in
		ORDER BY title_count DESC
		LIMIT 5
	) top5
	CROSS JOIN (
		SELECT COUNT(*) AS total_count
		FROM netflix_clean_final
	) totals
) genre_kpi;
