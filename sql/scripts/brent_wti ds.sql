SELECT
  YEAR(Date) AS yr,
  MONTH(Date) AS mn,
  MIN(Brent_Close) AS min_brent,
  MAX(Brent_Close) AS max_brent,
  AVG(Brent_Close) AS avg_brent,
  STDDEV_SAMP(Brent_Close) AS std_brent,
  MIN(WTI_Close) AS min_wti,
  MAX(WTI_Close) AS max_wti,
  AVG(WTI_Close) AS avg_wti,
  STDDEV_SAMP(WTI_Close) AS std_wti
FROM brent_wti_data
WHERE Date NOT IN ('Ticker','Date','None')
  AND Date IS NOT NULL
  AND Brent_Close IS NOT NULL
  AND WTI_Close IS NOT NULL
GROUP BY YEAR(Date), MONTH(Date)
ORDER BY yr, mn;
