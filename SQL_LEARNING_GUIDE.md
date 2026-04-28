-- ============================================================================
-- NETFLIX EDA PROJECT - SQL FILES GUIDE
-- Complete Learning Path for Data Cleaning, Preparation & Exploratory Analysis
-- ============================================================================

## PROJECT OVERVIEW

This SQL-based learning project is structured to teach you **Data Cleaning & Preparation** 
and **Exploratory Data Analysis (EDA)** skills using the Netflix dataset.

All files use **simple, well-commented SQL queries** that demonstrate practical techniques
you'll use in real-world data analysis projects.

---

## FILE STRUCTURE & LEARNING PATH

### PHASE 1: SETUP & DATA LOADING (Foundation)
**File:** 00_setup_and_load_data.sql
**What You'll Learn:**
- Creating database and tables
- Loading CSV data into MySQL
- Basic data validation after import
- Understanding the data schema

**Key Queries:**
- CREATE TABLE with proper data types
- LOAD DATA INFILE for CSV imports
- COUNT queries to verify data loaded correctly
- Basic descriptive queries

**Expected Learning Outcome:**
You'll understand how data gets into a database and learn to validate the import process.

---

### PHASE 2: DATA CLEANING & PREPARATION (Core Skills)

#### File 1: 01_data_cleaning_missing_values_duplicates.sql
**Cleaning Skills Covered:**
1. Handling Missing Values (NULL and empty strings)
2. Detecting Duplicates
3. Removing Duplicates
4. Data Quality Assessment

**Key Techniques:**
- Using CASE statements to identify missing data
- CASE WHEN to fill missing values
- GROUP BY to find duplicates
- Creating temporary tables with cleaned data
- Calculating missing data percentages

**Why It Matters:**
Missing values and duplicates are the most common data quality issues. Learning to 
identify and handle them is fundamental before any analysis.

**Portfolio Value:**
Shows you understand data quality assessment and cleaning strategies.

---

#### File 2: 02_data_types_standardization.sql
**Standardization Skills Covered:**
1. Fixing Data Types (VARCHAR to DATE)
2. Standardizing Date Formats
3. Extracting Numeric Values from Text
4. Cleaning Text Fields (trimming, spacing)
5. Handling Comma-Separated Values
6. Creating Standardized Output

**Key Techniques:**
- STR_TO_DATE() for date conversion
- SUBSTRING_INDEX() to extract parts of text
- TRIM() to remove whitespace
- UPPER() and LOWER() for case standardization
- LENGTH() and REPLACE() to work with strings
- CASE WHEN for conditional transformations

**Why It Matters:**
Inconsistent data types and formats cause errors in analysis. Standardization ensures
consistency across your dataset.

**Real-World Example:**
You'll convert date strings like "September 25, 2021" into proper DATE type, and 
extract numeric duration from "90 min" strings.

---

#### File 3: 03_outliers_inconsistencies_feature_engineering.sql
**Advanced Cleaning Skills Covered:**
1. Identifying Outliers (unusual values)
2. Handling Outliers (removal vs. capping strategies)
3. Detecting Data Inconsistencies
4. Correcting Inconsistencies
5. Creating New Features from Existing Data

**Key Techniques:**
- Statistical methods (min, max, STDDEV) to identify outliers
- Comparison operations to find inconsistencies
- Feature extraction (SUBSTRING_INDEX for first element)
- Creating numeric features from text
- Counting items in comma-separated fields

**Why It Matters:**
Outliers can skew analysis results. Understanding different strategies (remove vs. cap)
prepares you for real projects where deletion isn't always appropriate.

**Portfolio Value:**
Feature engineering shows advanced data manipulation and domain understanding.

---

### PHASE 3: EXPLORATORY DATA ANALYSIS (Understanding Your Data)

#### File 4: 04_eda_descriptive_statistics.sql
**EDA Skill: Descriptive Statistics**

**What You'll Learn:**
- Mean (average), Median (middle value), Mode (most common)
- Standard Deviation (how spread out data is)
- Min/Max values
- Range and Variance
- Quartile Analysis (dividing data into 4 parts)

**Key Queries:**
- Basic statistical functions (AVG, MIN, MAX, STDDEV)
- Percentile analysis (PERCENTILE_CONT)
- Frequency distributions
- Skewness detection (comparing mean vs median)

**Real-World Application:**
You'll find that Netflix has content from 1927 to 2021, understand the distribution,
and detect if it's skewed toward recent years.

**Portfolio Value:**
Descriptive statistics is the foundation of all analysis. Interviewers expect you to 
know these inside and out.

---

#### File 5: 05_eda_univariate_analysis.sql
**EDA Skill: Univariate Analysis (Analyzing One Variable at a Time)**

