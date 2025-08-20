
# Dokumentace k SQL analýze

## Otázka 2
**Otázka:** Má výška HDP vliv na změny ve mzdách a cenách potravin?  
**Použité tabulky:**  
- `t_petra_snajdrova_project_SQL_primary_final` – obsahuje mzdy a ceny potravin  
- `t_secondary_hdp` – obsahuje data o HDP (pouze Czech Republic)

### Postup analýzy
1. Spočítali jsme meziroční procentuální růst HDP.  
2. Spočítali jsme meziroční růst průměrných mezd a cen potravin.  
3. Porovnali jsme růst HDP se změnami v cenách a mzdách pro **stejný rok** i **následující rok**.  

### Shrnutí výsledků
- Obecně platí, že **vyšší růst HDP** má **pozitivní vliv na mzdy**.  
- Ceny potravin ale **nereagují přímo** na růst HDP – jejich růst je pomalejší a někdy nesouvisí.  
- Větší korelace mezi HDP a mzdami je patrná s **ročním zpožděním** → růst HDP se do platů promítá více až **v následujícím roce**.

### Závěr
- **HDP má vliv na růst mezd.**  
- **Vliv HDP na ceny potravin je slabší** a nelze říct, že výrazně rostou při zvýšení HDP.  
- Největší souvislost se projevuje mezi HDP a mzdami, zejména s ročním odstupem.

---

## Otázka 5
**Otázka:** Kolik je možné si koupit litrů mléka a kilogramů chleba za průměrnou mzdu v prvním a posledním srovnatelném období?  
**Použitá tabulka:**  
- `t_petra_snajdrova_project_SQL_primary_final`

### Postup analýzy
1. Vybrali jsme pouze zboží:  
   - „Mléko polotučné pasterované“  
   - „Chléb konzumní kmínový“  
2. Spočítali jsme průměrné ceny mléka a chleba za jednotlivé roky.  
3. Spočítali jsme průměrné mzdy za jednotlivé roky.  
4. Zjistili jsme, **kolik kusů daného zboží** si lze koupit za průměrnou mzdu v každém roce.  
5. Vybrali jsme **první** a **poslední** srovnatelný rok.

### Shrnutí výsledků
| Rok | Zboží                         | Průměrná mzda | Cena | Kolik kusů lze koupit |
|------|------------------------------|---------------|------|------------------------|
| 2000 | Chléb konzumní kmínový      | 12 205 Kč     | 14,50 Kč | ~841 ks |
| 2000 | Mléko polotučné pasterované | 12 205 Kč     | 12,00 Kč | ~1 017 l |
| 2023 | Chléb konzumní kmínový      | 40 325 Kč     | 38,90 Kč | ~1 036 ks |
| 2023 | Mléko polotučné pasterované | 40 325 Kč     | 25,50 Kč | ~1 582 l |

### Závěr
- Kupní síla se **výrazně zvýšila**.  
- I přes růst cen je možné si za průměrnou mzdu koupit **více mléka** i **více chleba** než na začátku sledovaného období.
