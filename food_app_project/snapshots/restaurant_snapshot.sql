{% snapshot restaurant_snapshot %}

{{
    config(
        unique_key='RESTAURANT_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('restaurant')}}

{% endsnapshot %}