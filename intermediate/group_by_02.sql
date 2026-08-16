SELECT skill, COUNT(skill)
FROM candidates
GROUP BY skill
ORDER BY 2 DESC;
