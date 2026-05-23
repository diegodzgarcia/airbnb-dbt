{{ config(materialized='table') }}

with listings as (
    select * from {{ ref('int_listings') }}
),

calendar as (
    select * from {{ ref('mart_calendar') }}
)

select
    -- identificação
    l.id as listing_id,
    l.name as listing_name,

    -- localização
    l.neighbourhood,
    l.latitude,
    l.longitude,

    -- características do imóvel
    l.room_type,
    l.property_type,
    l.accommodates,
    l.size_category,

    -- preço e classificação
    l.price,
    l.price_category,
    l.minimum_nights,
    l.min_revenue_potential,

    -- avaliações
    l.review_scores_rating,
    l.number_of_reviews,
    l.host_is_superhost,

    -- dados de ocupação e receita (do calendar)
    c.total_days,
    c.booked_days,
    c.occupancy_rate,
    c.total_revenue,
    c.avg_price as avg_price_calendar,
    c.revpar

from listings l
left join calendar c on l.id = c.listing_id