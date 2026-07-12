with source as (
    select * from {{ source('raw_banking', 'raw_cc_events') }}
),

flattened_json as (
    select
        -- Extracting JSON keys and casting them to strict data types
        raw_json:event_id::varchar as event_id,
        raw_json:card_suffix::varchar as card_suffix,
        raw_json:merchant::varchar as merchant_name,
        raw_json:fraud_score::float as fraud_risk_score,
        ingestion_timestamp
    from source
)

select * from flattened_json