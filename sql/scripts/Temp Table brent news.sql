CREATE TEMPORARY TABLE brent_news_daily AS
SELECT
  DATE(published_date) AS news_day,
  COUNT(*) AS daily_articles
FROM brent_news
WHERE published_date IS NOT NULL
GROUP BY DATE(published_date);
