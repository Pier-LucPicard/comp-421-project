SELECT first_name, last_name, gender, country,
       COUNT(*) OVER (PARTITION BY country)
FROM users
WHERE last_name  SIMILAR TO '[A-L]%'
ORDER BY first_name

SELECT email, last_name, city, birthday,
       AVG(date_part('year',current_date)-date_part('year',birthday)) OVER (PARTITION BY city ORDER BY birthday) AS avg_city_age_soFar
FROM   users;