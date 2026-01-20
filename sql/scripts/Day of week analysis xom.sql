SELECT
  DAYNAME(Date) AS day_of_week,
  AVG(Close) AS avg_close,
  STDDEV_SAMP(Close) AS std_close
FROM xom_data
WHERE Date IS NOT NULL
  AND Close IS NOT NULL
GROUP BY DAYNAME(Date)
ORDER BY FIELD(day_of_week, 'Monday','Tuesday','Wednesday','Thursday','Friday');
