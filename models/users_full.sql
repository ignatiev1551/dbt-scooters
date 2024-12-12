with fns_cte as (
  select
    id,
    first_name,
    last_name,
    fns.sex as l_sex,
    sn.sex as r_sex,
    phone,
    birth_date
  from {{ref('first_name_sex')}} as fns
  left join {{ref('sex_name')}} as sn
  using(first_name)  
)
select
  id,
  first_name,
  last_name,
  coalesce(l_sex,r_sex) as sex,
  phone,
  birth_date
from fns_cte