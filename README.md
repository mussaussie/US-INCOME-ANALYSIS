# US Household Income Data Analysis

A comprehensive SQL data analysis project that cleans, explores, and analyzes US household income data across different states, cities, and community types. This project demonstrates data cleaning techniques, exploratory data analysis (EDA), and deriving meaningful insights from geographic and economic data.

## Project Overview

This project analyzes two related datasets:
- **ushouseholdincome**: Geographic and demographic information including land/water area
- **ushouseholdincome_statistics**: Income statistics (mean and median) by location

The analysis uncovers patterns in income distribution across the United States, identifying high and low-income areas, and examining the relationship between geography and household income.

## Features

- **Data Cleaning**: Remove duplicates, fix typos, and standardize values
- **Geographic Analysis**: Identify states with largest land and water areas
- **Income Analysis**: Compare average household income across states, cities, and community types
- **Statistical Insights**: Calculate mean and median income distributions
- **Comparative Analysis**: Identify highest and lowest earning locations

## Database Schema

### Table: `ushouseholdincome`
| Column | Description |
|--------|-------------|
| row_id | Unique row identifier |
| id | Primary key |
| State_Name | State name |
| City | City name |
| place | Place/Location name |
| Type | Community type (Borough, CDP, Town, etc.) |
| ALAND | Land area in square meters |
| AWATER | Water area in square meters |

### Table: `ushouseholdincome_statistics`
| Column | Description |
|--------|-------------|
| id | Primary key (matches ushouseholdincome.id) |
| Mean | Mean household income |
| Median | Median household income |

## Prerequisites

- MySQL Server 5.7 or higher (or compatible database system)
- MySQL Workbench or any SQL client
- Basic understanding of SQL

## Installation & Setup

1. **Create Database**
```sql
CREATE DATABASE us_income_project;
USE us_income_project;
```

2. **Import Data**
- Import the CSV files for both tables into the database
- Ensure proper data types and relationships

3. **Run the Analysis**
- Execute the SQL script: `us_household_income_analysis.sql`
- Review results in query output


## Analysis Breakdown

### Part 1: Data Cleaning

#### 1. Duplicate Removal
- Identified and removed 6 duplicate records from `ushouseholdincome` table
- Used `ROW_NUMBER()` window function to detect duplicates
- Verified no duplicates in `ushouseholdincome_statistics` table

#### 2. Data Quality Fixes
- **State Names**: Corrected 'georia' → 'Georgia'
- **Place Names**: Fixed incorrect place assignment
- **Type Standardization**: Unified 'Boroughs' → 'Borough'
- **Null/Zero Values**: Identified empty or zero land/water area records

### Part 2: Exploratory Data Analysis

#### 3. Geographic Insights

**Largest Land Area:**
```
State: Texas
Has the largest total land area among all US states
```

**Largest Water Area:**
```
State: Michigan
Has the largest total water area (Great Lakes impact)
```

#### 4. Income by State
- Ranked all states by average household income
- Compared mean vs. median income across states
- Filtered out zero-income records for accuracy

#### 5. Income by Community Type
- Analyzed income patterns across different community types
- Only included types with 100+ occurrences for statistical significance
- Revealed which types of communities have higher/lower incomes

#### 6. City-Level Analysis

**Highest Income City:**
```
City: Delta Junction
State: Alaska
Has the highest average mean household income
```

**Community Type Analysis:**
```
Type: Community
Location: Puerto Rico
Identified as lower-income community type
```

## Key Findings

### Geographic Findings
- 🏆 **Texas** has the largest land area in the dataset
- 🌊 **Michigan** has the largest water area (due to Great Lakes)

### Income Findings
- 💰 **Delta Junction, Alaska** has the highest average household income
- 📍 Community types vary significantly in income levels
- 🏘️ Puerto Rico's "Community" type locations show lower average incomes
- 📊 Significant variation exists between mean and median incomes across locations

## SQL Techniques Used

- **Window Functions**: `ROW_NUMBER() OVER()` for duplicate detection
- **Aggregate Functions**: `SUM()`, `AVG()`, `COUNT()`, `ROUND()`
- **Joins**: `INNER JOIN` to combine geographic and income data
- **Filtering**: `WHERE`, `HAVING` clauses for data quality
- **Grouping**: `GROUP BY` for aggregation analysis
- **Ordering**: `ORDER BY` with `LIMIT` for top/bottom rankings


## Potential Enhancements

- [ ] Add visualizations using Python (matplotlib/seaborn) or Tableau
- [ ] Perform time-series analysis if multi-year data available
- [ ] Calculate income inequality metrics (Gini coefficient)
- [ ] Add cost of living adjustments for more accurate comparisons
- [ ] Include demographic data (population, age distribution)
- [ ] Create stored procedures for recurring analysis
- [ ] Build interactive dashboard with Power BI or Tableau
- [ ] Add correlation analysis between land area and income
- [ ] Include regional groupings (Northeast, South, etc.)
- [ ] Export results to CSV for further analysis

## Data Quality Notes

### Issues Found and Fixed
1. ✅ 6 duplicate records removed
2. ✅ State name typo corrected (Georgia)
3. ✅ Inconsistent Type values standardized
4. ✅ Place name corrections applied
5. ⚠️ Some records have zero income values (excluded from analysis)
6. ⚠️ Some records have zero land/water area (flagged for review)

### Limitations
- Income data with zero values excluded from analysis
- Some geographic areas may have incomplete data
- Dataset may not represent current year (check data source for year)
- Community type classifications may vary by state

## Data Sources

This analysis uses US household income data. For the most current data, visit:
- [US Census Bureau](https://www.census.gov/)
- [American Community Survey](https://www.census.gov/programs-surveys/acs)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Data sourced from US Census Bureau datasets
- Analysis performed using MySQL
- SQL techniques based on data analytics best practices

## Contact & Support

For questions or suggestions:
- Open an issue on GitHub
- Review the SQL comments for query explanations
- Check the analysis results for insights

---

**📊 Analysis Complete** | **🔍 Clean Data** | **💡 Actionable Insights**
