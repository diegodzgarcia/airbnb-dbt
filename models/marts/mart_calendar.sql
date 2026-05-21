{{ config(materialized='table') }}

with calendar as (

    select * from {{ ref('int_calendar') }}

),

final as (

    select
        listing_id,

        -- período
        min(date) as start_date,
        max(date) as end_date,

        count(*) as total_days,

        -- ocupação
        sum(is_booked) as booked_days,

        safe_divide(sum(is_booked), count(*)) as occupancy_rate,

        -- receita
        sum(revenue_realized) as total_revenue,

        avg(price) as avg_price,

        -- RevPAR (receita por dia disponível)
        safe_divide(sum(revenue_realized), count(*)) as revpar

    from calendar

    group by listing_id

)

select * from final