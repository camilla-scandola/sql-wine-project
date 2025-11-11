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

## Note:
we need to create an extra column on both dataset, and map each cultivar and wine variety to a specific type (full-bodied reds, lights reds, medium/aromatic)

---
