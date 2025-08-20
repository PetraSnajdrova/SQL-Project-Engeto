/*
 * úkol 2: Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v
 * dostupných datech cen a mezd?
 */
WITH cte_milk_bread_purchase AS (
	SELECT *,
		round((avg_salary_value / avg_goods_value)::NUMERIC,1) AS How_many_units
	FROM t_petra_snajdrova_project_sql_primary_final tpspspf
	WHERE goods_name LIKE 'Mléko polotučné pasterované'
		OR goods_name LIKE 'Chléb konzumní kmínový'
)
SELECT
	year,
	goods_name,
	avg(How_many_units) AS Possible_purchase,
	price_unit
FROM cte_milk_bread_purchase
WHERE year = 2006 OR year = 2018
GROUP BY year, goods_name, price_unit
ORDER BY year ASC, goods_name asc;
