{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshot_layer'
        unique_key='ADDRESS_ID'
        statergy='timestamp'
        updated_by='change_date'
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('customer_address')}}

{% endsnapshot %}