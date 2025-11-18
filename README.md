# Coffee Sales — SQL-first Analysis (Mar/2024 → Mar/2025)

SQL-first portfolio project analyzing one year of a coffee shop’s transactions (8 coffee types).  
All metrics are computed in **MySQL** (month, weekday, hour, daypart, and product mix).  
The repo includes the original dataset, three SQL scripts (create table, load data, analysis), CSV outputs, and a compact Power BI visualization.

<!-- right under the overview -->
<p align="center">
  <img src=""C:\Users\felip\OneDrive\Área de Trabalho\code and stuff\projects\coffee sales\BI dashboard\sales_dashboard_preview.png"" alt="Coffee Sales — Power BI overview" width="800">
</p>



## Repository layout

data/
  coffee_sales.csv
outputs/
  sales_by_month.csv
  sales_by_weekday.csv
  sales_by_time_of_day.csv
  sales_by_hour_time_series.csv
  sales_by_hour_ranked.csv
  sales_by_coffee_type.csv
sql_scripts/
  1_create_table.sql
  2_load_data.sql
  3_analysis.sql
dashboard/
  sales_dashboard.pbix
  sales_dashboard.pdf
README.md

## Questions answered

- How do sales evolve by **month**?
- Which **weekdays** are strongest (and weakest)?
- What are the **peak hours**? (both a time series and a ranked view)
- How do **dayparts** (morning / afternoon / evening) compare?
- What is the **product mix** by **coffee type**?

## How to run (MySQL)

- This project targets **MySQL 8.x**.
- Run the scripts **in this order** in your SQL client (e.g., MySQL Workbench, DBeaver, etc.):
  1) `sql_scripts/1_create_table.sql`  → creates the schema/table(s)
  2) `sql_scripts/2_load_data.sql`     → loads the dataset
  3) `sql_scripts/3_analysis.sql`      → contains the analytical queries

- In `3_analysis.sql`, **run one section at a time** (each section is commented and independent).
- Results appear directly in your SQL client’s results grid.
- Note on compatibility: queries use common MySQL functions (e.g., `DATE_FORMAT`, `DAYNAME`, `HOUR`, `CASE`, and standard aggregations).
  - Other SQL dialects may require small adjustments to date/time functions and formatting.

## Outputs (CSV)

All summary tables produced by the SQL are included in `/outputs` for quick review:

- `sales_by_month.csv`
- `sales_by_weekday.csv`
- `sales_by_time_of_day.csv`
- `sales_by_hour_time_series.csv`
- `sales_by_hour_ranked.csv`
- `sales_by_coffee_type.csv`

> These are the direct results of queries in `sql_scripts/3_analysis.sql` (one section per output).

## Dashboard

- Open `dashboard/sales_dashboard.pbix` in **Power BI Desktop**.
- Or simply open `dashboard/sales_dashboard.pdf` for a snapshot preview.

> The dashboard summarizes the SQL outputs (month, weekday, hour time series & ranking, daypart, coffee type).

## Notes & assumptions
- Coverage: **Mar/2024 → Mar/2025** (inclusive).
- Business scope: single coffee shop; **8 coffee types**.
- Time fields stored/handled as MySQL `DATE`/`DATETIME`; functions used: `DATE_FORMAT`, `DAYNAME`, `HOUR`, `CASE`.
- Dayparts (**morning / afternoon / evening**) come from the source data (no custom bucketing).
- Monetary fields treated as numeric/decimal; each row = one transaction.
- Queries target **MySQL 8.x**; other SQL dialects may require minor date/time syntax changes.

## Highlights (quick read)
- **Product mix:** Latte + Americano w/ Milk = **~46%** of revenue (almost half).
- **Dayparts:** Distribution is balanced (≈31% morning, 33% afternoon, 36% evening), but sales **build through the day** with **evening peaks**; all top-5 hours are **after 16:00**.
- **Weekdays:** **Midweek wins**; **Saturday and Sunday** are the softest—good targets for weekend promos.
- **Seasonality:** Clear peaks in **October** and **February** (outliers vs. other months). **Summer is weaker** → consider seasonal items (iced/refreshers).
- **Actions:** Morning bundles/loyalty to lift early hours; weekend deals to drive traffic; summer SKUs (iced, light) aligned to demand.

## License
This repository is released under the **MIT License**. See `LICENSE` for details.


