{% macro add_table_fk_constraint(table_name,tab_key,fk_table,fk_key) %}

ALTER TABLE {{ table_name }} ADD FOREIGN KEY (  {{ tab_key }} ) REFERENCES {{ fk_table }} ({{ fk_key }})

{% endmacro %}