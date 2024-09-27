CREATE DATABASE IF NOT EXISTS employeeinfo;

CREATE TABLE IF NOT EXISTS employee(
employee_id      INT    NOT NULL   PRIMARY KEY,
department     VARCHAR(30)   NOT NULL,
gender     VARCHAR(10)    NOT NULL,
age      INT     NOT NULL,
hire_date             VARCHAR(10)     NOT NULL,
job_title      VARCHAR(10)     NOT NULL,
years_at_company       INT     NOT NULL,
education_level        VARCHAR(15)       NOT NULL,
performance_score       INT    NOT NULL,
monthly_salary      decimal(5,1)     NOT NULL,
work_hours_per_week          INT     NOT NULL,
projects_handled           INT      NOT NULL,
overtime_hours          INT      NOT NULL,
sick_days         INT    NOT NULL,
remote_work_from_home      INT    NOT NULL,
team_size            INT      NOT NULL,
training_hours    INT       NOT NULL,
promotions       INT       NOT NULL,
employee_satisfaction     DECIMAL(3,2)    NOT NULL,
resigned          VARCHAR(10)       NOT NULL
);

--- Fixing table--------------------------------------------
ALTER TABLE EMPLOYEE RENAME COLUMN job_title TO hired_date;


ALTER TABLE EMPLOYEE RENAME COLUMN hire_date TO job_title;

ALTER TABLE EMPLOYEE ADD COLUMN hire_date DATE;
UPDATE employee SET hire_date = hired_date;

ALTER TABLE employee DROP COLUMN hired_date;

----------------------- Generic questions---------------------------------------------
-- How many employees are in this company?

SELECT COUNT(employee_id) FROM employee;

-- What are the different departments?

SELECT DISTINCT(department) FROM employee
GROUP BY department;

-- How many employees have resigned from this company?

SELECT COUNT(resigned) FROM employee
WHERE resigned = 'TRUE';

-- How many men and women are employed by this company?
SELECT COUNT(gender), gender FROM employee
GROUP BY gender;

----------------------------- Salary and its impact----------------------------------------
-- What is the avg salary in the company?
SELECT 	ROUND(AVG(monthly_salary),2) FROM employee;

-- Do employees making less than the avg salary($6403.21) have a lower employee satisfaction rating than employees making over avg?
SELECT ROUND(AVG(employee_satisfaction),3)
FROM employee
WHERE monthly_salary > '6403';
-- Answer is 3.002
SELECT ROUND(AVG(employee_satisfaction),3)
FROM employee 
WHERE monthly_salary < '6403';
-- Answer is 2.996. Slight difference showing employees who make more than avg salary are slightly happier.

-- Do people with higher than avg salaries have a higher performance rating?
SELECT ROUND(AVG(performance_score),2)
FROM employee
WHERE monthly_salary > 6403;
-- 3.39
SELECT ROUND(AVG(performance_score),2)
FROM employee
WHERE monthly_salary < 6403;
-- 2.58. So it seems like employees with higher than avg salaries tend to have higher performance ratings.

-- What is the average mothly salary based on your education level?
SELECT education_level, ROUND(AVG(monthly_salary),2) as avg_sal
FROM employee
GROUP BY education_level
ORDER BY avg_sal DESC;
------------------------------------- Performance Score and Employee Satisfaction------------------------------------------

-- Does +10hrs overtime lead to a higher performance score?
SELECT ROUND(AVG(performance_score),2)
FROM employee
WHERE overtime_hours > 10;
-- 3.00
SELECT ROUND(AVG(performance_score),2)
FROM employee
WHERE overtime_hours < 10;
-- 2.99. Seems like there is not much of an impact with more OT.

-- Does working from home lead to higher employee satisfaction ratings?
SELECT round(AVG(employee_satisfaction),2)
FROM employee
WHERE remote_work_from_home = 25;
-- 3.01
SELECT round(AVG(employee_satisfaction),2)
FROM employee
WHERE remote_work_from_home = 50;
-- 3.00
SELECT round(AVG(employee_satisfaction),2)
FROM employee
WHERE remote_work_from_home = 75;
-- 3.00
SELECT round(AVG(employee_satisfaction),2)
FROM employee
WHERE remote_work_from_home = 100;
-- 2.99. Looks like there is no real satisfaction difference.

