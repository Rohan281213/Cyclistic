-- All tables merged and nulls and negative time removed, adding day of week
select *, DATENAME(weekday, started_at) as day_of_week into all_data_ff
from (
select *
from Cyclistic.dbo.['202101-divvy-tripdata$']
union all
select *
from Cyclistic.dbo.['202102-divvy-tripdata$']
union all
select *
from Cyclistic.dbo.['202103-divvy-tripdata$']
union all
select *
from Cyclistic.dbo.['202104-divvy-tripdata$']
union all
select *
from Cyclistic.dbo.['202105-divvy-tripdata$']

) a
WHERE start_station_name is not null and end_station_name is not null and minutes > 0 

-- Data Overview
SELECT *
FROM all_data_ff
order by minutes


--  Type of bikes preferred by members and casual riders (SCORING)

--casual riders score
select member_casual, rideable_type,
       count(member_casual) as number_of_rides,
       count(member_casual) * 100.0 / (select count(*) from  all_data_ff where member_casual = 'casual') as score
from all_data_ff
where member_casual = 'casual'
group by rideable_type, member_casual
order by member_casual

--members score
select member_casual, rideable_type,
       count(member_casual) as number_of_rides,
       count(member_casual) * 100.0 / (select count(*) from  all_data_ff where member_casual = 'member') as score
from all_data_ff where member_casual = 'member'
group by rideable_type, member_casual
order by member_casual



---------------------------------------------------------------------

-- Plot member vs casual riders duration of time
SELECT member_casual, minutes
FROM all_data_ff
ORDER BY minutes asc

--Average time used
Select member_casual, avg(minutes) as Average_Usage_time
From all_data_ff
group by member_casual

---------------------------------------------------------------------
-- Getting Day of the week
SELECT *, DATENAME(weekday, started_at) as day_of_week
FROM all_data_ff
order by minutes, start_station_name


---------------------------------------------------------------------
--number of bikes used per catergory per day

Select day_of_week, member_casual, count(member_casual) as Number_of_people
from all_data_ff
group by day_of_week, member_casual
order by day_of_week


--avg duration for bikes used per catergory per day

Select day_of_week, member_casual, avg(minutes) as Avg_time
from all_data_ff
group by day_of_week, member_casual
order by day_of_week
---------------------------------------------------------------------------