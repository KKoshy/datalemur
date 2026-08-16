SELECT candidate_id
FROM candidates
GROUP BY candidate_id
HAVING count(candidate_id)>2;
