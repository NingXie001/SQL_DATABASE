-- Create new table
CREATE TABLE departments (
    dept_no CHAR(4)         NOT NULL,  -- in the form of 'dxxx'
    dept_name VARCHAR(40)     NOT NULL
);

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
    dept_no CHAR(4) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL
);

CREATE TABLE dept_manager (
	dept_no CHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL
);

CREATE TABLE employees (
    emp_no INT NOT NULL,  -- UNSIGNED AUTO_INCREMENT??
    birth_date DATE NOT NULL,
    first_name VARCHAR(14) NOT NULL,
    last_name VARCHAR(16) NOT NULL,
    gender VARCHAR(2) NOT NULL,   
    hire_date DATE NOT NULL
);

CREATE TABLE salaries (
	emp_no INT NOT NULL,
    salary INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL
);

CREATE TABLE titles (
	emp_no INT NOT NULL,
    title VARCHAR(50) NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL
);

--Q1:List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary
FROM employees e, salaries s
WHERE e.emp_no = s.emp_no;

--Q2:List employees who were hired in 1986.
SELECT e.emp_no, e.first_name, e.last_name
FROM employees e
WHERE EXTRACT(year FROM hire_date) = 1986;

--Q3:List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT d.dept_no, d.dept_name, m.emp_no, m.from_date, m.to_date, e.first_name, e.last_name
FROM departments d, dept_manager m, employees e
WHERE d.dept_no = m.dept_no AND m.emp_no = e.emp_no;

--Q4:List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e, dept_emp de, departments d
WHERE e.emp_no = de.emp_no AND de.dept_no = d.dept_no;

--Q5:List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees 
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--Q6:List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e, dept_emp de, departments d
WHERE e.emp_no = de.emp_no AND de.dept_no = d.dept_no AND d.dept_name = 'Sales';

--Q7:List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e, dept_emp de, departments d
WHERE e.emp_no = de.emp_no 
    AND de.dept_no = d.dept_no
    AND (d.dept_name = 'Sales' OR d.dept_name = 'Development');

--Q8:In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name)
FROM employees 
GROUP BY last_name
ORDER BY COUNT(last_name) DESC;

