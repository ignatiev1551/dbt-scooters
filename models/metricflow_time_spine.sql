with hours as (
    {{ dbt.date_spine(
        'hour',
        "date '2023-06-01'",
        "date '2023-08-31'") }}
),
final as (
    select cast(date_hour as timestamp) as date_hour
    from hours
)
select *
from final