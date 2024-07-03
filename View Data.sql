-- Use target schema -- 
USE hive_metastore.dlt_pipeline_guide_target

-- View bronze layer table  -- 
SELECT * FROM delta_guide_bronze

-- See data attributes of bronze layer table -- 
DESCRIBE delta_guide_bronze

-- View silver layer data table --
SELECT * FROM delta_guide_silver

-- Change ordering of grades in silver layer table -- 
SELECT * FROM delta_guide_silver
ORDER BY student_grade

-- View gold layer table -- 
SELECT * FROM delta_guide_gold
