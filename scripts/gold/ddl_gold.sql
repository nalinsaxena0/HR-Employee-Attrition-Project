/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- Creating VIEW gold.dim_demographics
CREATE OR ALTER VIEW gold.dim_demographics AS
SELECT DISTINCT
	employee_number,
	age,
	age_group,
	CASE
		WHEN gender = 'MALE' THEN 'Male'
		ELSE 'Female'
	END AS gender,
	CASE 
		WHEN marital_status = 'SINGLE' THEN 'Single'
		WHEN marital_status = 'MARRIED' THEN 'Married'
		ELSE 'Divorced'
	END AS marital_status,
	education,
	education_field,
	over18_flag
FROM silver.emp_att_clean;
GO

-- Creating VIEW gold.dim_job
CREATE OR ALTER VIEW gold.dim_job AS
SELECT DISTINCT
	employee_number,
	department,
	job_role,
	job_level,
	job_involvement,
	business_travel,
	high_travel_flag,
	distance_from_home,
	standard_hours
FROM silver.emp_att_clean;
GO

-- Creating VIEW gold.dim_compensation
CREATE OR ALTER VIEW gold.dim_compensation AS
SELECT DISTINCT
	employee_number,
	monthly_income,
	income_band,
	daily_rate,
	hourly_rate,
	monthly_rate,
	percent_salary_hike,
	stock_option_level
FROM silver.emp_att_clean;
GO

-- Creating VIEW gold.dim_tenure
CREATE OR ALTER VIEW gold.dim_tenure AS
SELECT DISTINCT
	employee_number,
	total_working_years,
	total_experience_group,
	num_companies_worked,
	years_at_company,
	tenure_group,
	years_in_current_role,
	years_since_last_promotion,
	years_with_curr_manager
FROM silver.emp_att_clean;
GO

-- Creating VIEW gold.dim_engagement
CREATE OR ALTER VIEW gold.dim_engagement AS
SELECT DISTINCT
	employee_number,
	job_satisfaction,
	job_satisfaction_label,
	environment_satisfaction,
	relationship_satisfaction,
	work_life_balance,
	overtime_flag,
	training_times_last_year,
	performance_rating
FROM silver.emp_att_clean;
GO

-- Creating VIEW gold.fact_employee_attrition
CREATE OR ALTER VIEW gold.fact_employee_attrition AS
SELECT
	employee_number,
	employee_count,
	attrition_flag,
	overtime_flag,
	promotion_stagnant_flag,
	manager_instability_flag,
	high_travel_flag

FROM silver.emp_att_clean;
GO
