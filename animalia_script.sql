--DROP existing tables

DROP TABLE Adoption CASCADE CONSTRAINTS;
DROP TABLE Foster CASCADE CONSTRAINTS;
DROP TABLE Caregiver CASCADE CONSTRAINTS;
DROP TABLE Animal CASCADE CONSTRAINTS;
DROP TABLE Volunteer CASCADE CONSTRAINTS;
DROP TABLE VolunteerAssignment CASCADE CONSTRAINTS;
DROP TABLE Staff CASCADE CONSTRAINTS;
DROP TABLE HealthCheckup CASCADE CONSTRAINTS;
DROP TABLE Donors CASCADE CONSTRAINTS;
DROP TABLE Donations CASCADE CONSTRAINTS;


--CREATE tables
CREATE TABLE Animal (
    Animal_ID VARCHAR2(7) PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Species VARCHAR2(20) NOT NULL,
    Breed VARCHAR2(20),
    Gender VARCHAR2(6) NOT NULL CHECK (Gender IN ('Male','Female')),
    AGE NUMERIC NOT NULL CHECK (Age BETWEEN 0 AND 40),
    ArrivalDate DATE NOT NULL,
    Status VARCHAR2(30) NOT NULL CHECK (Status IN ('Available','Adopted','Fostered','Under Treatment'))
);

CREATE TABLE Caregiver (
    CaregiverID VARCHAR2(7) PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    ContactNumber NUMERIC(13) NOT NULL,
    Email VARCHAR2(50)
);

CREATE TABLE Foster (
    FosterID VARCHAR2(7) PRIMARY KEY,
    Animal_ID VARCHAR2(7) NOT NULL,
    StartDate DATE NOT NULL ,
    EndDate DATE NOT NULL ,
    CaregiverID VARCHAR2(7) NOT NULL,
    MedicalNotes VARCHAR(100),
    FOREIGN KEY (Animal_ID) REFERENCES Animal (Animal_ID),
    FOREIGN KEY (CaregiverID) REFERENCES Caregiver (CaregiverID),
    CONSTRAINT check_foster_period CHECK (EndDate >= StartDate)
);

CREATE TABLE Adoption (
    AdoptionID VARCHAR2(7) PRIMARY KEY,
    CaregiverID VARCHAR2(7) NOT NULL,
    Animal_ID VARCHAR2(7) NOT NULL, 
    AdoptionDate DATE NOT NULL,
    FOREIGN KEY (Animal_ID) REFERENCES Animal (Animal_ID),
    FOREIGN KEY (CaregiverID) REFERENCES Caregiver (CaregiverID)
);

CREATE TABLE Volunteer (
    VolunteerID VARCHAR2 (7) PRIMARY KEY,
    Name VARCHAR2(100) NOT NULL,
    ContactNumber NUMERIC(13) NOT NULL,
    Email VARCHAR2(50)  
);


CREATE TABLE VolunteerAssignment (
    AssignmentID VARCHAR2 (7) PRIMARY KEY,
    VolunteerID VARCHAR2 (7) NOT NULL,
    Animal_ID VARCHAR2 (7) NOT NULL,
    TaskDescription VARCHAR2(100) NOT NULL,
    FOREIGN KEY (VolunteerID) REFERENCES Volunteer(VolunteerID),
    FOREIGN KEY (Animal_ID) REFERENCES Animal(Animal_ID)
);

CREATE TABLE Staff (
    StaffID VARCHAR2(7) PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    Position VARCHAR2(20) NOT NULL CHECK (Position IN ('Administrator', 'Caretaker', 'Vet Assistant')),
    ContactNumber NUMERIC(13) NOT NULL,
    JoinDate DATE NOT NULL
);

CREATE TABLE HealthCheckup (
    CheckupID VARCHAR2(7) PRIMARY KEY,
    Animal_ID VARCHAR2(7) NOT NULL,
    CheckupDate DATE NOT NULL,
    Condition VARCHAR2(100),
    Rating NUMBER(1) NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    StaffID VARCHAR2(7) NOT NULL,
    FOREIGN KEY (Animal_ID) REFERENCES Animal(Animal_ID),
    FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
);

