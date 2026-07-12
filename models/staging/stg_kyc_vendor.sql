with source as (
    select * from {{ source('raw_banking', 'raw_kyc_vendor') }}
),

flattened_avro as (
    select
        raw_avro:customer_id::varchar as customer_id,
        raw_avro:kyc_status::varchar as kyc_status,
        raw_avro:risk_tier::int as risk_tier,
        ingestion_timestamp
    from source
)

select * from flattened_avro