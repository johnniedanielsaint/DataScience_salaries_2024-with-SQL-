CREATE DATABASE SQL_PROJECT;
USE sql_project;

select * from datascience_salaries_2024;
-- Task 1: Basic Queries
-- Write a query to retrieve the job titles and salaries in USD from the 
-- dataset.
-- 1. Retrieve job titles and salaries in USD
select job_title,salary_in_usd from datascience_salaries_2024;

/* Write a query to filter and display data for the year 2022, for employees 
at the Senior experience level, working full-time.*/

-- 2. Filter data for the year 2022, Senior level, full-time employees
SELECT *
FROM datascience_salaries_2024 where work_year = 2022 and experience_level = 'se'
and employment_type = 'ft';


-- Task 2: Aggregation and Grouping
-- Calculate the average salary in USD for each job title.
SELECT job_title, avg(salary_in_usd) as average_salary
from datascience_salaries_2024 group by job_title
order by avg(salary_in_usd) desc;
 

-- Group the data by company location and calculate the average salary in each region.
-- 2. Group by company location and calculate average salary
select company_location, avg(salary_in_usd) as average_salary from 
datascience_salaries_2024 group by company_location;

-- 3. Count the total number of employees working remotely vs. on-site.
select remote_ratio, count(*) as num_employees from datascience_salaries_2024
group by remote_ratio; 

select * from datascience_salaries_2024;

-- 3.  Join Operations:
/* If you have additional tables (e.g., currency exchange rates), join them 
to analyze trends in local vs. USD salaries.

select s.job_title, s.salary, s.currency,
e.exchange_rate,s.salary * e._rate as salary_in_usd from
datascience_salaries_2024 
join exchange_rate e on s.salary_currency = e.currency_code;*/

select s.job_title, s.salary, s.salary_currency,
coalesce(e.exchange_rate, 1) as exchange_rate,
s.salary * coalesce(e.exchange_rate, 1) as salary_in_usd from
datascience_salaries_2024 s
left join 
(select 'usd' as currency_code, 1 as exchange_rate
union all select 'EUR',1.1
union all select 'GBP', 1.3
union all select 'INR', 0.012
union all select 'AUD', 0.7) e
on 
s.salary_currency = e.currency_code;


-- Task 4: Advanced Analysis
-- Identify the top 5 job titles with the highest average salaries.
SELECT job_title, AVG(salary_in_usd) AS average_salary
FROM datascience_salaries_2024
GROUP BY job_title
ORDER BY average_salary DESC
LIMIT 5;

-- Analyze salary trends over the years.
SELECT work_year, AVG(salary_in_usd) AS average_salary from
datascience_salaries_2024 group by work_year order by work_year;

-- Examine the relationship between company size and average salary
SELECT company_size, AVG(salary_in_usd) AS average_salary
FROM datascience_salaries_2024 group by company_size order by
field(company_size,'s','m','l');

-- Task 5: Subqueries
-- Write a query to find the top 5 highest-paying jobs in the dataset.
SELECT job_title, salary_in_usd
FROM datascience_salaries_2024 order by salary_in_usd desc
limit 5;

-- Write a query to find the most common job titles in different regions.
SELECT company_location, job_title, COUNT(job_title) AS count_num
FROM datascience_salaries_2024 group by company_location, job_title
order by count_num desc ,company_location;




