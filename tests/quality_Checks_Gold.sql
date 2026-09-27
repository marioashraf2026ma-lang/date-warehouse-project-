
/*
===============================================================================
                         DATA WAREHOUSE PROJECT
===============================================================================
    Author      : Mario Kadess
    Project     : Data Warehouse
    Layer       : Gold
    Database    : DataWarehouse
    Purpose     : Perform data quality checks on the Gold Layer

===============================================================================

Script Purpose:
    This script performs quality checks to validate the integrity,
    consistency, and accuracy of the Gold Layer.

    The checks include:
    - Uniqueness of surrogate keys in dimension tables.
    - Referential integrity between fact and dimension tables.
    - Validation of relationships in the data model.
    - Verification of connectivity between fact and dimension tables.

Usage Notes:
    - Run these checks after loading the Gold Layer.
    - Investigate and resolve any discrepancies found during the checks.
    - These checks help ensure that the Gold Layer is reliable for
      analytical and reporting purposes.

===============================================================================
*/


-- ====================================================================
-- Checking 'gold.dim_customers'
-- ====================================================================

-- Check for Uniqueness of Customer Key in gold.dim_customers
-- Expectation: No Results
SELECT 
    customer_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking 'gold.dim_products'
-- ====================================================================

-- Check for Uniqueness of Product Key in gold.dim_products
-- Expectation: No Results
SELECT 
    product_key,
    COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================

-- Check the data model connectivity between fact and dimensions
-- Expectation: No Results
SELECT 
    *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
    ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
   OR c.customer_key IS NULL;
```
