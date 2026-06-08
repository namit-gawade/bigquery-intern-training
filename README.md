# bigquery-intern-training

# NYC Taxi Data Architecture & Optimization

## Overview
This repository contains an enterprise-grade BigQuery optimization project using the `tlc_yellow_trips_2022` public dataset. 

The primary objective of this project was to transform a raw, expensive, and scattered dataset into a highly optimized data, drastically reducing cloud compute costs while improving query performance.

## Architecture & Optimization Techniques
To build the final optimized table, I applied five main strategies:

1. Keeping only what we need (Pruning): Selected only the required columns instead of loading the entire heavy table, which saves on storage space.

2. Organizing messy data (Denormalization): Combined all the scattered financial columns into a single, clean JSON-like structure (a STRUCT) to make the data easier to read.

3. Partitioning by date: Set up the table to physically group data by day, so we can query specific dates without paying to scan the whole year.

4. Clustering by taxi company: Sorted the data within those daily groups by vendor_id, allowing for lightning-fast filtering between different cab companies.

5. Filtering out anomalies: Removed bad data (like $0 trips from broken meters) right at the source so it doesn't break future analysis.

## The Results: 99.7% Cost Reduction

To prove the efficiency of the new architecture, a standard query—pulling fare details for a single day (New Year's Day 2022)—was executed against both the raw table and the optimized table.

* **Raw Table Data Scanned:** ~1.89 GB
* **Optimized Table Data Scanned:** ~4.33 MB
* **Total Reduction:** **99.7%**

By strategically applying partitioning and structural grouping, the cost to query this dataset was reduced to a fraction of a penny, demonstrating the massive financial impact of proper cloud data architecture.
