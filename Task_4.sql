-- Úkol 4: Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?
WITH cte_salary AS (
    SELECT
        year,
        AVG(avg_salary_value) AS avg_salary
    FROM t_petra_snajdrova_project_SQL_primary_final
    WHERE avg_salary_value IS NOT NULL
    GROUP BY year
),
cte_goods AS (
    SELECT
        year,
        AVG(avg_goods_value) AS avg_goods
    FROM t_petra_snajdrova_project_SQL_primary_final
    WHERE avg_goods_value IS NOT NULL
    GROUP BY year
),
cte_joined AS (
    SELECT
        s.year,
        s.avg_salary,
        g.avg_goods
    FROM cte_salary s
    JOIN cte_goods g USING (year)
),
cte_growth AS (
    SELECT
        year,
        avg_salary,
        avg_goods,
        LAG(avg_salary) OVER (ORDER BY year) AS prev_salary,
        LAG(avg_goods)  OVER (ORDER BY year) AS prev_goods
    FROM cte_joined
)
SELECT
    year,
    ROUND(100 * (avg_salary - prev_salary) / prev_salary, 2) AS salary_growth_pct,
    ROUND(100 * (avg_goods   - prev_goods)  / prev_goods, 2) AS goods_growth_pct,
    ROUND(100 * ((avg_goods - prev_goods) / prev_goods - (avg_salary - prev_salary) / prev_salary ), 2) AS diff_pct
FROM cte_growth
WHERE prev_salary IS NOT NULL
  AND prev_goods IS NOT NULL
  AND (
        (avg_goods - prev_goods) / prev_goods
      - (avg_salary - prev_salary) / prev_salary
      ) > 0.10    -- rozdíl větší než 10 procentních bodů
ORDER BY year;