/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID ('bronze.emp_att_raw', 'U') IS NOT NULL
	DROP TABLE bronze.emp_att_raw;
GO


CREATE TABLE bronze.emp_att_raw (
age										INT,
attrition								NVARCHAR(50),
business_travel							NVARCHAR(50),
daily_rate								INT,
department								NVARCHAR(50),
distance_from_home						INT,
education								INT,
education_field							NVARCHAR(50),
employee_count							INT,
employee_number							INT,
environment_satisfaction				INT,
gender									NVARCHAR(50),
hourly_rate								INT,
job_involvement							INT,
job_level								INT,
job_role								NVARCHAR(50),
job_satisfaction						INT,
marital_status							NVARCHAR(50),
monthly_income							INT,
monthly_rate							INT,
num_companies_worked					INT,
over_18									NVARCHAR(50),
overtime								NVARCHAR(50),
percent_salary_hike						INT,
performance_rating						INT,
relationship_satisfaction				INT,
standard_hours							INT,
stock_option_level						INT,
total_working_years						INT,
training_times_last_year				INT,
work_life_balance						INT,
years_at_company						INT,
years_in_current_role					INT,
years_since_last_promotion				INT,
years_with_curr_manager					INT
);
GO
