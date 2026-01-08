--part1 views
use iti

Create View PassedStudentsData
As
Select (s.[St_Fname] + ' ' + s.[St_Lname]) as [Student Fullname], crs.[Crs_Name]
From Stud_Course stdcrs
inner join Course crs on crs.Crs_Id = stdcrs.Crs_Id
inner join Student s on s.St_Id = stdcrs.St_Id
Where stdcrs.Grade > 50


select * from PassedStudentsData

/*
mafesh managers lel departments, 7atet shwya
*/
update  department set Dept_Manager = 2  where Dept_Id = 10
update  department set Dept_Manager = 9 where Dept_Id = 30
update  department set Dept_Manager = 10  where Dept_Id = 40
update  department set Dept_Manager = 6  where Dept_Id = 60
update  department set Dept_Manager = 4  where Dept_Id = 70

Create View MangersGivesTopics
with encryption
As
select [Managers Names].Ins_Name , [Course Topic Name].Top_Name
from ins_course inscrs
inner join
	(
	select ins.*
	from [ITI].[dbo].[Department] d
	inner join [ITI].[dbo].[Instructor] ins on ins.Ins_Id = d.Dept_Manager
	) as [Managers Names]
on inscrs.Ins_Id = [Managers Names].ins_id
inner join 
(
select t.* , crs.Crs_Id
from Course crs
inner join topic t on t.Top_Id = crs.Top_Id
) as  [Course Topic Name]

on inscrs.Crs_Id = [Course Topic Name].Crs_Id


select * from MangersGivesTopics



create view DeptData
with schemabinding -- ya3ny as long as I have this view I can't alter or drop any used columns or table in this view
as
select ins.Ins_Name , d.Dept_Name
from [dbo].[Instructor] ins
inner join [dbo].[Department] d
on d.Dept_Id = ins.Dept_Id
where Dept_Name = 'SD' or Dept_Name = 'Java'

select * from DeptData



CREATE VIEW V1
AS
SELECT *
FROM Student
WHERE St_Address IN ('Alex', 'Cairo')
WITH CHECK OPTION; /* to prevent this query Update V1 set st_address=’tanta’ Where st_address=’alex’; */


Update V1 set st_address='tanta' Where st_address='alex';

select * from V1



use MyCompany


create view EmployeesPerProject
as
select p.Pname , count(p.Pnumber) as [Employees No]
from Works_for wf 
inner join Project p on wf.Pno = p.Pnumber
group by p.Pname


select * from EmployeesPerProject


use [SD32-Company]


create or alter view v_clerk
as
select *
from [dbo].[Works_on]
where [Job] =  'clerk';

select * from v_clerk
/*
?? ????? ???? ??? ??????? ????? ?????? ????? ????
*/

create view v_without_budget
as
select *
from [HR].[Project]
where Budget is null

select * from v_without_budget

create view v_without_budget1
as
select ProjectNo , ProjectName
from [HR].[Project]

select * from v_without_budget1



create view v_count
as
select p.ProjectName, count(w.ProjectNo) as [Number of Jobs]
from [HR].[Project] p
inner join dbo.Works_on w on w.ProjectNo = p.ProjectNo
group by ProjectName


select * from v_count





create view v_project_p2
as
select EmpNo
from v_clerk
where ProjectNo = 2

select * from v_project_p2


/*
هنعملها مرتين عشان انا ضعيف في الانجليزي شوية
*/

alter view v_without_budget
as
select *
from [HR].[Project]
where ProjectNo in (1,2)

select * from v_without_budget

alter view v_without_budget1
as
select ProjectNo , ProjectName
from [HR].[Project]
where ProjectNo in (1,2)

select * from v_without_budget1

drop view v_count
drop view v_clerk



create view dept2EmployeesData
as
select EmpNo , EmpLname 
from hr.Employee
where DeptNo =  '2'

select  * from dept2EmployeesData



create or alter view lastNameWithJ
as
select  EmpLname 
from dept2EmployeesData
where EmpLname like '%j%'

select * from lastNameWithJ




create or alter view v_dept
as 
select DeptNo , DeptName
from Department

select * from v_dept

insert into v_dept(DeptNo, DeptName) values ('d4','Development')

  sp_help v_dept
  --DeptNo dtype is int
insert into v_dept(DeptNo, DeptName) values (4,'Development')

create or alter view v_2006_check
as
select EmpNo ,  ProjectNo, Enter_Date
from dbo.Works_on 
where Enter_Date BETWEEN '2006-01-01' AND '2006-12-31'
with check option

select * from v_2006_check

INSERT INTO v_2006_check --sha8ala fol
VALUES (22222, '2', '2006-06-15')

INSERT INTO v_2006_check --mesh sha8ala ,  w da employee gded Ana deftoh
VALUES (23523563, '2', '2007-06-15')


--Part 2
use iti

