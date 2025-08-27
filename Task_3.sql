-- Úkol 3: Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?
WITH cte_avg_goods_value_percentage AS (
WITH cte_avg_goods_value_previous_year AS (
	SELECT
		DISTINCT year,	
		avg_goods_value,
		goods_name,
		lag(avg_goods_value) OVER (PARTITION BY Goods_name ORDER BY year) AS avg_goods_previous_year
	FROM t_petra_snajdrova_project_sql_primary_final tpspspf
	ORDER BY YEAR ASC, goods_name ASC
)
	SELECT
		year,
		goods_name,
		avg_goods_value,
		avg_goods_previous_year,
		CASE
			WHEN avg_goods_value - avg_goods_previous_year > 0 THEN (avg_goods_value * 100 / avg_goods_previous_year)-100
			ELSE (avg_goods_value * 100 / avg_goods_previous_year)-100
		END AS goods_status_percentage
	FROM cte_avg_goods_value_previous_year
	WHERE  avg_goods_value - avg_goods_previous_year != 0
	ORDER BY year ASC, goods_name ASC
)
SELECT *
FROM cte_avg_goods_value_percentage
WHERE goods_status_percentage > 0
ORDER BY goods_status_percentage ASC, YEAR ASC
LIMIT 1;

