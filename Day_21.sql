-- SQLWithIDC - Day 21

/* Challenge:
   ---------
Create a comprehensive hospital performance dashboard using CTEs. Calculate: 
1) Service-level metrics (total admissions, refusals, avg satisfaction),
2) Staff metrics per service (total staff, avg weeks present),
3) Patient demographics per service (avg age, count). Then combine all three CTEs to create a final report
showing service name, all calculated metrics, and an overall performance score (weighted average of admission rate and satisfaction).
Order by performance score descending.
*/

with service_stats as(
select service,
       sum(patients_admitted) as total_admissions,
	   sum(patients_refused) as total_refusals,
	   avg(cast(patient_satisfaction as float)) as avg_satisfaction
from services_weekly
group by service),
staff_stats as(
select s.service,
       count(distinct s.staff_id) as total_staff,
	   avg(cast(ss.present as float)) as avg_weeks_present
from staff s
left join staff_schedule ss on s.staff_id=ss.staff_id
group by s.service),
patient_stats as(
select service,
       avg(cast(age as float)) as avg_age,
	   count(*) as total_patients
from patients
group by service)
select ss.service,
       ss.total_admissions,
	   ss.total_refusals,
	   ss.avg_satisfaction,
	   st.total_staff,
	   st.avg_weeks_present,
	   ps.avg_age,
	   ps.total_patients,
	   ((ss.avg_satisfaction*0.6)+(ss.total_admissions*1.0/(select max(total_admissions)from service_stats))*0.4) as performance_score
from service_stats ss
left join staff_stats st on ss.service=st.service
left join patient_stats ps on ss.service=ps.service
order by performance_score desc;

-----------------------------------------------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (SELECT service,
COUNT(*) AS total_patients,
AVG(satisfaction) AS avg_satisfaction
FROM patients
GROUP BY service)
SELECT *
FROM service_stats;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH admissions AS (SELECT service,
SUM(patients_admitted) AS total_admitted
FROM services_weekly
GROUP BY service),
refusals AS (
SELECT service,
SUM(patients_refused) AS total_refused
FROM services_weekly
GROUP BY service),
combined AS (
SELECT a.service, a.total_admitted, r.total_refused,
ROUND(
100.0 * a.total_admitted / (a.total_admitted + r.total_refused),2) 
AS admission_rate
FROM admissions a
JOIN refusals r ON a.service = r.service)
SELECT *
FROM combined;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_utilization AS (
SELECT
service,
COUNT(*) AS total_staff
FROM staff
GROUP BY service)
SELECT * FROM staff_utilization;