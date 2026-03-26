DECLARE run_id STRING DEFAULT GENERATE_UUID();

INSERT INTO `retail_staging.etl_run`
WITH last_execution AS (
  SELECT COALESCE(MAX(ExecutionNumber), 0) AS last_exec
  FROM `retail_staging.etl_run`
)
SELECT
  run_id,
  last_exec + 1,
  CURRENT_TIMESTAMP(),
  CURRENT_DATE(),
  CAST(NULL AS TIMESTAMP),
  CAST(NULL AS DATE),
  'RUNNING'
FROM last_execution;