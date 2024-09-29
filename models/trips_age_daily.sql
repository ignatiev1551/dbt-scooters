with
    date_age_cte as (
        select
            pt.*,
            extract(year from pt.started_at) - extract(year from u.birth_date) as age
        from {{ ref("trips_prep") }} as pt
        inner join {{ source("scooters_raw", "users") }} as u on pt.id = u.id
    )
select date, age, count(*) as trips, sum(price_rub) as revenue_rub
from date_age_cte
group by date, age