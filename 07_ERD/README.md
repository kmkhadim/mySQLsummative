# Crownfield Eye Hospital -- Database Models

## CPU4:103 Introduction to Databases

This folder contains the three editable diagrams for the Crownfield Eye
Hospital database assignment. They document the progression from the
business-level conceptual model to the logical data model and final
relational schema.

**Database scenario:** Fictional Crownfield Eye Hospital ophthalmology
service\
**Diagram format:** `.drawio` (editable using diagrams.net / draw.io)

------------------------------------------------------------------------

## 1. Model files

  ----------------------------------------------------------------------------------
  File                               Model stage             Purpose
  ---------------------------------- ----------------------- -----------------------
  `Conceptual Data Model.drawio`     Conceptual data model   Identifies the main
                                                             entities and the
                                                             business relationships
                                                             between them without
                                                             focusing on
                                                             implementation details.

  `Logical Data Model.drawio`        Logical data model /    Develops the conceptual
                                     ERD                     model into entities,
                                                             attributes, primary
                                                             keys, foreign keys and
                                                             relationship
                                                             cardinalities.

  `Final Relational Schema.drawio`   Final relational schema Presents the proposed
                                                             relational tables,
                                                             attributes, key fields
                                                             and relationships for
                                                             database
                                                             implementation.
  ----------------------------------------------------------------------------------

## 2. Recommended order

Read and present the diagrams in this order:

1.  **Conceptual Data Model** -- begin with the main hospital entities
    and how they relate.
2.  **Logical Data Model** -- explain the attributes, primary keys,
    foreign keys, associative entities and cardinality.
3.  **Final Relational Schema** -- show how the design is represented as
    relational tables for implementation in MySQL.

This sequence demonstrates how the design develops from the business
requirements into a database structure.

## 3. Main entities represented

The models include the following subject areas:

-   **Patient** -- patient identity and contact-location information.
-   **Clinician** and **Specialty** -- clinical staff and their
    specialty.
-   **Clinic** -- the clinic location assigned to appointments.
-   **Appointment** -- appointment date, time and links to the patient,
    clinician and clinic.
-   **Diagnosis** -- diagnosis descriptions recorded for appointments.
-   **AppointmentDiagnosis** -- associative entity linking appointments
    and diagnoses.
-   **Prescription** -- prescription details associated with an
    appointment.
-   **Medicine** -- medicine information.
-   **PrescriptionItem** -- the medicines included in a prescription,
    with dose, route, frequency and duration.
-   **FollowUpPlan** -- follow-up due date, priority, status and notes.

## 4. Relationship and key notation

-   **PK** -- Primary Key: uniquely identifies each row in a table.
-   **FK** -- Foreign Key: references a key in another table and
    establishes a relationship.
-   **UQ** -- Unique constraint: prevents duplicate values for the
    constrained field.
-   **1:M** -- One-to-many relationship.
-   **1:0..1** -- One-to-zero-or-one relationship; the related record is
    optional.
-   **M:N** -- Many-to-many relationship, implemented through an
    associative table.

The AppointmentDiagnosis entity resolves the many-to-many relationship
between Appointment and Diagnosis. PrescriptionItem resolves the
many-to-many relationship between Prescription and Medicine and stores
the treatment details for each medicine item.

## 5. Important consistency checks before submission

The supplied diagrams show the design progression, but some field and
key definitions differ between the logical model, final schema and
supplied SQL scripts. These should be reconciled before treating the
diagrams as a single fully consistent design:

1.  **Clinician name:** the logical model displays `ClinicianName`,
    whereas the final schema and SQL use `FirstName` and `LastName`.
2.  **AppointmentDiagnosis naming:** the diagrams use both
    `AppointmentDiagnosis` and `Appointment_Diagnosis`. Use one
    consistent table name in the report, diagrams and SQL.
3.  **PrescriptionItem key:** the logical model shows `PrescriptionID`
    and `MedicineID` as a composite PK/FK, while the SQL implementation
    uses `PrescriptionItemID` as the primary key and separate foreign
    keys to Prescription and Medicine.
4.  **Medicine key and naming:** the diagrams use `MedicineID` /
    `MedicineId`, while the SQL file uses `medicine_id`. Ensure the
    spelling and capitalisation are consistent with the implemented
    schema.
5.  **Dose attribute:** the logical model uses `Dose`, while the SQL
    implementation uses `Dosage`. Choose the implemented name
    consistently in the final diagram and report.
6.  **Follow-up relationship:** the diagrams show an appointment may
    have zero or one follow-up plan. The SQL enforces this with a
    foreign key and a UNIQUE constraint on `FollowUpPlan.AppointmentID`.

These are documentation-alignment checks; the README does not change the
diagrams or SQL.

## 6. Opening and editing the diagrams

1.  Open [diagrams.net](https://app.diagrams.net/).
2.  Choose **Device** if prompted to select where to open or save files.
3.  Select **File → Open From → Device**.
4.  Choose the required `.drawio` file.
5.  Edit the diagram if necessary, then save the `.drawio` file.
6.  For report or presentation use, export a clear image or PDF using
    **File → Export as**. Check that all entity names, attributes, keys
    and relationship labels remain readable.

Keep the original `.drawio` files in the repository so the diagrams
remain editable.

## 7. Assessment use

The diagrams support the Part A deliverables in the CPU4:103 assessment:

-   **Task A2 -- Conceptual data model:** identifies entities,
    attributes and relationships and presents the conceptual ER model.
-   **Task A3 -- Logical design:** develops the logical schema,
    identifies keys and relationships, and supports the final relational
    schema.

The diagrams should be considered alongside the written anomaly
analysis, normalisation working and SQL implementation evidence. The
assessment brief requires the ER diagram to be included in the report
and the original diagram file to be retained in the GitHub repository.


