# Healthcare Job Market Analysis

A demand, compensation, and skills analysis of the U.S. healthcare 
operations and analytics job market using 123,842 LinkedIn job postings 
from 2023–2024.

## Overview

This project analyzes LinkedIn job posting data to identify which 
healthcare operations and analytics roles are most in demand, where 
hiring is geographically concentrated, which skills appear most 
frequently across postings, and how compensation varies across 
functional role categories.

A three-condition filtering methodology was designed and applied to 
isolate 2,868 healthcare-relevant postings from the raw dataset of 
123,842 — combining company-level classification, description-level 
keyword matching, and title-level categorization to ensure analytical 
relevance without relying on broad keyword overlap with non-healthcare 
job posting language.

## Key Findings

- Nearly one third of all healthcare operations and analytics postings 
  are concentrated in four states — California, Texas, New York, and 
  Florida
- Clinical Operations roles command the highest average compensation 
  at approximately $118,300 annually while Coordinator roles represent 
  the entry point at approximately $57,000
- Manager-level roles account for the largest share of postings among 
  the four primary role categories, while Consultant roles are the 
  least represented at 2.1% of the dataset
- The healthcare operations and analytics job market is highly 
  fragmented by title — no single job title accounts for a dominant 
  share of postings, reflecting the diversity of functional roles 
  within the space

Full findings summary available in [`/findings`](./findings).

## Repository Structure

| Folder | Contents |
|---|---|
| [`/data`](./data) | Raw and cleaned LinkedIn job posting datasets |
| [`/sql`](./sql) | BigQuery SQL queries for cleaning and analysis |
| [`/python`](./python) | Google Colab notebook for skill extraction and analysis |
| [`/findings`](./findings) | Cleaning report and one-page findings summary |
| [`/powerbi`](./powerbi) | Interactive Power BI dashboard and workbook file |

## Tools Used

- **BigQuery** — data cleaning, filtering, and SQL analysis
- **Python / pandas** — skill keyword extraction from unstructured 
  description text in Google Colab
- **Power BI** — dashboard visualization and published report
- **Microsoft Excel** — supplementary data exploration

## Live Dashboard

View the interactive dashboard on Power BI Service: [link]

## Data Source

LinkedIn Job Postings 2023–2024 dataset, accessed via 
[Kaggle]([https://www.kaggle.com/](https://www.kaggle.com/datasets/arshkon/linkedin-job-postings))

## About

Built by Nikhil Edouard as an independent healthcare analytics 
portfolio project. This is the second of two published projects — 
the first analyzed CMS Medicare hospital quality data across nearly 
3,000 U.S. hospitals using SQL, BigQuery, and Tableau. 

Connect on [LinkedIn](https://linkedin.com/in/Nikhil-edouard) | 
View Project 1: [CMS Hospital Quality Analysis]
(https://github.com/nedouard03/CMS-Hospital-Quality-Analysis)
