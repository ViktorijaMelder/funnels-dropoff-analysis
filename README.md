# Funnels – Drop-off & Conversion Analysis

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
- Analyze funnel behavior by **category** and **top 3 countries**
- Visualize the user journey using a funnel chart

---

## Tools Used

- **BigQuery SQL** – For querying event data and computing funnel metrics
- **Google Sheets** – For funnel chart creation and drop-off visualization

---

## Key Findings

- The funnel analysis revealed the **highest user drop-off** occurred between the **View Item** and **Add to Cart** steps (79.27%), followed by **Session Start → View Item** (76.88%). These indicate potential friction in product discovery and purchase intent.

- Different funnel stages showed varying levels of user drop-off. The most significant losses occurred between **View Item → Add to Cart** and **Session Start → View Item**, possibly due to missing information or unclear navigation. A moderate drop-off between **Shipping Info → Payment Info** also suggests potential friction from required sign-ins or hidden charges.

- The **Add to Cart → Add Shipping Info** step had a **lower-than-average drop-off**, possibly indicating user trust or interface efficiency at that stage.

- The most preferred platform for funnel engagement was **Desktop (58%)**, followed by **Mobile (40%)**, and **Tablet (2%)**.

- Drop-off rates were **consistent across device categories**, indicating no major usability issues specific to one platform.

---

## Acknowledgements

- [Google BigQuery](https://cloud.google.com/bigquery) – SQL platform used for querying user event data  
- Google Sheets – Used to build funnel visualizations and present metrics

---

## Contact

Feel free to reach out if you have any questions.   
viktorija.melder@gmail.com    
www.linkedin.com/in/viktorija-melder-4799967a
