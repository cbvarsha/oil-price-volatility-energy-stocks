SELECT
  DAYOFMONTH(Date) AS dom,
  AVG(Brent_Close) AS avg_close
FROM brent_wti_data
WHERE Date IS NOT NULL
  AND Brent_Close IS NOT NULL
GROUP BY DAYOFMONTH(Date)
ORDER BY dom;
