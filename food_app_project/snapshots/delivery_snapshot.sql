{% snapshot delivery_snapshot %}

{{
    config(
        unique_key='DELIVERY_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('delivery')}}

{% endsnapshot %}