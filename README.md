# Crownfield Eye Hospital Database

## CPU4:103 -- Introduction to Databases

**Project:** Crownfield Eye Hospital ophthalmology relational database\
**Database name:** `CrownfieldEyeHospital`\
**DBMS:** MySQL (tested scripts are written for MySQL)\
**Purpose:** This repository contains the SQL files for the
collaborative database build and the individual SQL, security and
data-protection work.

> **Important:** This is a fictional teaching database. The sample
> records and credentials are demonstration data only. Do not use real
> patient information or reuse the demonstration passwords.

------------------------------------------------------------------------

## 1. Repository contents

  -------------------------------------------------------------------------------------
  File                             Purpose                      Assessment area
  -------------------------------- ---------------------------- -----------------------
  `01_Schema(1).sql`               Creates the database and its Part B -- Physical
                                   11 tables, inserts synthetic design, implementation
                                   records, checks structures   and testing
                                   and record counts, and       
                                   includes selected integrity  
                                   and controlled update/delete 
                                   tests.                       

  `02_Individual_queries(1).sql`   Contains the aggregate       Part C -- SQL queries
                                   query, INNER JOIN, LEFT JOIN 1--4
                                   and subquery. The LEFT JOIN  
                                   section creates and then     
                                   removes a temporary test     
                                   patient.                     

  `03_Procedure_and_trigger.sql`   Creates and calls the        Part C -- SQL queries
                                   `GetPrescriptionDetails`     5--6
                                   stored procedure and defines 
                                   the                          
                                   `PreventDuplicateMedicine`   
                                   trigger.                     

  `04_Security_Controls.sql`       Creates the Administrator,   Part D -- Security and
                                   Doctor, Receptionist and     data protection
                                   Patient roles; grants        
                                   privileges; creates test     
                                   accounts; and demonstrates   
                                   SHA-256 hashing and password 
                                   verification.                

  `05_patient_test.sql`            Tests Patient account access Part D -- Permission
                                   to Appointment and Diagnosis testing
                                   and attempts restricted      
                                   UPDATE and INSERT            
                                   operations.                  

  `06_receptionist_test.sql`       Tests Receptionist account   Part D -- Permission
                                   access to Appointment and    testing
                                   Diagnosis.                   
  -------------------------------------------------------------------------------------

The ER diagrams, report, presentation and screenshots are maintained
separately from these SQL scripts.

------------------------------------------------------------------------

## 2. Requirements before running the scripts

1.  Install and open MySQL Server and MySQL Workbench.
2.  Connect using an account with permission to create databases,
    tables, roles and users (for example, a suitably authorised local
    administrator account).
3.  Use a clean database environment for the first execution. The schema
    script creates tables without `IF NOT EXISTS`, so it is not designed
    to be run repeatedly over an existing populated schema.
4.  Confirm that the MySQL server is running and that the connection
    points to the intended local server.
5.  Keep a backup if the database already contains work that must be
    retained.

------------------------------------------------------------------------

## 3. Execution order

Run the files in the following order. The order matters because later
scripts depend on the database objects created earlier.

### Step 1 -- Build the database and populate the tables

Open and execute:

`01_Schema(1).sql`

This script: - creates and selects `CrownfieldEyeHospital`; - creates
the 11 relational tables: `Patient`, `Specialty`, `Clinician`, `Clinic`,
`Appointment`, `Diagnosis`, `Appointment_Diagnosis`, `Prescription`,
`Medicine`, `Prescription_Item` and `FollowUpPlan`; - inserts synthetic
sample records; - displays table structures and record counts; -
performs selected constraint and controlled data-manipulation tests.

**Execution notes:** - Run this file only once on a new/empty project
database unless you have deliberately reset the database. - The script
includes an intentionally invalid appointment insert using a
non-existent `PatientID` (`999`). A foreign-key error is expected for
this test. Execute that statement separately from the main build if you
want the remaining statements to continue without interruption. - The
script updates AppointmentID `1` to `09:15:00` and changes FollowUpID
`1` to `Completed`; these are deliberate test changes and remain in the
database. - It temporarily creates a test clinic and removes it, and it
deletes then reinserts FollowUpID `10` to demonstrate controlled
deletion while restoring the record.

### Step 2 -- Run the individual SQL queries

Open and execute:

`02_Individual_queries(1).sql`

This file contains: 1. **Aggregate query:** groups appointments by date
and uses `HAVING` to show dates with at least two appointments. 2.
**INNER JOIN:** joins Patient, Appointment, Prescription,
Prescription_Item and Medicine to show prescribed medicines and
treatment details. 3. **LEFT JOIN:** identifies patients who do not have
an appointment. 4. **Subquery:** identifies patients whose prescribed
medicine was manufactured by Pharma C.

