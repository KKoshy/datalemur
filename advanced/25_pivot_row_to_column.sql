SELECT superhero_alias,
       MAX(CASE WHEN platform='Instagram' THEN engagement_rate END) AS instagram_engagement_rate,
       MAX(CASE WHEN platform='Twitter' THEN engagement_rate END) AS twitter_engagement_rate,
       MAX(CASE WHEN platform='TikTok' THEN engagement_rate END) AS tiktok_engagement_rate,
       MAX(CASE WHEN platform='YouTube' THEN engagement_rate END) AS youtube_engagement_rate
FROM marvel_avengers
GROUP BY superhero_alias
ORDER BY superhero_alias;
