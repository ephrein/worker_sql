USE ATHLETES;

-- Visualizar toda la tabla
SELECT * FROM athletes as A;

-- Estudiar la columna gender (genero) de los atletas
SELECT DISTINCT gender FROM athletes;

-- La tabla de genero tiene dos expresiones para la misma categoria Ej: Male y M
UPDATE athletes
SET gender = 'Male'
WHERE gender = 'M';

UPDATE athletes
SET gender = 'Female'
WHERE gender = 'F';

-- Numero total de atletas
SELECT COUNT(gender) FROM athletes;
-- R: 2897

-- Calcule que porcentaje de hombres y mujeres participaron en las olimpiadas.
SELECT DISTINCT gender genero, ROUND(COUNT(gender)/2897*100,2) as num_atletas
    FROM athletes
    WHERE gender IS NOT NULL
    GROUP BY gender;
-- R: Male 55,30% y Female 44,70%

-- Pais que llevo mas atletas a las olimpiadas
SELECT DISTINCT country pais, COUNT(country) as n_ath_pais
    FROM athletes
    WHERE country IS NOT NULL
    GROUP BY country
    ORDER BY n_ath_pais DESC ;
-- R: United States of America = 225

-- Edad de los atletas tomando como referencia 2022-06-30
WITH edades as
    (
    SELECT name, ROUND(DATEDIFF('2022-06-30', birth_date) / 365, 0) as edad
        FROM athletes as B
        WHERE birth_date IS NOT NULL AND name IS NOT NULL
        ORDER BY edad ASC
    ),
    dep_edad as
   (
    SELECT discipline, edad
        FROM athletes
        LEFT JOIN edades
        ON athletes.name = edades.name
    )
    -- En esta tabla se resume los tipos de disciplina y el promedio de edad de laos atletas
    SELECT discipline, ROUND(AVG(edad),0) avg_edad
        FROM dep_edad
        WHERE discipline IS NOT NULL AND edad IS NOT NULL
        GROUP BY discipline
        ORDER BY avg_edad DESC;









