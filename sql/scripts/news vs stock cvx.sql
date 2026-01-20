SELECT
  s.Date,
  s.Close,
  n.daily_articles
FROM cvx_data s
JOIN cvx_news_daily n
   ON s.Date = n.news_day
WHERE s.Date IS NOT NULL
  AND s.Close IS NOT NULL
ORDER BY s.Date;
