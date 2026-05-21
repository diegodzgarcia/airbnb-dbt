{{ config(materialized='view') }}

with listings as (

    select * from {{ ref('stg_listings') }}

)

select
    id,
    name,
    neighbourhood,
    room_type,
    property_type,

    accommodates,
    price,
    minimum_nights,

    -- receita mínima potencial
    price * minimum_nights as min_revenue_potential,

    -- classificação de preço
    case 
        when price < 100 then 'low'
        when price between 100 and 300 then 'medium'
        else 'high'
    end as price_category,

    -- classificação de capacidade
    case
        when accommodates <= 2 then 'small'
        when accommodates <= 4 then 'medium'
        else 'large'
    end as size_category,

    review_scores_rating,
    number_of_reviews,

    host_is_superhost

from listings