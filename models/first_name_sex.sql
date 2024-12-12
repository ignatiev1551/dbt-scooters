with fns_cte as(
select
   first_name,
   sex
from {{source('scooters_raw','users')}}
where sex is not null
group by 
  1,
  2
)
select
  id,
  first_name,
  last_name,
  fns_cte.sex,
  phone,
  birth_date
from {{source('scooters_raw','users')}}
left join fns_cte using(first_name)