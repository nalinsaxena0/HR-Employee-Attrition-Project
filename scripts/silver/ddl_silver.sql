/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

IF OBJECT_ID('silver.emp_att_clean', 'U') IS NOT NULL
	DROP TABLE silver.emp_att_clean;
GO

CREATE TABLE silver.emp_att_clean (
	-- Identifiers
	employee_number					INT,
	employee_count					INT,

	-- Target variable
	attrition						NVARCHAR(10),
	attrition_flag					TINYINT,

	-- Demographics
	age								INT,
	age_group						NVARCHAR(20),
	gender							NVARCHAR(20),
	marital_status					NVARCHAR(20),
	education						INT,
	education_field					NVARCHAR(50),
	over18							NVARCHAR(5),
	over18_flag						TINYINT,

	-- Job & Organization
	department						NVARCHAR(50),
	job_role						NVARCHAR(50),
	job_level						INT,
	job_involvement					INT,
	business_travel					NVARCHAR(50),
	high_travel_flag				TINYINT,
	distance_from_home				INT,
	standard_hours					INT,

	-- Compensation
	daily_rate						INT,
	hourly_rate						INT,
	monthly_income					INT,
	income_band						NVARCHAR(20),
	monthly_rate					INT,
	percent_salary_hike				INT,
	stock_option_level				INT,

	-- Satisfaction & Engagement
	environment_satisfaction		INT,
	job_satisfaction				INT,
	job_satisfaction_label			NVARCHAR(20),
	relationship_satisfaction		INT,
	work_life_balance				INT,
	overtime						NVARCHAR(10),
	overtime_flag					TINYINT,

	-- Experience & Tenure
	total_working_years				INT,
	total_experience_group			NVARCHAR(20),
	num_companies_worked			INT,
	years_at_company				INT,
	tenure_group					NVARCHAR(20),
	years_in_current_role			INT,
	years_since_last_promotion		INT,
	promotion_stagnant_flag			TINYINT,
	years_with_curr_manager			INT,
	manager_instability_flag		TINYINT,

	-- Training & Performance
	training_times_last_year		INT,
	performance_rating				INT
);
GO
