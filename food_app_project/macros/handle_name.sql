{% macro handle_name(column_name) %}

case 
  when {{ column_name }}  is null then 'Not Available'
  else initcap(trim( {{ column_name }} )) 
end

{% endmacro %}