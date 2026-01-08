use ITI
--part 1
create trigger NotInsertDept
on Department
Instead of insert 
as
	select 'You can’t insert a new record in that table'
go


insert into Department values (9999
    ,'Hanyy dept'
    ,'dept of hany'
    ,'house of hany'
    ,11
    ,'2009-12-2'
    )

create table StudentAudit (
ServerUserName NVARCHAR(128) DEFAULT SUSER_NAME(),
    Date DATETIME DEFAULT GETDATE(),
    Note NVARCHAR(255)
)

INSERT INTO StudentAudit (Note)
VALUES ('E7na bnmoooott hena')

select * from StudentAudit




create trigger saveUserInfo
on Student
after insert 
as
	insert into StudentAudit  
    select
        SUSER_NAME(),
        GETDATE(),
        SUSER_NAME() + ' Insert New Row with Key = '
        + cast(inserted.St_Id AS NVARCHAR(50))
        + ' in table Student'
        from inserted

insert into Student(St_Id) values (456)
insert into Student(St_Id) values (987)

select * from StudentAudit
    

create trigger saveRemoverInfo
on Student
instead of delete
as
	insert into StudentAudit  
    select
        SUSER_NAME(),
        GETDATE(),
        SUSER_NAME() + ' try to delete Row with id = '
        + cast(deleted.St_Id AS NVARCHAR(50))
        from deleted

DELETE FROM Student WHERE St_Id = 5
DELETE FROM Student WHERE St_Id = 11

select * from StudentAudit

--part 2
use MyCompany

/*???? ????? ?? ??????? ???? ?? ???? ?? ??? 3*/
CREATE TRIGGER PREVENT_IN_MARCH
ON Employee
INSTEAD OF INSERT
AS
BEGIN
    IF MONTH(GETDATE()) = 3
    BEGIN
        RAISERROR ('Insertion is not allowed in March', 16, 1);
        RETURN;
    END

    INSERT INTO Employee
    SELECT * FROM inserted;
END;


INSERT INTO Employee(ssn) VALUES (2324366) -- ????? ????


USE [SD32-Company]

CREATE TABLE ProjectAudit (
    ProjectNo NVARCHAR(50),
    UserName NVARCHAR(128),
    ModifiedDate DATETIME,
    Budget_Old DECIMAL(18,2),
    Budget_New DECIMAL(18,2)
)

CREATE TRIGGER UpdateAudit
ON hr.project
after update
AS
begin

    if update(budget)
        begin
            insert into ProjectAudit
            select
                i.[ProjectNo],
                SUSER_NAME(),
                GETDATE(),
                d.Budget,
                i.Budget
            from inserted i
            inner join deleted d on d.[ProjectNo] = i.[ProjectNo]

        end
end

UPDATE [HR].[Project]
SET Budget = 3445466
WHERE ProjectNo = '1';

select * from ProjectAudit


use ITI

CREATE CLUSTERED INDEX IX_Department_HireDate
ON Department([Manager_hiredate])
-- first i should delete the cluster index on 'PK_Department' as it gives an error now
-- more safe one is to make PK_Department nonclustered and the hiredate clustered
-- i did by wizard

CREATE CLUSTERED INDEX CI_HireDate
ON Department(Manager_hiredate)


CREATE UNIQUE INDEX UI_Age
ON Student(ST_Age);
/*
The CREATE UNIQUE INDEX statement terminated because a duplicate key was found for the object name 'dbo.Student' and the index name 'UI_Age'. The duplicate key value is (<NULL>).

3andy duplicates w nulls
*/

SELECT st_Age, COUNT(*) 
FROM Student
GROUP BY st_Age
HAVING COUNT(*) > 1 OR st_Age IS NULL;
/*lazem delete nulls we duplicates */


USE master

CREATE LOGIN RouteStudent WITH PASSWORD = 'StrongP@ssw0rd!';


USE ITI;


CREATE USER RouteStudent FOR LOGIN RouteStudent;


GRANT SELECT, INSERT ON dbo.Student TO RouteStudent;
GRANT SELECT, INSERT ON dbo.Course TO RouteStudent;


DENY DELETE, UPDATE ON dbo.Student TO RouteStudent;
DENY DELETE, UPDATE ON dbo.Course TO RouteStudent;


EXECUTE AS LOGIN = 'RouteStudent';

INSERT INTO Student (st_id, [St_Fname], st_Age)
VALUES (10043, 'Ahmed', 20)

UPDATE Student
SET st_Age = 21
WHERE st_id = 1001;

