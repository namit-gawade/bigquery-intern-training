/* Transforms raw, expensive NYC Taxi data into a clean table 
Architecture Applied:
         - Columnar Pruning: Selects only required fields.
         - Denormalization: Combine columns into a STRUCT.
         - Partitioning: Partitioned by date to reduce data scan costs.
         - Clustering: Clustered by vendor_id for fast filtering.
*/

CREATE OR REPLACE TABLE `gcp-learning-lab-498505.intern_sandbox.optimized_nyc_taxi_trips`
-- Partitioning by pickup_datetime so that we can query specific days without scanning the whole year
PARTITION BY DATE(pickup_datetime)
-- Clustering by vendor_id for fast filtering between different taxi companies
CLUSTER BY vendor_id
AS
SELECT     
    vendor_id, -- Selecting only those columns which are required instead of selecting the full table
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    
    -- Denormalizes unorganized data into a single, organized JSON-like format
    STRUCT(
        fare_amount, 
        tip_amount, 
        tolls_amount,
        total_amount
    ) AS fare_details
FROM 
    `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE 
    -- Ignoring the anomalies in the table
    fare_amount > 0;
