# 🍷 SQL Wine Project  
[The Science Behind Wine](https://docs.google.com/presentation/d/1h3SEF8ikUqUs0xNb5UQ0rbcuz6sclPfLNSgg-Jlq3aA/edit?slide=id.g3a0343450ef_2_75#slide=id.g3a0343450ef_2_75)



## Project Overview: 
The project explores the correlations between the **chemical composition of wines** and their **popularity or perceived quality** among consumers.  
By combining the first dataset (UCI Wine), which is purely scientific and solely based on quantitative data, with a qualitative one (Wine Reviews), the goal is to understand how measurable chemical components influence the likability of wine.

---

## 🧪 Dataset 1: UCI Wine Dataset
The **UCI Wine dataset** contains the results of a chemical analysis of wines produced from three different grape cultivars grown in Piemonte, Italy.  

Each sample includes measurements of 13 chemical components (Alcohol, color intensity etc.), which reflect differences in body, color, flavor, and acidity among the cultivars.

---

## 🍇 Dataset 2: Wine Reviews Dataset
The **Wine Reviews dataset** ([Kaggle’s Wine Reviews](https://www.kaggle.com/datasets/zynicide/wine-reviews)) includes information and ratings on thousands of wines from around the world.  

Each row contains:
- **Variety**
- **Region and country of origin**  
- **Rating/Points**

---

## 🎯 Project Goal  
To **analyze and correlate** the two datasets, exploring how wine composition relates to popularity.

Specifically:
- Identify which **chemical properties** are linked to higher or lower likability;  
- Understand which **characteristics** (e.g., higher alcohol, more flavanoids, stronger color intensity) tend to appear in popular wines


---

## Approach with SQL

1. Created a new database (`sql_wine_study`);

2. Calculated average chemical component values grouped by wine class to understand the chemical profile of each cultivar;

3. Created a separate table (`wine_class_characteristics`) assigning qualitative levels (high, medium, low) to each class based on the chemical averages;

4. Displayed and interpreted these class-based chemical profiles;

5. Analyzed Italian wines by calculating average ratings and prices across varieties and provinces;

6. Focused specifically on Piemonte wines and mapped key grape varieties (Nebbiolo, Barbera, Grignolino) to the UCI wine classes;

7. Ranked all Italian wines by average rating and compared Piemonte varieties to national ranking results.

---

### Tables
- The UCI Wine dataset (chemical analysis + class labels)
- The Wine Magazine reviews dataset (geographic + rating + price data)
- Wine Class Characteristics, which assigns qualitative levels to each class
  
### Views
- `italian_wine_summary`: average rating and price grouped by variety and province for Italian wines
- `piemonte_wines`: subset of Italian wines filtered for Piemonte with average rating and price
- `piemonte_class_mapping`: Piemonte wines mapped conceptually to UCI wine classes based on grape variety
- `italian_wine_ranked`: all Italian wines ranked by average rating using `DENSE_RANK()`

---