**Execution notes:** - The LEFT JOIN test inserts a temporary patient
with `PatientID = 11`, runs the query, and then deletes that patient. -
If execution stops before the DELETE statement, remove the temporary
record manually after checking it is the test record:\
`DELETE FROM Patient WHERE PatientID = 11;` - The script includes
additional supporting SELECT statements. These do not replace the four
required query demonstrations.

### Step 3 -- Create the stored procedure and trigger

Open and execute:

`03_Procedure_and_trigger.sql`

This file: - creates `GetPrescriptionDetails`, which accepts a
`PrescriptionID` input parameter and returns prescription, medicine and
treatment information; - checks the procedure in MySQL and calls it
using `CALL GetPrescriptionDetails(3);`; - creates
`PreventDuplicateMedicine`, a `BEFORE INSERT` trigger on
`Prescription_Item`.

The trigger checks whether the same `medicine_id` is already present for
the incoming `PrescriptionID`. If a duplicate exists, it raises an SQL
error and rejects the insert.

**Execution notes:** - The trigger section uses `DELIMITER //`. In MySQL
Workbench, execute the complete trigger definition as a script so the
`BEGIN ... END` block is treated as one statement. - The procedure and
trigger are not written as repeatable migrations. If they already exist,
remove or replace the existing object deliberately before running the
relevant CREATE statement again. - After creating the trigger, test it
with a duplicate prescription/medicine pair in a controlled test. Do not
leave an unwanted test row in the database. Capture both the rejection
message and a check showing the original records remain unchanged.

### Step 4 -- Create roles, users and demonstrate data protection

Open and execute:

`04_Security_Controls.sql`

This file: - creates four roles: `HospitalAdministrator`, `Doctor`,
`Receptionist` and `Patient`; - grants database privileges to each
role; - creates local test accounts for Administrator, Doctor,
Receptionist and Patient; - assigns roles to accounts and sets default
roles; - checks role and account grants; - demonstrates SHA-256 hash
generation and correct/incorrect password comparisons; - creates
`PasswordSecurityDemo`, stores a fictional user's password hash and
verifies it.

**Demonstration credentials in the supplied SQL:**

  Test account    Username              Demonstration password
  --------------- --------------------- ------------------------
  Administrator   `hospital_admin`      `Admin#ChangeMe2026!`
  Doctor          `doctor_user`         `Doctor#ChangeMe2026!`
  Receptionist    `receptionist_test`   `Receptionist@123`
  Patient         `patient_test`        `Patient@123`

These are exposed demonstration credentials in the coursework SQL.
Change them before any use beyond the local teaching environment. Do not
use these passwords for personal or production accounts.

**Security limitations to explain:** - The Patient role currently has
table-level `SELECT` access to the Patient and Appointment tables. This
does not, by itself, limit a patient to their own records. A real
deployment would need an additional patient-specific access mechanism,
such as appropriately designed views and controlled application
access. - The Administrator role has full privileges on the project
database. The Doctor role has `SELECT`, `INSERT` and `UPDATE` on all
tables in the database. These broad grants should be reviewed against
the principle of least privilege before any real deployment. - The
SHA-256 section is a teaching demonstration. Plain SHA-256 is a fast
general-purpose hash and is not recommended on its own for real password
storage. Production systems should use a dedicated password-hashing
algorithm with a unique salt and appropriate work factor.

### Step 5 -- Test the Patient role

Create the Patient connection in MySQL Workbench using: - Host:
`localhost` - Username: `patient_test` - Password: the demonstration
password above - Default schema: `CrownfieldEyeHospital`

Connect using that account, then open and execute:

`05_patient_test.sql`

Expected behaviour: - `SELECT * FROM Appointment;` should be allowed. -
`SELECT * FROM Diagnosis;` should be denied. - The UPDATE attempt on
Appointment should be denied. - The INSERT attempt should be denied.

The final INSERT statement is deliberately incomplete. Its purpose is to
test that the Patient account does not have INSERT permission; run it as
a separate test and capture the permission-denied result. If the server
reports a different error, record the actual output rather than assuming
the expected result.

### Step 6 -- Test the Receptionist role

Create the Receptionist connection in MySQL Workbench using: - Host:
`localhost` - Username: `receptionist_test` - Password: the
demonstration password above - Default schema: `CrownfieldEyeHospital`

Connect using that account, then open and execute:

`06_receptionist_test.sql`

Expected behaviour: - `SELECT * FROM Appointment;` should be allowed. -
`SELECT * FROM Diagnosis;` should be denied.

The supplied Receptionist test file checks SELECT access only. It does
not independently test the Receptionist INSERT or UPDATE grants; use the
`SHOW GRANTS` output as evidence for those assigned privileges, or
perform additional controlled tests if required.

