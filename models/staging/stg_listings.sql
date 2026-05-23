{{ config(materialized='view') }}
with source as (
    select * from {{ source('airbnb_raw', 'listings') }}
),
cleaned as (
    select
        id,
        name,
        neighbourhood_cleansed as neighbourhood,
        latitude,
        longitude,
        property_type,
        room_type,
        accommodates,
        cast(price as float64) as price,
        minimum_nights,
        maximum_nights,
        availability_30,
        availability_365,
        number_of_reviews,
        review_scores_rating,
        host_id,
        host_is_superhost
    from source
)
select * from cleaned
where price is not null
  and price > 0