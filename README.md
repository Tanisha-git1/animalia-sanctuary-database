# 🐾 Animalia — Animal Sanctuary Database Management System

[![Database](https://img.shields.io/badge/Database-Oracle%20SQL-F80000?style=for-the-badge&logo=oracle&logoColor=white)](https://www.oracle.com/database/)
[![Schema](https://img.shields.io/badge/Schema-Relational%20RDBMS-4A90E2?style=for-the-badge)](https://en.wikipedia.org/wiki/Relational_database)
[![Status](https://img.shields.io/badge/Status-Completed-success?style=for-the-badge)](#)

A comprehensive relational database solution engineered in **Oracle SQL** to centralize operations, medical health tracking, volunteer coordination, foster care, adoptions, and donor contributions for an animal sanctuary and rescue organization.

---

## 📖 Project Overview

Animal shelters and sanctuaries manage complex, interconnected operational workflows across rescue intake, medical evaluations, temporary foster homes, permanent adoptions, volunteer assignments, and financial fundraising.

**Animalia** replaces error-prone spreadsheet logs with a robust, normalized 3NF Oracle relational database that:
- Guarantees **data integrity** through foreign keys, check constraints, and cascading rules.
- Centralizes medical histories, staff assignments, and caregiver records.
- Provides real-time operational reports for sanctuary administrators.

---

## ✨ Key Features & Business Rules

- **🐾 Animal Intake & Lifecycle Tracking:** Registers animals with unique IDs, species, breeds, arrival dates, and strict status constraints (`Available`, `Fostered`, `Adopted`, `Under Treatment`).
- **🩺 Health Checkups & Medical Logs:** Logs routine/post-treatment health evaluations with condition descriptions, 1–5 numerical ratings, and accountable veterinary staff.
- **🏡 Foster Care & Adoption Programs:** Tracks temporary foster intervals, medical notes, and official adoption placements with registered caregivers.
- **🤝 Volunteer Coordination:** Manages volunteer duties (e.g., exercise, grooming, cage maintenance, medical transport) linked to specific animals.
- **💰 Donors & Fund Processing:** Records financial contributions, specific funding purposes (e.g., Emergency Vet Fund, Shelter Renovation), and processing staff.

---

## 🗄️ Database Schema & Constraints

| Table Name | Primary Key | Foreign Keys | Key Integrity Constraints / Domain Checks |
| :--- | :--- | :--- | :--- |
| **`Animal`** | `Animal_ID` | — | `Gender IN ('Male','Female')`<br>`Age BETWEEN 0 AND 40`<br>`Status IN ('Available','Adopted','Fostered','Under Treatment')` |
| **`Caregiver`** | `CaregiverID` | — | Contact numbers & email records |
| **`Foster`** | `FosterID` | `Animal_ID`, `CaregiverID` | `EndDate >= StartDate` |
| **`Adoption`** | `AdoptionID` | `Animal_ID`, `CaregiverID` | Multi-table relational joins |
| **`Volunteer`** | `VolunteerID` | — | Volunteer personal directory |
| **`VolunteerAssignment`** | `AssignmentID` | `VolunteerID`, `Animal_ID` | Connects volunteers to animals & assigned tasks |
| **`Staff`** | `StaffID` | — | `Position IN ('Administrator', 'Caretaker', 'Vet Assistant')` |
| **`HealthCheckup`** | `CheckupID` | `Animal_ID`, `StaffID` | `Rating BETWEEN 1 AND 5` |
| **`Donors`** | `DonorID` | — | Donor registry |
| **`Donations`** | `DonationID` | `DonorID`, `StaffID` | `Amount > 0` |

---

## 📊 Key Analytical Queries

The script executes administrative SQL queries to solve key operational questions:

### 1. Caregiver Adoption Overview (Including Non-Adopters)
```sql
SELECT
    c.CaregiverID,
    c.Name AS Caregiver_Name,
    a.Animal_ID
FROM Caregiver c
LEFT JOIN Adoption ad ON c.CaregiverID = ad.CaregiverID
LEFT JOIN Animal a ON ad.Animal_ID = a.Animal_ID;

SELECT 
    a.Animal_ID, 
    a.Name,
    a.ArrivalDate,
    ROUND(AVG(h.Rating), 2) AS AvgRating
FROM Animal a
JOIN HealthCheckup h ON a.Animal_ID = h.Animal_ID
WHERE a.ArrivalDate <= ADD_MONTHS(SYSDATE, -12)
GROUP BY a.Animal_ID, a.Name, a.ArrivalDate
HAVING AVG(h.Rating) >= 4
ORDER BY AvgRating DESC;

