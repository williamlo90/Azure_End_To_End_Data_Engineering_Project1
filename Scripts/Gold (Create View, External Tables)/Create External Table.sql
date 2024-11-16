CREATE DATABASE SCOPED CREDENTIAL <user_credential>
WITH
    IDENTITY = 'Managed Identity'


CREATE EXTERNAL DATA SOURCE source_silver
WITH 
(
    LOCATION = 'https://awstoragedatalakewill.blob.core.windows.net/silver',
    CREDENTIAL = <user_credential>
)


CREATE EXTERNAL DATA SOURCE source_gold
WITH 
(
    LOCATION = 'https://awstoragedatalakewill.blob.core.windows.net/gold',
    CREDENTIAL = <user_credential>
)


CREATE EXTERNAL FILE FORMAT format_parquet
WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
)


---------------------------------
-- CREATE EXTERNAL TABLE EXTSALES 
---------------------------------
CREATE EXTERNAL TABLE gold.extsales
WITH
(
    LOCATION = 'extsales', 
    DATA_SOURCE = source_gold,
    FILE_FORMAT = format_parquet
) AS 
SELECT * FROM gold.sales

-- Query testing
SELECT * FROM gold.extsales


