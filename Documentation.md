
# Dokumentace k SQL analýze

data vycházejí z následujících tabulek:

`t_petra_snajdrova_project_SQL_primary_final`
 - obsahuje informace o průměrných mzdách rozdělených po odvětvích, včetně odvětví neuvedených (tj. hodnoty NULL)
 - dále pak obsahuje informace o průměrných cenách potravin a to vše za Českou republiku
 - pro výpočet mezd byl zvolen přepočtený počet na plný úvazek, který se oproti fyzickému lépe hodí
   pro statistické účely
 - data jsou uvedena za období 2006 - 2018

`t_petra_snajdrova_project_SQL_secundary_final`
   - obsahuje data o HDP Evropských zemí v letech 2006 - 2018

## Otázka č. 1
**Otázka:** Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?  
**Použité tabulky:**  
- `t_petra_snajdrova_project_SQL_primary_final`

### Postup analýzy
 - Porovnali jsme průměrnou hodnotu mezd za dané odvětví s předchozím rokem pomocí funkce `LAG` a zjistili tak,
   zda-li mzdy klesly, nebo se navýšily, což je poté vidět ve sloupci `salary_status`.
 - Data jsou až od roku 2007, v roce 2006 není srovnání s předchozím rokem.
 - Explicitně neuvedená odvětví, tzn. ta s hodnotou NULL nejsou brána v potaz.

### Závěr
 - Až do roku 2008 včetně mzdy pouze stoupají, od roku 2009 v některých odvětvích začínají klesat.
 - V letech 2007 - 2015 docházelo k všeobecnému ekonomickému poklesu na světových trzích (tzv. velká recese)
   což se projevilo i meziročním poklesem mezd v někteých odvětvích.
 - V roce 2013 došlo k poklesu mezd u 11 odvětví z 19ti, rok 2013 byl druhým rokem recese v řadě v ČR.
 - nejčastěji a to 4x klesly mzdy ve sledovaném období v odvětví "Těžba a dobývání".

---

## Otázka č. 2
**Otázka:** Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? 
**Použité tabulky:**  
- `t_petra_snajdrova_project_SQL_primary_final`

### Postup analýzy
 - Vybrali jsme pouze zboží:  
   - „Mléko polotučné pasterované“  
   - „Chléb konzumní kmínový“  
 - Spočítali jsme průměrné ceny mléka a chleba za jednotlivé roky.  
 - Spočítali jsme průměrné mzdy za jednotlivé roky.  
 - Zjistili jsme, **kolik kusů daného zboží** si lze koupit za průměrnou mzdu v každém roce.  
 - Vybrali jsme **první** a **poslední** srovnatelný rok. Tj. 2006 a 2018.

### Závěr
 - V prvním sledovaném období tj. v roce 2006 je možné zakoupit 1 309,54 kg chleba a 1 464,17 l mléka.
 - V posledním sledovaném období, tj. rok 2018 je možné zakoupit 1 365,24 kg chleba a 1 668,64 l mléka.
 - Brány v potaz jsou všechny mzdy včetně nevyplněného odvětví.

---

## Otázka č. 3
**Otázka:** Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd? 
**Použité tabulky:**  
- `t_petra_snajdrova_project_SQL_primary_final`






