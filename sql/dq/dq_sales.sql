INSERT INTO `retail_staging.dq_rejections`
SELECT
  'retail_raw',
  'sales_raw',
  'sale_id',
  'A1_Obligatorio',
  'El identificador de la venta debe existir',
  'La venta no tiene identificador, por lo que no puede ser registrada ni analizada correctamente',
  CAST(sale_id AS STRING),
  'RUN_001',
  CURRENT_TIMESTAMP()
FROM `retail_raw.sales_raw`
WHERE sale_id IS NULL;