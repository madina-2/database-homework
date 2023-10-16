SELECT
    s.store_id,
    s.staff_id,
    CONCAT(s.first_name, ' ', s.last_name) AS staff_name,
    SUM(p.amount) AS revenue
FROM
    staff s
INNER JOIN
    payment p ON s.staff_id = p.staff_id
INNER JOIN
    rental r ON p.rental_id = r.rental_id
INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id
INNER JOIN
    store st ON i.store_id = st.store_id
WHERE
    EXTRACT(YEAR FROM p.payment_date) = 2017
GROUP BY
    st.store_id,
    s.staff_id,
    s.first_name,
    s.last_name
HAVING
    SUM(p.amount) = (
        SELECT
            MAX(total_revenue)
        FROM
            (SELECT
                st.store_id,
                s.staff_id,
                SUM(p.amount) AS total_revenue
            FROM
                staff s
            INNER JOIN
                payment p ON s.staff_id = p.staff_id
            INNER JOIN
                rental r ON p.rental_id = r.rental_id
            INNER JOIN
                inventory i ON r.inventory_id = i.inventory_id
            INNER JOIN
                store st ON i.store_id = st.store_id
            WHERE
                EXTRACT(YEAR FROM p.payment_date) = 2017
            GROUP BY
                st.store_id,
                s.staff_id) AS subquery
        WHERE
            subquery.store_id = st.store_id
    );
