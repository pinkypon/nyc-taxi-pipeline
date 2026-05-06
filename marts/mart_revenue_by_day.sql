-- models/marts/mart_revenue_by_day.sql
-- Business question: Which days generate the most revenue?

with trips as (

    select * from {{ ref('stg_yellow_trips') }}

)

select
    PICKUP_DAY,
    case PICKUP_DAY
        when 1 then 'Sunday'
        when 2 then 'Monday'
        when 3 then 'Tuesday'
        when 4 then 'Wednesday'
        when 5 then 'Thursday'
        when 6 then 'Friday'
        when 7 then 'Saturday'
    end as day_name,
    COUNT(*) as total_trips,
    ROUND(SUM(TOTAL_AMOUNT), 2) as total_revenue,
    ROUND(AVG(TOTAL_AMOUNT), 2) as avg_fare
from trips
group by PICKUP_DAY
order by total_revenue desc