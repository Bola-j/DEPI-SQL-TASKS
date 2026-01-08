
-- MyCompny --
use MyCompany;
-- 1. Try to create the following Queries: --
select * from Employee;

select Fname, Lname, Salary, Dno from Employee;

select [Pname]
      ,[Plocation]
      ,[Dnum]
  FROM [MyCompany].[dbo].[Project]

select (Fname + ' ' + Lname) as Fullname, (0.1*12*Salary) as ANNUAL_COMM from Employee;

select SSN , Fname , Lname from Employee 
where Salary > 1000;


select SSN , Fname , Lname from Employee 
where Salary*12 > 10000;

select (Fname + ' ' + Lname) as Fullname, Salary from Employee
where Sex = 'f';


SELECT [Dname]
      ,[Dnum]
  FROM [MyCompany].[dbo].[Departments]
  where [MGRSSN]= 968574;


SELECT [Pname] as ProjectName
      ,[Pnumber] as ProjectID
      ,[Plocation] as ProjectLocation
  FROM [MyCompany].[dbo].[Project]
    where Dnum = 10;

    -- DML --
INSERT INTO Employee(Dno , SSN, Superssn, Salary)
VALUES (30, 102672, 112233, 3000);



INSERT INTO Employee(Dno , SSN)
VALUES (30, 102660);

select * from Employee where ssn = 102672;

update Employee
set Salary = Salary * 1.2
where ssn = 102672;

select * from Employee where ssn = 102672;



-- ITI --
USE ITI;

--Restore ITI Database and then:
SELECT distinct Ins_Name from Instructor;

select i.Ins_Name , d.Dept_Name 
from Instructor i 
left join Department d on i.Dept_Id = d.Dept_Id;


select ( std.St_Fname + ' ' + std.St_Lname ) AS Full_Name , crs.Crs_Name as Course_Name 
from Stud_Course stdCrs join Student std on std.St_Id = stdCrs.St_Id
join Course crs on crs.Crs_Id = stdCrs.Crs_Id
where stdCrs.Grade is not null;


select @@VERSION -- da bygeeb el version beta3et el SQL wel build

select @@SERVERNAME  -- da bygeeb el servers' names elly ana connected 3aleh




--Part 03
-- Using MyCompany Database and try to create the following
-- Queries:


use MyCompany;


select d.Dnum , d.Dname , e.SSN , (e.Fname + ' ' + e.Lname ) as fullname
from Employee e  right join Departments d on e.SSN = d.MGRSSN;


select d.Dname as DepartmentName, p.Pname as ProjectName
from Departments d   join Project p on p.Dnum = d.Dnum
order by d.Dnum;

select (e.Fname + ' ' + e.Lname ) as fullname , d.* from Dependent d left join Employee e on e.SSN = d.ESSN;

select * from Project where City = 'Cairo' or City = 'Alex';

select * from Project where Pname LIKE 'a%';

select e.*  from Employee e  join Departments d on e.Dno = 30 where e.Salary > 1000 and e.Salary < 2000;
-- Kamel Mohamed

select * from Employee where Superssn = (
select SSN from Employee where Fname = 'Kamel' and Lname = 'Mohamed'
);

select (e.Fname + ' ' + e.Lname ) as fullname , p.Pname 
from Works_for w 
join project p on p.Pnumber = w.Pno
join Employee e on e.SSN = w.ESSn
order by p.Pname;

select p.Pname , d.Dname, e.Lname , convert( date , e.Bdate) from Project p
join Departments d on p.Dnum = d.Dnum
join Employee e on e.SSN = d.MGRSSN;


select e.* from Employee e join Departments d on d.MGRSSN = e.SSN;


select e.* , d.* from Employee e left join Dependent d on d.ESSN = e.SSN;

