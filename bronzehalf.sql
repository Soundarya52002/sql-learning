CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
    SET @batch_start_time = GETDATE();
    PRINT('==============================================================');
    PRINT('Loading data into bronze');
	PRINT('==============================================================');
	PRINT('--------------------------------------------------------------');
    PRINT('Loading CRM data into bronze');
	PRINT('--------------------------------------------------------------');
	SET @start_time = GETDATE();
    PRINT('Truncating the table : bronze.crm_cst_info');
	TRUNCATE TABLE bronze.crm_cst_info;
	PRINT('Inserting the table : bronze.crm_cst_info');
	BULK INSERT bronze.crm_cst_info
	FROM 'D:\warehouse_project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration is :' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT('--------------------------------------------------------------');
	SELECT COUNT(*) FROM bronze.crm_cst_info;
	--table insertion for crm prod
	SET @start_time = GETDATE();
	PRINT('Truncating the table : bronze.crm_prd_info');
	TRUNCATE TABLE bronze.crm_prd_info;
	PRINT('Inserting the table : bronze.crm_cst_info');
	BULK INSERT bronze.crm_cst_info
	FROM 'D:\warehouse_project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration is :' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT('--------------------------------------------------------------');
	SELECT COUNT(*) FROM bronze.crm_prd_info;
	--table insertion for crm sales details
	SET @start_time = GETDATE();
	PRINT('Truncating the table : bronze.crm_sales_details');
	TRUNCATE TABLE bronze.crm_sales_details;
	PRINT('Inserting the table : bronze.crm_sales_details');
	BULK INSERT bronze.crm_sales_details
	FROM 'D:\warehouse_project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration is :' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT('--------------------------------------------------------------');
	SELECT COUNT(*) FROM bronze.crm_sales_details;
	--table insertion for erp cust_az12
	PRINT('--------------------------------------------------------------');
    PRINT('Loading ERP data into bronze');
	PRINT('--------------------------------------------------------------');
	PRINT('Truncating the table : bronze.erp_cust_az12');
	SET @start_time = GETDATE();
	TRUNCATE TABLE bronze.erp_cust_az12;
	PRINT('Inserting the table : bronze.erp_cust_az12');
	BULK INSERT bronze.erp_cust_az12
	FROM 'D:\warehouse_project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration is :' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT('--------------------------------------------------------------');
	SELECT COUNT(*) FROM bronze.erp_cust_az12;
	--table insertion for erp loc_a101
	SET @start_time = GETDATE();
	PRINT('Truncating the table : bronze.erp_loc_a101');
	TRUNCATE TABLE bronze.erp_loc_a101;
	PRINT('Inserting the table : bronze.erp_loc_a101');
	BULK INSERT bronze.erp_loc_a101
	FROM 'D:\warehouse_project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration is :' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT('--------------------------------------------------------------');
	SELECT COUNT(*) FROM bronze.erp_loc_a101;
	--table insertion for erp px_cat
	SET @start_time = GETDATE();
	PRINT('Truncating the table : bronze.erp_px_cat_g1v2');
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	PRINT('Inserting the table : bronze.erp_px_cat_g1v2');
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'D:\warehouse_project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);
	SET @end_time = GETDATE();
	PRINT '>>Load Duration is :' + CAST(DATEDIFF(second,@start_time, @end_time) AS NVARCHAR) + 'seconds';
	PRINT('--------------------------------------------------------------');
	SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2;
	SET @batch_end_time = GETDATE();
	PRINT('==============================================================');
	PRINT '>>Load Duration of BRONZE LAYER is :' + CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
	PRINT('==============================================================');
END TRY
	BEGIN CATCH
	PRINT('==============================================================');
	PRINT'Error Message:'+ ERROR_MESSAGE();
	PRINT('==============================================================');
	END CATCH
END;

EXEC bronze.load_bronze;