SELECT
  b.Date,
  b.WTI_Close,
  n.daily_articles
FROM brent_wti_data b
JOIN wti_news_daily n
   ON b.Date = n.news_day
WHERE b.Date IS NOT NULL
  AND b.WTI_Close IS NOT NULL
ORDER BY b.Date;
