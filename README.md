# 📊 Case Study: Bellabeat Fitness Data Analysis


## 📌 One-line Summary  
**A complete analysis of Bellabeat smart device data to uncover behavioral patterns and provide actionable insights for growth-focused marketing strategies.**

---

## 🔍 1. Ask – Defining the Business Task

**Business Objective:**  
Bellabeat, a wellness tech company targeting health-conscious women, wants to leverage data to strengthen its position in the smart device market. The marketing team seeks insights from user activity data to drive evidence-based marketing strategies and product positioning.

**Key Stakeholders:**  
- **Primary:** Urška Sršen (Co-founder), Sando Mur (Executive Team)  
- **Secondary:** Bellabeat Marketing Analytics Team

**Key Question:**  
*How are users engaging with their smart devices, and what patterns can inform Bellabeat’s future marketing and product decisions?*

---

## 🗂 2. Prepare – Data Collection & Understanding

**Data Source:**  
- Public Fitbit Dataset from Kaggle:  
  [https://www.kaggle.com/arashnic/fitbit](https://www.kaggle.com/arashnic/fitbit)

**About the Dataset:**  
- Data collected from **30 Fitbit users** between **March 2016 to May 2016**
- Covers daily activity, sleep tracking, heart rate, and weight logs
- Comprises 18 CSV files with minute-level to daily-level granularity

**ROCCC Review:**

| Criteria      | Assessment |
|---------------|------------|
| **Reliable**  | Sourced via Mechanical Turk with user consent |
| **Original**  | Collected directly from devices worn by participants |
| **Comprehensive** | Tracks key behaviors like steps, sleep, calories |
| **Current**   | Dated (2016) – user behavior may have evolved |
| **Cited**     | Limited citation; from a Kaggle community dataset |

**Limitations:**
- Small sample size (n = 30–33)
- Uneven data availability across users
- Sparse weekend activity records
- Weight data inconsistently tracked (only 8 users)

---

## 🧹 3. Process – Data Cleaning & Transformation

**Tools Used:**  
`R`, with libraries: `tidyverse`, `lubridate`, `dplyr`, `skimr`

**Key Steps:**
- Renamed columns for consistency (e.g., `ActivityDate → activitydate`)
- Parsed date/time formats using `mdy()` and `mdy_hms()`
- Removed duplicates and null entries
- Merged datasets for richer insights (`daily_activity` + `sleep_day`)
- Added derived features like `day of the week` and activity intensity categories

**Data Challenges Addressed:**
- Inconsistent column names across CSVs
- Time zones and timestamp formatting
- Mismatched users across datasets (handled via joins and `distinct()`)

---

## 📈 4. Analyze – Uncovering Trends & Patterns

**Exploratory Questions:**
- Do users with more sleep tend to be more active?
- Are there consistent patterns in activity based on days of the week?
- What is the relationship between calories burned and step count?

**Key Insights:**
- **Weekday Engagement:** Higher physical activity from Tuesday to Thursday
- **Sleep vs. Steps:** Weak correlation – longer sleep doesn’t always lead to more steps
- **Activity Breakdown:** Most users fall under lightly active or sedentary
- **Weight Log:** Sparse, but BMI distribution shows concentration in the healthy range
- **User Retention:** Varies widely; some users only recorded for <7 days

**Visuals Created:**
- Bar plots of average steps/sleep per weekday
- Correlation scatter plots (e.g., `TotalMinutesAsleep` vs. `TotalSteps`)
- Histogram of user engagement (active days)
- BMI distribution from weight logs

---

## 📢 5. Share – Communicating Results

**Mediums:**
- Visuals exported from `ggplot2` and embedded in reports
- [Optional] Tableau dashboard for dynamic exploration
- Summary tables generated in R (e.g., mean steps, calories, sleep)

**Narrative Strategy:**
Each insight was paired with a potential business implication, such as:
- Targeting weekday behavior in app notifications
- Highlighting wellness benefits for low-activity users
- Promoting smart scale integration to boost tracking habits

---

## 🚀 6. Act – Strategic Recommendations

Based on the analysis, here are actionable steps for Bellabeat:

1. **Enhance Weekend Engagement:**  
   Introduce reminders or app features encouraging activity logging over weekends.

2. **Behavior-Based Targeting:**  
   Personalize marketing messages based on user activity clusters (e.g., lightly active vs. sedentary).

3. **Incentivize Tracking Consistency:**  
   Launch loyalty badges or streaks for continuous usage (especially for sleep and weight tracking).

4. **Smart Scale Integration Campaign:**  
   Push campaigns encouraging hardware syncing (e.g., Bellabeat Spring + app)

5. **Refine Product Messaging:**  
   Promote Bellabeat’s holistic tracking (activity, sleep, wellness) as a differentiator against competition.

---
   
## 👨‍💻 Author

**Achuth Akilesh**  
*Data Analyst & UI/UX Enthusiast*
