-- SQLWithIDC - Day 18

/* Challenge:
   ---------
Create a comprehensive personnel and patient list showing: identifier (patient_id or staff_id), full name,
type ('Patient' or 'Staff'), and associated service. Include only those in 'surgery' or 'emergency' services. 
Order by type, then service, then name.
*/

select patient_id as identifier,name as full_name,'patient' as type,service from patients where service in('surgery','emergency')
union all
select staff_id as identifier,staff_name as full_name,'staff' as type,service from staff where service in('surgery','emergency')
order by type,service,full_name;

----------------------------------------------------------------------------------------------------------------------------------

-- Practice Questions:

-- 1. Combine patient names and staff names into a single list.
select name as full_name,'patient' as type from patients
union all
select staff_name as full_name,'staff' as type from staff;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
select patient_id,age,name,'high satifaction' as category from patients where satisfaction>90
union all
select patient_id,age,name,'low satifaction' as category from patients where satisfaction<50;

-- 3. List all unique names from both patients and staff tables.
select name as full_name from patients union select staff_name as full_name from staff;