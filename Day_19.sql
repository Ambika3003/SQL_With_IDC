-- SQLWithIDC - Day 19

/* Challenge:
   ---------
For each service, rank the weeks by patient satisfaction score (highest first). Show service, week, 
patient_satisfaction, patients_admitted, and the rank. Include only the top 3 weeks per service.
*/

select * from
(select service,
        week,
		patient_satisfaction,
		patients_admitted,
		rank() over(partition by service order by patient_satisfaction desc) as week_rank
		from services_weekly) x
where week_rank<=3;

------------------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. 1. Rank patients by satisfaction score within each service.
select patient_id,name,satisfaction,rank() over(partition by service order by satisfaction desc) 
from patients;

-- 2. Assign row numbers to staff ordered by their name.
select *,row_number() over(order by staff_name) from staff;

-- 3. Rank services by total patients admitted.
select service,sum(patients_admitted) as total_admission,rank() over(order by sum(patients_admitted) desc) 
from services_weekly group by service;