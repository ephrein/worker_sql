

Lenguaje Programación 
SQL 

Herramientas: 
Docker
DataGrip 

Procedimiento:
Mediante docker se crea y levanta una contenedor de “mysql”. 
Desde “DataGrip” nos conectamos al contenedor para poder trabajar con los conjuntos de datos. 
Se probaron 2 métodos para la importación de los conjuntos de datos en CSV. El primero consistía en cargar los archivos en un directorio del contenedor docker. 
La importación se realizaba con los siguientes comandos: 


	LOAD DATA INFILE '/var/lib/mysql-files/data_movies.csv' IGNORE INTO TABLE movies
	CHARACTER SET UTF8
	FIELDS TERMINATED BY '|' ENCLOSED BY '|' ESCAPED BY '\n'
	LINES TERMINATED BY '\r'
	IGNORE 1 LINES; 

