with source as (
    select * from {{ source('raw_banking', 'raw_mobile_telemetry') }}
),

flattened_parquet as (
    select
        raw_parquet:session_id::varchar as session_id,
        raw_parquet:os::varchar as operating_system,
        raw_parquet:button_clicked::varchar as action_type,
        raw_parquet:timestamp::timestamp_ntz as event_timestamp,
        ingestion_timestamp
    from source
)

select * from flattened_parquet