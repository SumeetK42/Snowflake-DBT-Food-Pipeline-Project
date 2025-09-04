{% snapshot customer_snapshot %}

{{
    config(
        unique_key='CUSTOMER_ID',
        strategy='timestamp',
        updated_at='CHANGE_DATE',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('customer') }}

{% endsnapshot %}