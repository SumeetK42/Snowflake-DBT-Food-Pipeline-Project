{% snapshot menu_snapshot %}

{{
    config(
        unique_key='MENU_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('menu')}}

{% endsnapshot %}