-- SQLWithIDC Day 16

/* Challenge:
   ---------
Find all patients who were admitted to services that had at least one week where patients were refused 
AND the average patient satisfaction for that service was below the overall hospital average satisfaction. 
Show patient_id, name, service, and their personal satisfaction score.
*/

select 
     p.patient_id,
	 p.name,
	 p.service,
	 p.satisfaction
from patients p
where p.service in 
(select sw.service from services_weekly sw
where sw.patients_refused > 0
group by sw.service
having avg(sw.patient_satisfaction)<(select avg(patient_satisfaction) from services_weekly));

----------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Find patients who are in services with above-average staff count.
select p.patient_id,p.name,p.service from patients p where p.service in
(select service from staff group by service having count(*)>(select avg(staff_count)
from (select count(*) as staff_count from staff group by service)t));

-- 2. List staff who work in services that had any week with patient satisfaction below 70.
select staff_id,staff_name,service from staff where service in
(select distinct service from services_weekly where patient_satisfaction<70);

-- 3. Show patients from services where total admitted patients exceed 1000.
select patient_id,name,age,service from patients where service in
(select service from services_weekly group by service having sum(patients_admitted)>1000);



