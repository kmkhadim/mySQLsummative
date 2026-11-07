

-- ==========================================
-- PART C: G1432240 SQL QUERIES
-- ==========================================



-- QUERY 1: AGGREGATE QUERY
-- ==========================================

USE CrownfieldEyeHospital;

-- Question: On which dates were at least two appointments scheduled, and how many were recorded?

SELECT
    AppointmentDate,
    COUNT(AppointmentID) AS TotalAppointments
FROM Appointment
GROUP BY AppointmentDate
HAVING COUNT(AppointmentID) >= 2
ORDER BY AppointmentDate;



-- QUERY 2: INNER JOIN ACROSS FIVE TABLES
-- ==========================================

-- Question: Which medicines were prescribed to each patient, and what were their dosage, route, frequency
-- and treatment duration?

USE CrownfieldEyeHospital;

SHOW TABLES;


SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    pr.PrescriptionID,
    m.MedicineName,
    m.Strength,
    pi.Dosage,
    pi.Route,
    pi.Frequency,
    pi.Duration
FROM Patient AS p
INNER JOIN Appointment AS a
    ON p.PatientID = a.PatientID
INNER JOIN Prescription AS pr
    ON a.AppointmentID = pr.AppointmentID
INNER JOIN Prescription_Item AS pi
    ON pr.PrescriptionID = pi.PrescriptionID
INNER JOIN Medicine AS m
    ON pi.medicine_id = m.medicine_id
ORDER BY p.PatientID;

USE CrownfieldEyeHospital;

SELECT
    PrescriptionItemID,
    Dosage,
    Route,
    Frequency,
    Duration
FROM Prescription_Item;


SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    pr.PrescriptionID,
    m.MedicineName,
    pi.Duration,
    pi.Dosage,
    pi.Route,
    pi.Frequency
FROM Patient AS p
INNER JOIN Appointment AS a
    ON p.PatientID = a.PatientID
INNER JOIN Prescription AS pr
    ON a.AppointmentID = pr.AppointmentID
INNER JOIN Prescription_Item AS pi
    ON pr.PrescriptionID = pi.PrescriptionID
INNER JOIN Medicine AS m
    ON pi.medicine_id = m.medicine_id
ORDER BY p.PatientID;



-- QUERY 3: LEFT JOIN
-- ==================

-- Question: Which registered patients do not yet have an appointment?

-- Insert a temporary patient for testing

INSERT INTO Patient
    (PatientID, FirstName, LastName, Postcode)
VALUES
    (11, 'Test', 'Patient', 'ZZ1 1ZZ');

-- Verify the temporary patient

SELECT *
FROM Patient
WHERE PatientID = 11;


-- LEFT JOIN: Find patients without appointments

SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    a.AppointmentID,
    a.AppointmentDate
FROM Patient AS p
LEFT JOIN Appointment AS a
    ON p.PatientID = a.PatientID
WHERE a.AppointmentID IS NULL;

-- Deleting a temporary patient

DELETE FROM Patient WHERE PatientID = 11;

SELECT COUNT(*) AS TotalPatients FROM Patient;


-- QUERY 4: SUBQUERY USING IN
-- =============================

-- Question: Which patients have been prescribed medicines manufactured by Pharma C?


SELECT
    p.PatientID,
    p.FirstName,
    p.LastName,
    pr.PrescriptionID,
    m.MedicineName,
    m.Manufacturer
FROM Patient AS p
INNER JOIN Appointment AS a
    ON p.PatientID = a.PatientID
INNER JOIN Prescription AS pr
    ON a.AppointmentID = pr.AppointmentID
INNER JOIN Prescription_Item AS pi
    ON pr.PrescriptionID = pi.PrescriptionID
INNER JOIN Medicine AS m
    ON pi.medicine_id = m.medicine_id
WHERE pr.PrescriptionID IN
(
    SELECT pi.PrescriptionID
    FROM Prescription_Item AS pi
    INNER JOIN Medicine AS m
        ON pi.medicine_id = m.medicine_id
    WHERE m.Manufacturer = 'Pharma C'
);