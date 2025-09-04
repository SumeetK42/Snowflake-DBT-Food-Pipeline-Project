{% macro handle_is_current(col) %}

case 
  when {{ col }} is null then 1
  else 0
end  

{% endmacro %}