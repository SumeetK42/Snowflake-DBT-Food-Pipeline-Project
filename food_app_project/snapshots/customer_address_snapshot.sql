{% snapshot customer_address_snapshot %}

{{
    config(
        unique_key='ADDRESS_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('customer_address')}}

{% endsnapshot %}