-- Does working from home full time lead to being more productive compared to someone not working from home?
SELECT ROUND(AVG(performance_score),2)
FROM employee
WHERE remote_work_from_home = 100;
-- 3.00
SELECT ROUND(AVG(performance_score),2)
FROM employee
WHERE remote_work_from_home = 0;

-- 2.98. Slight difference but nothing too significant.


-------------------------------- Department Review----------------------------------------------
-- Is there a specific department that has a higher performance score?
SELECT department, ROUND(AVG(performance_score),2)
FROM employee
GROUP BY department;
-- Not much of a difference either.

-- Which department has the highest avg salary?
SELECT department, AVG(monthly_salary) AS avg_salary
FROM employee
GROUP BY department
ORDER BY avg_salary DESC;
-- IT.


-- Which department is the happiest?
SELECT department, ROUND(AVG(employee_satisfaction),2) AS avg_emp_sat
FROM employee
GROUP BY department
ORDER BY avg_emp_sat DESC;
-- Operations.

-- What is the avg years at company per each department?
SELECT ROUND(AVG(years_at_company),2) AS avg_years, department
FROM employee
GROUP BY department
ORDER BY avg_years DESC;

-- Is there a department that is handling more projects?
SELECT AVG(projects_handled) AS avg_proj, department
FROM employee
GROUP BY department
ORDER BY avg_proj DESC;
-- Not much of a difference.

-- Is there a specific job that yields a higher salary?
SELECT job_title, ROUND(AVG(monthly_salary),2) as avg_job_sal
FROM employee
GROUP BY job_title
ORDER BY avg_job_sal DESC;

-- Which job title requires the most amount of hours to work per week?
SELECT job_title, ROUND(AVG(work_hours_per_week),2) as avg_hours
FROM employee
GROUP BY job_title
ORDER BY avg_hours DESC;

--engineer.
------------------------------- Gender----------------------------------------
-- What is the avg salary for both genders?
SELECT ROUND(AVG(monthly_salary),2), gender
FROM employee
GROUP BY gender;

-- Is there a gender that has more of a higher education than the other?
SELECT COUNT(gender),education_level
FROM employee
WHERE gender = 'MALE'
GROUP BY education_level;

SELECT COUNT(gender),education_level
FROM employee
WHERE gender = 'FEMALE'
GROUP BY education_level;

-------------------------- Training and Promotions------------------------------
-- Does promotions lead to a higher employee satisfaction?
SELECT promotions, ROUND(AVG(employee_satisfaction),2) as avg_sat
FROM employee
GROUP BY promotions
ORDER BY avg_sat DESC;
-- Do promotions lead to a higher monthly salary?
SELECT promotions, ROUND(AVG(monthly_salary),2) AS avg_salary
FROM employee
GROUP BY promotions
ORDER BY avg_salary DESC;

-- Does more hours trained correlate with a higher performance score?
SELECT training_hours, ROUND(AVG(performance_score),2) AS avg_perf
FROM employee
GROUP BY training_hours
ORDER BY avg_perf DESC;

-- Does age reflect a higher salary as you get older?
SELECT age, ROUND(AVG(monthly_salary),2) AS avg_salary
FROM employee
GROUP BY age
ORDER BY avg_salary DESC;
-- Is there a time when people hired were tasked with more projects?
SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2015-01-01' AND hire_date < '2016-01-01';

SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2016-01-01' AND hire_date < '2017-01-01';

SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2017-01-01' AND hire_date < '2018-01-01';

SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2018-01-01' AND hire_date < '2019-01-01';

SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2019-01-01' AND hire_date < '2020-01-01';

SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2020-01-01' AND hire_date < '2021-01-01';

SELECT SUM(projects_handled)
FROM employee
WHERE hire_date > '2021-01-01' AND hire_date < '2022-01-01';