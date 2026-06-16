# 🐎 Performance Analysis Dashboard: Horse Racing

## 📋 Project Overview
This project was built as a personal initiation into the field of Data Analysis. It serves as my first practical experience in handling end-to-end data cleaning and reporting.

This project involves the design of a Business Intelligence (BI) decision-making model to analyze historical horse racing performance across a dataset containing over 59,000 race participations. The primary objective is to deliver reliable metrics for analysts to identify high-performing horses with strong success rates and understand how odds are distributed across different racetracks.

## 📂 Data Source & ETL Process
The raw data used in this project originates from a public Kaggle dataset. Due to file size limitations, raw CSV files are not included in this repository.

* **Dataset Source:** [Kaggle - Horse Racing Dataset](https://www.kaggle.com/datasets/hwaitt/horse-racing)
* **Dataset Content:** Over 59,000 historical race participation records, horse characteristics (age, sex, breed), racetrack locations, and historical betting odds.
* **Data Pipeline:** 1. **Extract:** Downloaded raw CSV data from Kaggle, 2020 data were used.
  2. **Transform & Clean:** Filtered out corrupt entries, set strict data types, and handled missing values using SQL staging queries.
  3. **Load:** Injected the cleaned data into a relational database structured in a Star Schema before connecting it to Power BI.

---

## 🛠️ Tech Stack
* **Storage Engine:** SQL (PostgreSQL / MySQL) 
* **Business Intelligence:** Power BI Desktop.
* **Modeling Language:** Explicit DAX (Data Analysis Expressions).

---

## 📐 Data Architecture & Modeling
The project is built on a **Star Schema** architecture, isolating the fact table from the dimension tables. This setup optimizes calculation performance and prevents data inflation issues caused by cartesian products.

* **Fact Table:**
    * `Participations`: Contains foreign keys, raw metrics (`cotePari`, `tempsChrono`), and the final race outcome (`positionArriver`).
* **Dimension Tables:**
    * `Chevaux`: Descriptive attributes of the horses (`Nom`, `Age`, `Race`, `Sexe`).
    * `Courses`: Event-specific metadata.
    * `Hippodromes`: Racetrack locations and track characteristics (`Nom`, `Ville`, `typePiste`).

---

## 🧠 Technical Challenges & Engineering Choices (DAX)

### 1. Modifying the Evaluation Context
**The Issue:** Using native implicit aggregations (simple drag-and-drop counts) made it impossible to display both the total number of races and the number of victories side-by-side per horse accurately. Without a dedicated measure, filtering for "Victory" would automatically filter the entire row, turning the "Total Races" count into the "Total Wins" count as well.

**The Solution:** Implemented explicit DAX measures using `CALCULATE`. This function overrides the default filter context for that specific column, filtering the underlying fact table data for `positionArriver = 1` while leaving the rest of the row's evaluation context (like total race appearance volume) intact.

### 2. Implemented DAX Formulas

* **Global Participation Volume:**
    ```dax
    Nombre de Courses = COUNT(Participations[id_Course]) + 0
    ```

* **Isolated Victory Count (with null-value handling):**
    ```dax
    Nombre de Victoires = CALCULATE(COUNT(Participations[id_Course]), Participations[positionArriver] = 1) + 0
    ```

## 🔍 Key Insights & Data Analytics

* **Statistical Reliability vs. Absolute Performance:** The analysis highlights distinct profiles like *Golden Sixty*, boasting a perfect 100% win rate over a limited sample size (8 races, 8 wins), compared to high-volume, battle-tested profiles like *Will Power* (18 races, 9 wins).

* **Odds Asymmetry:** Racetracks located in Japan (*Tokyo*, *Hanshin*) display the highest average betting odds in the entire model (average odds > 31). This signals high-volatility race dynamics or potentially higher payouts for bettors.

---

## 📊 Dashboard Render

![Dashboard View](Assets/tableau_de_bord.png)

*Note: The primary table sorting is indexed in descending order based on the explicit `Nombre de Victoires` measure to instantly surface the highest-performing assets at the top of the report.*