Create or Alter Procedure StdNoPerDept @Dept_Id int
With Encryption
As
Select @Dept_Id as [Dept ID] , d.Dept_Name, count(@Dept_Id) as [Student No.]
From [dbo].[Student] s
inner join [dbo].[Department] d on s.[Dept_Id] = d.[Dept_Id]
where d.Dept_Id = @Dept_Id
group by d.Dept_Name


declare @x int = 10
exec StdNoPerDept @x

use MyCompany

CREATE OR ALTER PROCEDURE EmpNoPerProj @projID int
WITH ENCRYPTION
AS
BEGIN
    DECLARE @EmpCount INT;

    
    SELECT @EmpCount = COUNT(*)
    FROM Works_for
    WHERE Pno = @projID;

    -- If employees are 3 or more
    IF @EmpCount >= 3
    BEGIN
        SELECT 'The number of employees in the project 100 is 3 or more';
    END
    ELSE
    BEGIN
        SELECT 'The following employees work for the project 100';

        SELECT 
            e.Fname AS FirstName,
            e.Lname AS LastName
        FROM Employee e
        INNER JOIN Works_for w
            ON e.SSN = w.ESSn
        WHERE w.Pno = 100;
    END
END;

declare @x int =100
exec EmpNoPerProj @x


CREATE OR ALTER PROCEDURE ReplaceEmployeeInProject
    @OldEmpNo INT,
    @NewEmpNo INT,
    @ProjectNo INT
WITH ENCRYPTION
AS
BEGIN
    update Works_for 
    set [ESSn] = @NewEmpNo
    where  [ESSn] = @OldEmpNo and [Pno] =@ProjectNo
end


EXEC ReplaceEmployeeInProject 
     @OldEmpNo = 223344,
     @NewEmpNo = 512463,
     @ProjectNo = 100


--part 3

CREATE OR ALTER PROCEDURE SumRange -- A7la mn el loop 3ashan el performance
    @StartNum INT,
    @EndNum INT
AS
BEGIN
    SELECT ((@EndNum - @StartNum + 1) * (@StartNum + @EndNum)) / 2
           AS TotalSum;
END;


exec SumRange
    @StartNum = 1,
    @EndNum = 5


CREATE OR ALTER PROC CircleArea @r INT
AS
BEGIN
    SELECT (3.14 * @r * @r)
           AS Area;
END;


exec CircleArea @r=5



CREATE OR ALTER PROC AgeCateg @age INT
AS
BEGIN
    if @age < 18
        select 'Child' as [Age Category]
    else if @age >= 18 and @age < 60
        select 'Adult' as [Age Category]
    else
        select 'Senior' as [Age Category]
END;


exec AgeCateg @age=10
exec AgeCateg @age=48
exec AgeCateg @age=77




CREATE OR ALTER PROCEDURE GetMaxMinAvg
    @Numbers NVARCHAR(200)
AS
BEGIN
    DECLARE @xml XML;

    -- Convert string to XML
    SET @xml = CAST(
                '<x>' + 
                REPLACE(@Numbers, ',', '</x><x>') + 
                '</x>' 
              AS XML);

    SELECT
        MAX(T.c.value('.', 'INT')) AS MaxValue,
        MIN(T.c.value('.', 'INT')) AS MinValue,
        AVG(CAST(T.c.value('.', 'INT') AS FLOAT)) AS AvgValue
    FROM @xml.nodes('/x') T(c);
END;


EXEC GetMaxMinAvg @Numbers= '5,10,15,20,25';
EXEC GetMaxMinAvg @Numbers= '5, 10, 15, 20, 25';





USE DepiCompany

CREATE TABLE Department (
    DeptNo VARCHAR(10) PRIMARY KEY,
    DeptName NVARCHAR(50) NOT NULL,
    Location NVARCHAR(50)
);

INSERT INTO Department (DeptNo, DeptName, Location) 
VALUES 
    ('d1', 'Research', 'NY'),
    ('d2', 'Accounting', 'DS'),
    ('d3', 'Marketing', 'KW');


CREATE TABLE Employee (
    EmpNo INT PRIMARY KEY,
    EmpFname NVARCHAR(50) NOT NULL,
    EmpLname NVARCHAR(50) NOT NULL,
    DeptNo VARCHAR(10),
    Salary DECIMAL(10,2) UNIQUE,
    CONSTRAINT FK_Employee_Department 
        FOREIGN KEY (DeptNo) REFERENCES Department(DeptNo)
);



INSERT INTO Employee (EmpNo, EmpFname, EmpLname, DeptNo, Salary)
VALUES
    (25348, 'Mathew', 'Smith', 'd3', 2500),
    (10102, 'Ann', 'Jones', 'd3', 3000),
    (18316, 'John', 'Barrymore', 'd1', 2400),
    (29346, 'James', 'James', 'd2', 2800),
    (9031, 'Lisa', 'Bertoni', 'd2', 4000),
    (2581, 'Elisa', 'Hansel', 'd2', 3600),
    (28559, 'Sybl', 'Moser', 'd1', 2900);


