{% macro handle_column_date(date_col,format='YYYY-MM-DD') %}

nvl(try_to_date( trim( {{ date_col }} ) , '{{ format }}' ),current_date)


{% endmacro %}