{{ config(materialized='table') }}

with listings as (

    select * from {{ ref('int_listings') }}

)

select
    neighbourhood,
    room_type,

    count(*) as total_listings,

    avg(price) as avg_price,

    avg(min_revenue_potential) as avg_revenue_potential,

    avg(review_scores_rating) as avg_rating

from listings

group by
    neighbourhood,
    room_type