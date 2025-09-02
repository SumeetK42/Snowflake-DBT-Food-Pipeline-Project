{% snapshot orders_snapshot %}

{{
    config(
        unique_key='ORDER_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('orders')}}

{% endsnapshot %}