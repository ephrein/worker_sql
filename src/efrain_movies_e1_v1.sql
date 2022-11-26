-- Crear Base de datos
CREATE DATABASE MOVIES;
USE MOVIES;
-- Crear Esquema
CREATE SCHEMA sch_movies;
USE sch_movies;

-- Crear Tabla para recibir datos de CSV
CREATE TABLE movies (
    `name` text,
    `genre` text,
    `year` int,
    `rating` float );

-- Encontrar el directorio del docker donde cargar el archivo csv
-- SHOW VARIABLES LIKE "secure_file_priv";

-- Lectura archivo CSV y copia de datos en la tabla
LOAD DATA INFILE '/var/lib/mysql-files/data_movies.csv' IGNORE INTO TABLE movies
CHARACTER SET UTF8
FIELDS TERMINATED BY '|' ENCLOSED BY '|' ESCAPED BY '\n'
LINES TERMINATED BY '\r'
IGNORE 1 LINES;

-- Visualizamos la tabla
SELECT * FROM movies;

-- Error al cargar los datos, por ello reemplazamos algunos ceros por la variable Null
UPDATE movies
SET rating = NULL
WHERE rating = 0;

-- Estadistica de rating por genero de peliculas
SELECT DISTINCT genre kind_genre, MIN(rating) AS min_rating, ROUND(AVG(rating),2) AS avg_rating, MAX(rating) AS max_rating
    FROM movies
    WHERE genre IS NOT NULL AND rating IS NOT NULL
    GROUP BY genre;

-- Cantidad de peliculas sin rating
SELECT COUNT(name) as n_movie_snrtg FROM movies WHERE rating IS NULL;

-- Peliculas con menor rating (menor a 5) sin considerar las con rating nulo
SELECT name, rating
    FROM movies
    WHERE rating IS NOT NULL  AND rating < 5
    ORDER BY rating ASC;

-- Cantidad de peliculas por año y su rating promedio
SELECT DISTINCT year year_movie, COUNT(year) as num_movie, ROUND(AVG(rating),2) as avg_rating
    FROM movies
    WHERE year IS NOT NULL AND rating IS NOT NULL
    GROUP BY year
    ORDER BY year_movie ASC;

-- Mayor rating promedio de peliculas por año, considerando los años con más de 6 peliculas.
SELECT DISTINCT year year_movie, COUNT(year) as num_movie, ROUND(AVG(rating),2) as avg_rating
    FROM movies
    WHERE year IS NOT NULL AND rating IS NOT NULL
    GROUP BY year
    HAVING num_movie > 6
    ORDER BY avg_rating DESC;

-- Ratings promedio por año con puntuacion media entre 6,5 y 7,9.
SELECT DISTINCT year year_movie, COUNT(year) as num_movie, ROUND(AVG(rating),2) as avg_rating
    FROM data_movies
    WHERE year IS NOT NULL AND rating IS NOT NULL
    GROUP BY year
    HAVING num_movie >= 6.5 AND num_movie <= 7.9
    ORDER BY avg_rating DESC;

-- Los primeros 5 años con mayor rating promedio.
SELECT DISTINCT year year_movie, COUNT(year) as num_movie, ROUND(AVG(rating),2) as avg_rating
    FROM data_movies
    WHERE year IS NOT NULL AND rating IS NOT NULL
    GROUP BY year
    ORDER BY avg_rating DESC
    LIMIT 5;



