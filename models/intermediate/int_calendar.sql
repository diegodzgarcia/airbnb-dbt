{{ config(materialized='table') }}

with calendar as (

    select * from {{ ref('stg_calendar') }}

),

final as (

    select
        listing_id,
        date,

        available as is_available,

        price,

        -- receita potencial
        price as revenue_potential,

        -- receita realizada (ocupado = false)
        case 
            when available = false then price
            else 0
        end as revenue_realized,

        -- flag ocupado
        case 
            when available = false then 1
            else 0
        end as is_booked,

        -- fim de semana
        extract(dayofweek from date) in (1,7) as is_weekend

    from calendar

)

select * from final