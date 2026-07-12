with source as (
    -- Using the dbt source macro to dynamically reference our Snowflake table
    select * from {{ source('raw_banking', 'raw_transactions') }}
),

renamed_and_cast as (
    select
        -- Standardizing column names and ensuring data types are correct
        txn_id::varchar as transaction_id,
        account_id::varchar as account_id,
        amount::number(10,2) as transaction_amount,
        txn_type::varchar as transaction_type,
        txn_date::date as transaction_date,
        ingestion_timestamp
    from source
)

select * from renamed_and_cast