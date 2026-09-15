using System.Data.SQLite;
using System;
using System.Configuration;
using System.IO;
using System.Web;

namespace AQUACORE_CMPG223
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
            string dbPath = Server.MapPath("~/App_Data/AquaCore.sqlite");

            if (!File.Exists(dbPath))
            {
                SQLiteConnection.CreateFile(dbPath);
            }

            string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;

            using (SQLiteConnection conn = new SQLiteConnection(connStr))
            {
                conn.Open();

                // Enforce foreign key constraints in SQLite (off by default)
                using (SQLiteCommand pragmaCmd = new SQLiteCommand("PRAGMA foreign_keys = ON;", conn))
                {
                    pragmaCmd.ExecuteNonQuery();
                }

                // Enable Write-Ahead Logging to reduce lock contention
                using (SQLiteCommand walCmd = new SQLiteCommand("PRAGMA journal_mode = WAL;", conn))
                {
                    walCmd.ExecuteNonQuery();
                }

                string createTables = @"
                    CREATE TABLE IF NOT EXISTS Staff (
                        StaffID INTEGER PRIMARY KEY AUTOINCREMENT,
                        Name VARCHAR(100) NOT NULL,
                        Surname VARCHAR(100) NOT NULL,
                        Role VARCHAR(50),
                        ContactDetails VARCHAR(100),
                        Username VARCHAR(50) UNIQUE,
                        PasswordHash VARCHAR(255),
                        CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
                    );

                    CREATE TABLE IF NOT EXISTS Animal (
                        AnimalID INTEGER PRIMARY KEY AUTOINCREMENT,
                        Name VARCHAR(100) NOT NULL,
                        Species VARCHAR(100) NOT NULL,
                        DateOfBirth DATE,
                        Gender VARCHAR(10),
                        HabitatLocation VARCHAR(100)
                    );

                    CREATE TABLE IF NOT EXISTS FeedingSchedule (
                        ScheduleID INTEGER PRIMARY KEY AUTOINCREMENT,
                        StaffID INTEGER NOT NULL,
                        AnimalID INTEGER NOT NULL,
                        FoodType VARCHAR(100),
                        FeedingTime DATETIME,
                        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID),
                        FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID)
                    );

                    CREATE TABLE IF NOT EXISTS Medical_Record (
                        RecordID INTEGER PRIMARY KEY AUTOINCREMENT,
                        AnimalID INTEGER NOT NULL,
                        VetName VARCHAR(100),
                        DateOfCheckup DATE,
                        IsFollowUpRequired VARCHAR(5),
                        FOREIGN KEY (AnimalID) REFERENCES Animal(AnimalID)
                    );

                    CREATE TABLE IF NOT EXISTS Visitors (
                        VisitorID INTEGER PRIMARY KEY AUTOINCREMENT,
                        Name VARCHAR(100),
                        Surname VARCHAR(100),
                        Email VARCHAR(255),
                        PhoneNumber VARCHAR(20),
                        PasswordHash VARCHAR(255),
                        CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP
                    );

                    CREATE TABLE IF NOT EXISTS Ticket (
                        TicketID INTEGER PRIMARY KEY AUTOINCREMENT,
                        VisitorID INTEGER NOT NULL,
                        StaffID INTEGER NOT NULL,
                        Purchase_Date DATE,
                        Ticket_Type VARCHAR(50),
                        Amount DECIMAL(10,2),
                        FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID),
                        FOREIGN KEY (StaffID) REFERENCES Staff(StaffID)
                    );

                    CREATE TABLE IF NOT EXISTS Reservations (
                        ReservationID INTEGER PRIMARY KEY AUTOINCREMENT,
                        VisitorID INTEGER,
                        TicketType VARCHAR(100),
                        VisitDate DATE,
                        NumTickets INTEGER,
                        TotalCost DECIMAL(10,2),
                        PaymentMethod VARCHAR(50),
                        Status VARCHAR(50) DEFAULT 'Pending',
                        CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                        FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID)
                    );


                CREATE TABLE Restaurant_Order (
                    OrderID INTEGER PRIMARY KEY AUTOINCREMENT,
                    VisitorID INTEGER,
                    CustomerName VARCHAR(100),
                    TableNumber VARCHAR(10),
                    FoodItems VARCHAR(255),
                    Quantity INTEGER,
                    TotalPrice DECIMAL(10,2),
                    OrderDate DATE,
                    Status VARCHAR(50) DEFAULT 'Pending',
                    FOREIGN KEY (VisitorID) REFERENCES Visitors(VisitorID)
                );
                ";

                using (SQLiteCommand cmd = new SQLiteCommand(createTables, conn))
                {
                    cmd.ExecuteNonQuery();
                }
            }
        }

        protected void Application_End(object sender, EventArgs e)
        {
        }

        protected void Application_Error(object sender, EventArgs e)
        {
        }

        protected void Session_Start(object sender, EventArgs e)
        {
        }

        protected void Session_End(object sender, EventArgs e)
        {
        }
    }
}