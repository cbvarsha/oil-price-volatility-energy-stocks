CREATE TEMPORARY TABLE wti_news_daily AS
SELECT
  DATE(published_date) AS news_day,
  COUNT(*) AS daily_articles
FROM wti_news
WHERE published_date IS NOT NULL
GROUP BY DATE(published_date);
