-- Bronze layer -- 
CREATE OR REFRESH STREAMING LIVE TABLE delta_guide_bronze
COMMENT 'Collect the grading data'
AS SELECT * FROM cloud_files("/FileStore/grading_data_raw", "csv", map("cloudFiles.inferColumnTypes", "true"))

-- Silver layer -- 
CREATE OR REFRESH LIVE TABLE delta_guide_silver(
  CONSTRAINT sufficient_response EXPECT (student_grade IS NOT NULL and student_result IS NOT NULL) ON VIOLATION DROP ROW
)
COMMENT 'Rename columns, drop all rows with nulls, and sort in descending order by student grade'
AS SELECT 
  id AS student_id, names AS student_name, gender AS student_gender, gpa AS student_gpa, grade AS student_grade, result AS student_result 
FROM 
  LIVE.delta_guide_bronze
ORDER BY
  student_grade DESC;

-- Gold layer -- 
CREATE LIVE TABLE delta_guide_gold
COMMENT 'Drop some columns and only include rows of students who passed'
AS SELECT 
  student_id, student_name, student_grade, student_result
FROM 
  LIVE.delta_guide_silver 
WHERE 
  student_result = 'Pass'
