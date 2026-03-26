DECLARE run_id STRING;

SET run_id = (
  SELECT RunId
  FROM `retail_staging.etl_run`
  ORDER BY RunDateStart DESC
  LIMIT 1
);

--------------------------------------------------------------
-- Data Quality – Reglas de Observación
--------------------------------------------------------------