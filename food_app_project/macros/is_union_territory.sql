{% macro is_union_territory(column_name) %}

case 
  WHEN {{ column_name }} IN ('Delhi', 'Chandigarh', 'Puducherry', 'Jammu and Kashmir') THEN 'Y'
  ELSE 'N'
end    

{% endmacro %}