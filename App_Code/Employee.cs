using System;

namespace AQUACORE_CMPG223
{
    /// <summary>
    /// Plain data holder for one Employees row (plus the joined Department/Role
    /// names, which only ever come from a read - they are never written back).
    /// </summary>
    public class Employee
    {
        public int EmployeeID { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
        public string ContactDetails { get; set; }
        public int DepartmentID { get; set; }
        public int RoleID { get; set; }
        public string WorkSchedule { get; set; }
        public DateTime DateHired { get; set; }
        public bool IsActive { get; set; }

        public string DepartmentName { get; set; }
        public string RoleName { get; set; }
    }
}
