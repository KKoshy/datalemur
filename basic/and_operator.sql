SELECT * 
FROM reviews
WHERE stars >= 4
AND review_id BETWEEN 2000 AND 6000
AND user_id != 142;
