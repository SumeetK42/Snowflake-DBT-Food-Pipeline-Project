{% macro handle_email(column_name) %}

case 
   when regexp_like( trim({{ column_name  }}),'([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+)\.(com)') then lower(trim({{ column_name  }}))
   else 'Not Available'
end 

{% endmacro %}