/*
 * Úkol 5: Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji
 * v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?
 */
WITH salary_growth AS (
  SELECT
    year,
    AVG(avg_salary_value) AS avg_salary,
    LAG(AVG(avg_salary_value)) OVER (ORDER BY year) AS prev_salary
  FROM t_petra_snajdrova_project_SQL_primary_final
  WHERE avg_salary_value IS NOT NULL
  GROUP BY year
),
goods_growth AS (
  SELECT
    year,
    AVG(avg_goods_value) AS avg_goods,
    LAG(AVG(avg_goods_value)) OVER (ORDER BY year) AS prev_goods
  FROM t_petra_snajdrova_project_SQL_primary_final
  WHERE avg_goods_value IS NOT NULL
  GROUP BY year
),
gdp_growth AS (
  SELECT
    h.year,
    h.gdp,
    LAG(h.gdp) OVER (ORDER BY h.year) AS prev_gdp
  FROM t_petra_snajdrova_project_SQL_secundary_final h
  WHERE h.country = 'Czech Republic'
    AND h.gdp IS NOT NULL
),
same_year AS (
  SELECT
    g.year,
    (100.0 * (g.gdp - g.prev_gdp) / NULLIF(g.prev_gdp, 0))::double precision AS gdp_growth,
    (100.0 * (s.avg_salary - s.prev_salary) / NULLIF(s.prev_salary, 0))::double precision AS salary_growth,
    (100.0 * (gd.avg_goods - gd.prev_goods) / NULLIF(gd.prev_goods, 0))::double precision AS goods_growth
  FROM gdp_growth g
  JOIN salary_growth s USING (year)
  JOIN goods_growth  gd USING (year)
  WHERE g.prev_gdp IS NOT NULL
    AND s.prev_salary IS NOT NULL
    AND gd.prev_goods IS NOT NULL
),
next_year AS (
  SELECT
    g.year,
    (100.0 * (g.gdp - g.prev_gdp) / NULLIF(g.prev_gdp, 0))::double precision AS gdp_growth,
    (100.0 * (s.avg_salary - s.prev_salary) / NULLIF(s.prev_salary, 0))::double precision AS salary_growth_next_year,
    (100.0 * (gd.avg_goods - gd.prev_goods) / NULLIF(gd.prev_goods, 0))::double precision AS goods_growth_next_year
  FROM gdp_growth g
  JOIN salary_growth s ON s.year = g.year + 1
  JOIN goods_growth  gd ON gd.year = g.year + 1
  WHERE g.prev_gdp IS NOT NULL
    AND s.prev_salary IS NOT NULL
    AND gd.prev_goods IS NOT NULL
)
SELECT 'SAME_YEAR' AS variant, year,
       ROUND(gdp_growth::numeric, 2) AS gdp_growth_pct,
       ROUND(salary_growth::numeric,2) AS salary_growth_pct,
       ROUND(goods_growth::numeric, 2) AS goods_growth_pct
FROM same_year
UNION ALL
SELECT 'NEXT_YEAR', year,
       ROUND(gdp_growth::numeric, 2) AS gdp_growth_pct,
       ROUND(salary_growth_next_year::numeric,2) AS salary_growth_pct,
       ROUND(goods_growth_next_year::numeric, 2) AS goods_growth_pct
FROM next_year
ORDER BY year;
