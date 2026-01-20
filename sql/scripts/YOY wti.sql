WITH monthly_data_wti AS (
  SELECT
    YEAR(Date) AS yr,
    MONTH(Date) AS mn,
    AVG(WTI_Close) AS avg_wti
  FROM brent_wti_data
  WHERE WTI_Close IS NOT NULL
  GROUP BY YEAR(Date), MONTH(Date)
),
monthly_yoy_wti AS (
  SELECT
    d.yr,
    d.mn,
    d.avg_wti,
    LAG(d.avg_wti, 1) OVER (
      PARTITION BY d.mn
      ORDER BY d.yr
    ) AS last_year_wti
  FROM monthly_data_wti d
)
SELECT
  yr,
  mn,
  avg_wti,
  last_year_wti,
  (avg_wti - last_year_wti) AS yoy_diff,
  CASE
    WHEN last_year_wti IS NOT NULL AND last_year_wti <> 0 THEN
      ( (avg_wti - last_year_wti) / last_year_wti ) * 100
    ELSE NULL
  END AS yoy_pct_change
FROM monthly_yoy_wti
ORDER BY yr, mn;
