{% macro handle_phone_number(column_name) %}

case
  when
   regexp_like( cast (trim(replace({{column_name}},'+','')) as number(12,0)),'[0-9]{10,}' ) then trunc(right( {{ column_name }} ,10))
  else 0
end  

{% endmacro %}