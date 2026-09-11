--- Produces the exact ordering to match Datalemur of the previous problem - https://github.com/KKoshy/datalemur/blob/mainline/advanced/09_rank_multiple_cte.sql

WITH RankingData AS (
  SELECT artist_name,
         DENSE_RANK() OVER (ORDER BY count(rank) DESC) AS artist_rank
  FROM artists
  INNER JOIN songs
  ON artists.artist_id = songs.artist_id
  INNER JOIN global_song_rank AS ranking
  ON songs.song_id = ranking.song_id
  WHERE ranking.rank <= 10
  GROUP BY artist_name
)

SELECT artist_name,
       artist_rank
FROM RankingData
WHERE artist_rank <= 5;
