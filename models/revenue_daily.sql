select
  sum(price_rub) as revenue_rub,
  "date",
  now() at time zone 'utc' as update_at
from {{ref("trips_prep")}}
{% if is_incremental %}
  where "date">=(select max("date")-INTERVAL '2' day from {{this}})
{% endif %}
group by "date", "update_at"
order by "date"