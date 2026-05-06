-- models/marts/mart_busiest_hours.sql
-- Business question: What time of day is busiest?

with trips as (

    select * from {{ ref('stg_yellow_trips') }}

)

select
    PICKUP_HOUR,
    COUNT(*) as total_trips,
    ROUND(AVG(TOTAL_AMOUNT), 2) as avg_fare
from trips
group by PICKUP_HOUR
order by total_trips desc