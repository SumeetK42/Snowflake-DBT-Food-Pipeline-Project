{% macro add_table_constraint(table_name,CNST) %}

{% for cst in CNST %}
{% do run_query("ALTER TABLE " ~ table_name ~ " ADD " ~ cst ) %}
{% endfor %}

{% endmacro %}