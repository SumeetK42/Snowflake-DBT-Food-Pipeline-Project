{% snapshot order_items_snapshot %}

{{
    config(
        unique_key='ORDER_ITEM_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('order_items')}}

{% endsnapshot %}