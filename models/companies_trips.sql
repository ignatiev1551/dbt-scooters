with
  company_stat_cte as(
    select
      m.company as company,
      count(t.*) as trips
      from {{ref("trips_prep")}} as t
      join {{ref("models")}} as m
      on t.scooter_hw_id=m.hardware_id
      group by m.company
  )
  select
    cs.company,
    cs.trips/cast(c.scooters as float) as trips_per_scooters
  from company_stat_cte as cs
  join {{ref("companies")}} as c
  using (company)