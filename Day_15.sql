-- SQLWithIDC - Day 15

/* Challenge:
   ---------
Create a comprehensive service analysis report for week 20 showing: service name, 
total patients admitted that week, total patients refused, average patient satisfaction, 
count of staff assigned to service, and count of staff present that week. Order by patients admitted descending.
*/

SELECT
    sw.service,
    SUM(sw.patients_admitted) AS patients_admitted,
	SUM(sw.patients_refused) AS patients_refused,
	ROUND(AVG(patient_satisfaction),2) AS avg_patient_satisfaction,
    COUNT(DISTINCT s.staff_id) AS total_staff,
    SUM(CASE WHEN ss.present = 1 THEN 1 ELSE 0 END) AS staff_present
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss
    ON (s.staff_id = ss.staff_id AND sw.week = ss.week)
WHERE sw.week = 20
GROUP BY sw.service
ORDER BY SUM(sw.patients_admitted) DESC;

---------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
select 
    p.patient_id,
	p.name,
	p.service,
	count(distinct s.staff_id) as total_staff,
	sum(ss.present) as staff_present
from patients p left join staff s on p.service=s.service left join staff_schedule ss on s.staff_id=ss.staff_id
group by p.patient_id,p.name,p.service 
order by p.name;


-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
select
    sw.service,
	sw.week,
    sw.patients_admitted,
	sw.patients_refused,
	round(avg(patient_satisfaction),2) as avg_patient_satisfaction,
    count(distinct s.staff_id) as total_staff,
    sum(case when ss.present = 1 then 1 else 0 end) as staff_present
from services_weekly sw
left join staff s on sw.service = s.service
left join staff_schedule ss
    on (s.staff_id = ss.staff_id and sw.week = ss.week)
group by sw.service, sw.week, sw.patients_admitted, sw.patients_refused
order by sw.service,sw.week;


-- 3. Create a multi-table report showing patient admissions with staff information.
select 
	p.name,
	p.service,
	p.arrival_date,
	s.staff_name,
	s.role,
	sum(case when ss.present = 1 then 1 else 0 end) as staff_present
from patients p left join staff s on p.service=s.service left join staff_schedule ss on s.staff_id=ss.staff_id
group by p.name,p.age,p.service,p.arrival_date,s.staff_name,s.role
order by p.name;
	
	


