{{
    config(
        materialized = 'table',
    )
}}

with days as (

    {{
        dbt_utils.date_spine(
            'day',
            "DATE(2000,1,1)",
            "DATE(2027,1,1)"
        )
    }}

),

final as (
    select cast(date_day as date) as date_day
    from days
)

select * from final