**What You'll Learn:**
- Analyzing individual columns independently
- Frequency distributions
- Finding outliers in single variables
- Understanding data diversity
- Creating histograms with SQL
- Cumulative frequency analysis

**Key Queries:**
- GROUP BY with COUNT for frequency
- Creating bins/categories for continuous data
- Identifying unique values
- Missing value patterns
- Concentration measures (Herfindahl Index)

**Real-World Example:**
You'll discover that most Netflix content is from 2015-2020, identify which ratings
are most common, and find the most prolific directors.

**Portfolio Value:**
Univariate analysis shows you can explore data systematically, one variable at a time.

---

#### File 6: 06_eda_bivariate_analysis.sql
**EDA Skill: Bivariate Analysis (Analyzing Two Variables Together)**

**What You'll Learn:**
- How one variable changes across categories of another
- Cross-tabulation (contingency tables)
- Numerical vs Categorical comparisons
- Correlation patterns
- Group comparisons
- Effect sizes

**Key Queries:**
- Pivot-style analysis with SUM and CASE
- GROUP BY with multiple columns
- Window functions for proportions
- Creating comparison metrics

**Real-World Example:**
You'll compare movie durations vs release year, see how ratings differ by content type,
and find if newer content has better data quality.

**Portfolio Value:**
Bivariate analysis is where real insights start appearing. It shows you can identify
meaningful relationships in data.

---

#### File 7: 07_eda_multivariate_analysis.sql
**EDA Skill: Multivariate Analysis (Analyzing 3+ Variables Together)**

