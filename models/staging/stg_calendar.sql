{{ config(materialized='view') }}

with source as (

    select * from {{ source('airbnb_raw', 'calendar') }}

)

select
    listing_id,
    
    date,

    -- já é boolean
    available,

    -- já está limpo
    cast(price as float64) as price,

    minimum_nights,
    maximum_nights

from source