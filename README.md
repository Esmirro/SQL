# 📊 Proyecto de Análisis SQL sobre Base de Datos de Alquileres

## Descripción del proyecto

El presente proyecto tiene como objetivo el análisis y explotación de una base de datos de alquiler de películas mediante el uso SQL.

A lo largo del proyecto se han aplicado distintos conceptos fundamentales y avanzados del lenguaje SQL para extraer información relevante y responder a distintos requisitos planteados.

## Objetivos del proyecto

- Familiarizarse con la estructura de una base de datos relacional.
- Aplicar consultas SQL para la obtención de información.
- Utilizar correctamente JOINs, subconsultas, funciones de agregación, vistas y tablas temporales.
- Analizar los datos obtenidos y extraer conclusiones.

## Herramientas utilizadas

- DBeaver como gestos de la base de datos.
- PostreSQL como motor de base de datos.
- Archivo de base de datos en formato .sql

## Pasos seguidos durante el proyecto
#### 1. Preparación del entorno
- Crear una conexión a la base de datos desde DBeaver.
- Importar el archivo .sql proporcionado, que contiene la estrucutra y los datos de la base.
- Verificar que todas las tablas se han cargado correctamente.

#### 2. Exploración de la base de datos
- Analizar las tablas principales y sus relaciones.
- Identificar claves primarias.
- Comprender el modelo relacional.

#### 3. Desarrollo de consultas SQL
- Consultas básicas como SELECT, ORDER BY, WHERE
- Consultas de agregación como COUNT, SUM, AVG, MIN, MAX
- Consultas con JOINs como INNER JOIN, LEFT JOIN, CROSS JOIN
- Creación de vistas y tablas temporales

## Informe de análisis
- Identificamos las categorías más alquiladas para conocer las preferencias de los clientes.
- Analizamos el comportamiento de los clientes, detectando cuales son los que más alquilan y más dinero gastan.
- Evaluamo la participación de los actores, tanto por número de películas como por categorías.
- Algunas consultas como CROSS JOIN no aportan valor real en casos específicos.
- Se detectan clientes y actores sin registros, lo que desmuestra la importancia del uso de LEFT JOIN.

## Conclusiones finales
El proyecto ha permitido consolidar y ampliar conocimientos sobre el uso del SQL en un entorno práctico y realista, simulando el funcionamiento de una base de datos utilizada en un sistema de alquiler de películas. A través de consultas se ha adquirido una comprensión más profunda de como extraer, analizar y relacionar datos almacenados en bases de datos relacionales.

Además ha servido para aplicar los conceptos teóricos como joins, subconsultas, funciones de agregación, vistas y tablas temporales a problemas reales como el comportamiento de clientes, gestión de inventario o obtención de métricas de negocio.
   
