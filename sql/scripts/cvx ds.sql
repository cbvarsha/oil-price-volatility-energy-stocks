SELECT
  YEAR(date) AS yr,
  MONTH(Date) AS mn,
  MIN(Close) AS min_close,
  MAX(Close) AS max_close,
  AVG(Close) AS avg_close,
  STDDEV_SAMP(Close) AS std_close
FROM bp_data
WHERE Date NOT IN ('Ticker','Date','None')
  AND Date IS NOT NULL
  AND Close IS NOT NULL
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY yr, mn;
