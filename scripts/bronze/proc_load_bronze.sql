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

    SELECT *
    FROM bronze.etl_log
    ORDER BY log_id DESC;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @start_time       DATETIME2,
        @end_time         DATETIME2,
        @batch_start_time DATETIME2,
        @batch_end_time   DATETIME2,
        @rows_loaded      INT,
        @run_id           UNIQUEIDENTIFIER = NEWID(),
        @current_table    NVARCHAR(100);

    BEGIN TRY
        SET @batch_start_time = SYSDATETIME();

        PRINT '================================================';
        PRINT 'Loading Bronze Layer';
        PRINT 'Run ID: ' + CAST(@run_id AS NVARCHAR(36));
        PRINT '================================================';

        PRINT '------------------------------------------------';
        PRINT 'Loading CRM Tables';
        PRINT '------------------------------------------------';

        -----------------------------------------------------------------------
        -- bronze.crm_cust_info
        -----------------------------------------------------------------------
        SET @current_table = 'bronze.crm_cust_info';
        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '>> Inserting Data Into: ' + @current_table;
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\\vip\\SQL Data Warehouse Portfolio Project\\Project\\datasets\\source_crm\\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            MAXERRORS = 1000,
            TABLOCK
        );

        SET @rows_loaded = @@ROWCOUNT;
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', @current_table, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), @rows_loaded, 'Success', NULL
        );

        PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS NVARCHAR(20));
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '>> -------------';

        -----------------------------------------------------------------------
        -- bronze.crm_prd_info
        -----------------------------------------------------------------------
        SET @current_table = 'bronze.crm_prd_info';
        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.crm_prd_info;

        PRINT '>> Inserting Data Into: ' + @current_table;
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\\vip\\SQL Data Warehouse Portfolio Project\\Project\\datasets\\source_crm\\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @rows_loaded = @@ROWCOUNT;
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', @current_table, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), @rows_loaded, 'Success', NULL
        );

        PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS NVARCHAR(20));
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '>> -------------';

        -----------------------------------------------------------------------
        -- bronze.crm_sales_details
        -----------------------------------------------------------------------
        SET @current_table = 'bronze.crm_sales_details';
        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.crm_sales_details;

        PRINT '>> Inserting Data Into: ' + @current_table;
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\\vip\\SQL Data Warehouse Portfolio Project\\Project\\datasets\\source_crm\\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @rows_loaded = @@ROWCOUNT;
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', @current_table, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), @rows_loaded, 'Success', NULL
        );

        PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS NVARCHAR(20));
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '>> -------------';

        PRINT '------------------------------------------------';
        PRINT 'Loading ERP Tables';
        PRINT '------------------------------------------------';

        -----------------------------------------------------------------------
        -- bronze.erp_cust_az12
        -----------------------------------------------------------------------
        SET @current_table = 'bronze.erp_cust_az12';
        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.erp_cust_az12;

        PRINT '>> Inserting Data Into: ' + @current_table;
        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\\vip\\SQL Data Warehouse Portfolio Project\\Project\\datasets\\source_erp\\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @rows_loaded = @@ROWCOUNT;
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', @current_table, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), @rows_loaded, 'Success', NULL
        );

        PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS NVARCHAR(20));
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '>> -------------';

        -----------------------------------------------------------------------
        -- bronze.erp_loc_a101
        -----------------------------------------------------------------------
        SET @current_table = 'bronze.erp_loc_a101';
        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.erp_loc_a101;

        PRINT '>> Inserting Data Into: ' + @current_table;
        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\\vip\\SQL Data Warehouse Portfolio Project\\Project\\datasets\\source_erp\\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @rows_loaded = @@ROWCOUNT;
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', @current_table, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), @rows_loaded, 'Success', NULL
        );

        PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS NVARCHAR(20));
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '>> -------------';

        -----------------------------------------------------------------------
        -- bronze.erp_px_cat_g1v2
        -----------------------------------------------------------------------
        SET @current_table = 'bronze.erp_px_cat_g1v2';
        SET @start_time = SYSDATETIME();

        PRINT '>> Truncating Table: ' + @current_table;
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        PRINT '>> Inserting Data Into: ' + @current_table;
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\\vip\\SQL Data Warehouse Portfolio Project\\Project\\datasets\\source_erp\\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            ROWTERMINATOR = '\n',
            TABLOCK
        );

        SET @rows_loaded = @@ROWCOUNT;
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', @current_table, @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), @rows_loaded, 'Success', NULL
        );

        PRINT '>> Rows Loaded: ' + CAST(@rows_loaded AS NVARCHAR(20));
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '>> -------------';

        -----------------------------------------------------------------------
        -- Batch Summary
        -----------------------------------------------------------------------
        SET @batch_end_time = SYSDATETIME();

        PRINT '==========================================';
        PRINT 'Loading Bronze Layer is Completed';
        PRINT 'Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR(20)) + ' Seconds';
        PRINT '==========================================';
    END TRY

    BEGIN CATCH
        SET @end_time = SYSDATETIME();

        INSERT INTO bronze.etl_log
        (
            run_id, layer_name, table_name, load_start, load_end,
            duration_sec, rows_loaded, status, error_message
        )
        VALUES
        (
            @run_id, 'bronze', ISNULL(@current_table, 'UNKNOWN'), @start_time, @end_time,
            DATEDIFF(SECOND, @start_time, @end_time), NULL, 'Failed', ERROR_MESSAGE()
        );

        PRINT '==========================================';
        PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER';
        PRINT 'Table: ' + ISNULL(@current_table, 'UNKNOWN');
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR(20));
        PRINT 'Error State: ' + CAST(ERROR_STATE() AS NVARCHAR(20));
        PRINT '==========================================';

        THROW;
    END CATCH
END;
GO
