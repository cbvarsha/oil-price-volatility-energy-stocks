WITH daily_changes AS (
  SELECT
    Date,
    Close,
    LAG(Close) OVER (ORDER BY Date) AS prev_close,
    (Close - LAG(Close) OVER (ORDER BY Date)) AS daily_change
  FROM bp_data
  WHERE Close IS NOT NULL
    AND Date IS NOT NULL
)
SELECT
  Date,
  Close,
  prev_close,
  daily_change
FROM daily_changes
ORDER BY daily_change DESC
LIMIT 10;
