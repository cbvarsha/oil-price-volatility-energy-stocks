WITH daily_changes AS (
  SELECT
    Date,
    Brent_Close,
    LAG(Brent_Close) OVER (ORDER BY Date) AS prev_brent,
    (Brent_Close - LAG(Brent_Close) OVER (ORDER BY Date)) AS daily_change
  FROM brent_wti_data
  WHERE Brent_Close IS NOT NULL
    AND Date IS NOT NULL
)
SELECT
  Date,
  Brent_Close,
  prev_brent,
  daily_change
FROM daily_changes
ORDER BY daily_change DESC
LIMIT 10;
