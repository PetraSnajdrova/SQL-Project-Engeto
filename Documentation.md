
# Dokumentace k SQL analýze

data vycházejí z následujících tabulek:

`t_petra_snajdrova_project_SQL_primary_final`
 - Obsahuje informace o průměrných mzdách rozdělených po odvětvích, včetně odvětví neuvedených (tj. hodnoty NULL).
 - Dále pak obsahuje informace o průměrných cenách potravin a to vše za Českou republiku.
 - Pro výpočet mezd byl zvolen přepočtený počet na plný úvazek, který se oproti fyzickému lépe hodí
   pro statistické účely.
 - Data jsou uvedena za období 2006 - 2018.

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
 - V roce 2013 došlo k poklesu mezd u 11ti odvětví z 19ti, rok 2013 byl druhým rokem recese v řadě v ČR.
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
 - I přes růst cen je možné si za průměrnou mzdu koupit **více mléka** i **více chleba** než na začátku sledovaného období. Kupní síla se tedy zvýšila.
 - Brány v potaz jsou všechny mzdy včetně nevyplněného odvětví.

---

## Otázka č. 3
**Otázka:** Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)? 

**Použité tabulky:**  
- `t_petra_snajdrova_project_SQL_primary_final`

### Postup analýzy
 - Pomocí funkce `LAG()` jsme zjistili průměrnou cenu stejné potraviny v předchozím roce.
 - Data jsou rozdělena podle goods_name a seřazena podle roku.
 - Pro každou potravinu jsme vypočetli procentuální změnu ceny.
 - Pokud cena vzrostla → hodnota je kladná.
 - Pokud cena klesla → hodnota je záporná.
 - Odstranili jsme případy, kdy je rozdíl nulový (žádná změna ceny).
 - Seřadili jsme výsledek vzestupně podle procentuální změny.
 - Pomocí LIMIT 1 jsme vybrali potravinu s nejnižším kladným růstem.

### Závěr
 - Nejpomaleji zdražila kategorie potravin "Pomeranče" v roce 2016 o 0,31 %.
 - Srovnání je bráno v potaz od roku, kdy již existuje předchozí údaj, tzn. např. u položky Jakostní víno bílé je brána hodnota od roku 2016, protože pro rok 2015 chybí předchozí srovnávací hodnota, u ostatních je první záznam v roce 2006, tj. první srovnávací období je od roku 2007.
 - Dle dotazu bereme pouze nárůsty, snížení není bráno v potaz a ve výsledcích není.

---

## Otázka č. 4
**Otázka:** Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

**Použité tabulky:**
- `t_petra_snajdrova_project_SQL_primary_final`

### Postup analýzy
 - Vypočítali jsme průměrnou hodnotu avg_salary_value pro každý rok.
 - Vypočítali jsme průměrnou hodnotu avg_goods_value pro každý rok.
 - Data o průměrných mzdách a průměrných cenách jsme spojili dle sloupce year.
 - Pomocí funkce LAG() jsme získali hodnoty průměrné mzdy a ceny z předchozího roku.
 - Vypočítali jsme percentuální změny.
 - Vybrali jsme pouze ty roky, kde je rozdíl (diff_pct) větší než 10 %.

### Závěr
 - Není žádný rok, kdy by růst průměrných cen potravin předčil růst průměrných mezd o víc než 10%.
 - Výsledkem dotazu je prázdná tabulka.

---

## Otázka č. 5
**Otázka:** Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, projeví se to na cenách potravin či mzdách ve stejném nebo následujícím roce výraznějším růstem?

**Použité tabulky:**
- `t_petra_snajdrova_project_SQL_primary_final`
- `t_petra_snajdrova_project_SQL_sekundary_final`

### Postup analýzy
 - Spočítali jsme meziroční procentuální růst HDP.
 - Spočítali jsme meziroční růst průměrných mezd a cen potravin.
 - Porovnali jsme růst HDP se změnami v cenách a mzdách pro **stejný rok** i **následující rok**.
 - Data jsou vybrána pouze pro Českou republiku.

### Závěr
 - V letech s vyšším růstem HDP zpravidla rostly i mzdy.
 - Největší nárůst je vidět vletech 2016–2017, kdy HDP rostlo kolem +5 % a mzdy na to reagovaly výrazným růstem v roce 2017.
 - Jedná se o léta po skončení krize (Velká recese 2007 - 2015)
 - V době poklesu - rok 2009, HDP kleslo o -4,7 % a hned ve stejném roce je vidět i pokles cen potravin.
 - Mzdy se celkově držely, ale růst se zasavil (u 4 sledovaných odvětví viz. otázka č. 1 už k poklesu došlo)
 - Výška HDP má tedy jasný vliv na mzdy, růst HDP se projeví vyšším růstem mezd, často se zpožděním o jeden rok
 - U cen potravin je vliv podstatně slabší, někdy kopírují trend HDP  - rok 2009 pokles HDP a pokles cen, 2016 - 2017 rostou spolu s HDP,
   jindy se vyvíjejí nezávisle - 2014-2015 HDP rostlo, ceny potravin stagnovaly nebo mírně klesaly 




