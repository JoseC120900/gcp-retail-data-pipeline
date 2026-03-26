-- =========================================
-- TABLA: etl_run
-- =========================================
CREATE OR REPLACE TABLE `retail_staging.etl_run` (
  RunId STRING,
  ExecutionNumber INT64,
  RunDateStart TIMESTAMP,
  RunDateStartDate DATE,
  RunDateFinish TIMESTAMP,
  RunDateFinishDate DATE,
  Status STRING
);

-- =========================================
-- TABLA: dq_observations
-- =========================================
CREATE OR REPLACE TABLE `retail_staging.dq_observations` (
  Dataset STRING,
  TableName STRING,
  Field STRING,
  DQ_Type STRING,
  Rule STRING,
  Reason STRING,
  RecordId STRING,
  RunId STRING,
  SourceCreationDate TIMESTAMP
);

-- =========================================
-- TABLA: dq_rejections
-- =========================================
CREATE OR REPLACE TABLE `retail_staging.dq_rejections` (
  Dataset STRING,
  TableName STRING,
  Field STRING,
  DQ_Type STRING,
  Rule STRING,
  Reason STRING,
  RecordId STRING,
  RunId STRING,
  SourceCreationDate TIMESTAMP
);