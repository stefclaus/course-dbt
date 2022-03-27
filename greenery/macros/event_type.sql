{% set event_types = ["page_view", "add_to_cart", "checkout", "package_shipped"]%}

for 
    session_guid
    {% for event_type in event_type %},
    MAX(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present,
{% endfor %}
GROUP BY session_guid


