{% macro add_audit_columns() %}
 current_timestamp as create_date,
 'admin' as create_user,
 current_timestamp as change_date,
 'admin' as change_user
{% endmacro %}