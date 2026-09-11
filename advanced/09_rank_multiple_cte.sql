--- this version has a minor difference in the ordering in artist_name compared to output, but the results are the same.

WITH SongFrequency AS (
  SELECT song_id, COUNT(rank) AS song_count
  FROM global_song_rank
  WHERE rank <= 10
  GROUP BY song_id
),

ArtistData AS (
  SELECT artist_id,
        SUM(song_count) AS song_count
  FROM SongFrequency
  LEFT JOIN songs
  ON songs.song_id = SongFrequency.song_id
  WHERE artist_id IS NOT NULL
  GROUP BY artist_id
),

RankData AS (
  SELECT artist_name,
        DENSE_RANK() OVER (ORDER BY song_count DESC) AS artist_rank
  FROM ArtistData
  LEFT JOIN artists
  ON ArtistData.artist_id = artists.artist_id
)

SELECT artist_name,
      artist_rank
FROM RankData
WHERE artist_rank <= 5;
