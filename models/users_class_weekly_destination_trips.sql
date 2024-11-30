with user_destination_trips_per_day_cte as (
     select
       user_id,
       st_reduceprecision(st_makepoint(finish_lon, finish_lat),0.001) as destination,
       "date",
       count(case when extract(hour from started_at at time zone 'Europe/Moscow') 
       between 6 and 10 then 1 end) as morning_trips
     from {{ref('trips_prep')}}
     group by
       1,
       2,
       3
),
user_destination_trips_per_week_cte as (
     select
       user_id,
       destination,
       date_trunc('week',"date") as "week",
       count(distinct case when morning_trips>0 then "date" end) as morning_trip_days
     from user_destination_trips_per_day_cte
     group by
       1,
       2,
       3
),
user_destination_avg_trips_per_week_cte as (
    select
      user_id,
      destination,
      avg(morning_trip_days) as avg_morning_trip_days
    from user_destination_trips_per_week_cte
    group by
      1,
      2
)
select
  user_id,
  max(avg_morning_trip_days)>=3 as to_work
from user_destination_avg_trips_per_week_cte
group by
  1