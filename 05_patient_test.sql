USE CrownfieldEyeHospital;

SELECT * FROM Appointment;

SELECT * FROM Diagnosis;

UPDATE Appointment
SET AppointmentDate = AppointmentDate
WHERE AppointmentID = -1;

INSERT INTO Appointment (AppointmentID)
VALUES (999);