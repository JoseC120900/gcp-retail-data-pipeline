-- =========================================
-- Declarar run_id
-- =========================================

DECLARE run_id STRING;

SET run_id = (
  SELECT RunId
  FROM `retail_staging.etl_run`
  ORDER BY RunDateStart DESC
  LIMIT 1
);

-- =========================================
-- Crear tabla Staging
-- =========================================

CREATE OR REPLACE TABLE `retail_staging.stg_products` AS
SELECT
	raw.product_id,
	NULLIF(TRIM(raw.name), '') AS name,
	NULLIF(TRIM(raw.category), '') AS category,
	SAFE_CAST(raw.price AS INT64) AS price,

	-- Obs_Flag
	CASE 
		WHEN EXISTS (
			SELECT 1
			FROM `retail_staging.dq_observations` o
			WHERE o.RecordId = COALESCE(CAST(raw.product_id AS STRING), 'SIN_ID')
			  AND o.RunId = run_id
		)
		THEN 1
		ELSE 0
	END AS is_observed,
	
	run_id AS RunId

FROM `retail_raw.products_raw` raw

-- Excluir rechazos
WHERE NOT EXISTS (
	SELECT 1
	FROM `retail_staging.dq_rejections` r
	WHERE r.RecordId = COALESCE(CAST(raw.product_id AS STRING), 'SIN_ID')
		AND r.RunId = run_id
);