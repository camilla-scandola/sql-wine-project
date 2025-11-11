-- Creating the database and selecting it
CREATE DATABASE sql_wine_study;
USE sql_wine_study;

-- Creating a table for the UCI Wine dataset
CREATE TABLE wine_dataset (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Alcohol FLOAT,
    Malicacid FLOAT,
    Ash FLOAT,
    Alcalinity_of_ash FLOAT,
    Magnesium FLOAT,
    Total_phenols FLOAT,
    Flavanoids FLOAT,
    Nonflavanoid_phenols FLOAT,
    Proanthocyanins FLOAT,
    Color_intensity FLOAT,
    Hue FLOAT,
    0D280_0D31 FLOAT,
    Proline FLOAT,
    class INT
);

-- Creating a table for the Wine Magazine Reviews dataset
CREATE TABLE winemag_data_clean (
    id INT AUTO_INCREMENT PRIMARY KEY,
    country VARCHAR(100),
    province VARCHAR(100),
    variety VARCHAR(100),
    winery VARCHAR(150),
    points INT,
    price FLOAT
);

-- Allow local file importing
SET GLOBAL local_infile = 1;

-- Load UCI Wine data into wine_dataset
LOAD DATA LOCAL INFILE './wine_dataset.csv'
INTO TABLE wine_dataset
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Load Wine Magazine Reviews data into winemag_data_clean
LOAD DATA LOCAL INFILE './winemag_data_clean.csv'
INTO TABLE wine_data_clean
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- Verifying that tables have been created

SHOW TABLES;

-- Checking total records count for each table (from respective datasets)

SELECT COUNT(*) AS total_class_records FROM wine_dataset;
SELECT COUNT(*) AS total_ratings_records FROM winemag_data_clean;

-- Checking table layout

SELECT * FROM wine_dataset LIMIT 5;
SELECT * FROM winemag_data_clean LIMIT 5;

-- 🧪🍷 PART 1: In this part, I calculate average chemical values per class and then create a
-- table that assigns qualitative level categories to each class.

-- 1. Calculating average values for every chemical component, grouped by class (cultivar)

SELECT
    class,
    ROUND(AVG(Alcohol), 2) AS avg_alcohol,
    ROUND(AVG(Malicacid), 2) AS avg_malic_acid,
    ROUND(AVG(Color_intensity), 2) AS avg_color_intensity,
    ROUND(AVG(Total_phenols), 2) AS avg_phenols,
    ROUND(AVG(Flavanoids), 2) AS avg_flavanoids,
    ROUND(AVG(Hue), 2) AS avg_hue,
    ROUND(AVG(Proline), 2) AS avg_proline
FROM wine_dataset
GROUP BY class
ORDER BY class;

-- 2. Creating a structured table for wine classes with measurable categories

CREATE TABLE wine_class_characteristics (
    class INT PRIMARY KEY,
    alcohol_quantity VARCHAR(20),
    malic_acid_level VARCHAR(20),
    phenols_level VARCHAR(20),
    flavanoids_level VARCHAR(20),
    color_intensity_level VARCHAR(20)
);

-- 3. Assigning levels to each chemical and mapping them into a table

INSERT INTO wine_class_characteristics (class, alcohol_quantity, malic_acid_level, phenols_level, flavanoids_level, color_intensity_level)
VALUES
(1, 'High', 'Low', 'High', 'High', 'Medium'),
(2, 'Medium', 'Low', 'Medium', 'Medium', 'Low'),
(3, 'Medium', 'High', 'Low', 'Low', 'High');


SELECT 
    w.class,
    wc.alcohol_quantity,
    wc.malic_acid_level,
    wc.phenols_level,
    wc.flavanoids_level,
    wc.color_intensity_level,
    ROUND(AVG(w.Alcohol), 2) AS avg_alcohol,
    ROUND(AVG(w.Malicacid), 2) AS avg_malic_acid,
    ROUND(AVG(w.Total_phenols), 2) AS avg_total_phenols,
    ROUND(AVG(w.Flavanoids), 2) AS avg_flavanoids,
    ROUND(AVG(w.Color_intensity), 2) AS avg_color_intensity
FROM wine_dataset w
JOIN wine_class_characteristics wc
ON w.class = wc.class
GROUP BY 
    w.class,
    wc.alcohol_quantity,
    wc.malic_acid_level,
    wc.phenols_level,
    wc.flavanoids_level,
    wc.color_intensity_level;
    
