----------------------------------------
-- Ola Rides Analysis Project
-----------------------------------------

-- Creating database
create database ola;
------------------------------------------

-- using database
use ola;
------------------------------------------

-- Importing table from table wizrd
----------------------------------------

-- Analysis
------------------------------------------

-- 1. Retrive all successfull bookings

Create view Successfull_Bookings as
Select 
* 
from bookings
where Booking_Status = 'Success'; 

Select * from Successfull_Bookings;
-------------------------------------------

-- 2.Find the average ride distance for each vechile type

Create view Ride_Distance_for_Each_Vechile as
Select 
	Vehicle_Type, 
	round(avg(Ride_Distance),2) as Avg_distance
from bookings
group by Vehicle_Type;

Select * from Ride_Distance_for_Each_Vechile;
-------------------------------------------

-- 3. Get the total no of rides cancelled by customers

Select 
	count(*) as Rides_Cancelled_by_Customers
from bookings
where Booking_Status = 'Canceled by Customer';
-------------------------------------------------

-- 4.List the top 5 customers who booked the highest no of rides
Select
	Customer_ID,
    count(*) as Total_Rides
from Bookings
group by Customer_ID
order by count(*) desc
limit 5;
-----------------------------------------------------

-- 5.Get the number of rides canceled by drivers due to personal and car related issues
select
	count(*) as No_of_Rides
from bookings
where Canceled_Rides_by_Driver = 'Personal & Car related issue';
-------------------------------------------------------

-- 6.FInd the max and min driver rating for prime sedan booking
Select
	Vehicle_Type,
    max(Driver_Ratings) as Max_Rating,
    min(Driver_Ratings) as Min_Rating
from bookings
where Vehicle_Type = 'Prime Sedan'
group by Vehicle_Type;
---------------------------------------------------------

-- 7.Retrive all the rides where payment was made using upi
Create view Rides_with_UPI as 
Select 
	*
from bookings
where Payment_Method = 'UPI';

Select * from Rides_with_UPI;
----------------------------------------------------------

-- 8.Find the avg customer rating per vechile type
Create view Customer_Rating_by_Vechile as 
Select 
	Vehicle_Type,
    round(avg(Customer_Rating),2) as Avg_Rating
from bookings
group by Vehicle_Type
order by 2 desc;

Select * from Customer_Rating_by_Vechile;
-----------------------------------------------------------

-- 9. Calculate the total booking value of rides completed successfully
Create view Total_booking_Value as 
Select 
	round(sum(Booking_Value),2) as Total_Value
from Successfull_Bookings;

Select * from Total_booking_Value;
-------------------------------------------------------------

-- 10. List all incomplte rides along with the reason
Create view incomplete_ride_reason as 
Select 
	Booking_Status,
    ifnull(Canceled_Rides_by_Customer, 'None') as Reason_from_Customer,
    ifnull(Canceled_Rides_by_Driver, 'None') as Reason_from_Driver
from bookings
where Booking_Status != 'Success';

Select * from incomplete_ride_reason;



