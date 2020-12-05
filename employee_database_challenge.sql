-- DELIVERABLE 1
SELECT e.emp_no,
		e.first_name,
		e.last_name,
		t.titles,
		t.from_date,
		t.to_date		
INTO retirement_titles 
FROM employees AS e
INNER JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

--Selecting employees with most recent titles

SELECT emp_no,
		first_name,
		last_name,
		titles
FROM retirement_titles;

-- Use Dictinct ON with Orderby to remove duplicate rows

SELECT DISTINCT ON (emp_no) emp_no, 
first_name,
last_name,
titles
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

--Creating Retiring Titles table

SELECT COUNT (emp_no), titles
INTO retiring_titles
FROM unique_titles
GROUP BY titles
ORDER BY COUNT (emp_no) DESC;

--DELIVERABLE 2

SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.titles
INTO mentorship_eligibility
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN titles AS t
ON (e.emp_no = t.emp_no)
WHERE e.birth_date BETWEEN '1965-01-01' AND '1965-12-31'
AND de.to_date = '9999-01-01'
AND t.to_date = '9999-01-01'
ORDER BY e.emp_no;


--DELIVERABLE 3

--number of roles due to "silver tsunami"

SELECT COUNT (emp_no)
FROM unique_titles;

-- To check are there enough employees to provide mentorship?

SELECT COUNT (emp_no), titles
FROM mentorship_eligibility
GROUP BY titles
ORDER BY COUNT (emp_no) DESC;