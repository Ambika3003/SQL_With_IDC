-- SQLWithIDC - Capstone Project
-- SQL Murder Mystery: “Who Killed the CEO?”

-- Investigation Steps / Questions:

-- 1. Identify where and when the crime happened
SELECT 
    room AS crime_location,
    entry_time AS crime_time
FROM keycard_logs
WHERE room = 'CEO Office'
AND entry_time <= '2025-10-15 21:00:00' AND exit_time >= '2025-10-15 21:00:00';

-- 2. Analyze who accessed critical areas at the time
SELECT 
    kl.employee_id,
    e.name,
    kl.log_id,
    kl.room,
    kl.entry_time,
    kl.exit_time
FROM keycard_logs kl
JOIN employees e ON kl.employee_id = e.employee_id
WHERE kl.room = 'CEO Office' and kl.entry_time between '2025-10-15 20:00:00' and '2025-10-15 21:00:00'
ORDER BY kl.entry_time;

-- 3. Cross-check alibis with actual logs
SELECT 
  a.alibi_id,
  a.employee_id,
  emp.name,
  a.claimed_location,
  a.claim_time,
  kl.room AS actual_room,
  kl.entry_time,
  kl.exit_time,
  CASE 
    WHEN kl.room IS NULL THEN 'no_log_available'
    WHEN LOWER(TRIM(kl.room)) = LOWER(TRIM(a.claimed_location)) THEN 'match'
    ELSE 'mismatch'
  END AS alibi_check
FROM alibis a
JOIN employees emp ON a.employee_id = emp.employee_id
LEFT JOIN keycard_logs kl ON a.employee_id = kl.employee_id
  AND a.claim_time BETWEEN kl.entry_time AND kl.exit_time
ORDER BY a.claim_time;

-- 4. Investigate suspicious calls made around the time
SELECT 
    c.call_id,
    c.caller_id,
    emp1.name AS caller_name,
    c.receiver_id,
    emp2.name AS receiver_name,
    c.call_time,
    c.duration_sec
FROM calls c
LEFT JOIN employees emp1 ON c.caller_id = emp1.employee_id
LEFT JOIN employees emp2 ON c.receiver_id = emp2.employee_id
WHERE c.call_time BETWEEN '2025-10-15 20:00:00' AND '2025-10-15 21:00:00'
ORDER BY c.call_time DESC;

-- 5. Match evidence with movements and claims
SELECT
    ev.evidence_id,
    ev.room AS evidence_room,
    ev.description,
    ev.found_time::TIME,
	e.name,
    kl.room AS actual_location,
    kl.entry_time::TIME,
    a.claimed_location,
    a.claim_time::TIME,
    CASE 
        WHEN a.claimed_location IS NULL THEN 'not available'
        WHEN a.claimed_location = kl.room THEN 'match'
        ELSE 'mismatch'
    END AS Alibi_status
FROM evidence ev
JOIN keycard_logs kl ON ev.room = kl.room
JOIN employees e ON kl.employee_id = e.employee_id
LEFT JOIN alibis a ON e.employee_id = a.employee_id;

-- 6. Combine all findings to identify the killer
SELECT 
    e.employee_id,
    e.name,
    kl.room AS actual_location,
    kl.entry_time,
    kl.exit_time,
    a.claimed_location,
    a.claim_time,
    CASE
        WHEN a.claimed_location != kl.room AND a.claim_time BETWEEN kl.entry_time AND kl.exit_time
        THEN 'Alibi FALSE'
        ELSE 'Alibi TRUE'
    END AS alibi_verification,
    ev.room AS evidence_room,
    ev.description AS evidence_description,
    ev.found_time AS evidence_found_time
FROM employees e
LEFT JOIN keycard_logs kl ON e.employee_id = kl.employee_id
LEFT JOIN alibis a ON e.employee_id = a.employee_id
LEFT JOIN evidence ev ON kl.room = ev.room
WHERE kl.entry_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:30:00'
ORDER BY e.name;

-----------------------------------------------------------------------------------------------------------------

-- A final “Case Solved” query that reveals the killer in below single column table format:

WITH office_visitors AS (
    SELECT DISTINCT kl.employee_id
    FROM keycard_logs kl
    WHERE kl.room ILIKE '%CEO%'
      AND kl.entry_time <= '2025-10-15 21:00:00'
      AND kl.exit_time  >= '2025-10-15 21:00:00'),
alibi_mismatch AS (
    SELECT a.employee_id
    FROM alibis a
    LEFT JOIN keycard_logs kl ON a.employee_id = kl.employee_id
     AND a.claim_time BETWEEN kl.entry_time AND kl.exit_time
    WHERE kl.room IS NULL OR LOWER(TRIM(kl.room)) <> LOWER(TRIM(a.claimed_location))),
call_activity AS (
    SELECT DISTINCT caller_id AS employee_id FROM calls
    WHERE call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00'
    UNION
    SELECT DISTINCT receiver_id AS employee_id FROM calls
    WHERE call_time BETWEEN '2025-10-15 20:50:00' AND '2025-10-15 21:00:00')
SELECT e.name AS killer
FROM employees e
JOIN office_visitors ov ON e.employee_id = ov.employee_id
JOIN alibi_mismatch am ON e.employee_id = am.employee_id
JOIN call_activity ca ON e.employee_id = ca.employee_id;
