{% macro money(col) -%}
cast({{col}} as decimal(16,4))
{%- endmacro %}