create database RealEstate;

create table Owner(
Owener_ID int primary key identity(100000, 1),
Owner_Name nvarchar(50) not null
);




CREATE TABLE Employee(
    Employee_ID INT PRIMARY KEY IDENTITY(200000, 1),
    Employee_Name NVARCHAR(50) NOT NULL,
    SalesOfficeID INT  
);


CREATE TABLE SalesOffice(
    SalesOfficeID INT PRIMARY KEY IDENTITY(300000, 1),
    Location nvarchar(70) NOT NULL,
    Employee_ID INT 
);
    



-- Add FK from SalesOffice ? Employee
ALTER TABLE SalesOffice
ADD CONSTRAINT FK_SalesOffice_Employee
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID);

-- Add FK from Employee ? SalesOffice
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_SalesOffice
    FOREIGN KEY (SalesOfficeID) REFERENCES SalesOffice(SalesOfficeID);

create table Property(
    Property_ID INT PRIMARY KEY IDENTITY(400000, 1),
    city nvarchar(20) not null,
    address nvarchar(50) not null,
    state nvarchar(50) not null,
    zipcode varchar(30) not null,
    SalesOfficeID int not null,
    FOREIGN KEY (SalesOfficeID) REFERENCES SalesOffice(SalesOfficeID)

);


create table Ownership(
    Property_ID int not null references Property(Property_ID),
    Owner_ID int not null references Owner(Owener_ID),
    primary key (Property_ID, Owner_ID) ,
    percentage decimal(5,2) not null
);

INSERT INTO SalesOffice (Location, Employee_ID) 
VALUES
('Cairo', NULL),
('Giza', NULL),
('Alexandria', NULL),
('Suez', NULL),
('Nasr City', NULL);


INSERT INTO Employee (Employee_Name, SalesOfficeID) 
VALUES
('John Carter', 300000),
('Mary Allen', 300001),
('James Brown', 300002),
('Linda Davis', 300003),
('Michael Wilson', 300004);


UPDATE SalesOffice
SET Employee_ID = (SELECT Employee_ID FROM Employee WHERE Employee_Name = 'John Carter')
WHERE Location = 'Cairo';

UPDATE SalesOffice
SET Employee_ID = (SELECT Employee_ID FROM Employee WHERE Employee_Name = 'Mary Allen')
WHERE Location = 'Giza';

UPDATE SalesOffice
SET Employee_ID = (SELECT Employee_ID FROM Employee WHERE Employee_Name = 'James Brown')
WHERE Location = 'Alexandria';

UPDATE SalesOffice
SET Employee_ID = (SELECT Employee_ID FROM Employee WHERE Employee_Name = 'Linda Davis')
WHERE Location = 'Suez';

UPDATE SalesOffice
SET Employee_ID = (SELECT Employee_ID FROM Employee WHERE Employee_Name = 'Michael Wilson')
WHERE Location = 'Nasr City';


INSERT INTO Owner (Owner_Name) 
VALUES
('Alice Johnson'),
('Bob Smith'),
('Carol Martinez'),
('David Lee'),
('Eva Green');


INSERT INTO Property (city, address, state, zipcode, SalesOfficeID) 
VALUES
('Cairo', '123 Nile St', 'Cairo Governorate', '11511', 300000),
('Giza', '45 Pyramids Rd', 'Giza Governorate', '12511', 300001),
('Alexandria', '78 Corniche', 'Alexandria Governorate', '21511', 300002),
('Suez', '12 Port Ave', 'Suez Governorate', '41511', 300003),
('Nasr City', '89 El Tayaran', 'Cairo Governorate', '11765', 300004),
('Cairo', '200 Zamalek St', 'Cairo Governorate', '11518', 300000),
('Giza', '33 Saqqara Rd', 'Giza Governorate', '12512', 300001),
('Alexandria', '101 Stanley Bay', 'Alexandria Governorate', '21512', 300002),
('Suez', '50 Canal Rd', 'Suez Governorate', '41512', 300003),
('Nasr City', '77 Heliopolis St', 'Cairo Governorate', '11766', 300004);


INSERT INTO Ownership (Property_ID, Owner_ID, percentage) 
VALUES
(400000, 100000, 100.00),
(400001, 100001, 100.00),
(400002, 100002, 60.00),
(400002, 100003, 40.00),
(400003, 100003, 100.00),
(400004, 100004, 50.00),
(400004, 100000, 50.00),
(400005, 100001, 100.00),
(400006, 100002, 70.00),
(400006, 100003, 30.00);


SELECT --List all SalesOffices with their Employee manager
    s.SalesOfficeID,
    s.Location,
    e.Employee_Name
FROM SalesOffice s
JOIN Employee e ON s.Employee_ID = e.Employee_ID;


--List all Properties with their SalesOffice location and manager
SELECT 
    p.Property_ID,
    p.city,
    p.address,
    p.state,
    p.zipcode,
    s.Location AS Office_Location,
    e.Employee_Name AS Office_Manager
FROM Property p
JOIN SalesOffice s ON p.SalesOfficeID = s.SalesOfficeID
JOIN Employee e ON s.Employee_ID = e.Employee_ID;



SELECT --Count of Properties per SalesOffice
    s.SalesOfficeID,
    s.Location,
    COUNT(p.Property_ID) AS Num_Properties
FROM SalesOffice s
LEFT JOIN Property p ON s.SalesOfficeID = p.SalesOfficeID
GROUP BY s.SalesOfficeID, s.Location;

--Total ownership percentage per Owner
select
    o.owner_name,
    sum(ow.percentage) as total_owned
    from Owner o
join ownership ow  on ow.Owner_ID = o.Owener_ID
GROUP BY o.Owner_Name;