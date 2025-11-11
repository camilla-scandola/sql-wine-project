# sql-wine-project
# 🍷 SQL Wine Study  
[The Science Behind Wine](https://docs.google.com/presentation/d/1h3SEF8ikUqUs0xNb5UQ0rbcuz6sclPfLNSgg-Jlq3aA/edit?slide=id.g3a0343450ef_2_75#slide=id.g3a0343450ef_2_75)


---

## Project Overview  
This project focuses on exploring the relationship between the chemical composition of different types of wines and their likeability and perceived quality among consumers.  
By combining a quantitative dataset (UCI Wine) with a qualitative one (Wine Magazine Reviews), the goal is to understand how measurable chemical traits influence the way wines are rated and see how they are differently priced.

---

## 🧪 Dataset 1: UCI Wine Dataset (Quantitative Data)
The **UCI Wine dataset** contains the results of a chemical analysis of wines produced from **three different grape cultivars** grown in the **Piemonte region of Italy**.  

Each sample includes measurements of **13 chemical components**, such as:
- Alcohol  
- Malic acid  
- Flavanoids  
- Color intensity  
- Proline  
- Ash, magnesium, and more  

These values reflect differences in **body, color, flavor, and acidity** among the cultivars.

---

## 🍇 Dataset 2 — Wine Reviews Dataset *(Qualitative Data)*  
The **Wine Reviews dataset** (e.g., from [Kaggle’s Wine Reviews](https://www.kaggle.com/datasets/zynicide/wine-reviews)) includes real-world information on thousands of wines from around the world.  

Each record typically contains:
- **Variety** (e.g., Cabernet Sauvignon, Pinot Noir)  
- **Region and country of origin**  
- **Rating/Points** (reflecting critic or consumer preference)  
- **Tasting notes** (descriptions of flavor, aroma, and style)  

This dataset represents the *human perception* and *popularity* side of wine appreciation.

---

## 🎯 Project Goal  
To **analyze and correlate** the two datasets, exploring how wine composition relates to popularity.

Specifically:
- Identify which **chemical properties** are most strongly linked to **high-rated wines**.  
- Understand which **characteristics** (e.g., higher alcohol, more flavanoids, stronger color intensity) tend to appear in **popular or premium wines**.  
- Map **chemical profiles** from the UCI dataset to **real-world wine styles** from the review dataset.

---

## Approach:

1. **Profile the UCI Dataset**  
   - Calculate averages and distributions of chemical features per cultivar.  
   - Identify patterns (e.g., full-bodied vs. light-bodied wines).

2. **Map Cultivars to Wine Styles**  
   - Associate UCI cultivars with similar real-world wine varieties (e.g., Class 1 → Barolo/Cabernet, Class 2 → Chianti/Pinot Noir).  
   - Create a mapping table to bridge chemical and stylistic data.

3. **Join with the Review Dataset (SQL)**  
   - Use SQL joins to link the mapped varieties to the Wine Reviews dataset.  
   - Aggregate ratings, prices, and regions for each style.

4. **Analyze Correlations**  
   - Compare composition metrics (alcohol, color intensity, flavanoids) with average ratings.  
   - Identify trends showing which chemical features drive popularity.

5. **Visualize Insights**  
   - 
