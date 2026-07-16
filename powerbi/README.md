# Power BI

Interactive dashboard visualizing the healthcare job market analysis 
findings across role demand, geographic concentration, and 
compensation patterns.

## Files

**Healthcare_Job_Market_Dashboard.pbix**  
Power BI Desktop workbook containing all report pages, data 
connections, and visualizations. Open with Power BI Desktop (free 
download at app.powerbi.com) to interact with the full dashboard 
and explore underlying data connections.

**dashboard_screenshot.png**  
Static image of the published dashboard for quick reference without 
opening Power BI Desktop.

## Live Version

The dashboard is published and viewable without any software:  
[View on Power BI Service] — link coming soon

## Dashboard Contents

- **KPI cards:** Total postings analyzed, percentage with salary 
  data, top hiring state, highest earning functional category
- **Role demand by title:** Top healthcare operations and analytics 
  job titles by posting volume
- **Geographic demand map:** Posting concentration by state across 
  the contiguous United States
- **Compensation by functional area:** Average annual salary range 
  by functional title group across 13 categories
- **Salary by role category:** Average compensation comparison 
  across Analyst, Manager, Consultant, Coordinator, and Other 
  role types

## Data Source

Connected to cleaned job postings data exported from BigQuery. 
Salary analysis filtered to postings with disclosed compensation 
and annualized values between $30,000 and $500,000 to exclude 
outliers from pay period normalization.

## Tools

Built in **Power BI Desktop**, published via **Power BI Service** 
(free account). Data imported as CSV exports from BigQuery 
analysis queries.
