/*Created By: Nikhil Edouard
Date: 7/14/2026
Description: Role Demand Analysis Queries*/

--Cleamed Queries CTEs
WITH clean_postings AS (
  SELECT
    DISTINCT job_id,
    TRIM(company_name) AS company_name,
    TRIM(title) AS title,
    --Categorizes healthcare relevant roles
    CASE
      WHEN LOWER(title) LIKE '%analyst%' THEN 'Analyst'
      WHEN LOWER(title) LIKE '%manager%' THEN 'Manager'
      WHEN LOWER(title) LIKE '%consultant%' THEN 'Consultant'
      WHEN LOWER(title) LIKE '%coordinator%' THEN 'Coordinator'
      WHEN LOWER(title) LIKE '%director%' 
        OR LOWER(title) LIKE '%administrator%'
        OR LOWER(title) LIKE '%specialist%'
        OR LOWER(title) LIKE '%advisor%'
        OR LOWER(title) LIKE '%coder%'
        OR LOWER(title) LIKE '%educator%'
        OR LOWER(title) LIKE '%researcher%'
        OR LOWER(title) LIKE '%planner%'
        OR LOWER(title) LIKE '%liaison%'
        OR LOWER(title) LIKE '%navigator%'
        OR LOWER(title) LIKE '%worker%'
        OR LOWER(title) LIKE '%reviewer%'
        OR LOWER(title) LIKE '%associate%'
        THEN 'Other'
      ELSE 'Uncategorized'
    END AS role_category,
    description,
    --Creates BOOLEAN column identifying if salary information is available
    (max_salary IS NOT NULL OR min_salary IS NOT NULL) AS salary_available,
    --Standardizes all salaries to annual. The dataset originally contained a mix of monthly, bi-weekly, weekly, hourly, and annual compensation values
    CASE 
      WHEN pay_period = 'MONTHLY' THEN max_salary*12
      WHEN pay_period = 'BIWEEKLY' THEN max_salary*26
      WHEN pay_period = 'WEEKLY' THEN max_salary*52
      WHEN pay_period = 'HOURLY' THEN max_salary*2080
      ELSE max_salary
    END AS max_annual_salary,
    CASE 
      WHEN pay_period = 'MONTHLY' THEN min_salary*12
      WHEN pay_period = 'BIWEEKLY' THEN min_salary*26
      WHEN pay_period = 'WEEKLY' THEN min_salary*52
      WHEN pay_period = 'HOURLY' THEN min_salary*2080
      ELSE min_salary
    END AS min_annual_salary,
    pay_period,
    TRIM(
      REGEXP_REPLACE(
          REGEXP_REPLACE(
              REGEXP_REPLACE(
                  location,
                  r',\s*United States$', ''
              ),
              r'\s*Metropolitan Area$', ''
          ),
          r'^Greater\s+', ''
      )
    )  AS clean_location
  FROM
    job-market-1.Job_Market.postings),


