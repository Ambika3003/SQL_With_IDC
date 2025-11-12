-- SQLWithIDC - Day 9

/* Challenge:
   ----------

Calculate the average length of stay (in days) for each service, showing only services where 
the average stay is more than 7 days. Also show the count of patients and order by average stay
descending.
*/

select service, 
       round(avg((departure_date - arrival_date)),2) as avg_stay,
	   count(patient_id) as total_patients
from patients 
group by service
having round(avg((departure_date - arrival_date)),2)>7
order by avg_stay desc;

-------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Extract the year from all patient arrival dates.
select patient_id,name,extract(year from arrival_date) as arrival_year from patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).
select patient_id,name,(departure_date - arrival_date) as stay_length from patients;

-- 3. Find all patients who arrived in a specific month.
select * from patients where extract(month from arrival_date) = 05 order by arrival_date;

-------------------------------------------------------------------------------------------

-- NOTES:
-- To extract value from a single date
select extract(month from date '2025-07-01');

-- To extract values from a column
select extract(month from arrival_date) from patients; -- it return the month as an integer

