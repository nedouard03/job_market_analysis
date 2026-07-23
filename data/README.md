# Data

This folder contains cleaned versions of the LinkedIn 
job postings dataset used in this analysis.

## Files

**Raw Dataset**  
The original LinkedIn Job Postings 2023–2024 dataset was too large to be uploaded, but it is available on 
[Kaggle]([https://www.kaggle.com/](https://www.kaggle.com/datasets/arshkon/linkedin-job-postings]). Contains 123,842 job postings across all industries with 
columns including job_id, company_name, title, description, location, 
min_salary, max_salary, pay_period, and skills_desc among others. 

**job_postings_clean.csv**  
The cleaned and filtered dataset exported from BigQuery after applying 
the full cleaning pipeline. Contains 2,868 healthcare-relevant job 
postings after applying a three-condition healthcare relevance filter, 
role categorization, salary normalization, location standardization, 
and deduplication. This is the dataset used for all downstream SQL 
analysis, Python skill extraction, and Power BI visualization.

## Filtering Summary

The raw dataset was reduced from 123,842 to 2,855 rows through the 
following process:

- **Condition 1:** Pure healthcare organizations included without 
  description verification (payers, health systems, healthcare 
  technology firms, healthcare consulting firms)
- **Condition 2:** Multi-industry firms (Deloitte, Accenture, EY, etc.) 
  included only when job description contained specific clinical or 
  operational healthcare terminology
- **Condition 3:** All other companies included only when job 
  description contained the same specific healthcare terminology
- **Title filter:** Roles categorized as Uncategorized or matching 
  known non-healthcare title patterns were excluded
- **Deduplication:** 44 duplicate job_id records removed

Full documentation of all cleaning decisions is available in 
[`/findings/Healthcare Job Market Data Cleaning Report.pdf`](../findings/Healthcare Job Market Data Cleaning Report.pdf)

## Source

LinkedIn Job Postings 2023–2024 dataset, available on 
[Kaggle]([https://www.kaggle.com/](https://www.kaggle.com/datasets/arshkon/linkedin-job-postings])

## Notes

The skills_desc column present in the raw dataset was excluded from 
all analysis due to a 98% null rate (populated in only 2,439 of 
123,842 rows). Skill demand analysis was performed instead via Python 
keyword extraction from the description column. See 
[`/python`](../python) for methodology and implementation.