CREATE TABLE Donors (
    DonorID VARCHAR2(7) PRIMARY KEY,
    Name VARCHAR2(50) NOT NULL,
    ContactNumber NUMERIC(13) NOT NULL,
    Email VARCHAR2(50)
);

CREATE TABLE Donations (
    DonationID VARCHAR2(7) PRIMARY KEY,
    DonorID VARCHAR2(7) NOT NULL,
    StaffID VARCHAR2(7) NOT NULL,
    Amount NUMERIC NOT NULL CHECK (Amount > 0),
    Purpose VARCHAR2(50),
    DonationDate DATE NOT NULL,
    FOREIGN KEY (DonorID) REFERENCES Donors(DonorID)
);

--INSERT data into Animal table 

INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A001', 'Miso', 'Cat','Persian','Male', 1, TO_DATE('12 JAN 2024','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A002', 'Oreo', 'Cat','British Shorthair','Male', 4, TO_DATE('17 AUG 2022','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A003', 'Daisy', 'Cat','Siamese','Female', 13, TO_DATE('2 OCT 2022','DD-MON-YYYY'), 'Available');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A004', 'Max', 'Dog','Bulldog','Male', 15, TO_DATE('10 APR 2020','DD-MON-YYYY'), 'Under Treatment');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A005', 'Muffy', 'Dog','Beagle','Male', 12, TO_DATE('9 JAN 2021','DD-MON-YYYY'), 'Fostered');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A006', 'Luna', 'Cat','Burmese','Female', 3, TO_DATE('13 JAN 2023','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A007', 'Lucy', 'Cat','Persian','Female', 22, TO_DATE('12 SEP 2020','DD-MON-YYYY'), 'Available');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A008', 'Hope', 'Rabbit','Persian','Female', 5, TO_DATE('14 NOV 2022','DD-MON-YYYY'), 'Fostered');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A009', 'Lexi', 'Cat','Siamese','Female', 10, TO_DATE('8 MAR 2025','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A010', 'Simba', 'Dog','German Shepherd','Male', 25, TO_DATE('19 JUL 2021','DD-MON-YYYY'), 'Available');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A011', 'Ollie', 'Dog','Labrador Retriever','Male', 12, TO_DATE('27 JAN 2023','DD-MON-YYYY'), 'Fostered');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A012', 'Lola', 'Cat','Burmese','Female', 6, TO_DATE('26 FEB 2022','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A013', 'Sky', 'Cat','Persian','Male', 9, TO_DATE('5 MAY 2021','DD-MON-YYYY'), 'Fostered');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A014', 'Rex', 'Dog','Golden Retriever','Male', 21, TO_DATE('18 OCT 2020','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A015', 'Bella', 'Cat','Ragdoll','Female', 16, TO_DATE('12 JUN 2022','DD-MON-YYYY'), 'Adopted');
INSERT INTO Animal (Animal_ID, Name, Species, Breed, Gender, Age, ArrivalDate, Status) VALUES ('A016', 'Milo', 'Dog','German Shepherd','Male', 2, TO_DATE('7 JAN 2025','DD-MON-YYYY'), 'Adopted');

--INSERT data into Caregiver table

INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C001', 'John Jones', 4370994572216, 'JohnJ41@gmail.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C002', 'Jane Brown', 8711248930864, 'JaneBrown908@gmail.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C003', 'William Boones', 1334569844125, 'Will2009@yahoo.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C004', 'Grace Adams', 7609224137609, 'GraceeA64@gmail.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C005', 'Sara Kane', 6098765908812, 'Sarakane@gmail.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C006', 'Peter Parker', 8779044211708, 'Spidey2012@gmail.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C007', 'Oliver Jonson ', 1334569844125, 'Ollie150995@yahoo.com');
INSERT INTO Caregiver (CaregiverID, Name, ContactNumber, Email) VALUES ('C008', 'Marie Davis', 9771330731788, 'MDavis0801@gmail.com');


--INSERT data into Foster table

INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F001', 'A003', TO_DATE('7 OCT 2022', 'DD-MON-YYYY'), TO_DATE('14 OCT 2022', 'DD-MON-YYYY'), 'C001', 'Healing well from minor wound on back leg');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F002', 'A004', TO_DATE('10 MAY 2020', 'DD-MON-YYYY'), TO_DATE('17 MAY 2020', 'DD-MON-YYYY'), 'C003', 'Recovering from spay surgery; monitor incision site');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F003', 'A005', TO_DATE('12 JAN 2021', 'DD-MON-YYYY'), TO_DATE('10 FEB 2021', 'DD-MON-YYYY'), 'C002', 'Mild skin allergy; using medicated cream as needed');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F004', 'A007', TO_DATE('15 SEP 2020', 'DD-MON-YYYY'), TO_DATE('28 SEP 2020', 'DD-MON-YYYY'), 'C002', 'Taking joint supplements for mobility support');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F005', 'A008', TO_DATE('25 NOV 2022', 'DD-MON-YYYY'), TO_DATE('15 DEC 2022', 'DD-MON-YYYY'), 'C004', 'Treated for ear mites; no signs of irritation');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F006', 'A010', TO_DATE('8 AUG 2021', 'DD-MON-YYYY'), TO_DATE('22 AUG 2021', 'DD-MON-YYYY'), 'C005', 'Showing signs of anxiety; using calming support');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F007', 'A011', TO_DATE('4 FEB 2023', 'DD-MON-YYYY'), TO_DATE('13 MAR 2023', 'DD-MON-YYYY'), 'C006', 'Eye infection healing; continue eye drops');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F008', 'A013', TO_DATE('12 APR 2021', 'DD-MON-YYYY'), TO_DATE('12 MAY 2021', 'DD-MON-YYYY'), 'C007', 'Healing well from minor wound on back leg');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F009', 'A001', TO_DATE('14 JAN 2024', 'DD-MON-YYYY'), TO_DATE('10 FEB 2024', 'DD-MON-YYYY'), 'C005', 'Showing signs of anxiety; using calming support');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F010', 'A014', TO_DATE('25 OCT 2020', 'DD-MON-YYYY'), TO_DATE('29 OCT 2020', 'DD-MON-YYYY'), 'C006', 'All vaccinations completed; no further treatment needed');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F011', 'A015', TO_DATE('16 JUN 2022', 'DD-MON-YYYY'), TO_DATE('25 JUN 2022', 'DD-MON-YYYY'), 'C003', 'All vaccinations completed; no further treatment needed');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F012', 'A016', TO_DATE('8 JUL 2025', 'DD-MON-YYYY'), TO_DATE('15 JUL 2025', 'DD-MON-YYYY'), 'C004', 'Eye infection healing; continue eye drops');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F013', 'A005', TO_DATE('18 JUL 2025', 'DD-MON-YYYY'), TO_DATE('13 SEP 2025', 'DD-MON-YYYY'), 'C004', 'Not Applicable');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F014', 'A008', TO_DATE('7 JUL 2025', 'DD-MON-YYYY'), TO_DATE('14 DEC 2025', 'DD-MON-YYYY'), 'C004', 'Training in home environment');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F015', 'A011', TO_DATE('3 AUG 2025', 'DD-MON-YYYY'), TO_DATE('19 NOV 2025', 'DD-MON-YYYY'), 'C004', 'Healing well from minor injury');
INSERT INTO Foster (FosterID, Animal_ID, StartDate, EndDate, CaregiverID, MedicalNotes) VALUES ('F016', 'A013', TO_DATE('8 JUL 2025', 'DD-MON-YYYY'), TO_DATE('15 SEP 2025', 'DD-MON-YYYY'), 'C004', 'Training in home environment');


--INSERT data into Adoption Table

INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD001', 'C005', 'A001', TO_DATE('12 FEB 2024', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD002', 'C006', 'A014', TO_DATE('1 NOV 2020', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD003', 'C003', 'A015', TO_DATE('2 JUL 2022', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD004', 'C005', 'A016', TO_DATE('17 JUL 2025', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD005', 'C001', 'A002', TO_DATE('25 AUG 2022', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD006', 'C002', 'A006', TO_DATE('20 JAN 2023', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD007', 'C002', 'A009', TO_DATE('15 MAR 2025', 'DD-MON-YYYY'));
INSERT INTO Adoption (AdoptionID, CaregiverID, Animal_ID, AdoptionDate) VALUES ('AD008', 'C007', 'A012', TO_DATE('3 MAR 2022', 'DD-MON-YYYY'));

--INSERT data into Volunteer table 

INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V001', 'Sarah Johnson', '0123456789789', 'sarah.j@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V002', 'Michael Chen', '0119876543456', 'michael.c@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V003', 'Aisha Rahman', '0134567890123', 'aisha.r@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V004', 'David Wong', '0198765432453', 'david.w@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V005', 'Priya Patel', '0176543210125', 'priya.p@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V006', 'James Wilson', '0167890123963', 'james.w@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V007', 'Emma Davis', '0143210987741', 'emma.d@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V008', 'Daniel Lee', '0182109876147', 'daniel.l@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V009', 'Sophia Garcia', '0154321098258', 'sophia.g@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES ('V010', 'Lucas Brown', '0109876543672', 'lucas.b@email.com');
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES('V011', 'Olivia Tan', '0112233445123', 'olivia.t@email.com');       
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES('V012', 'Nathan Lim', '0165544332456', 'nathan.l@email.com');   
INSERT INTO Volunteer (VolunteerID, Name, ContactNumber, Email) VALUES('V013', 'Grace Ho', '0197788990789', 'grace.h@email.com');

--INSERT data into VolunteerAssignment table

INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS001', 'V001', 'A003', 'Daily feeding and grooming');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS002', 'V002', 'A007', 'Playtime and socialization');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS003', 'V003', 'A010', 'Exercise and walking');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS004', 'V001', 'A007', 'Weekend care');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS005', 'V004', 'A003', 'Cage cleaning');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS006', 'V005', 'A010', 'Medication administration');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS007', 'V006', 'A003', 'Behavior monitoring');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS008', 'V002', 'A010', 'Evening walks');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS009', 'V003', 'A007', 'Special diet preparation');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS010', 'V004', 'A010', 'Obedience training');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS011', 'V011', 'A003', 'Grooming sessions');                  
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS012', 'V007', 'A007', 'Exercise and walking');    
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS013', 'V008', 'A003', 'Weekend care');    
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS014', 'V009', 'A007', 'Veterinary transport assistance');    
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS015', 'V010', 'A010', 'Grooming sessions');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS016', 'V012', 'A010', 'Cage cleaning');
INSERT INTO VolunteerAssignment (AssignmentID, VolunteerID, Animal_ID, TaskDescription) VALUES ('AS017', 'V013', 'A010', 'Behavior monitoring');


