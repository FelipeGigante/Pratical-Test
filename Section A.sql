/*1 - Write a query to display the name (first_name and last_name) and department ID of all
employees in departments 30 or 100 in ascending order.*/
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_ID 
FROM employees WHERE DEPARTMENT_ID = 30 OR DEPARTMENT_ID = 100 
ORDER BY DEPARTMENT_ID ASC;


/*2. Write a query to find the manager ID and the salary of the lowest-paid employee for that
manager.*/
SELECT MANAGER_ID, MIN(SALARY) FROM employees 
GROUP BY MANAGER_ID 
ORDER BY MIN(SALARY) DESC;


/*3. Write a query to find the name (first_name and last_name) and the salary of the employees
who earn more than the employee whose last name is Bell.*/
SELECT FIRST_NAME, LAST_NAME, SALARY FROM employees 
WHERE SALARY > (SELECT SALARY FROM employees WHERE LAST_NAME = 'Bell');


/*4. Write a query to find the name (first_name and last_name), job, department ID and name of
all employees that work in London.*/
SELECT EMP.FIRST_NAME, EMP.LAST_NAME, EMP.JOB_ID, EMP.DEPARTMENT_ID, DEP.DEPARTMENT_ID 
FROM employees EMP JOIN departments DEP 
ON (EMP.DEPARTMENT_ID = DEP.DEPARTMENT_ID) 
JOIN locations LOC ON 
(DEP.LOCATION_ID = LOC.LOCATION_ID) WHERE LOWER(LOC.CITY) = 'London';


/*5. Write a query to get the department name and number of employees in the department.*/
SELECT DEPARTMENT_NAME, COUNT(*) AS 'Total Employees' 
FROM departments 
INNER JOIN employees 
ON employees.DEPARTMENT_ID = departments.DEPARTMENT_ID 
GROUP BY departments.DEPARTMENT_ID, DEPARTMENT_NAME
ORDER BY COUNT(*) ASC;
