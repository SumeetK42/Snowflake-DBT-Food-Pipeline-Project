{% macro add_audit_columns() %}
 current_date as create_date,
 'admin' as create_user,
 current_date as change_date,
 'admin' as change_user
{% endmacro %}