-- SQLWithIDC - Day 14

/* Challenge:
   ---------
Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service)
and the count of weeks they were present (from staff_schedule). Include staff members even if they 
have no schedule records. Order by weeks present descending.
*/

select s.*,sum(ss.present) as weeks_present
from staff s left join staff_schedule ss on s.staff_id=ss.staff_id
group by s.staff_id,s.staff_name,s.role,s.service
order by weeks_present desc

-------------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Show all staff members and their schedule information (including those with no schedule entries).
select s.*,count(ss.week) as week_count,sum(ss.present) as weeks_present
from staff s left join staff_schedule ss on s.staff_id=ss.staff_id
group by s.staff_id,s.staff_name,s.role,s.service;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).
select distinct sw.service,s.staff_id,s.staff_name,s.role
from services_weekly sw left join staff s on sw.service=s.service

-- 3. Display all patients and their service's weekly statistics (if available).
select p.*,sw.week,sw.patients_request,sw.patients_admitted,sw.patient_satisfaction
from patients p left join services_weekly sw on p.service=sw.service
order by p.patient_id,week;

