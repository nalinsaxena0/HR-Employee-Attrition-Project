/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '==============================';
        PRINT 'Loading Silver Layer';
        PRINT '==============================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.emp_att_clean';
		TRUNCATE TABLE silver.emp_att_clean;
		PRINT '>> Inserting Data into Table: silver.emp_att_clean';
		INSERT INTO silver.emp_att_clean
		(
			employee_number,
			employee_count,

			attrition,
			attrition_flag,

			age,
			age_group,
			gender,
			marital_status,
			education,
			education_field,
			over18,
			over18_flag,

			department,
			job_role,
			job_level,
			job_involvement,
			business_travel,
			high_travel_flag,
			distance_from_home,
			standard_hours,

			daily_rate,
			hourly_rate,
			monthly_income,
			income_band,
			monthly_rate,
			percent_salary_hike,
			stock_option_level,

			environment_satisfaction,
			job_satisfaction,
			job_satisfaction_label,
			relationship_satisfaction,
			work_life_balance,
			overtime,
			overtime_flag,

			total_working_years,
			total_experience_group,
			num_companies_worked,
			years_at_company,
			tenure_group,
			years_in_current_role,
			years_since_last_promotion,
			promotion_stagnant_flag,
			years_with_curr_manager,
			manager_instability_flag,

			training_times_last_year,
			performance_rating
		)

		SELECT
			-- Identifiers
			employee_number,
			employee_count,

			-- Attrition
			attrition,
			CASE 
				WHEN attrition = 'Yes' THEN 1
				WHEN attrition = 'No' THEN 0
				ELSE NULL
			END AS attrition_flag,

			-- Demographics
			age,
			CASE
				WHEN age BETWEEN 18 AND 25 THEN '18-25'
				WHEN age BETWEEN 26 AND 35 THEN '26-35'
				WHEN age BETWEEN 36 AND 45 THEN '36-45'
				WHEN age BETWEEN 46 AND 55 THEN '46-55'
				WHEN age > 55 THEN '55+'
				ELSE 'Unknown'
			END AS age_group,
			UPPER(TRIM(gender)) AS gender,
			UPPER(TRIM(marital_status)) AS marital_status,
			education,
			TRIM(education_field) AS education_field,
			over_18,
			CASE
				WHEN over_18 = 'Y' THEN 1
				ELSE 0
			END AS over18_flag,

			-- Job & Organization
			TRIM(department) AS department,
			TRIM(job_role) AS job_role,
			job_level,
			job_involvement,
			TRIM(business_travel) AS business_travel,
			CASE
				WHEN business_travel = 'Travel_Frequently' THEN 1
				ELSE 0
			END AS high_travel_flag,
			distance_from_home,
			standard_hours,

			-- Compensation
			daily_rate,
			hourly_rate,
			monthly_income,
			CASE
				WHEN monthly_income < 3000 THEN 'Low'
				WHEN monthly_income BETWEEN 3000 AND 8000 THEN 'Medium'
				WHEN monthly_income > 8000 THEN 'High'
				ELSE 'Unknown'
			END AS income_band,
			monthly_rate,
			percent_salary_hike,
			stock_option_level,

			-- Satisfaction & Engagement
			environment_satisfaction,
			job_satisfaction,
			CASE job_satisfaction
				WHEN 1 THEN 'Low'
				WHEN 2 THEN 'Medium'
				WHEN 3 THEN 'High'
				WHEN 4 THEN 'Very High'
				ELSE 'Unknown'
			END AS job_satisfaction_label,
			relationship_satisfaction,
			work_life_balance,
			overtime,
			CASE
				WHEN overtime = 'Yes' THEN 1
				WHEN overtime = 'No' THEN 0
				ELSE NULL
			END AS overtime_flag,

			-- Experience & Tenure
			total_working_years,
			CASE
				WHEN total_working_years BETWEEN 0 AND 5 THEN '0-5'
				WHEN total_working_years BETWEEN 6 AND 10 THEN '6-10'
				WHEN total_working_years BETWEEN 11 AND 20 THEN '11-20'
				WHEN total_working_years > 20 THEN '20+'
				ELSE 'Unknown'
			END AS total_experience_group,
			num_companies_worked,
			years_at_company,
			CASE
				WHEN years_at_company BETWEEN 0 AND 2 THEN 'New'
				WHEN years_at_company BETWEEN 3 AND 5 THEN 'Early'
				WHEN years_at_company BETWEEN 6 AND 10 THEN 'Mid'
				WHEN years_at_company > 10 THEN 'Long'
				ELSE 'Unknown'
			END AS tenure_group,
			years_in_current_role,
			years_since_last_promotion,
			CASE
				WHEN years_since_last_promotion >= 3 THEN 1
				ELSE 0
			END AS promotion_stagnant_flag,
			years_with_curr_manager,
			CASE
				WHEN years_with_curr_manager <= 1 THEN 1
				ELSE 0
			END AS manager_instability_flag,

			-- Training & Performance
			training_times_last_year,
			performance_rating

		FROM bronze.emp_att_raw;
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
