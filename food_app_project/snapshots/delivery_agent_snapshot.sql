{% snapshot delivery_agent_snapshot %}

{{
    config(
        unique_key='DELIVERYAGENT_ID',
        strategy='timestamp',
        updated_at='change_date',
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('delivery_agent')}}

{% endsnapshot %}