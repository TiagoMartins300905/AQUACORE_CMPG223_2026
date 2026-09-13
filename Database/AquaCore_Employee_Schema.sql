-- =============================================================
-- AquaCore - Employee Management schema
-- Target: Azure SQL Database (database name referenced by the
--         "AquaCoreDB" connection string in Web.config)
--
-- Table name "Employees" (plural) matches the naming already used
-- in AddEmployee.aspx.cs / EmployeeManagement.aspx.cs / etc.
--
-- Safe to re-run: every CREATE/INSERT is guarded so running this
-- script twice will not error out or duplicate seed data.
-- =============================================================

-- ---------------------------------------------------------------
-- Department (lookup table)
-- ---------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Department')
BEGIN
    CREATE TABLE Department
    (
        DepartmentID    INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        DepartmentName  NVARCHAR(100)     NOT NULL,
        CONSTRAINT UQ_Department_DepartmentName UNIQUE (DepartmentName)
    );
END
GO

-- ---------------------------------------------------------------
-- Role (lookup table). "Role" is bracketed everywhere it is used
-- because it is a keyword-adjacent name in SQL Server.
-- ---------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Role')
BEGIN
    CREATE TABLE [Role]
    (
        RoleID    INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        RoleName  NVARCHAR(100)     NOT NULL,
        CONSTRAINT UQ_Role_RoleName UNIQUE (RoleName)
    );
END
GO

-- ---------------------------------------------------------------
-- Employees
-- ---------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Employees')
BEGIN
    CREATE TABLE Employees
    (
        EmployeeID      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
        FirstName       NVARCHAR(100)     NOT NULL,
        LastName        NVARCHAR(100)     NOT NULL,
        Email           NVARCHAR(150)     NOT NULL,
        ContactDetails  NVARCHAR(100)     NULL,
        DepartmentID    INT               NOT NULL,
        RoleID          INT               NOT NULL,
        WorkSchedule    NVARCHAR(100)     NULL,
        DateHired       DATE              NOT NULL CONSTRAINT DF_Employees_DateHired DEFAULT (CONVERT(date, GETDATE())),
        IsActive        BIT               NOT NULL CONSTRAINT DF_Employees_IsActive DEFAULT (1),

        CONSTRAINT UQ_Employees_Email UNIQUE (Email),
        CONSTRAINT FK_Employees_Department FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
        CONSTRAINT FK_Employees_Role FOREIGN KEY (RoleID) REFERENCES [Role] (RoleID)
    );
END
GO

-- ---------------------------------------------------------------
-- Seed data - Departments (matches the assignment brief exactly)
-- ---------------------------------------------------------------
INSERT INTO Department (DepartmentName)
SELECT v.DepartmentName
FROM (VALUES ('Animal Care'), ('Ticket Sales'), ('Restaurant'), ('Maintenance')) AS v(DepartmentName)
WHERE NOT EXISTS (SELECT 1 FROM Department d WHERE d.DepartmentName = v.DepartmentName);
GO

-- ---------------------------------------------------------------
-- Seed data - Roles
-- ---------------------------------------------------------------
INSERT INTO [Role] (RoleName)
SELECT v.RoleName
FROM (VALUES ('Keeper'), ('Veterinarian'), ('Cashier'), ('Chef'), ('Waiter'),
             ('Technician'), ('Manager'), ('Admin')) AS v(RoleName)
WHERE NOT EXISTS (SELECT 1 FROM [Role] r WHERE r.RoleName = v.RoleName);
GO
