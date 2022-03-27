{% macro event_type() %}
{{ return(["page_view", "add_to_cart", "checkout", "package_shipped"]) }}
{% endmacro %}