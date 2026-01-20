WITH base AS (
  SELECT
    WTI_Close AS x,
    Brent_Close AS y
  FROM brent_wti_data
  WHERE WTI_Close IS NOT NULL
    AND Brent_Close IS NOT NULL
),
calc AS (
  SELECT
    COUNT(*)       AS n,
    SUM(x)         AS sum_x,
    SUM(y)         AS sum_y,
    SUM(x*x)       AS sum_x2,
    SUM(y*y)       AS sum_y2,
    SUM(x*y)       AS sum_xy
  FROM base
)
SELECT
  (
    (calc.n * calc.sum_xy) - (calc.sum_x * calc.sum_y)
  ) / (
    SQRT(
      (calc.n * calc.sum_x2 - (calc.sum_x * calc.sum_x)) *
      (calc.n * calc.sum_y2 - (calc.sum_y * calc.sum_y))
    )
  ) AS corr_wti_brent
FROM calc;
