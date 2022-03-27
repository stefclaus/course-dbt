{% macro event_types() %}
{%- set event_types = ["page_view", "add_to_cart", "checkout", "package_shipped"] -%}

{%- for event_type in event_types %}
    MAX(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_present
{%- if not loop.last %},{% endif -%}
{% endfor %}

{% endmacro %}