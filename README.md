# 🔄 Funnels – Drop-off & Conversion Analysis

## Project Overview

This project focuses on analyzing **user funnels** by identifying key events and measuring **drop-off rates** between each stage. The goal is to understand how users progress (or churn) through a defined series of actions, and where the most significant friction points occur.

The analysis was conducted using SQL in BigQuery and visualized in Google Sheets using funnel charts and data tables.

---

## Repository Contents

- 📄 [Funnels Project – Final Google Sheets Visualization](https://docs.google.com/spreadsheets/d/1e1tyeCK-IE6Ri8AGd1XlbFWrG1iaq7i7cGmHfmXlso4/edit?gid=409644485#gid=409644485)
- 📂 `sql/` – Folder containing all SQL queries used in the project:
  - `1_unique_events.sql`
  - `2_events_with_percentage_dropoffs.sql`
  - `3_events_by_category.sql`
  - `4_events_by_top3_countries.sql`
  - `5_funnel_analysis_events.sql`

---

## Project Goals

- Identify the core set of user events forming a funnel
- Measure the number of users at each stage
- Calculate **percentage drop-offs** from one stage to the next
- Analyze event performance by **category** and **top 3 countries**
- Visualize the user journey using a funnel chart

---

## Tools Used

- **BigQuery SQL** – For querying event data and computing funnel metrics
- **Google Sheets** – For funnel chart creation and drop-off visualization

---

## Key Findings

- Significant drop-off was observed between the first and second events, suggesting friction early in the user journey
- Funnel performance varied across **event categories** and **countries**, offering potential for targeted UX or marketing improvements
- The top 3 countries accounted for a large proportion of the total events and exhibited different funnel behaviors

---

## Acknowledgements

- [Google BigQuery](https://cloud.google.com/bigquery) – SQL platform used for querying user event data
- Google Sheets – Used to build funnel visualizations and present metrics

---

## Contact

Feel free to reach out if you have any questions.   
viktorija.melder@gmail.com    
www.linkedin.com/in/viktorija-melder-4799967a
