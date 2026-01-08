use ITI;


WITH RankedSalaries AS (
  SELECT d.Dept_Name,
         i.Ins_Id,
         i.Ins_Name,
         i.Salary,
         DENSE_RANK() OVER (PARTITION BY i.Dept_Id ORDER BY i.Salary DESC) AS SalaryRank
  FROM dbo.Instructor i
  INNER JOIN dbo.Department d ON d.Dept_Id = i.Dept_Id
  WHERE i.Salary IS NOT NULL
)
SELECT Dept_Name, Ins_Id, Ins_Name, Salary, SalaryRank
FROM RankedSalaries
WHERE SalaryRank <= 2;


with random as 
(
select  s.St_ID,
        (s.St_Fname + ' ' + s.St_Lname) as St_Name,
        s.Dept_ID,
        d.Dept_Name,
        ROW_NUMBER() OVER (ORDER BY NEWID()) AS rn
from Department d inner join Student s on d.Dept_Id = s.Dept_Id
) 
select 
    r.St_ID,
    r.St_Name,
    r.Dept_Name
from random r
where rn = 1;

-- part2

use AdventureWorks2012


select SalesOrderID , FORMAT(ShipDate, 'dd-MM-yyyy')
from sales.SalesOrderHeader
where OrderDate > '7/28/2002' and OrderDate < '7/29/2014'


select ProductID , Name
from Production.Product
where StandardCost < 110

select ProductID , Name
from Production.Product
where Weight is null


select ProductID , Name
from Production.Product
where color = 'silver' or
color = 'black'or 
color = 'red'

select ProductID , Name
from Production.Product
where name like 'b%'


UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

select p.*
from [Production].[ProductModelProductDescriptionCulture] pm 
inner join Production.Product p on pm.ProductModelID = p.ProductModelID
inner join [Production].[ProductDescription] pd on pd.ProductDescriptionID = pm.ProductDescriptionID
where pd.Description = 'Chromoly steel_High of defects'


select distinct [HireDate]
from [HumanResources].[Employee]



select 
    [Name] , 
    [ListPrice] , 
    ('The ' + [Name] + 'is only! ' + convert( nvarchar(30), [ListPrice]) ) as 'The [product name] is only! [List price]'
from [Production].[Product]
where 
    [ListPrice] < 120 and 
    [ListPrice] > 100
order by[ListPrice]


--part3 func

use iti

CREATE FUNCTION dbo.getMonthName (@InputDate Datetime)
RETURNS nvarchar(15)
AS
BEGIN
    RETURN DATENAME(MONTH, @InputDate)
END


select dbo.getMonthName(getDate())


CREATE FUNCTION dbo.GetNumbersBetween ( @Start INT, @End INT)
RETURNS @Result TABLE
(
    Number INT
)
AS
BEGIN
    DECLARE @i INT


    IF @Start <= @End
        SET @i = @Start
    ELSE
        SET @i = @End

    WHILE @i <= CASE WHEN @Start <= @End THEN @End ELSE @Start END
    BEGIN
        INSERT INTO @Result
        VALUES (@i);

        SET @i = @i + 1
    END

    RETURN
END

select * from dbo.GetNumbersBetween(5,10);
select * from dbo.GetNumbersBetween(17,10);


CREATE FUNCTION dbo.GetStdDept (@StdID INT)
RETURNS TABLE
AS
return (
    select s.[St_Id], (s.[St_Fname] + ' ' + s.[St_Lname]) as [Stduent Fullname] , d.[Dept_Name]
    from dbo.Department d inner join dbo.Student s on s.Dept_Id = d.Dept_Id
    where s.St_Id = @StdID
    

    )
   

select * from dbo.GetStdDept (1)
select * from dbo.GetStdDept (5)
select * from dbo.GetStdDept (23)

go
CREATE FUNCTION dbo.getNameNull (@StdID INT)
RETURNS nvarchar(100)
AS
BEGIN

    DECLARE @Message NVARCHAR(100);
    DECLARE @FName NVARCHAR(50);
    DECLARE @LName NVARCHAR(50);
    
    select 
        @FName = [St_Fname] , 
        @LName = [St_Lname] 
    from dbo.Student 
    where st_id = @StdID
    
    
    IF @FName is null And @lname is null
        set @message = 'First name & last name are null'
    ELSE IF @FName is not null And @lname is null
        set @message = 'Last name is null'
    ELSE IF @FName is null And @lname is not null
        set @message = 'First name is null'
    ELSE
        set @message = 'First name & last name are not null'
        
    RETURN @Message;
END


select dbo.getNameNull (2)
select dbo.getNameNull (5)
select dbo.getNameNull (1111)


use MyCompany
go
CREATE FUNCTION dbo.GetManager (@DateFormat INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        d.Dname AS DepartmentName,
        (e.Fname + ' ' + e.Lname) AS ManagerName,
        CONVERT(VARCHAR(20), d.[MGRStart Date], @DateFormat) AS HiringDateFormatted
    FROM dbo.Departments d
    INNER JOIN dbo.Employee e
        ON d.MGRSSN = e.SSN
);

select * from dbo.GetManager (112)
select * from dbo.GetManager (110)
select * from dbo.GetManager (111)


use ITI
CREATE FUNCTION dbo.GetStudentName
(
    @Type NVARCHAR(20)
)
RETURNS @Result TABLE
(
    StudentID INT,
    NameValue NVARCHAR(100)
)
AS
BEGIN
    IF @Type = 'first name'
    BEGIN
        INSERT INTO @Result (StudentID, NameValue)
        SELECT 
            St_Id,
            ISNULL(St_Fname, 'NULL') 
        FROM dbo.Student;
    END
    ELSE IF @Type = 'last name'
    BEGIN
        INSERT INTO @Result (StudentID, NameValue)
        SELECT 
            St_Id,
            ISNULL(St_Lname, 'NULL') 
        FROM dbo.Student;
    END
    ELSE IF @Type = 'full name'
    BEGIN
        INSERT INTO @Result (StudentID, NameValue)
        SELECT 
            St_Id,
            ISNULL(St_Fname, 'NULL') + ' ' + ISNULL(St_Lname, 'NULL')
        FROM dbo.Student;
    END

    RETURN;
END;

select * from dbo.GetStudentName('first name');
select * from dbo.GetStudentName('last name');
select * from dbo.GetStudentName('full name');



use MyCompany


CREATE FUNCTION dbo.GetEmployeesByProject
(
    @Pno INT
)
RETURNS @Result TABLE
(
    EmployeeSSN CHAR(9),
    EmployeeName NVARCHAR(100),
    HoursWorked DECIMAL(5,2)
)
AS
BEGIN
    INSERT INTO @Result (EmployeeSSN, EmployeeName, HoursWorked)
    SELECT 
        e.SSN,
        e.Fname + ' ' + e.Lname AS EmployeeName,
        w.Hours
    FROM dbo.Employee e
    INNER JOIN dbo.Works_for w
        ON e.SSN = w.Essn
    WHERE w.Pno = @Pno;

    RETURN;
END;



    select * from dbo.GetEmployeesByProject(100)
    select * from dbo.GetEmployeesByProject(600)

