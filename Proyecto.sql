-- 1. Crea el esquema de la BBDD.
-- Imagen adjuntada

-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

select f.title 
from	 film f 
where f.rating = 'R';

-- 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

select  a.first_name, a.last_name
from	 actor a 
where	 a.actor_id  between 30 and 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.

select  f.title 
from	 film f 
where	f.language_id  = f.original_language_id;

-- 5. Ordena las películas por duración de forma ascendente.

select  *
from  film f 
order  by  f.length  asc;

-- 6.  Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

select  a.first_name , a.last_name 
from	actor a 
where	a.last_name  like 'ALLEN';

-- 7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento.

select  rating , count(*) as total_peliculas
from  film f 
group  by  f.rating ;

-- 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

select  f.title 
from  film f 
where	 f.rating  = 'PG-13'
or f.length  > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

select  variance(f.replacement_cost ) AS variabilidad_coste
from  film f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

select  
    max(f.length ) as duracion_maxima,
    min(f.length ) as duracion_minima
from  film f ;

-- 11.  Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

select	p.amount as coste_antepenultimo_alquiler
from	rental r
join	payment p on p.rental_id   = r.rental_id
order by r.rental_date desc
limit 1 offset 2;

-- 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.

select	f.title 
from	film f 
where	f.rating  not in ('NC-17', 'G');

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación
--junto con el promedio de duración.

select	 
f.rating ,
avg(f.length ) as promedio_duracion
from  film f 	
group  by f.rating ;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

select	f.title 
from	film f 
where f.length  > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

select  sum(p.amount ) as ingresos_totales
from payment p ;

-- 16. Muestra los 10 clientes con mayor valor de id.

select  *
from  customer
order by customer_id desc
limit 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

select  a.first_name, a.last_name
from  actor a
join  film_actor fa on a.actor_id = fa.actor_id
join  film f on fa.film_id = f.film_id
where  f.title = 'EGG IGBY';

-- 18. Selecciona todos los nombres de las películas únicos.

select  distinct  f.title 
from  film f ;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

select  f.title
from	 film f
join	 film_category fc on f.film_id = fc.film_id
join	 category c on fc.category_id = c.category_id
where	 c.name = 'Comedy'
  and f.length > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
--junto con el promedio de duración.

select	 
    c.name as categoria,
    avg(f.length) as promedio_duracion
from	category c
join	film_category fc on c.category_id = fc.category_id
join	film f on fc.film_id = f.film_id
group by c.name
having avg(f.length) > 110;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

select	avg(f.rental_duration ) as media_duracion_alquiler
FROM film f ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

select	 
    concat	(a.first_name , ' ', a.last_name ) as nombre_completo
from	 actor a ;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

select	 
    date(r.rental_date ) as dia,
    count(*) as numero_alquileres
from rental r 
group by date(r.rental_date )
order by numero_alquileres desc;

-- 24. Encuentra las películas con una duración superior al promedio.

select  f.title , f.length 
from	 film f 
where  f.length  > (
select  avg(length)
from film );

-- 25. Averigua el número de alquileres registrados por mes.

select 
    extract(month from rental_date) as mes,
    count(*) as numero_alquileres
from rental
group by extract(month from rental_date)
order by mes;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

select
    avg(p.amount ) as promedio,
    stddev(p.amount ) as desviacion_estandar,
    variance(p.amount ) as varianza
from payment p ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

select title, rental_rate
from film
where rental_rate > (
    select avg(rental_rate)
    from film );

-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.

select 
    fa.actor_id 
from film_actor fa 
group by fa.actor_id 
having count(fa.film_id ) > 40;

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

select 
f.film_id,
f.title,
count(i.inventory_id) as cantidad_disponible
from film f
left join inventory i 
on f.film_id = i.film_id
group by f.film_id, f.title
order by f.title;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

select 
a.actor_id,
a.first_name,
a.last_name,
count(fa.film_id) as numero_peliculas
from actor a
join film_actor fa 
on a.actor_id = fa.actor_id
group by 
a.actor_id,
a.first_name,
a.last_name
order by numero_peliculas desc;

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

select 
f.film_id,
f.title,
a.first_name,
a.last_name
from film f
left join film_actor fa 
on f.film_id = fa.film_id
left join actor a 
on fa.actor_id = a.actor_id
order by f.title;

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.

select
a.actor_id,
a.first_name,
a.last_name,
f.title
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
order by a.last_name, a.first_name, f.title;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.

select
f.film_id,
f.title,
r.rental_id,
r.rental_date,
r.return_date
from film f
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
order by f.title, r.rental_date;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

select
c.customer_id,
c.first_name,
c.last_name,
sum(p.amount) as total_gastado
from customer c
join payment p
on c.customer_id = p.customer_id
group by
c.customer_id,
c.first_name,
c.last_name
order by total_gastado desc
limit 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

select *
from actor
where first_name = 'JOHNNY';

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

alter table actor 
rename column first_name to nombre;

alter table actor
rename column last_name to apellido;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

select
min(actor_id) as id_minimo,
max(actor_id) as id_maximo
from actor;

