with source as (
    select * from {{ source('raw_banking', 'raw_insurance_claims') }}
),

flattened_xml as (
    select
        -- Extracting the text value ('$') from inside the specific XML tags
        GET(XMLGET(raw_xml, 'ClaimID'), '$')::varchar as claim_id,
        GET(XMLGET(raw_xml, 'PolicyType'), '$')::varchar as policy_type,
        GET(XMLGET(raw_xml, 'Status'), '$')::varchar as claim_status,
        ingestion_timestamp
    from source
)

select * from flattened_xml