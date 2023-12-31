with customers as (

    select *
    from {{ ref('bigquery_demo_project','dim_customers', v=1) }}

), orders as (

    select *
    from {{ ref('bigquery_demo_project','fct_orders') }}

), join__source_data as (

    select 
        {{ dbt_utils.generate_surrogate_key(['order_date', 'region', 'nation', 'market_segment', 'status_code', ]) }} as id,
        orders.order_date,
        customers.region,
        customers.nation,
        customers.market_segment,
        orders.status_code,
        sum(order_count) as order_count,
        sum(net_item_sales_amount) as net_item_sales_amount
    from customers
    inner join orders 
        on orders.customer_key = customers.customer_key
    {{ dbt_utils.group_by(6) }}

)

select *
from join__source_data