-- 38. Cuenta cuántos actores hay en la tabla “actor”.

select count(*) as total_actores
from actor;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

select *
from actor
order by apellido asc;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.

select *
from film
limit 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

select
nombre,
count(*) as total_actores
from actor
group by nombre
order by total_actores desc;

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

select
r.rental_id,
r.rental_date,
c.first_name,
c.last_name
from rental r
join customer c
on r.customer_id = c.customer_id
order by r.rental_date;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

select
c.customer_id,
c.first_name,
c.last_name,
r.rental_id,
r.rental_date,
r.return_date
from customer c
left join rental r
on c.customer_id = r.customer_id
order by c.last_name, c.first_name, r.rental_date;

-- 44.  Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

select
f.title,
c.name as categoria
from film f
cross join category c;

-- El Cross Join ha producido una combinación de cada película con cada categoría, aunque no tengan ninguna relación real.

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.

select distinct
a.actor_id,
a.nombre,
a.apellido
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film_category fc
on fa.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
where c.name = 'Action'
order by a.apellido, a.nombre;

-- 46. Encuentra todos los actores que no han participado en películas.

select
a.actor_id,
a.nombre,
a.apellido
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
where fa.film_id is null;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

select
a.nombre,
a.apellido,
count(fa.film_id) as cantidad_peliculas
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
group by
a.nombre,
a.apellido
order by cantidad_peliculas desc;

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

create view actor_num_peliculas as
select
a.nombre,
a.apellido,
count(fa.film_id) as numero_peliculas
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
group by
a.nombre,
a.apellido;

-- Para consultar la vista
select *
from actor_num_peliculas;

-- 49. Calcula el número total de alquileres realizados por cada cliente.

select
c.customer_id,
c.first_name,
c.last_name,
count(r.rental_id) as total_alquileres
from customer c
left join rental r
on c.customer_id = r.customer_id
group by
c.customer_id,
c.first_name,
c.last_name
order by total_alquileres desc;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

select
sum(f.length) as duracion_total
from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
where c.name = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.

create temporary table cliente_rentas_temporal as
select
c.customer_id,
c.first_name,
c.last_name,
count(r.rental_id) as total_alquileres
from customer c
left join rental r
on c.customer_id = r.customer_id
group by
c.customer_id,
c.first_name,
c.last_name;

-- Para consultar la tabla temporal
select *
from cliente_rentas_temporal;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

create temporary table peliculas_alquiladas as
select
f.film_id,
f.title,
count(r.rental_id) as total_alquileres
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by
f.film_id,
f.title
having count(r.rental_id) >= 10;

-- Consultar la tabla temporal

select *
from peliculas_alquiladas;

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
--los resultados alfabéticamente por título de película.

select distinct
f.title
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
join film f
on i.film_id = f.film_id
where c.first_name = 'TAMMY'
and c.last_name = 'SANDERS'
and r.return_date is null
order by f.title asc;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
--alfabéticamente por apellido.

select distinct
a.nombre,
a.apellido
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film_category fc
on fa.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
where c.name = 'Sci-Fi'
order by a.apellido asc, a.nombre asc;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
--Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.

select distinct
a.nombre,
a.apellido
from actor a
join film_actor fa
on a.actor_id = fa.actor_id
join film f
on fa.film_id = f.film_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
where r.rental_date > (
select min(r2.rental_date)
from film f2
join inventory i2
on f2.film_id = i2.film_id
join rental r2
on i2.inventory_id = r2.inventory_id
where f2.title = 'SPARTACUS CHEAPER'
)
order by a.apellido asc, a.nombre asc;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.

select
a.nombre,
a.apellido
from actor a
where a.actor_id not in (
select distinct fa.actor_id
from film_actor fa
join film_category fc
on fa.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
where c.name = 'Music'
)
order by a.apellido asc, a.nombre asc;

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

select distinct
f.title
from film f
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
where r.return_date is not null
and r.return_date - r.rental_date > interval '8 days'
order by f.title;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

select
f.title
from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id
where c.name = 'Animation'
order by f.title;

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados
--alfabéticamente por título de película.

select
title
from film
where length = (
select length
from film
where title = 'DANCING FEVER'
)
order by title asc;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

select
c.first_name,
c.last_name
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
group by
c.customer_id,
c.first_name,
c.last_name
having count(distinct i.film_id) >= 7
order by c.last_name asc, c.first_name asc;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

select
c.name as categoria,
count(r.rental_id) as total_alquileres
from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by
c.name
order by total_alquileres desc;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

select
c.name as categoria,
count(f.film_id) as total_peliculas
from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
where f.release_year = 2006
group by c.name
order by total_peliculas desc;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

select
s.staff_id,
s.first_name,
s.last_name,
st.store_id
from staff s
cross join store st
order by s.staff_id, st.store_id;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de
--películas alquiladas.

select
c.customer_id,
c.first_name,
c.last_name,
count(r.rental_id) as total_peliculas_alquiladas
from customer c
left join rental r
on c.customer_id = r.customer_id
group by
c.customer_id,
c.first_name,
c.last_name
order by total_peliculas_alquiladas desc;