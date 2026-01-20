SELECT
  DAYNAME(Date) AS day_of_week,
  AVG(WTI_Close) AS avg_close,
  STDDEV_SAMP(WTI_Close) AS std_close
FROM brent_wti_data
WHERE Date IS NOT NULL
  AND WTI_Close IS NOT NULL
GROUP BY DAYNAME(Date)
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday');