-- 🇮🇹🍇 PART 2: 
-- This parts focuses on Italian wines, and the goal is to compare ratings and prices;
-- After retrieving all Italian wines, the analysis goes on to focus on wines from Piemonte and conceptually maps them to the three UCI wine classes 
-- based on their supposed grape varieties (Nebbiolo (Barolo), Barbera, Grignolino)
-- The goal is to assess how these wines rank among all Italian varieties and if there are correlations between their chemical composition and likeness


-- 1. Identifying Italian wines with missing prices

SELECT variety, province, points, price
FROM winemag_data_clean
WHERE country = 'Italy'
  AND (price IS NULL OR price = 0);


-- 2. Calculating average rating and price per Italian variety and province

CREATE OR REPLACE VIEW italian_wine_summary AS
SELECT 
    variety,
    province,
    ROUND(AVG(points), 1) AS avg_rating,
    CASE 
        WHEN AVG(price) IS NULL THEN 'Not available'
        ELSE ROUND(AVG(price), 2)
    END AS avg_price
FROM winemag_data_clean
WHERE country = 'Italy'
GROUP BY variety, province
ORDER BY avg_rating DESC;

SELECT * FROM italian_wine_summary LIMIT 10;


-- 3. Filtering only Piemonte wines

CREATE OR REPLACE VIEW piemonte_wines AS
SELECT 
    variety,
    province,
    ROUND(AVG(points), 1) AS avg_rating,
    CASE 
        WHEN AVG(price) IS NULL THEN 'Not available'
        ELSE ROUND(AVG(price), 2)
    END AS avg_price
FROM winemag_data_clean
WHERE country = 'Italy' 
  AND province LIKE '%Piedmont%'
GROUP BY variety, province
ORDER BY avg_rating DESC;

SELECT * FROM piemonte_wines;


-- 4. Mapping Piemonte varieties to UCI wine classes

CREATE OR REPLACE VIEW piemonte_class_mapping AS
SELECT 
    variety,
    province,
    ROUND(AVG(points), 1) AS avg_rating,
    CASE 
        WHEN AVG(price) IS NULL THEN 'Not available'
        ELSE ROUND(AVG(price), 2)
    END AS avg_price,
    CASE 
        WHEN variety LIKE '%Nebbiolo%' THEN 'Class 1'
        WHEN variety LIKE '%Barbera%' THEN 'Class 2'
        WHEN variety LIKE '%Grignolino%' THEN 'Class 3'
        ELSE 'Other Piemonte variety'
    END AS conceptual_class
FROM winemag_data_clean
WHERE country = 'Italy'
  AND (province LIKE '%Piedmont%' OR region_1 LIKE '%Piedmont%')
GROUP BY variety, province, conceptual_class
ORDER BY avg_rating DESC;

SELECT * FROM piemonte_class_mapping;


-- 5. Ranking all Italian wines by average rating

CREATE OR REPLACE VIEW italian_wine_ranked AS
SELECT 
    variety,
    province,
    ROUND(AVG(points), 1) AS avg_rating,
    CASE 
        WHEN AVG(price) IS NULL THEN 'Not available'
        ELSE ROUND(AVG(price), 2)
    END AS avg_price,
    DENSE_RANK() OVER (ORDER BY AVG(points) DESC) AS rating_rank
FROM winemag_data_clean
WHERE country = 'Italy'
GROUP BY variety, province
ORDER BY rating_rank;

SELECT * FROM italian_wine_ranked LIMIT 10;


-- 6. Comparing the three classes (Piemonte wines) to all Italian wines by rank; this shows how Nebbiolo, Barbera, and Grignolino rank overall

SELECT 
    i.rating_rank,
    i.variety,
    i.province,
    i.avg_rating,
    i.avg_price,
    CASE 
        WHEN i.variety LIKE '%Nebbiolo%' THEN 'Class 1'
        WHEN i.variety LIKE '%Barbera%' THEN 'Class 2'
        WHEN i.variety LIKE '%Grignolino%' THEN 'Class 3'
        ELSE 'Other'
    END AS conceptual_class
FROM italian_wine_ranked i
WHERE i.variety IN ('Nebbiolo', 'Barbera', 'Grignolino')
ORDER BY i.rating_rank;

SELECT DISTINCT variety
FROM winemag_data_clean
WHERE country = 'Italy' AND province LIKE '%Piedmont%'
ORDER BY variety;
