
SELECT person_id,
       AVG(income) AS mean_income,
       MAX(CASE WHEN year = ? THEN income END) AS one_income,
       MAX(CASE WHEN year = ? THEN age END) AS age,
       MAX(CASE WHEN year = ? THEN family_id END) AS home
FROM incomes
WHERE year IN (?, ?, ?)
GROUP BY person_id
HAVING COUNT(income) = 3
