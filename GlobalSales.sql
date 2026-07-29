/* 1.Create database Pharmacy*/
Select
Globalsales.Unit_price,
Globalsales.Units_sold
from Globalsales

/* 2.Calculate Sales*/
select
Globalsales.Unit_price,
Globalsales.Units_sold,
round(Globalsales.Unit_price*Globalsales.Units_sold,2)as Sales
from Globalsales

/*3.Calculate total Sales */

Select
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) as Total_Sales
From Globalsales

/*4   total sales by Years*/
Select
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) as Total_Sales_year
From Globalsales
Group by Globalsales.Year

/*5 Year over Year Sales*/
select*,
Current_Year_sales-Previous_year as Year_over_Year
from(
Select
Globalsales.Year,
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) as Current_year_sales,
Lag(sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)),1)over(order by Globalsales.Year) as Previous_year
from Globalsales
Group by Globalsales.Year 
)t

/*6 Extract month name and calculate Sales by month For seperate Years from Date */
select
Year,Datename(Month,Globalsales.Date) as Month,
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) Over(partition by GlobalSales.Year Order by Globalsales.Unit_price*Globalsales.Units_sold ) as Total_Sales_Month
From Globalsales

/*7Ctegory wise Sales*/
Select 
Category,
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) As Categorywise_Sales
from Globalsales
Group by Category


/*8 Top region as per Sales*/
Select top 1
Region,
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) as Top_sales_region
from Globalsales
Group by Region
order by Top_sales_region  desc
/*9 Country wise Sales*/
select
Country,
sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) CountryWise_Total_sales
from Globalsales
Group by Country

/*10Which Category give the highest sales in Non Covid conditions*/
SELECT TOP 1
 Category,
 sum(round(Globalsales.Unit_price*Globalsales.Units_sold,2)) Total_sales
 from Globalsales
 where Covid_flag=0
 group by Category
 order by Total_sales desc
 
 /* 11 Country wise covid cases */

 select
 Country,
 Count(Globalsales.Covid_flag) as CovidCase
 from Globalsales
 Where Globalsales.Covid_flag=1
 group by Country 
 order by CovidCase

 




