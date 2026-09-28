# Gold Layer — Data Catalog

## Overview

The **Gold Layer** represents the business-level data layer, designed to support analytical, reporting, and business intelligence use cases.

It contains:

* **Dimension Tables** — descriptive business entities.
* **Fact Tables** — transactional and measurable business data.

---

## 1. `gold.dim_customers`

### Purpose

Stores customer information enriched with demographic and geographic attributes.

### Columns

| Column            | Data Type      | Description                                                                     |
| ----------------- | -------------- | ------------------------------------------------------------------------------- |
| `customer_key`    | `INT`          | Surrogate key uniquely identifying each customer record in the dimension table. |
| `customer_id`     | `INT`          | Unique numerical identifier assigned to the customer.                           |
| `customer_number` | `NVARCHAR(50)` | Alphanumeric identifier used for customer tracking and referencing.             |
| `first_name`      | `NVARCHAR(50)` | Customer's first name.                                                          |
| `last_name`       | `NVARCHAR(50)` | Customer's last or family name.                                                 |
| `country`         | `NVARCHAR(50)` | Customer's country of residence.                                                |
| `marital_status`  | `NVARCHAR(50)` | Customer's marital status, such as `Married` or `Single`.                       |
| `gender`          | `NVARCHAR(50)` | Customer's gender, such as `Male`, `Female`, or `n/a`.                          |
| `birthdate`       | `DATE`         | Customer's date of birth, formatted as `YYYY-MM-DD`.                            |
| `create_date`     | `DATE`         | Date and time when the customer record was created in the system.               |

---

## 2. `gold.dim_products`

### Purpose

Provides product information and descriptive attributes used for analysis and reporting.

### Columns

| Column                 | Data Type      | Description                                                                       |
| ---------------------- | -------------- | --------------------------------------------------------------------------------- |
| `product_key`          | `INT`          | Surrogate key uniquely identifying each product record in the dimension table.    |
| `product_id`           | `INT`          | Unique identifier assigned to the product for internal tracking and referencing.  |
| `product_number`       | `NVARCHAR(50)` | Structured alphanumeric code representing the product.                            |
| `product_name`         | `NVARCHAR(50)` | Descriptive name of the product, including details such as type, color, and size. |
| `category_id`          | `NVARCHAR(50)` | Unique identifier for the product category.                                       |
| `category`             | `NVARCHAR(50)` | High-level product classification, such as `Bikes` or `Components`.               |
| `subcategory`          | `NVARCHAR(50)` | Detailed classification of the product within its category.                       |
| `maintenance_required` | `NVARCHAR(50)` | Indicates whether the product requires maintenance, such as `Yes` or `No`.        |
| `cost`                 | `INT`          | Cost or base price of the product in monetary units.                              |
| `product_line`         | `NVARCHAR(50)` | Product line or series, such as `Road` or `Mountain`.                             |
| `start_date`           | `DATE`         | Date when the product became available for sale or use.                           |

---

## 3. `gold.fact_sales`

### Purpose

Stores transactional sales data designed for analytical and reporting purposes.

### Columns

| Column          | Data Type      | Description                                                             |
| --------------- | -------------- | ----------------------------------------------------------------------- |
| `order_number`  | `NVARCHAR(50)` | Unique alphanumeric identifier for each sales order, such as `SO54496`. |
| `product_key`   | `INT`          | Surrogate key linking the sales transaction to the product dimension.   |
| `customer_key`  | `INT`          | Surrogate key linking the sales transaction to the customer dimension.  |
| `order_date`    | `DATE`         | Date when the order was placed.                                         |
| `shipping_date` | `DATE`         | Date when the order was shipped to the customer.                        |
| `due_date`      | `DATE`         | Date when the order payment was due.                                    |
| `sales_amount`  | `INT`          | Total monetary value of the sale for the line item.                     |
| `quantity`      | `INT`          | Number of units of the product ordered for the line item.               |
| `price`         | `INT`          | Price per unit of the product for the line item.                        |

---

## Gold Layer Structure

```text
                    GOLD LAYER
                         │
          ┌──────────────┼──────────────┐
          │              │              │
          ▼              ▼              ▼
   dim_customers   dim_products    fact_sales
          │              │              │
          │              │        ┌─────┴─────┐
          │              │        │           │
          └──────────────┴───────►│ Analytics │
                                  │ Reporting │
                                  └───────────┘
```

### Data Model

The Gold Layer follows a **Star Schema** design:

* **Dimensions**

  * `gold.dim_customers`
  * `gold.dim_products`

* **Fact**

  * `gold.fact_sales`

* **Relationships**

  * `fact_sales.customer_key` → `dim_customers.customer_key`
  * `fact_sales.product_key` → `dim_products.product_key`

This structure provides a business-ready dataset optimized for **analytics, reporting, dashboards, and BI tools**.
