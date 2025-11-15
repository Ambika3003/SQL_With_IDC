-- SQLWithIDC - Day 12

/* Challenge:
   ---------
Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction,
and average staff morale. Order by average patient satisfaction descending.
*/

select case
         when event='none' or event is null then 'no event'
         else 'with event'
       end as event_status,
       count(week) as week_count,
       round(avg(patient_satisfaction),2) as avg_patient_satisfaction,
       round(avg(staff_morale),2) as avg_staff_morale
from services_weekly
group by event_status
order by avg_patient_satisfaction desc;

------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Find all weeks in services_weekly where no special event occurred.
select distinct week from services_weekly where event='none';

-- 2. Count how many records have null or empty event values.
select count(*) as records from services_weekly where event is null or event='';

-- 3. List all services that had at least one week with a special event.
select service from services_weekly where event!='none' group by service having count(week)>=1;
