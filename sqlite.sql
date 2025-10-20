CREATE TABLE Branch (
    branchNo VARCHAR(4) PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postcode VARCHAR(255) NOT NULL
);

INSERT INTO Branch (branchNo, street, city, postcode)
VALUES
    ('B005', '22 Deer Rd', 'London', 'SW1 4EH'),
    ('B007', '16 Argyll St', 'Aberdeen', 'AB2 3SU'),
    ('B003', '163 Main St', 'Glasgow', 'G11 9QX'),
    ('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ'),
    ('B002', '56 Clover Dr', 'London', 'NW10 6EU');

Select * FROM Branch;

CREATE TABLE Staff(
    staffNo VARCHAR(4) PRIMARY KEY,
    fName VARCHAR(255) NOT NULL, 
    lName VARCHAR(255) NOT NULL,
    position VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    DOB VARCHAR(255) NOT NULL,
    salary INTEGER NOT NULL,
    branchNo VARCHAR(4) NOT NULL,
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO Staff (staffNo, fName, lName, position, sex, DOB, salary, branchNo)
VALUES 
    ('SL21', 'John', 'White', 'Manager', 'M', '1-Oct-45', 30000, 'B005'),
    ('SG37', 'Ann', 'Beech', 'Assistant', 'F', '10-Nov-60', 12000, 'B003'),
    ('SG14', 'David', 'Ford', 'Supervisor', 'M', '24-Mar-58', 18000, 'B003'),
    ('SA9', 'Mary', 'Howe', 'Assistant', 'F', '19-Feb-70', 9000, 'B007'),
    ('SG5', 'Susan', 'Brand', 'Manager', 'F', '3-Jun-40', 24000, 'B003'),
    ('SL41', 'Julie', 'Lee', 'Assistant', 'F', '13-Jun-65', 9000, 'B005');

SELECT * FROM STAFF;

CREATE TABLE PropertyForRent(
    propertyNo VARCHAR(4) PRIMARY KEY,
    street VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    postcode VARCHAR(255) NOT NULL,
    type VARCHAR(255) NOT NULL,
    rooms INTEGER NOT NULL,
    rent INTEGER NOT NULL,
    ownerNo VARCHAR(4) NOT NULL,
    staffNo VARCHAR(4),
    branchNo VARCHAR(4) NOT NULL,
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo)
);

INSERT INTO PropertyForRent (propertyNo, street, city, postcode, type, rooms, rent, ownerNo, staffNo, branchNo)
VALUES
    ('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SU', 'House', 6, 650, 'CO46', 'SA9', 'B007'),
    ('PL94', '6 Argyll St', 'London', 'NW2', 'Flat', 4, 400, 'CO87', 'SL41', 'B005'),
    ('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat', 3, 350, 'CO40', NULL, 'B003'), 
    ('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat', 3, 375, 'CO93', 'SG37', 'B003'),
    ('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House', 5, 600, 'CO87', 'SG37', 'B003'),
    ('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat', 4, 450, 'CO93', 'SG14', 'B003');

SELECT * FROM PropertyForRent;

CREATE TABLE Client(
    clientNo VARCHAR(4) PRIMARY KEY,
    fName VARCHAR(255) NOT NULL,
    lName VARCHAR(255) NOT NULL,
    telNo VARCHAR(255) NOT NULL,
    prefType VARCHAR(255) NOT NULL,
    maxRent INTEGER NOT NULL
);

INSERT INTO Client (clientNo, fName, lName, telNo, prefType, maxRent)
VALUES
    ('CR76', 'John', 'Kay', '0207-774-5632', 'Flat', 425),
    ('CR56', 'Aline', 'Stewart', '0141-848-1825', 'Flat', 350),
    ('CR74', 'Mike', 'Ritchie', '01475-392178', 'House', 750),
    ('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600);

SELECT * FROM Client;

CREATE TABLE PrivateOwner(
    ownerNo VARCHAR(4) PRIMARY KEY,
    fName VARCHAR(255) NOT NULL,
    lName VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    telNo VARCHAR(255) NOT NULL
);

INSERT INTO PrivateOwner (ownerNo, fName, lName, address, telNo)
VALUES
    ('CO46', 'Joe', 'Keogh', '2 Fergus Dr, Aberdeen AB2 7SX', '01224-861212'),
    ('CO87', 'Carol', 'Farrel', '6 Achray St, Glasgow G32 9DX', '0141-357-7419'),
    ('CO40', 'Tina', 'Murphy', '63 Well St, Glasgow G42', '0141-943-1728'),
    ('CO93', 'Tony', 'Shaw', '12 Park Pl, Glasgow G4 0QR', '0141-225-7025');

SELECT * FROM PrivateOwner;

CREATE TABLE Viewing(
    clientNo VARCHAR(4) NOT NULL,
    propertyNo VARCHAR(4) NOT NULL,
    viewDate VARCHAR(255) NOT NULL,
    comment VARCHAR(255),
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (propertyNo) REFERENCES PropertyForRent(propertyNo),
    PRIMARY KEY (clientNo, propertyNo)
);

INSERT INTO Viewing (clientNo, propertyNo, viewDate, comment)
VALUES
    ('CR56', 'PA14', '24-May-04', 'too small'),
    ('CR76', 'PG4', '20-Apr-04', 'too remote'),
    ('CR56', 'PG4', '26-May-04', NULL), 
    ('CR62', 'PA14', '14-May-04', 'no dining room'),
    ('CR56', 'PG36', '28-Apr-04', NULL); 
    
SELECT * FROM Viewing;

CREATE TABLE Registration(
    clientNo VARCHAR(4) NOT NULL,
    branchNo VARCHAR(4) NOT NULL,
    staffNo VARCHAR(4) NOT NULL,
    dateJoined VARCHAR(255) NOT NULL,
    PRIMARY KEY (clientNo, branchNo, staffNo),
    FOREIGN KEY (clientNo) REFERENCES Client(clientNo),
    FOREIGN KEY (branchNo) REFERENCES Branch(branchNo),
    FOREIGN KEY (staffNo) REFERENCES Staff(staffNo) 
);

INSERT INTO Registration (clientNo, branchNo, staffNo, dateJoined)
VALUES
    ('CR76', 'B005', 'SL41', '2-Jan-04'),
    ('CR56', 'B003', 'SG37', '11-Apr-03'),
    ('CR74', 'B003', 'SG37', '16-Nov-02'),
    ('CR62', 'B007', 'SA9', '7-Mar-03');

SELECT * FROM Registration;