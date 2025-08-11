{% macro add_table_pk_constraint(table_name,column_name) %}

ALTER TABLE {{ table_name }} ADD PRIMARY KEY (  {{ column_name }} ) 

{% endmacro %}