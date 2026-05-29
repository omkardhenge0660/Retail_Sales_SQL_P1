#---sql retail sales analysis project 

#---create a database 

create database sql_project_1;

use sql_project_1; 

#---create table and import data in table 

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(20),
    age INT ,
    category VARCHAR(50),
    quantiy INT ,
    price_per_unit float,
    cogs float,
    total_sale float
);

select * from retail_sales;

#count the data 

select 
     count(*)
            from retail_sales;
#cleaning the null value 
select * from retail_sales
where 
	 transactions_id is null
     or 
     sale_date is null
     or 
     sale_time is null
     or 
     customer_id is  null 
     or 
     gender is null
     or 
     age is null
     or 
     category is null
     or 
     quantiy is null
     or 
     price_per_unit is null
     or 
     cogs is null
     or 
     total_sale is null ;
     
#---data exploration-- 

#---how many sales we have?
select count(*) as total_sales
from retail_sales;
                  
#--- how many unique customer we have ?
select count(distinct customer_id ) as total_sales
from retail_sales;

#---what are the sales category?   
select distinct category from retail_sales;
			
#--Data analysis and business key problem-- 
#--Alaysis and Findings

#--write a sql query tp retrieve all columns fro sales made on '2022-11-05'

select * from retail_sales
where sale_date = '2022-11-05';
 
#--write a sql query to retrieve all transaction where the category is 'clothing' and the quantity sold is more than 4 in the month of nov-2022-- 

select *  
from retail_sales
where category = 'clothing'
and date_format(sale_date, '%Y-%m') = '2022-11'
and quantiy >= 4;

#--write a sql query to calculate the total sales(total_sales) and the total order for each category--

select category ,
sum(total_sale) as net_sales,
count(*)as total_orders
from retail_sales
group by 1;

#--write a sql query to find the average age of customers who purchased items from the 'Beauty' category--

select avg(age) as avg_age from retail_sales
where category = 'beauty';

#--write a sql query to find all transaction where the total_sales are greater than 1000--
select * from retail_sales
where total_sale >= 1000;

#--write a sql query to find the total number of transactions (transaction_id) made by each grender by each category--
select 
gender,category,
count(*) transations_id 
from retail_sales
group by 
gender,category
order by 1;
  
#--write a sql query to calculate the average sale for each month. find out best selling month in each year very imp one -- 
select * from
  (
    select 
	      year(sale_date) as Year,
          month(sale_date) as Month,
          avg(total_sale) as Avg_sale,
          rank() over(partition by Year(sale_date) order by Avg(total_sale) desc) as sale_rank
          from retail_sales
          group by Year(sale_date),Month(sale_date)
	)as t1
    where sale_rank = 1;
#--write a sql query to find the top 5 customers based on the highest total sales--
select
	customer_id,
    sum(total_sale) as total_sales
from retail_sales
group by 1
order by 2 desc
limit 5;

#--write a sql query to find the number of unique customers who purchased items from each category.
select
     category,
     count(distinct customer_id) as unique_cus_id
     from retail_sales
     group by 1;

#--write a sql query to create each shift and number of orders (example moring <=12 , afternoon between 12 and 17 ,evening>17)--
 
 with hourly_sales
 as
 (
select *,
		case
			when extract(hour from sale_time) < 12 then "morning"
            when extract(hour from sale_time) between 12 and 17 then "afternoon"
            else"evening"
            end as shift_time
from retail_sales
)
select
	shift_time,
    count(*) as total_order
from hourly_sales
group by shift_time;

#-- END--.



            


     
            