-- INSERT into Staff table
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S001', 'Alice Morgan', 'Vet Assistant', 6012345678901, TO_DATE('12 FEB 2022', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S002', 'Brian Lim', 'Caretaker', 6019876543210, TO_DATE('1 JUN 2021', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S003', 'Clara Ong', 'Administrator', 6011122233344, TO_DATE('20 AUG 2020', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S004', 'Nathan Young', 'Caretaker', 6012233445566, TO_DATE('15 JAN 2023', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S005', 'Irene Tan', 'Vet Assistant', 6011344556677, TO_DATE('10 DEC 2021', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S006', 'Jason Lee', 'Administrator', 6012987654321, TO_DATE('3 MAR 2020', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S007', 'Emily Carter', 'Vet Assistant', 6011765432198, TO_DATE('8 AUG 2022', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S008', 'Kevin Ng', 'Caretaker', 6011654321987, TO_DATE('27 JUN 2021', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S009', 'Rachel Lim', 'Administrator', 6011443322110, TO_DATE('14 NOV 2019', 'DD-MON-YYYY'));
INSERT INTO Staff (StaffID, Name, Position, ContactNumber, JoinDate) VALUES ('S010', 'Mohd Faiz', 'Caretaker', 6011001122334, TO_DATE('2 FEB 2024', 'DD-MON-YYYY'));

-- INSERT into HealthCheckup table
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC001', 'A003', TO_DATE('15 JAN 2024', 'DD-MON-YYYY'), 'Mild cough, under observation', 3, 'S001');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC002', 'A004', TO_DATE('20 MAR 2023', 'DD-MON-YYYY'), 'Post-treatment check: recovering well', 4, 'S002');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC003', 'A007', TO_DATE('5 JUN 2022', 'DD-MON-YYYY'), 'Senior cat, showing signs of arthritis', 2, 'S001');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC004', 'A002', TO_DATE('18 AUG 2022', 'DD-MON-YYYY'), 'Adoption pre-check - cleared', 5, 'S004');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC005', 'A006', TO_DATE('15 JAN 2023', 'DD-MON-YYYY'), 'Mild flu symptoms - medication ongoing', 3, 'S005');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC006', 'A009', TO_DATE('10 MAR 2025', 'DD-MON-YYYY'), 'Stable, healthy weight maintained', 5, 'S006');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC007', 'A001', TO_DATE('20 JAN 2024', 'DD-MON-YYYY'), 'Recovery post-foster: excellent progress', 5, 'S007');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC008', 'A015', TO_DATE('17 JUN 2022', 'DD-MON-YYYY'), 'Arthritis signs, supplements recommended', 3, 'S008');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC009', 'A012', TO_DATE('1 MAR 2022', 'DD-MON-YYYY'), 'Routine annual check - excellent health', 5, 'S009');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC010', 'A013', TO_DATE('15 MAY 2021', 'DD-MON-YYYY'), 'Post-foster follow-up - stable', 4, 'S005');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC011', 'A004', TO_DATE('18 MAY 2020', 'DD-MON-YYYY'), 'Surgery recovery-90% healed', 4, 'S010');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC012', 'A016', TO_DATE('20 JUL 2025', 'DD-MON-YYYY'), 'Final adoption check - condition good', 5, 'S006');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC013', 'A008', TO_DATE('10 DEC 2022', 'DD-MON-YYYY'), 'Ears clear, eating well', 5, 'S007');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC014', 'A005', TO_DATE('15 FEB 2021', 'DD-MON-YYYY'), 'Skin healed completely, no recurrence', 5, 'S005');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC015', 'A010', TO_DATE('5 SEP 2021', 'DD-MON-YYYY'), 'Responding well to anxiety treatment', 4, 'S007');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC016', 'A011', TO_DATE('10 MAR 2023', 'DD-MON-YYYY'), 'Final follow-up: infection cleared', 5, 'S004');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC017', 'A014', TO_DATE('28 OCT 2020', 'DD-MON-YYYY'), 'Adoption check: healthy, vaccinated', 5, 'S006');
INSERT INTO HealthCheckup (CheckupID, Animal_ID, CheckupDate, Condition, Rating, StaffID) VALUES ('HC018', 'A006', TO_DATE('31 JAN 2023', 'DD-MON-YYYY'), 'General checkup', 5, 'S006');

-- INSERT into Donors table
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000001', 'Alicia Tan', 60123456789, 'alicia.tan@gmail.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000002', 'Mohd Faizal', 60192654321, 'faizal.mohd@yahoo.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000003', 'Samantha Lee', 60182233445, 'samantha.lee@outlook.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000004', 'Arun Kumar', 60173334455, 'arun.kumar@gmail.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000005', 'Nur Aisyah', 60194561234, 'aisyah.nur@yahoo.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000006', 'Jason Lim', 60101239876, 'jason.lim@outlook.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000007', 'Emily Rodriguez', 14155552671, 'emily.rodriguez@gmail.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000008', 'Ahmed El-Sayed', 201112223344, 'ahmed.elsayed@outlook.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000009', 'Chloe Dubois', 33678901234, 'chloe.dubois@yahoo.com');
INSERT INTO Donors (DonorID, Name, ContactNumber, Email) VALUES ('D000010', 'Liam Connor', 447911123456, 'liam.oconnor@gmail.com');

