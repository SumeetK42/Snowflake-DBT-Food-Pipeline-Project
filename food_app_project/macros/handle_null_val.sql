{% macro handle_null_val(col) %}

case 
  when upper(trim({{ col }})) = upper({{ col }}) then NVL({{ col }},'Not Available')
  else NVL( trim({{ col }}),'Not Available')
end

{% endmacro %}