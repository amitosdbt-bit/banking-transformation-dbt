with transactions as (
    -- Reading from our clean staging model using ref()
    select * from {{ ref('stg_transactions') }}
),

daily_summary as (
    select
        transaction_date,
        transaction_type,
        count(transaction_id) as total_transactions_count,
        sum(transaction_amount) as total_transaction_volume
    from transactions
    group by 1, 2
)

select * from daily_summary