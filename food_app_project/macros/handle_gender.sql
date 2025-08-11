{% macro handle_gender(column_name) %}

case 
  when upper(trim( {{ column_name }})) in ('MALE','M')  then 'Male'
  when upper(trim( {{ column_name }})) in ('FEMALE','F')  then 'Female'
  else 'Not Available'
end

{% endmacro %}