--CTE filtering for healthcare relevant roles and standardizing locations to city/state format
filtered_postings AS (
  SELECT
    *,
    CASE
      WHEN clean_location = 'United States' THEN NULL
      WHEN STRPOS(clean_location, ',') > 0 THEN TRIM(SPLIT(clean_location, ',')[OFFSET(0)])
      ELSE clean_location
    END AS city,
    CASE
      WHEN ARRAY_LENGTH(SPLIT(clean_location, ',')) = 2 THEN TRIM(SPLIT(clean_location, ',')[OFFSET(1)])
      ELSE NULL
    END AS state
  FROM
    clean_postings
  WHERE (
    -- CONDITION 1: Pure healthcare companies — company name alone is sufficient
    LOWER(company_name) IN (
      -- Payers
      'unitedhealth group', 'optum', 'elevance health', 'humana',
      'cigna', 'aetna', 'cvs', 'centene', 'molina healthcare',
      'wellcare', 'oscar health', 'clover health', 'alignment healthcare',
      'highmark', 'carefirst', 'magellan health', 'bright health',
      -- Health Systems
      'hca healthcare', 'commonspirit health', 'ascension health',
      'advocate aurora health', 'dignity health', 'tenet healthcare',
      'banner health', 'providence', 'mass general brigham',
      'cleveland clinic', 'mayo clinic', 'johns hopkins medicine',
      'kaiser permanente', 'northwell health', 'intermountain health',
      'adventhealth', 'piedmont healthcare', 'novant health',
      'baylor scott and white health', 'methodist health system',
      'orlando health', 'baycare health system', 'christus health',
      -- Pure Healthcare Technology
      'epic systems', 'cerner', 'oracle health', 'meditech',
      'athenahealth', 'cotiviti', 'inovalon', 'phreesia',
      'health catalyst', 'availity', 'waystar', 'zelis',
      'change healthcare', 'multiplan', 'nthrive',
      'conifer health solutions', 'parallon', 'vizient', 'premier inc',
      -- Pure Healthcare Analytics and Consulting
      'evolent', 'cope health solutions', 'ecg management consultants',
      'sg2', 'healthlinkny', 'chartis', 'huron',
      'mathematica', 'navigant consulting')
    OR (
      -- CONDITION 2: Multi-industry firms require BOTH company name AND healthcare description
      LOWER(company_name) IN (
        'deloitte', 'accenture', 'mckinsey', 'bcg', 'bain',
        'pwc', 'kpmg', 'ey', 'ernst and young', 'guidehouse',
        'alvarez and marsal', 'iqvia', 'cognizant', 'ibm',
        'microsoft', 'amazon', 'google', 'oracle', 'sap',
        'booz allen hamilton', 'leidos', 'mitre', 'maximus')
      AND (LOWER(description) LIKE '%revenue cycle%'
        OR LOWER(description) LIKE '%managed care%'
        OR LOWER(description) LIKE '%population health%'
        OR LOWER(description) LIKE '%prior authorization%'
        OR LOWER(description) LIKE '%utilization management%'
        OR LOWER(description) LIKE '%medical coding%'
        OR LOWER(description) LIKE '%icd-10%'
        OR LOWER(description) LIKE '%ehr%'
        OR LOWER(description) LIKE '%emr%'
        OR LOWER(description) LIKE '%epic systems%'
        OR LOWER(description) LIKE '%cerner%'
        OR LOWER(description) LIKE '%medicaid%'
        OR LOWER(description) LIKE '%medicare%'
        OR LOWER(description) LIKE '%health system%'
        OR LOWER(description) LIKE '%health plan%'
        OR LOWER(description) LIKE '%payer%'
        OR LOWER(description) LIKE '%value-based care%'
        OR LOWER(description) LIKE '%clinical documentation%'
        OR LOWER(description) LIKE '%risk adjustment%'
        OR LOWER(description) LIKE '%care coordination%'
        OR LOWER(description) LIKE '%health informatics%'
        OR LOWER(description) LIKE '%hipaa compliance%'
        OR LOWER(description) LIKE '%credentialing%'
        OR LOWER(description) LIKE '%hedis%'
        OR LOWER(description) LIKE '%denial management%'
        OR LOWER(description) LIKE '%hcahps%'
        OR LOWER(description) LIKE '%medical records%')
    )
    OR (
      -- CONDITION 3: Any company not on either list but description contains specific healthcare operational terminology
      LOWER(company_name) NOT IN (
        'deloitte', 'accenture', 'mckinsey', 'bcg', 'bain',
        'pwc', 'kpmg', 'ey', 'ernst and young', 'guidehouse',
        'alvarez and marsal', 'iqvia', 'cognizant', 'ibm',
        'microsoft', 'amazon', 'google', 'oracle', 'sap',
        'unitedhealth group', 'optum', 'elevance health', 'humana',
        'cigna', 'aetna', 'cvs', 'centene', 'molina healthcare',
        'hca healthcare', 'commonspirit health', 'ascension health',
        'epic systems', 'cerner', 'oracle health', 'cotiviti',
        'inovalon', 'phreesia', 'evolent', 'chartis',
        'huron', 'mathematica')
      AND (
        LOWER(description) LIKE '%revenue cycle%'
        OR LOWER(description) LIKE '%managed care%'
        OR LOWER(description) LIKE '%population health%'
        OR LOWER(description) LIKE '%prior authorization%'
        OR LOWER(description) LIKE '%utilization management%'
        OR LOWER(description) LIKE '%medical coding%'
        OR LOWER(description) LIKE '%medicaid%'
        OR LOWER(description) LIKE '%medicare%'
        OR LOWER(description) LIKE '%health system%'
        OR LOWER(description) LIKE '%health plan%'
        OR LOWER(description) LIKE '%payer%'
        OR LOWER(description) LIKE '%value-based care%'
        OR LOWER(description) LIKE '%clinical documentation%'
        OR LOWER(description) LIKE '%risk adjustment%'
        OR LOWER(description) LIKE '%care coordination%'
        OR LOWER(description) LIKE '%health informatics%'
        OR LOWER(description) LIKE '%hipaa compliance%'
        OR LOWER(description) LIKE '%hedis%'
        OR LOWER(description) LIKE '%denial management%'
        OR LOWER(description) LIKE '%medical records%')
    )
  )
  AND role_category != 'Uncategorized'
  AND LOWER(title) NOT IN (
  'merchandiser specialist',
  'pt sales associate',
  'sales associate',
  'merchandiser',
  'cashier',
  'store manager',
  'pharmacy technician',
  'shift supervisor')
)

--Query 1: Role Demand by Title- Top 25 job titles by posting count 
SELECT
  title,
  COUNT(*) AS posting_count,
  ROUND(COUNT(*)*100.0 / (SUM(COUNT(*)) OVER()),2) AS percent_of_total_postings,
  RANK() OVER(ORDER BY COUNT(*) DESC) AS title_rank
FROM
  filtered_postings
GROUP BY
  title
ORDER BY
  title_rank
LIMIT 25;

--Query 2: Role Demand By State
SELECT
  state,
  COUNT(*) AS posting_count,
  ROUND(COUNT(*)*100.0 / (SUM(COUNT(*)) OVER()),2) AS percent_of_total_postings
FROM
  filtered_postings
WHERE
  state IS NOT NULL
GROUP BY
  state
ORDER BY
  posting_count DESC;