-- INSERT into Donations table
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00001', 'D000001', 'S006', 150.00, 'Animal Rescue Support', TO_DATE('01-JAN-2024', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00002', 'D000002', 'S003', 500.00, 'Medical Supplies', TO_DATE('15-JAN-2021', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00003', 'D000003', 'S009', 75.00, 'Food for Shelter Animals', TO_DATE('02-FEB-2021', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00004', 'D000004', 'S003', 2000.00, 'Shelter Renovation', TO_DATE('20-FEB-2022', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00005', 'D000005', 'S006', 300.00, 'Neutering Campaign', TO_DATE('05-MAR-2022', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00006', 'D000006', 'S009', 1000.00, 'Education Program', TO_DATE('25-MAR-2023', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00007', 'D000007', 'S003', 45.00, 'Basic Pet Supplies', TO_DATE('10-APR-2024', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00008', 'D000008', 'S006', 600.00, 'Emergency Vet Fund', TO_DATE('22-APR-2024', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00009', 'D000009', 'S009', 20.00, 'Daily Operations', TO_DATE('01-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO Donations (DonationID, DonorID, StaffID, Amount, Purpose, DonationDate) VALUES ('DN00010', 'D000010', 'S003', 850.00, 'Animal Adoption Campaign', TO_DATE('18-MAY-2025', 'DD-MON-YYYY'));

--DISPLAY tables
SELECT * FROM Animal;
SELECT * FROM Caregiver;
SELECT * FROM Foster;
SELECT * FROM Adoption;
SELECT * FROM Volunteer;
SELECT * FROM VolunteerAssignment;
SELECT * FROM Staff;
SELECT * FROM HealthCheckup;
SELECT * FROM Donors;
SELECT * FROM Donations;

--PART 2 QUERIES
--a. Display a list of all caregivers along with the animals they have adopted, if applicable including those who have not adopted any animals.
SELECT
c.CaregiverID,
c.Name AS Caregiver_Name,
a.Animal_ID
FROM Caregiver c
LEFT JOIN Adoption ad ON c.CaregiverID = ad.CaregiverID
LEFT JOIN Animal A ON ad.Animal_ID = a.Animal_ID;

--b. List each caregiver who has adopted animals, and show the total number of health checkups those adopted animals have received.
SELECT
c.CaregiverID, 
c.Name AS CaregiverName,
a.Animal_ID,
COUNT(CheckupID) AS TotalHealthChecks
FROM Caregiver c
JOIN Adoption ad ON c.CaregiverID = ad.CaregiverID
JOIN Animal a ON ad.Animal_ID = a.Animal_ID
LEFT JOIN HealthCheckup h ON a.Animal_ID = h.Animal_ID
GROUP BY c.CaregiverID, c.Name, a.Animal_ID
ORDER BY TotalHealthChecks DESC;
--c. List all donors whose names start with 'A' and who donated after 1st June 2023.
--Display their DonorID, FullName, and DonationDate, sorted by most recent donation.
SELECT d.DonorID, 
d.Name,
dn.DonationDate
FROM Donors d
JOIN Donations dn ON d.DonorID = DN.DonorID
WHERE d.Name LIKE 'A%'
AND dn.DonationDate >= TO_DATE('2023-06-01', 'YYYY-MM-DD')
ORDER BY dn.DonationDate DESC;

--d.List volunteers who are assigned to either the 'Exercise and walking' or 'Grooming sessions' tasks and are working with animals of the species 'Dog'.
SELECT DISTINCT 
v.VolunteerID, 
v.Name, 
va.TaskDescription, 
a.Name AS AnimalName, 
a.Species
FROM Volunteer v
JOIN VolunteerAssignment va ON v.VolunteerID = va.VolunteerID
JOIN Animal a ON va.Animal_ID = a.Animal_ID
WHERE (va.TaskDescription = 'Exercise and walking' OR va.TaskDescription = 'Grooming sessions')
AND a.Species = 'Dog';

--e. List caregivers who have both adopted and fostered animals.
SELECT 
CaregiverID, 
Name
FROM Caregiver
WHERE CaregiverID IN (
    SELECT CaregiverID FROM Foster
)
AND CaregiverID IN (
    SELECT CaregiverID FROM Adoption
);

--f. List the animals that have been in the sanctuary for over a year and have received the most positive health check ratings (rating 4+).
SELECT 
a.Animal_ID, 
a.Name,
a.ArrivalDate,
ROUND(AVG(H.Rating), 2) AS AvgRating
FROM Animal a
JOIN HealthCheckup h ON a.Animal_ID = h.Animal_ID
WHERE a.ArrivalDate <= ADD_MONTHS(SYSDATE, -12)
GROUP BY 
a.Animal_ID, 
a.Name,
a.ArrivalDate
HAVING AVG(H.Rating) >= 4
ORDER BY AvgRating DESC;

