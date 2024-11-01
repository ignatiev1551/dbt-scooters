select
  *
from {{ref("events_clean")}} as ec
left join {{ref("event_types")}} as et
using (type_id)