INSERT INTO Project (ProjectNo, ProjectName, Budget)
VALUES
    ('p1', 'Apollo', 120000),
    ('p2', 'Gemini', 95000),
    ('p3', 'Mercury', 185600);

INSERT INTO Works_on (EmpNo, ProjectNo, Job, Enter_Date)
VALUES
    (10102, 'p1', 'Analyst', '2006-10-01'),
    (10102, 'p3', 'Manager', '2012-01-01'),
    (25348, 'p2', 'Clerk', '2007-02-15'),
    (18316, 'p2', NULL, '2007-06-01'),
    (29346, 'p2', NULL, '2006-12-15'),
    (2581, 'p3', 'Analyst', '2007-10-15'),
    (9031, 'p1', 'Manager', '2007-04-15'),
    (28559, 'p1', NULL, '2007-08-01'),
    (28559, 'p2', 'Clerk', '2012-02-01'),
    (9031, 'p3', 'Clerk', '2006-11-15'),
    (29346, 'p1', 'Clerk', '2007-01-04');



INSERT INTO Works_on (EmpNo, ProjectNo, Job, Enter_Date)
VALUES
    (11111, 'p3', 'Office Boy', '2005-12-15') 
    /*
    Msg 547, Level 16, State 0, Line 427
The INSERT statement conflicted with the FOREIGN KEY constraint "FK_Works_on_Employee". The conflict occurred in database "DepiCompany", table "dbo.Employee", column 'EmpNo'.

مفيش موظف بالأي دي ده
    */

update Works_on
    set EmpNo = 11111
    where EmpNo = 10102
/*
    Msg 547, Level 16, State 0, Line 437
The UPDATE statement conflicted with the FOREIGN KEY constraint "FK_Works_on_Employee". The conflict occurred in database "DepiCompany", table "dbo.Employee", column 'EmpNo'.

مفيش موظف بالأي دي ده
    */

    
update Employee
    set EmpNo = 22222
    where EmpNo = 10102
/*
Msg 547, Level 16, State 0, Line 448
The UPDATE statement conflicted with the REFERENCE constraint "FK_Works_on_Employee". The conflict occurred in database "DepiCompany", table "dbo.Works_on", column 'EmpNo'.

works_on marboot be EmpNo fa kda ay haga feha FK le EmpNo = 10102 ba2et points to nowhere w da mo5alef lel database rules
*/

delete from Employee where EmpNo = 10102
/*
Msg 547, Level 16, State 0, Line 458
The DELETE statement conflicted with the REFERENCE constraint "FK_Works_on_Employee". The conflict occurred in database "DepiCompany", table "dbo.Works_on", column 'EmpNo'.

el basha da metgab serto as a FK fe Works_on, It can't be removed unless the mateer of relation solved
*/


create schema Company

ALTER SCHEMA Company TRANSFER [dbo].[Department]
ALTER SCHEMA Company TRANSFER [dbo].[Project]

create schema [Human Resources]

ALTER SCHEMA [Human Resources] TRANSFER [dbo].[Employee]


update p
set p.Budget = p.Budget * 1.1

from [DepiCompany].[Company].[Project] p
inner join [DepiCompany].[dbo].[Works_on] w on w.ProjectNo = p.ProjectNo
where w.EmpNo = 10102 AND Job = 'manager'


update d
set d.[DeptName] = 'Sales'
--select e.[EmpFname] ,e.[EmpLname] , d.[DeptName]
from [Human Resources].employee e
inner join Company.Department d on d.[DeptNo] = e.[DeptNo]
where e.[EmpLname] = 'james'

select e.[EmpFname] ,e.[EmpLname] , d.[DeptName]
from [Human Resources].employee e
inner join Company.Department d on d.[DeptNo] = e.[DeptNo]
where e.[EmpLname] = 'james'



update w
set w.enter_date = convert(date , '2007-12-12')
--select w.*
from dbo.Works_on w
inner join Company.project p on p.ProjectNo = w.ProjectNo
where w.ProjectNo = 'p1'


select w.*
from dbo.Works_on w
inner join Company.project p on p.ProjectNo = w.ProjectNo
where w.ProjectNo = 'p1'




delete from w
--select w.EmpNo , e.[EmpFname], e.[DeptNo], d.[DeptName], d.[Location]
from dbo.works_on w 
inner join [Human Resources].Employee e on e.[EmpNo] = w.[EmpNo]
inner join Company.Department d on d.[DeptNo] = e.[DeptNo]
where d.[Location] = 'kw'


select w.EmpNo , e.[EmpFname], e.[DeptNo], d.[DeptName], d.[Location]
from dbo.works_on w 
inner join [Human Resources].Employee e on e.[EmpNo] = w.[EmpNo]
inner join Company.Department d on d.[DeptNo] = e.[DeptNo]
where d.[Location] = 'kw'
