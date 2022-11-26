USE MOVIES;

-- Visualizar toda la tabla
SELECT * FROM data_movies;

ALTER TABLE data_movies
RENAME COLUMN imdb_rating TO rating;

-- Estadistica de rating por genero de peliculas
SELECT DISTINCT genre kind_genre, MIN(rating) AS min_rating, ROUND(AVG(rating),2) AS avg_rating, MAX(rating) AS max_rating
    FROM data_movies
    WHERE genre IS NOT NULL AND rating IS NOT NULL
    GROUP BY genre;
-- Cantidad de peliculas sin rating
SELECT COUNT(name) as n_movie_snrtg FROM data_movies WHERE rating IS NULL;

-- Peliculas con menor rating (menor a 5) sin considerar las con rating nulo
SELECT name, rating
    FROM data_movies
    WHERE rating IS NOT NULL  AND rating < 5
    ORDER BY rating ASC;

-- Cantidad de peliculas por año y su rating promedio
SELECT DISTINCT year year_movie, COUNT(year) as num_movie, ROUND(AVG(rating),2) as avg_rating
    FROM data_movies
    WHERE year IS NOT NULL AND rating IS NOT NULL
    GROUP BY year
    ORDER BY year_movie ASC;

-- Mayor rating promedio de peliculas por año, considerando los años con más de 6 peliculas.
SELECT DISTINCT year year_movie, COUNT(year) as num_movie, ROUND(AVG(rating),2) as avg_rating
    FROM data_movies
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