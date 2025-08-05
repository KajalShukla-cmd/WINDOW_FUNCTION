SQL Window Functions – Examples & Use Cases
This repository contains SQL scripts demonstrating the use of window functions for advanced analytics on salary data. It includes examples of ranking, partitioning, and value-based functions to analyze trends and derive insights from datasets.

Contents
Ranking Functions:

ROW_NUMBER() – Unique row numbering

RANK() – Ranking with gaps

DENSE_RANK() – Ranking without gaps

Value Functions:

FIRST_VALUE() – Get the first value in a partition

LAST_VALUE() – Get the last value in a partition

LAG() – Compare current row with previous row values

LEAD() – Compare current row with next row values

Practical Use Cases:

Ranking salaries by job title

Finding maximum salaries per job title

Analyzing salary trends (increase, decrease, no change)

Calculating percentage changes in salary across years

File Description
VALUE_WINDOW_FUNCTION.sql
Demonstrates different SQL window functions using a sample salaries table with columns like work_year, experience_level, job_title, and salary_in_usd.

How to Use
Import or create the salaries table in your database.

Run queries in VALUE_WINDOW_FUNCTION.sql to explore different window function applications.

Modify partitioning and ordering clauses for your specific analysis needs.

Sample Output
