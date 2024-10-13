select 
  tp.*,
  u.sex as sex,
  extract(year from tp.started_at) - extract(year from u.birth_date) as age
from {{ref('trips_prep')}} as tp
left join {{source('scooters_raw','users')}} as u on tp.user_id=u.id
{% if is_incremental() %}
  where
    tp.id>(select max(id) from {{this}})
  order by tp.id
  limit 75000
{% else %}
  where
    tp.id<=75000
{% endif %}  