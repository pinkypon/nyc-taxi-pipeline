-- models/staging/stg_yellow_trips.sql
-- Staging layer: reads from RAW and selects columns
-- Data is already cleaned in Databricks

with source as (

    select * from {{ source('raw', 'YELLOW_TRIPS') }}

),

renamed as (

    select
        PICKUP_DATETIME,
        DROPOFF_DATETIME,
        PASSENGER_COUNT,
        TRIP_DISTANCE,
        FARE_AMOUNT,
        TIP_AMOUNT,
        TOTAL_AMOUNT,
        PAYMENT_TYPE,
        PICKUP_LATITUDE,
        PICKUP_LONGITUDE,
        PICKUP_HOUR,
        PICKUP_DAY,
        PICKUP_MONTH,
        PICKUP_YEAR

    from source

)

select * from renamed