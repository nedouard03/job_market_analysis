# Python

Google Colab notebook containing skill demand extraction and 
supplementary analysis performed on the cleaned healthcare job 
postings dataset using Python and pandas.

## Files

**healthcare_job_market_skill_analysis.ipynb**  
A Google Colab notebook performing keyword-based skill extraction 
from the description column of the cleaned job postings dataset. 
Since the dataset's dedicated skills_desc column was 98% null, 
this notebook implements a custom keyword scanning approach to 
quantify skill demand signals from unstructured job description text.

**top_20_healthcare_skills.png**  
A horizontal bar chart showing the top 20 healthcare skills by frequency
identified in description solumn of the cleaned job posting dataset. This
chart was built using matplotlib.

## Methodology

The notebook follows this analytical sequence:

1. **Data loading** — cleaned job postings CSV imported into a 
   pandas DataFrame (2,854 rows)
2. **Keyword list definition** — skills organized into three 
   categories:
   - Technical tools (SQL, Excel, Python, R, Tableau, Power BI, 
     BigQuery, SAS, Epic, Cerner, Azure, AWS)
   - Healthcare domain skills (CMS, Medicaid, Medicare, HIPAA, 
     revenue cycle, risk adjustment, value-based care, population 
     health, prior authorization, claims, ICD, CPT, HCC, HEDIS)
   - Operational skills (project management, stakeholder management, 
     process improvement, lean, six sigma, agile, PMP, CAPM)
3. **Keyword extraction function** — case-insensitive keyword 
   matching applied across all 2,868 description rows per skill
4. **Frequency analysis** — total mention count and percentage of 
   postings mentioning each skill calculated across the full dataset
5. **Visualization** — horizontal bar chart of top 20 skills by 
   frequency built using matplotlib

## Key Output

A skill frequency DataFrame showing the count and percentage of 
postings mentioning each keyword, revealing which technical tools 
and domain competencies are most consistently sought across 
healthcare operations and analytics roles in the 2023–2024 
LinkedIn job market.

## Environment

Built in **Google Colab** (free Python environment, no local 
installation required). Primary libraries used: pandas, matplotlib. 
No additional installations required beyond Colab defaults.

## Notes

Skill extraction via keyword matching identifies skill presence in 
descriptions but does not distinguish between required and preferred 
qualifications, or between skills mentioned in context versus skills 
explicitly required. Frequency counts should be interpreted as 
signals of skill relevance rather than strict hiring requirements.
