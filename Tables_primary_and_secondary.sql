-- Primary table
CREATE TABLE t_petra_snajdrova_project_SQL_primary_final AS
SELECT
	round(avg(cp2.value)::NUMERIC, 1) AS Avg_goods_value,
	cp.payroll_year AS year,
	cpc.name AS goods_name,
	cpc.price_value,
	cpc.price_unit,
	cpib.name AS branch_name,
	round(avg(cp.value)::NUMERIC, 1) AS avg_salary_value
FROM czechia_payroll cp
FULL OUTER JOIN czechia_price cp2 ON EXTRACT(YEAR FROM cp2.date_from) = cp.payroll_year
LEFT JOIN czechia_price_category cpc ON cp2.category_code = cpc.code
LEFT JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
WHERE
	cp.value_type_code = 5958
	AND cp.calculation_code = 200
	AND EXTRACT(YEAR FROM cp2.date_from) >=2006
	AND EXTRACT(YEAR FROM cp2.date_from) <= 2018
GROUP BY
	cp.payroll_year,
	cpc.name,
	cpc.price_value,
	cpc.price_unit,
	cpib.name;

-- secondary table
CREATE TABLE t_petra_snajdrova_project_SQL_secondary_final AS
SELECT
	e.country,
	e.year,
	e.gdp,
	e.gini,
	e.population
FROM economies e
LEFT JOIN countries c ON e.country = c.country
WHERE
	c.continent = 'Europe'
	AND e.year >= 2006
	AND e.year <= 2018;
