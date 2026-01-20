WITH xom_news_daily AS (
  SELECT
    DATE(published_date) AS news_day,
    COUNT(*) AS daily_articles
  FROM xom_news
  WHERE published_date IS NOT NULL
  GROUP BY DATE(published_date)
),
joined AS (
  SELECT
    s.Close AS x,  -- stock close
    n.daily_articles AS y  -- daily news count
  FROM xom_data s
  JOIN xom_news_daily n ON s.Date = n.news_day
  WHERE s.Close IS NOT NULL
),
calc AS (
  SELECT
    COUNT(*) AS n,
    SUM(x) AS sum_x,
    SUM(y) AS sum_y,
    SUM(x*x) AS sum_x2,
    SUM(y*y) AS sum_y2,
    SUM(x*y) AS sum_xy
  FROM joined
)
SELECT
  (
    (c.n * c.sum_xy) - (c.sum_x * c.sum_y)
  ) / (
    SQRT(
      (c.n * c.sum_x2 - (c.sum_x * c.sum_x)) *
      (c.n * c.sum_y2 - (c.sum_y * c.sum_y))
    )
  ) AS corr_close_vs_articles
FROM calc c;
