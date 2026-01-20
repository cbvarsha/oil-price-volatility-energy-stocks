WITH base AS (
  SELECT
    Close AS x,
    Volume AS y
  FROM shel_data
  WHERE Close IS NOT NULL
    AND Volume IS NOT NULL
),
calc AS (
  SELECT
    COUNT(*) AS n,
    SUM(x) AS sum_x,
    SUM(y) AS sum_y,
    SUM(x*x) AS sum_x2,
    SUM(y*y) AS sum_y2,
    SUM(x*y) AS sum_xy
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
  ) AS corr_close_volume
FROM calc;
