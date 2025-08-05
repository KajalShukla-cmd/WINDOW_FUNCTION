USE kajals; 

SELECT * 
FROM salaries; 

SELECT work_year, experience_level, job_title, salary_in_usd, 
	ROW_NUMBER() OVER (ORDER BY salary_in_usd DESC) AS ROW_NUMBER_FUNCTION, 
    RANK() OVER (ORDER BY salary_in_usd DESC) AS RANK_FUNCTION, 
    DENSE_RANK() OVER (ORDER BY salary_in_usd DESC) AS DENSE_RANK_FUNCTION
FROM salaries; 
    
    
SELECT work_year, experience_level, job_title, salary_in_usd , 
	DENSE_RANK() OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC) AS SALARY_RANKING
FROM salaries; 

SELECT T1.work_year, T1.experience_level, T1.job_title, T1.salary_in_usd, T2.MAXIMUM_SALARY_PER_JOB_TITLE 
FROM 
(
SELECT * 
FROM salaries
) AS T1 
JOIN 
(  
SELECT job_title, MAX(salary_in_usd) AS MAXIMUM_SALARY_PER_JOB_TITLE
FROM salaries 
GROUP BY job_title
) AS T2
ON T1.job_title = T2.job_title
WHERE salary_in_usd = MAXIMUM_SALARY_PER_JOB_TITLE; 


SELECT * 
FROM 
(
SELECT work_year, experience_level, job_title, salary_in_usd , 
	DENSE_RANK() OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC) AS SALARY_RANKING
FROM salaries
) AS T 
WHERE SALARY_RANKING <= 5; 


/*
VALUE WINDOW FUNCTIONS 

1. FIRST VALUE 
2. LAST VALUE 
3. LEAD 
4. LAG 
*/

SELECT *, FIRST_VALUE_FUNCTION - salary_in_usd AS SALARY_DIFFERENCE
FROM 
(
SELECT 
	work_year, experience_level, employment_type, job_title, salary_in_usd, 
    FIRST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd DESC) AS FIRST_VALUE_FUNCTION
FROM salaries
) AS T; 


SELECT *,  salary_in_usd - FIRST_VALUE_FUNCTION AS SALARY_DIFFERENCE
FROM 
(
SELECT 
	work_year, experience_level, employment_type, job_title, salary_in_usd, 
    FIRST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd) AS FIRST_VALUE_FUNCTION
FROM salaries
) AS T; 


SELECT 
	work_year, experience_level, employment_type, job_title, salary_in_usd, 
    LAST_VALUE(salary_in_usd) OVER (PARTITION BY job_title ORDER BY salary_in_usd ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS FIRST_VALUE_FUNCTION
FROM salaries;

SELECT 
	work_year, experience_level, employment_type, job_title, salary_in_usd, 
    LAST_VALUE(salary_in_usd) OVER 
    (PARTITION BY job_title ORDER BY salary_in_usd 
    DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 
    AS FIRST_VALUE_FUNCTION
FROM salaries;

SELECT work_year, experience_level, employment_type, job_title, salary_in_usd, PREVIOUS_PERSON_SALARY, ABS(PERCENTAGE_SALARY_CHANGE), SALARY_TREND
FROM 
(
SELECT *, 
	CASE WHEN PERCENTAGE_SALARY_CHANGE < 0 THEN 'DECREASE' 
    WHEN PERCENTAGE_SALARY_CHANGE > 0 THEN 'INCREASE' 
    ELSE 'NO CHANGE' 
    END AS SALARY_TREND
FROM 
(
SELECT *, (salary_in_usd - PREVIOUS_PERSON_SALARY) * 100 / PREVIOUS_PERSON_SALARY AS PERCENTAGE_SALARY_CHANGE
FROM 
(
SELECT 
	work_year, experience_level, employment_type, job_title, salary_in_usd, 
	LAG(salary_in_usd, 1, salary_in_usd) OVER (PARTITION BY job_title ORDER BY work_year) AS PREVIOUS_PERSON_SALARY
FROM salaries
) AS T
) AS NEW_TABLE
) AS FINAL_TABLE;