# SQL

BigQuery SQL queries used to clean, filter, and analyze the LinkedIn 
job postings dataset across four analytical files.

## Files

**cleaned_queries.sql**  
Foundational cleaning pipeline applied to the raw job postings table. 
Contains two CTEs — clean_postings and filtered_postings — that form 
the base dataset referenced by all downstream analysis files.

Key operations performed:
- DISTINCT on job_id to remove 44 duplicate postings
- TRIM applied to company_name and title columns
- Role categorization via CASE statement assigning titles to Analyst, 
  Manager, Consultant, Coordinator, or Other based on title keywords
- Salary normalization converting hourly, weekly, biweekly, and 
  monthly values to annualized equivalents using standardized 
  multipliers (hourly × 2,080 | weekly × 52 | biweekly × 26 | 
  monthly × 12)
- salary_available boolean column flagging rows where salary data 
  exists
- Three-condition healthcare relevance filter using company-level 
  classification and description-level keyword matching
- Title exclusion list removing identified non-healthcare roles from 
  pure healthcare company postings
- Location standardization using REGEXP_REPLACE to remove 
  inconsistent suffixes and prefixes, followed by city and state 
  extraction via string splitting

**role_demand_analysis.sql**  
Analyzes job posting demand by title and geography. Contains:
- Query 1: Top 25 job titles by posting count with percentage of 
  total postings and RANK window function
- Query 2: Posting count by state with percentage of total postings 
  for geographic concentration analysis

**salary_analysis.sql**  
Analyzes compensation across role categories and functional title 
groups. Contains:
- Query 3: Average min, max, and midpoint annual salary by role 
  category filtered to postings with salary data and annualized 
  values between $30,000 and $500,000
- Query 4: Average min, max, and midpoint annual salary by functional 
  title group (13 groups) with minimum posting threshold applied for 
  statistical reliability

**geographic_analysis.sql**  
Analyzes role demand and compensation patterns at the geographic 
level. Contains:
- Query 5: Top 3 role titles by posting count within each state using 
  ROW_NUMBER window function partitioned by state
- Query 6: Role category demand versus compensation comparison using 
  RANK window function to identify demand-compensation relationships

## Tools

All queries were written and executed in **Google BigQuery**. Column 
names and syntax reflect BigQuery-specific SQL including FLOAT64 for 
numeric casting, SAFE_CAST for nullable columns, REGEXP_REPLACE for 
string cleaning, and ARRAY functions for location parsing.

## Notes

Because the BigQuery Sandbox environment does not support persistent 
temporary tables, the full cleaning CTE logic from cleaned_queries.sql 
is reproduced at the top of each analysis file rather than referenced 
from a shared cleaned table. This ensures each file is self-contained 
and independently executable.
