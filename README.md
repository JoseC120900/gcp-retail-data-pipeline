# 🏬 Retail Data Platform on GCP

## 📌 Overview

This project implements an end-to-end data pipeline on GCP for a retail company, designed to process, validate, and transform sales data into a structured analytical model.

The solution follows a layered architecture (**raw → staging → mart**) to ensure data quality, scalability, and business-ready insights.

---

## 🧠 Business Context

Retail companies require reliable and consistent data to analyze sales performance, customer behavior, and product trends.

This pipeline simulates a real-world scenario where data from multiple sources is ingested, validated, and transformed into a consumable data model.

---

## 🏗️ Architecture

Cloud Storage → BigQuery

* **Raw layer**: ingestion of source data
* **Staging layer**: data cleaning and standardization
* **Mart layer**: star schema for analytics

---

## ⚙️ Technologies

* GCP (BigQuery, Cloud Storage)
* SQL
* Mockaroo (data generation)

---

## 📊 Data Model

* **Fact table**: `fact_sales`
* **Dimensions**: `dim_customers`, `dim_products`

Designed using a star schema optimized for analytical queries.

---

## ✅ Data Quality

Data validation rules are applied before transformation to ensure consistency and reliability.

Examples:

* Null value checks
* Duplicate detection
* Business rule validations

(See `/docs/data_quality_rules.xlsx`)

---

## 📁 Project Structure

/data
/sql
├── core
├── orchestration
├── dq
├── staging
├── mart
/scripts
/docs

---

## 🚀 Key Highlights

* Layered data architecture (raw → staging → mart)
* Data quality validation framework
* Analytical data model (star schema)
* Modular and scalable SQL structure
