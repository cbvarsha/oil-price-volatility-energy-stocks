WITH monthly_data AS (
  SELECT
    YEAR(Date) AS yr,
    MONTH(Date) AS mn,
    AVG(Close) AS avg_close
  FROM bp_data
  WHERE Close IS NOT NULL
  GROUP BY YEAR(Date), MONTH(Date)
),
monthly_yoy AS (
  SELECT
    d.yr,
    d.mn,
    d.avg_close,
    LAG(d.avg_close, 1) OVER (PARTITION BY d.mn ORDER BY d.yr) AS last_year_close
  FROM monthly_data d
)
SELECT
  yr,
  mn,
  avg_close,
  last_year_close,
  (avg_close - last_year_close) AS yoy_diff,
  ( (avg_close - last_year_close) / last_year_close ) * 100 AS yoy_pct_change
FROM monthly_yoy
ORDER BY yr, mn;
