-- 1A) Aggregate daily articles
CREATE TEMPORARY TABLE xom_news_daily AS
SELECT
  DATE(published_date) AS news_day,
  COUNT(*) AS daily_articles
FROM xom_news
WHERE published_date IS NOT NULL
GROUP BY DATE(published_date);