**What You'll Learn:**
- Analyzing multiple variables simultaneously
- Creating segments and profiles
- Stratified analysis (analyzing by subgroups)
- Interaction effects (how one variable's effect depends on another)
- Hierarchical analysis
- Composite scoring

**Key Queries:**
- Complex GROUP BY with multiple dimensions
- Creating quality/composite scores
- Variance decomposition
- Hierarchical aggregation

**Real-World Example:**
You'll create content quality scores, analyze how the relationship between type and
rating changes over time, and profile different customer segments.

**Portfolio Value:**
Multivariate analysis is where you demonstrate sophisticated analytical thinking.
This is what separates junior from senior analysts.

---

#### File 8: 08_eda_timebased_analysis.sql
**EDA Skill: Time-Based Analysis (Temporal Patterns)**

**What You'll Learn:**
- Identifying trends over time
- Growth rate calculations
- Cumulative analysis
- Seasonality patterns
- Period comparisons
- Time interval analysis
- Moving averages
- Temporal segmentation

**Key Queries:**
- YEAR(), MONTH() extraction
- LAG/LEAD window functions for comparison
- SUM() with OVER() for cumulative totals
- Growth rate formulas
- Moving window calculations

**Real-World Example:**
You'll discover that Netflix added more content in certain years, find when most
content was released (heavily weighted toward recent years), and calculate how
growth has changed over time.

**Portfolio Value:**
Time-based analysis is crucial for business intelligence. Shows you understand trends
and can communicate historical patterns.

---

#### File 9: 09_eda_segmentation_distribution_analysis.sql
**EDA Skills: Segmentation & Distribution Analysis**

**What You'll Learn:**
- Breaking data into meaningful segments
- Demographic-style segmentation
- Behavioral segmentation based on characteristics
- Distribution patterns (histograms)
- Diversity metrics
- Pareto analysis (80/20 rule)

**Key Queries:**
- CASE WHEN for creating segments
- Distribution analysis with bins
- Cumulative percentage calculations
- Concentration measures

**Real-World Example:**
You'll segment content by type, release era, and quality level. Discover that most
content comes from 2010-2020 (Pareto principle), and understand genre diversity.

**Portfolio Value:**
Segmentation is critical for business decisions. Shows you can identify and profile
different customer/product groups.

---

#### File 10: 10_eda_correlation_analysis.sql
**EDA Skill: Correlation Analysis (Finding Relationships)**

**What You'll Learn:**
- Pearson Correlation (linear relationships)
- Spearman Rank Correlation (monotonic relationships)
- Point-Biserial Correlation (continuous vs binary)
- Chi-Square for categorical associations
- Conditional probability
- Correlation stability across subgroups

**Key Queries:**
- Pearson correlation formula implementation
- Spearman rank correlation
- Contingency table analysis
- Association strength measures

**Real-World Example:**
You'll find how strongly release year and data completeness are related, discover if
newer content has more/fewer directors, and test if content type predicts rating.

**Portfolio Value:**
Correlation analysis is fundamental to statistical thinking. Demonstrates you understand
when variables are truly related vs. coincidentally similar.

---

## HOW TO USE THESE FILES

### Step 1: Setup (15 minutes)
1. Open file: 00_setup_and_load_data.sql
2. Run the queries in order
3. This creates the database and loads your Netflix data
4. Verify the data loaded correctly (last section shows row counts)

### Step 2: Learn Cleaning Skills (1-2 hours)
1. Read file 01: Focus on understanding CASE WHEN logic
2. Read file 02: Learn string/date manipulation functions
3. Read file 03: See how features are created from raw data
4. **TRY THIS:** Modify queries to see different results!

### Step 3: Learn EDA Skills (2-4 hours)
1. Read each file 04-10 in order
2. **KEY LEARNING PATTERN:**
   - Read the comment header
   - Understand what the query is measuring
   - Look at the results and think: "What does this tell us?"
   - Ask: "How could I modify this for a different question?"

### Step 4: Create Your Own Analyses
1. Combine techniques from different files
2. Answer questions like:
   - "What's the relationship between rating and year?"
   - "Which directors have most content?"
   - "How does data completeness change over time?"
3. Build your own queries using these as templates

---

## LEARNING PROGRESSION

**Beginner → Intermediate → Advanced**

```
SETUP
  ↓
BASIC CLEANING (File 01) → Understand missing data & duplicates
  ↓
STANDARDIZATION (File 02) → Fix formats & types
  ↓
FEATURE ENGINEERING (File 03) → Create new variables
  ↓
DESCRIPTIVE STATS (File 04) → Understand basic patterns
  ↓
UNIVARIATE (File 05) → Analyze individual variables
  ↓
BIVARIATE (File 06) → Find pairwise relationships
  ↓
MULTIVARIATE (File 07) → Complex, multi-dimensional analysis
  ↓
TIME-BASED (File 08) → Understand temporal patterns
  ↓
SEGMENTATION (File 09) → Create meaningful groups
  ↓
CORRELATION (File 10) → Quantify relationships
```

---

## KEY SQL FUNCTIONS YOU'LL MASTER

**String Functions:**
- SUBSTRING_INDEX() - Extract parts of comma-separated values
- TRIM() - Remove whitespace
- UPPER(), LOWER() - Case conversion
- LENGTH(), REPLACE() - String manipulation
- CONCAT() - Combine strings

**Date Functions:**
- STR_TO_DATE() - Convert string to DATE
- YEAR(), MONTH(), DAY() - Extract date parts
- DATE_FORMAT() - Format dates

**Aggregation Functions:**
- COUNT(), SUM(), AVG(), MIN(), MAX() - Basic statistics
- STDDEV(), VARIANCE() - Distribution measures
- GROUP_CONCAT() - Combine values

**Window Functions:**
- LAG(), LEAD() - Compare with previous/next row
- ROW_NUMBER() - Rank rows
- SUM() OVER() - Running totals
- AVG() OVER() - Moving averages

**Conditional Logic:**
- CASE WHEN - Create categories and transformations
- IF() - Simple conditional

---

## PORTFOLIO PROJECT IDEAS

After completing these files, create these analyses for your portfolio:

### Portfolio Piece 1: Data Quality Report
- Show all data cleaning operations performed
- Quantify improvements (before/after)
- Highlight data types fixed and consistency issues resolved

### Portfolio Piece 2: Netflix Content Analysis
- Top findings from univariate and bivariate analysis
- Time-based trends in Netflix content
- Segmentation analysis identifying key content groups

### Portfolio Piece 3: Relationship Discovery
- Strongest correlations found
- Unexpected patterns identified
- Implications of findings (why it matters)

### Portfolio Piece 4: Complete Data Pipeline
- Data loading → Cleaning → Standardization → Feature Engineering → Analysis
- Shows end-to-end understanding

---

## TIPS FOR SUCCESS

1. **Don't Just Read**: Execute each query and examine results
2. **Modify Queries**: Change WHERE conditions, aggregations, filters
3. **Combine Concepts**: Mix techniques from multiple files
4. **Document Findings**: Write down what each analysis reveals
5. **Ask Questions**: "Why is this? What if I...?"
6. **Compare Results**: Run same analysis different ways
7. **Create Summaries**: Write plain English explanations of SQL results

---

## NEXT STEPS AFTER COMPLETING

1. **Apply to Different Dataset**: Take these same SQL patterns and apply to a different CSV
2. **Create Visualizations**: Run these queries in Power BI, Tableau, or Python (matplotlib)
3. **Build Dashboards**: Combine multiple analyses into a summary dashboard
4. **Learn Python/R**: Replicate these analyses in pandas/R to expand toolkit
5. **Practice Storytelling**: Present findings as business insights, not just statistics

---

## FINAL NOTES

This project teaches you to think like a data analyst:
- ✅ Ask questions about your data
- ✅ Systematically explore patterns
- ✅ Validate findings
- ✅ Communicate insights clearly

The SQL skills are tools; the analytical thinking is the real skill you're developing.

Good luck with your learning journey! 🚀
