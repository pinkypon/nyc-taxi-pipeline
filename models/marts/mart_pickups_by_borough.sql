-- models/marts/mart_pickups_by_borough.sql
-- Business question: Which borough has the most pickups?

with trips as (

    select * from {{ ref('stg_yellow_trips') }}

),

with_borough as (

    select
        *,
        case
            when PICKUP_LATITUDE between 40.496 and 40.915
                and PICKUP_LONGITUDE between -74.255 and -73.700
                then 'Manhattan'
            when PICKUP_LATITUDE between 40.570 and 40.739
                and PICKUP_LONGITUDE between -74.042 and -73.833
                then 'Brooklyn'
            when PICKUP_LATITUDE between 40.541 and 40.800
                and PICKUP_LONGITUDE between -73.962 and -73.700
                then 'Queens'
            when PICKUP_LATITUDE between 40.785 and 40.915
                and PICKUP_LONGITUDE between -73.933 and -73.765
                then 'Bronx'
            when PICKUP_LATITUDE between 40.496 and 40.651
                and PICKUP_LONGITUDE between -74.255 and -74.034
                then 'Staten Island'
            else 'Unknown'
        end as borough
    from trips

)

select
    borough,
    COUNT(*) as total_pickups,
    ROUND(AVG(TRIP_DISTANCE), 2) as avg_distance,
    ROUND(AVG(TOTAL_AMOUNT), 2) as avg_fare
from with_borough
group by borough
order by total_pickups desc