CREATE OR REPLACE TABLE `gcp-learning-lab-498505.intern_sandbox.optimized_nyc_taxi_trips`
PARTITION BY DATE(pickup_datetime)
CLUSTER BY vendor_id
AS
SELECT 
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    -- Grouping the messy financials into a clean STRUCT
    STRUCT(
        fare_amount, 
        tip_amount, 
        tolls_amount,
        total_amount
    ) AS fare_details
FROM 
    `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2022`
WHERE 
    fare_amount > 0;
