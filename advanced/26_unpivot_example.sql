SELECT
  superhero_alias,
  platform,
  CASE platform
    WHEN 'Instagram' THEN engagement_rate
    WHEN 'Twitter' THEN engagement_rate
    WHEN 'YouTube' THEN engagement_rate
    WHEN 'TikTok' THEN engagement_rate
  END AS engagement_rate
FROM marvel_avengers
WHERE superhero_alias IN ('Iron Man', 'Captain America', 'Black Widow', 'Thor')
ORDER BY superhero_alias;