------------------------------------------------------------------------

## 4. Verification commands

Run these using an authorised administrator connection after the
database has been built:

``` sql
USE CrownfieldEyeHospital;

SHOW TABLES;

SELECT 'Patient' AS TableName, COUNT(*) AS TotalRecords FROM Patient
UNION ALL
SELECT 'Specialty', COUNT(*) FROM Specialty
UNION ALL
SELECT 'Clinician', COUNT(*) FROM Clinician
UNION ALL
SELECT 'Clinic', COUNT(*) FROM Clinic
UNION ALL
SELECT 'Appointment', COUNT(*) FROM Appointment
UNION ALL
SELECT 'Diagnosis', COUNT(*) FROM Diagnosis
UNION ALL
SELECT 'Appointment_Diagnosis', COUNT(*) FROM Appointment_Diagnosis
UNION ALL
SELECT 'Prescription', COUNT(*) FROM Prescription
UNION ALL
SELECT 'Medicine', COUNT(*) FROM Medicine
UNION ALL
SELECT 'Prescription_Item', COUNT(*) FROM Prescription_Item
UNION ALL
SELECT 'FollowUpPlan', COUNT(*) FROM FollowUpPlan;

SHOW GRANTS FOR 'HospitalAdministrator';
SHOW GRANTS FOR 'Doctor';
SHOW GRANTS FOR 'Receptionist';
SHOW GRANTS FOR 'Patient';

SHOW PROCEDURE STATUS
WHERE Db = 'CrownfieldEyeHospital'
  AND Name = 'GetPrescriptionDetails';

SHOW TRIGGERS FROM CrownfieldEyeHospital;
```

The build scripts insert ten synthetic rows into the main tables. The
count query above is provided to verify the actual state after execution
and any test cleanup.

------------------------------------------------------------------------

## 5. Assessment mapping

  -----------------------------------------------------------------------
  Assessment requirement              Evidence in this repository
  ----------------------------------- -----------------------------------
  Part B: create relational           `01_Schema(1).sql`
  structures and apply constraints    

  Part B: populate main tables with   `01_Schema(1).sql`
  at least 10 coherent synthetic      
  records                             

  Part B: demonstrate controlled      `01_Schema(1).sql`
  UPDATE and DELETE                   

  Part C: aggregate with GROUP BY and `02_Individual_queries(1).sql`
  HAVING                              

  Part C: INNER JOIN across at least  `02_Individual_queries(1).sql`
  three tables                        

  Part C: LEFT JOIN for               `02_Individual_queries(1).sql`
  missing/optional data               

  Part C: subquery, CTE or UNION      `02_Individual_queries(1).sql`

  Part C: stored procedure with input `03_Procedure_and_trigger.sql`
  parameter                           

  Part C: trigger enforcing a         `03_Procedure_and_trigger.sql`
  business rule                       

  Part D: at least four roles and     `04_Security_Controls.sql`
  tailored permissions                

  Part D: data protection by hashing  `04_Security_Controls.sql`

  Part D: permission tests            `05_patient_test.sql`,
                                      `06_receptionist_test.sql`
  -----------------------------------------------------------------------

The assessment brief also requires an individual repository with a
README, ordered SQL files, clear attribution, runnable code and
evidence. This README documents the supplied SQL files and their
intended execution order.

------------------------------------------------------------------------

## 6. Known limitations and final checks

-   The supplied files do not include a separate SQL injection
    prevention demonstration. The assessment brief describes SQL
    injection work as optional extra credit.
-   The trigger definition is present in the script, but successful
    creation and duplicate-rejection testing must be verified in MySQL
    Workbench and evidenced with screenshots.
-   Confirm that all eleven table counts are correct after running the
    scripts and cleaning up temporary test records.
-   Check that the access control matrix in the report matches the
    actual `SHOW GRANTS` output.
-   Keep screenshots in the report and retain the full SQL in the
    repository, as required by the assessment brief.
-   The database is a teaching prototype, not a production-ready
    clinical system.

------------------------------------------------------------------------

## 7. Attribution

This is a collaborative database build for CPU4:103. The SQL comments
identify contributions where supplied: - Aamna: Patient, Specialty,
Clinician and Clinic schema contribution; Administrator and Doctor
roles. - Khalid: Appointment, Diagnosis, Appointment_Diagnosis and
Prescription contribution; individual SQL queries; Receptionist and
Patient roles and tests. - Farhan: Medicine, Prescription_Item and
FollowUpPlan contribution; SHA-256 password-hashing demonstration.

Each student should retain and explain their own individual contribution
in their report and recorded presentation.

