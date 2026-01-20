WITH daily_changes AS (
  SELECT
    Date,
    WTI_Close,
    LAG(WTI_Close) OVER (ORDER BY Date) AS prev_wti,
    (WTI_Close - LAG(WTI_Close) OVER (ORDER BY Date)) AS daily_change
  FROM brent_wti_data
  WHERE WTI_Close IS NOT NULL
    AND Date IS NOT NULL
)
SELECT
  Date,
  WTI_Close,
  prev_wti,
  daily_change
FROM daily_changes
ORDER BY daily_change DESC
LIMIT 10;
