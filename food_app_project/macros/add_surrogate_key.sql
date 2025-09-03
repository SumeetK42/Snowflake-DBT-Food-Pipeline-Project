{% macro add_surrograte_key(COL_1 , COL_2 , COL_3) %}

md5 ( {{  COL_1 }} || {{ COL_2 }} || {{ COL_3 }})

{% endmacro %}