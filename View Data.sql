-- Use target schema -- 
USE hive_metastore.dlt_pipeline_guide_target

-- View bronze layer -- 
SELECT * FROM delta_guide_bronze

-- See data attributes of bronze layer -- 
DESCRIBE delta_guide_bronze

-- View silver layer --
SELECT * FROM delta_guide_silver

-- Change ordering of grades in silver layer -- 
SELECT * FROM delta_guide_silver
ORDER BY student_grade

-- View gold layer -- 
SELECT * FROM delta_guide_gold
