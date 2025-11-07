-- SQLWithIDC - Day 5 

/* Challenge: 
Calculate the total number of patients admitted, total patients refused, and the average patient
satisfaction across all services and weeks. Round the average satisfaction to 2 decimal places.
*/

select sum(patients_admitted) as Total_patients_admitted,
       sum(patients_refused) as Total_patients_refused,
	   round(avg(patient_satisfaction),2) as average_patients_satifaction
from services_weekly;

-------------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Count the total number of patients in the hospital.
select count(*) as total_patients from patients;

-- 2. Calculate the average satisfaction score of all patients.
select avg(satisfaction) as average_satisfaction_score from patients;

-- 3. Find the minimum and maximum age of patients.
select min(age) as minimum_age,max(age) as maximum_age from patients;

	   


