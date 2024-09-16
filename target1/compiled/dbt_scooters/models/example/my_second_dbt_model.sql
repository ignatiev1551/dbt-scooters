-- Use the `ref` function to select from other models

select *
from "dev_bw2n"."dbt"."my_first_dbt_model"
where id = 1