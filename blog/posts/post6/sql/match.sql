
SELECT c.person_id AS child_id, c.father_id,
       p.one_income AS parent_one, p.mean_income AS parent_mean,
       e.one_income AS early_one, e.mean_income AS early_mean,
       l.one_income AS later_one, l.mean_income AS later_mean
FROM people AS c
JOIN parents AS p ON c.father_id = p.person_id
JOIN early AS e ON c.person_id = e.person_id
JOIN later AS l ON c.person_id = l.person_id
WHERE e.age BETWEEN 27 AND 32
  AND p.age BETWEEN 30 AND 60
  AND c.home_1985 = p.home
  AND c.sequence_1985 BETWEEN 1 AND 20
ORDER BY child_id
