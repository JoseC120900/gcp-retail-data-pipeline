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
-- Data Quality – Reglas de Observación
-- =========================================

INSERT INTO `retail_staging.dq_observations`
SELECT
  'retail_raw',
  'products_raw',
  'name',
  'A2_Consistencia',
  'El nombre debe tener al menos 5 caracteres alfanuméricos.',
  'El producto presenta menos de 5 caracteres alfanuméricos.',
  COALESCE(CAST(product_id AS STRING), 'SIN_ID'),
  run_id,
  NULL
FROM `retail_raw.products_raw`
WHERE LENGTH(REGEXP_REPLACE(name, r'[^a-zA-Z0-9]', '')) < 5
   OR name IS NULL;

-- =========================================
-- Data Quality – Reglas de Rechazo
-- =========================================

INSERT INTO `retail_staging.dq_rejections`
SELECT
  'retail_raw',
  'products_raw',
  'product_id',
  'A1_Obligatorio',
  'El identificador del producto debe ser obligatorio.',
  'El producto no puede ser analizado sin identificador.',
  COALESCE(CAST(product_id AS STRING), 'SIN_ID'),
  run_id,
  NULL
FROM `retail_raw.products_raw`
WHERE product_id IS NULL;

INSERT INTO `retail_staging.dq_rejections`
SELECT
  'retail_raw',
  'products_raw',
  'name',
  'A1_Obligatorio',
  'El nombre del producto debe ser obligatorio.',
  'El producto no puede ser analizado sin nombre.',
  COALESCE(CAST(product_id AS STRING), 'SIN_ID'),
  run_id,
  NULL
FROM `retail_raw.products_raw`
WHERE name IS NULL;

INSERT INTO `retail_staging.dq_rejections`
SELECT
  'retail_raw',
  'products_raw',
  'category',
  'A1_Obligatorio',
  'La categoría del producto debe ser obligatorio.',
  'El producto no puede ser analizado sin categoría.',
  COALESCE(CAST(product_id AS STRING), 'SIN_ID'),
  run_id,
  NULL
FROM `retail_raw.products_raw`
WHERE category IS NULL;

INSERT INTO `retail_staging.dq_rejections`
SELECT
  'retail_raw',
  'products_raw',
  'price',
  'A1_Obligatorio',
  'El precio del producto debe ser obligatorio.',
  'El producto debe tener precio.',
  COALESCE(CAST(product_id AS STRING), 'SIN_ID'),
  run_id,
  NULL
FROM `retail_raw.products_raw`
WHERE price IS NULL;

INSERT INTO `retail_staging.dq_rejections`
SELECT
  'retail_raw',
  'products_raw',
  'price',
  'A2_Dominio',
  'El precio debe ser mayor a 0.',
  'Precio inválido afecta métricas de ventas.',
  COALESCE(CAST(product_id AS STRING), 'SIN_ID'),
  run_id,
  NULL
FROM `retail_raw.products_raw`
WHERE price <= 0;