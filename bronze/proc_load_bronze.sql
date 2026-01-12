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

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
		DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
		BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '====================================';
		PRINT 'Loading Bronze Layer';
		PRINT '====================================';

		PRINT '------------------------------------';
		PRINT 'Loading CRM tables';
		PRINT '------------------------------------';
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table : bronze.crm_cust_info';
			truncate table bronze.crm_cust_info;
			Bulk insert bronze.crm_cust_info 
			from 'C:\Users\LENOVO\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
				);
				SET @end_time = GETDATE();
				PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR ) + 'seconds';
				print '----------------------------';
		
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table : bronze.crm_prd_info';
			truncate table bronze.crm_prd_info;
			Bulk insert bronze.crm_prd_info 
			from 'C:\Users\LENOVO\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
				);
				SET @end_time = GETDATE();
				PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR ) + 'seconds';
				print '----------------------------';


			SET @start_time = GETDATE();
			PRINT '>> Truncating Table : bronze.crm_sales_details';
			truncate table bronze.crm_sales_details;
			Bulk insert bronze.crm_sales_details 
			from 'C:\Users\LENOVO\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
					);
				SET @end_time = GETDATE();
				PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR ) + 'seconds';
				print '----------------------------';

		PRINT '------------------------------------';
		PRINT 'Loading ERP tables';
		PRINT '------------------------------------';
			
			SET @start_time = GETDATE();
			PRINT '>> Truncating Table : bronze.erp_cust_az12';
			truncate table bronze.erp_cust_az12;
			Bulk insert bronze.erp_cust_az12 
			from 'C:\Users\LENOVO\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR ) + 'seconds';
			print '----------------------------';


			SET @start_time = GETDATE();
			PRINT '>> Truncating Table : bronze.erp_loc_a101';
			truncate table bronze.erp_loc_a101;
			Bulk insert bronze.erp_loc_a101 
			from 'C:\Users\LENOVO\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
				);
				SET @end_time = GETDATE();
				PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR ) + 'seconds';
				print '----------------------------';

			SET @start_time = GETDATE();
			PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
			truncate table bronze.erp_px_cat_g1v2;
			Bulk insert bronze.erp_px_cat_g1v2 
			from 'C:\Users\LENOVO\Downloads\f78e076e5b83435d84c6b6af75d8a679\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
			with (
				firstrow = 2,
				fieldterminator = ',',
				tablock
				);
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) as NVARCHAR ) + 'seconds';
			print '----------------------------';

			SET @batch_end_time = GETDATE();
			PRINT '>> Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) as NVARCHAR ) + 'seconds';
			print '----------------------------';
	END TRY
BEGIN CATCH
PRINT '================================================================';
PRINT 'Error Message' + ERROR_MESSAGE();
PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
PRINT '================================================================';
END CATCH
END

