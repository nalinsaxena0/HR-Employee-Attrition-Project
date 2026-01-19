/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME;
	BEGIN TRY
		PRINT '==================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.emp_att_raw';
		TRUNCATE TABLE bronze.emp_att_raw;
		PRINT '>> Inserting Data Into: bronze.emp_att_raw';
		BULK INSERT bronze.emp_att_raw
				FROM 'D:\SQL files\HR-Employee-Attrition.csv'
				WITH (
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				TABLOCK
				);
		SET @end_time = GETDATE();

		PRINT '==================================';
		PRINT 'Loading Bronze Layer is completed';
		PRINT '		- Total Load Douration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '==================================';
	END TRY
	BEGIN CATCH
	PRINT '==================================';
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '==================================';
	END CATCH
END
