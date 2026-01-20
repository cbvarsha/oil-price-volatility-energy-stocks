SELECT
  b.Date,
  b.Brent_Close,
  n.daily_articles
FROM brent_wti_data b
JOIN brent_news_daily n
   ON b.Date = n.news_day
WHERE b.Date IS NOT NULL
  AND b.Brent_Close IS NOT NULL
ORDER BY b.Date;
