SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
    a.last_name,
    a.first_name,
    MAX(f.last_update) AS last_film
FROM 
    actor a
INNER JOIN 
    film_actor fa ON a.actor_id = fa.actor_id
INNER JOIN 
    film f ON fa.film_id = f.film_id
GROUP BY 
    a.actor_id,
    a.last_name,
    a.first_name
ORDER BY 
    last_film ASC;


