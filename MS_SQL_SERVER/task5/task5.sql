-- part 1
use ITI;

select * from Student where St_Age is not null;

select t.Top_Name  , count(c.Crs_Id ) as CourseNo 
from Topic t 
left join Course c  
on c.Top_Id = t.Top_Id 
group by t.Top_Name
order by CourseNo;

select s.St_Fname , i.* from Student s join Instructor i on s.St_super = i.Ins_Id;

SELECT 
    s.St_Id AS [Student ID],
    concat_ws(' ',s.St_Fname , s.St_Lname) AS [Student Full Name],
    ISNULL(d.Dept_Name, '') AS [Department Name]
FROM Student s
LEFT JOIN Department d
    ON s.Dept_Id = d.Dept_Id;

select Instructor.Ins_Name as [Instructor Name] , isNull(Instructor.Salary, '0000' ) as [Instructor Salary] 
from Instructor;

select ins.Ins_Name , count(stdcrs.crs_id) as [Number of students]
from Stud_Course stdCrs
inner join Ins_Course insCrs on insCrs.Crs_Id = stdCrs.Crs_Id
inner join Instructor ins on ins.Ins_Id = insCrs.Ins_Id
group by ins.Ins_Name
order by ins.Ins_Name;

select * -- for instructors with max and min salaries
from Instructor
where Salary = (select max(Salary) from Instructor)
or Salary = (select min(Salary) from Instructor);

select AVG(salary) from Instructor; --el Avg 3alatol


--part2
use MyCompany;

select p.Pname as [Project Name] , sum(wf.Hours) as [Total Hours]
from Works_for wf
inner join Project p on p.Pnumber = wf.Pno
join Employee e on e.SSN = wf.ESSn
group by p.Pname;

select d.Dname as [Department Name], min(salary) as [Min. Salary] , avg(salary) as [Avg. Salary], max(salary) as [Max. Salary] 
from Departments d
left join Employee e on e.dno = d.Dnum
group by d.Dname
order by d.Dname;
