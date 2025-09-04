{% snapshot restaurant_location_snapshot %}

{{
    config(
        unique_key='LOCATION_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('restaurant_location')}}

{% endsnapshot %}