# DEPI SQL Tasks Repository

This repository contains SQL Server practice tasks and exercises, along with sample database backups for learning and development purposes.

## Repository Structure

```
MS_SQL_SERVER/
├── bakups/              # Database backup files
│   ├── AdventureWorks2012.bak
│   ├── ITI.bak
│   ├── MyCompany.bak
│   ├── SD32_Company.bak
│   └── WideWorldImporters-Full.bak
├── Task1,2/             # Initial SQL tasks
├── task3(Define_Database)/
│   ├── Task3part1Musicana.sql
│   └── task3part2Realestate.sql
├── task4(DML)/
│   └── Task4.sql
├── task5/
│   └── task5.sql
├── task6/
│   └── task6.sql
├── task7/
│   └── task7.sql
└── task8/
    └── task8.sql
```

## Database Backups

The `bakups` folder contains several Microsoft SQL Server database backup files (.bak) that can be restored for practice:

- **AdventureWorks2012**: Microsoft's sample database for learning SQL Server
- **WideWorldImporters**: Microsoft's sample database for modern features
- **ITI**, **MyCompany**, **SD32_Company**: Custom practice databases

### How to Restore a Database

1. Open SQL Server Management Studio (SSMS)
2. Right-click on **Databases** → **Restore Database**
3. Select **Device** and browse to the .bak file
4. Click **OK** to restore

## Tasks Overview

### Task 3: Define Database
- Part 1: Musicana database design
- Part 2: Real estate database design

### Task 4: DML Operations
Data Manipulation Language exercises (INSERT, UPDATE, DELETE, SELECT)

### Tasks 5-8
Additional SQL practice exercises covering various SQL Server concepts

## Prerequisites

- Microsoft SQL Server (2012 or later)
- SQL Server Management Studio (SSMS)
- Basic understanding of SQL syntax

## Getting Started

1. Clone this repository
2. Restore the required database backup from the `bakups` folder
3. Navigate to the task folder you want to practice
4. Open the .sql file in SSMS
5. Execute the queries against the restored database

## License

This repository is for educational purposes.
