using System;
using System.Data;
using System.Data.SqlClient;

namespace AQUACORE_CMPG223
{
    /// <summary>
    /// All Employees-table SQL lives here and only here. Every Employee page
    /// (AddEmployee, EmployeeManagement, UpdateEmployee, DeleteEmployee) goes
    /// through these methods instead of writing its own SQL.
    /// </summary>
    public static class EmployeeRepository
    {
        private const string SelectWithLookups =
            @"SELECT e.EmployeeID, e.FirstName, e.LastName, e.Email, e.ContactDetails,
                     e.DepartmentID, e.RoleID, d.DepartmentName, r.RoleName,
                     e.WorkSchedule, e.DateHired, e.IsActive
              FROM Employees e
              INNER JOIN Department d ON e.DepartmentID = d.DepartmentID
              INNER JOIN [Role] r ON e.RoleID = r.RoleID";

        public static DataTable GetAllActive()
        {
            string sql = SelectWithLookups + " WHERE e.IsActive = 1 ORDER BY e.EmployeeID DESC";
            return DBHelper.GetDataTable(sql);
        }

        /// <summary>
        /// Same as GetAllActive but filtered to rows whose name, department or
        /// role contains the search term (keeps the directory's search box working).
        /// </summary>
        public static DataTable SearchActive(string searchTerm)
        {
            if (string.IsNullOrWhiteSpace(searchTerm))
            {
                return GetAllActive();
            }

            string sql = SelectWithLookups + @"
                WHERE e.IsActive = 1
                  AND (e.FirstName LIKE @Search OR e.LastName LIKE @Search
                       OR d.DepartmentName LIKE @Search OR r.RoleName LIKE @Search)
                ORDER BY e.EmployeeID DESC";

            return DBHelper.GetDataTable(sql, new SqlParameter("@Search", "%" + searchTerm + "%"));
        }

        public static Employee GetById(int employeeId)
        {
            string sql = SelectWithLookups + " WHERE e.EmployeeID = @EmployeeID";
            DataTable table = DBHelper.GetDataTable(sql, new SqlParameter("@EmployeeID", employeeId));

            if (table.Rows.Count == 0)
            {
                return null;
            }

            return MapRow(table.Rows[0]);
        }

        /// <summary>
        /// Active employees for the "select an employee" dropdowns on
        /// UpdateEmployee / DeleteEmployee.
        /// </summary>
        public static DataTable GetActiveForDropdown()
        {
            string sql = @"SELECT EmployeeID, FirstName + ' ' + LastName AS FullName
                           FROM Employees WHERE IsActive = 1 ORDER BY FirstName";
            return DBHelper.GetDataTable(sql);
        }

        /// <summary>
        /// Checks whether an email is already in use by another employee.
        /// Pass excludeEmployeeId when editing, so an employee's own email
        /// doesn't get flagged as a duplicate of itself.
        /// </summary>
        public static bool EmailExists(string email, int? excludeEmployeeId = null)
        {
            string sql = excludeEmployeeId.HasValue
                ? "SELECT COUNT(*) FROM Employees WHERE Email = @Email AND EmployeeID <> @ExcludeId"
                : "SELECT COUNT(*) FROM Employees WHERE Email = @Email";

            SqlParameter[] parameters = excludeEmployeeId.HasValue
                ? new[] { new SqlParameter("@Email", email), new SqlParameter("@ExcludeId", excludeEmployeeId.Value) }
                : new[] { new SqlParameter("@Email", email) };

            int count = (int)DBHelper.ExecuteScalar(sql, parameters);
            return count > 0;
        }

        public static void Insert(Employee employee)
        {
            string sql = @"INSERT INTO Employees (FirstName, LastName, Email, ContactDetails, DepartmentID, RoleID, WorkSchedule, DateHired, IsActive)
                            VALUES (@FirstName, @LastName, @Email, @ContactDetails, @DepartmentID, @RoleID, @WorkSchedule, @DateHired, 1)";

            DBHelper.ExecuteNonQuery(sql,
                new SqlParameter("@FirstName", employee.FirstName),
                new SqlParameter("@LastName", employee.LastName),
                new SqlParameter("@Email", employee.Email),
                new SqlParameter("@ContactDetails", (object)employee.ContactDetails ?? DBNull.Value),
                new SqlParameter("@DepartmentID", employee.DepartmentID),
                new SqlParameter("@RoleID", employee.RoleID),
                new SqlParameter("@WorkSchedule", (object)employee.WorkSchedule ?? DBNull.Value),
                new SqlParameter("@DateHired", DateTime.Today));
        }

        public static void Update(Employee employee)
        {
            string sql = @"UPDATE Employees
                            SET FirstName = @FirstName,
                                LastName = @LastName,
                                Email = @Email,
                                ContactDetails = @ContactDetails,
                                DepartmentID = @DepartmentID,
                                RoleID = @RoleID,
                                WorkSchedule = @WorkSchedule
                            WHERE EmployeeID = @EmployeeID";

            DBHelper.ExecuteNonQuery(sql,
                new SqlParameter("@FirstName", employee.FirstName),
                new SqlParameter("@LastName", employee.LastName),
                new SqlParameter("@Email", employee.Email),
                new SqlParameter("@ContactDetails", (object)employee.ContactDetails ?? DBNull.Value),
                new SqlParameter("@DepartmentID", employee.DepartmentID),
                new SqlParameter("@RoleID", employee.RoleID),
                new SqlParameter("@WorkSchedule", (object)employee.WorkSchedule ?? DBNull.Value),
                new SqlParameter("@EmployeeID", employee.EmployeeID));
        }

        /// <summary>
        /// Soft delete: flips IsActive to 0. Never issue a hard DELETE against
        /// Employees - Tickets/Animals/Restaurant records may reference EmployeeID.
        /// </summary>
        public static void Deactivate(int employeeId)
        {
            string sql = "UPDATE Employees SET IsActive = 0 WHERE EmployeeID = @EmployeeID";
            DBHelper.ExecuteNonQuery(sql, new SqlParameter("@EmployeeID", employeeId));
        }

        private static Employee MapRow(DataRow row)
        {
            return new Employee
            {
                EmployeeID = (int)row["EmployeeID"],
                FirstName = row["FirstName"].ToString(),
                LastName = row["LastName"].ToString(),
                Email = row["Email"].ToString(),
                ContactDetails = row["ContactDetails"] == DBNull.Value ? null : row["ContactDetails"].ToString(),
                DepartmentID = (int)row["DepartmentID"],
                RoleID = (int)row["RoleID"],
                DepartmentName = row["DepartmentName"].ToString(),
                RoleName = row["RoleName"].ToString(),
                WorkSchedule = row["WorkSchedule"] == DBNull.Value ? null : row["WorkSchedule"].ToString(),
                DateHired = (DateTime)row["DateHired"],
                IsActive = (bool)row["IsActive"]
            };
        }
    }
}
