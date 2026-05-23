{{ config(materialized='table') }}

with calendar as (
    select * from {{ ref('int_calendar') }}
),

listings as (
    select * from {{ ref('int_listings') }}
),

joined as (
    select
        c.date,
        extract(year from c.date)  as year,
        extract(month from c.date) as month,
        l.neighbourhood,
        l.room_type,
        c.is_booked,
        c.revenue_realized,
        c.price,
        c.is_weekend
    from calendar c
    left join listings l on c.listing_id = l.id
),

final as (
    select
        year,
        month,
        neighbourhood,
        room_type,
        is_weekend,
        count(*)                                    as total_days,
        sum(is_booked)                              as booked_days,
        safe_divide(sum(is_booked), count(*))       as occupancy_rate,
        sum(revenue_realized)                       as total_revenue,
        avg(price)                                  as avg_price
    from joined
    group by year, month, neighbourhood, room_type, is_weekend
)

select * from final