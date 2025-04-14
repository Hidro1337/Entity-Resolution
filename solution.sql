-- The provided file is in Parquet format, which is optimized for big data processing.
-- Replace '/path/to/entity_resolution.snappy.parquet' with the actual file path.
CREATE OR REPLACE TEMPORARY VIEW company_data
USING parquet
OPTIONS (path '/path/to/entity_resolution.snappy.parquet');


-- Step 2: Clean and Standardize Key Columns
--Convert company names and addresses to lowercase and trim extra spaces so small formatting quirks don't mess up duplicate matching.
WITH standardized_data AS (
    SELECT	id,  --IDENTIFIER
			LOWER(TRIM(company_name)) AS name_standard,
			LOWER(TRIM(address)) AS address_standard,
			phone,
			website,
			field1,
			field2
    FROM company_data
),


-- Step 3: Identify Unique Company Groups
grouped_companies AS (
    SELECT  name_standard,
			MIN(id) AS canonical_id,  
			COUNT(*) AS duplicate_count
    FROM standardized_data
    GROUP BY name_standard
   
)


-- This last query gives us the final dataset with the canonical_id and duplicate_count columns.
SELECT
    sd.id,
    sd.name_standard AS company_name,
    sd.address_standard AS address,
    gc.canonical_id,
    gc.duplicate_count,
    sd.phone,
    sd.website,
    sd.other_field1,
    sd.other_field2
FROM standardized_data sd LEFT JOIN grouped_companies gc 
ON sd.name_standard = gc.name_standard
ORDER BY gc.canonical_id, sd.id;
