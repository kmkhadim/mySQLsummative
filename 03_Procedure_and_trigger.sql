
-- ================================
-- PART C: G1432240 SQL QUERIES
-- ================================


-- QUERY 5: STORED PROCEDURE WITH INPUT PARAMETER
-- ===============================================

USE CrownfieldEyeHospital;

CREATE PROCEDURE GetPrescriptionDetails(
    IN p_PrescriptionID INT
)
SELECT
    pr.PrescriptionID,
    m.MedicineName,
    m.Strength,
    m.Manufacturer,
    pi.Dosage,
    pi.Route,
    pi.Frequency,
    pi.Duration
FROM Prescription AS pr
INNER JOIN Prescription_Item AS pi
    ON pr.PrescriptionID = pi.PrescriptionID
INNER JOIN Medicine AS m
    ON pi.medicine_id = m.medicine_id
WHERE pr.PrescriptionID = p_PrescriptionID;

USE CrownfieldEyeHospital;

SHOW PROCEDURE STATUS WHERE Db = 'CrownfieldEyeHospital' AND Name = 'GetPrescriptionDetails';

CALL GetPrescriptionDetails(3);


-- QUERY 6: Trigger to Prevent duplicate medicines in one prescription
-- ====================================================================

USE CrownfieldEyeHospital;

DELIMITER //

CREATE TRIGGER PreventDuplicateMedicine
BEFORE INSERT ON Prescription_Item
FOR EACH ROW
BEGIN
    DECLARE duplicate_count INT DEFAULT 0;

    SELECT COUNT(*)
    INTO duplicate_count
    FROM Prescription_Item
    WHERE PrescriptionID = NEW.PrescriptionID
      AND medicine_id = NEW.medicine_id;

    IF duplicate_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'This medicine already exists in this prescription';
    END IF;
END //

DELIMITER ;

