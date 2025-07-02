-- Set context
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE devops_wh;
USE DATABASE devops_db;
USE SCHEMA common;

-- Create or replace a table
CREATE OR REPLACE TABLE employee_demo (
    emp_id       INT,
    emp_name     STRING,
    department   STRING,
    hire_date    DATE
);

-- Insert sample data
INSERT INTO employee_demo (emp_id, emp_name, department, hire_date)
VALUES
    (1, 'Alice Johnson', 'Finance', '2023-01-15'),
    (2, 'Bob Smith', 'Engineering', '2023-03-01'),
    (3, 'Carol Lee', 'HR', '2023-05-12');

-- View data
SELECT * FROM employee_demo;
