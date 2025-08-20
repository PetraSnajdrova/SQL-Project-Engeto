-- úkol 1: Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?
WITH cte_avg_salary_previous_year AS (
	SELECT
	DISTINCT branch_name,
	year,
	avg_salary_value,
	lag(Avg_salary_value) OVER (PARTITION BY Branch_name ORDER BY year) AS Avg_salary_previous_year
	FROM t_petra_snajdrova_project_SQL_primary_final
	WHERE branch_name IS NOT NULL
)
SELECT
	year,
	Branch_name,
	avg_salary_value,
	Avg_salary_previous_year,
	CASE
		WHEN avg_salary_previous_year IS NULL THEN 'N/A'
		WHEN avg_salary_value - avg_salary_previous_year = 0 THEN 'duplicated data'
		WHEN avg_salary_value - avg_salary_previous_year > 0 THEN 'Salary increased'
		ELSE 'Salary decreased'
	END AS Salary_status
FROM cte_avg_salary_previous_year
WHERE  avg_salary_value - avg_salary_previous_year != 0
ORDER BY year ASC, branch_name ASC;