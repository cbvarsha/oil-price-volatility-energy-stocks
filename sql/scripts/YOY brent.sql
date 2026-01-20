WITH monthly_data_brent AS (
  SELECT
    YEAR(Date) AS yr,
    MONTH(Date) AS mn,
    AVG(Brent_Close) AS avg_brent
  FROM brent_wti_data
  WHERE Brent_Close IS NOT NULL
  GROUP BY YEAR(Date), MONTH(Date)
),
monthly_yoy_brent AS (
  SELECT
    d.yr,
    d.mn,
    d.avg_brent,
    LAG(d.avg_brent, 1) OVER (
      PARTITION BY d.mn
      ORDER BY d.yr
    ) AS last_year_brent
  FROM monthly_data_brent d
)
SELECT
  yr,
  mn,
  avg_brent,
  last_year_brent,
  (avg_brent - last_year_brent) AS yoy_diff,
  CASE
    WHEN last_year_brent IS NOT NULL AND last_year_brent <> 0 THEN
      ( (avg_brent - last_year_brent) / last_year_brent ) * 100
    ELSE NULL
  END AS yoy_pct_change
FROM monthly_yoy_brent
ORDER BY yr, mn;
