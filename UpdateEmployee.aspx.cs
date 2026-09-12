using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateEmployee : System.Web.UI.Page
    {
        // Centralized method to get the connection string safely
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["AquaCoreDB"]?.ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployeeDropdown();
            }
        }

        // 1. Fetch all employees to populate the selection dropdown
        private void LoadEmployeeDropdown()
        {
            string connStr = GetConnectionString();
            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus("Database connection string missing in Web.config.", Color.FromArgb(255, 107, 107));
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "SELECT EmployeeID, FirstName + ' ' + LastName AS FullName FROM Employees ORDER BY FirstName";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            ddlSelectEmployee.DataSource = reader;
                            ddlSelectEmployee.DataTextField = "FullName";
                            ddlSelectEmployee.DataValueField = "EmployeeID";
                            ddlSelectEmployee.DataBind();
                        }
                    }
                }

                // Add a default starting option
                ddlSelectEmployee.Items.Insert(0, new ListItem("-- Select an Employee --", ""));
            }
            catch (Exception ex)
            {
                SetStatus("Error loading employees: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        // 2. Fires automatically when the user selects a name from the dropdown
        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblStatus.Text = string.Empty; // Clear old messages

            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue))
            {
                pnlEditForm.Visible = false; // Hide form if they go back to the default option
                return;
            }

            string connStr = GetConnectionString();
            int selectedId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "SELECT FirstName, LastName, Email, Department, Salary FROM Employees WHERE EmployeeID = @EmployeeID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", selectedId);
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Populate the textboxes with database values
                                txtFirstName.Text = reader["FirstName"].ToString();
                                txtLastName.Text = reader["LastName"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                txtSalary.Text = Convert.ToDecimal(reader["Salary"]).ToString("0.00");

                                // Set the dropdown list safely
                                string dept = reader["Department"].ToString();
                                if (ddlDepartment.Items.FindByValue(dept) != null)
                                {
                                    ddlDepartment.SelectedValue = dept;
                                }

                                // Reveal the edit form
                                pnlEditForm.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus("Error retrieving employee: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        // 3. Perform the UPDATE in the database
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue)) return;

            int employeeId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string department = ddlDepartment.SelectedValue;
            string salaryInput = txtSalary.Text.Trim();

            // Validate
            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) || string.IsNullOrEmpty(department))
            {
                SetStatus("First Name, Last Name, and Department are required.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (!decimal.TryParse(salaryInput, out decimal salary) || salary < 0)
            {
                SetStatus("Please enter a valid numeric salary.", Color.FromArgb(255, 107, 107));
                return;
            }

            // Save to database
            string connStr = GetConnectionString();
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = @"UPDATE Employees 
                                   SET FirstName = @FirstName, LastName = @LastName, 
                                       Email = @Email, Department = @Department, Salary = @Salary 
                                   WHERE EmployeeID = @EmployeeID";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                        cmd.Parameters.AddWithValue("@FirstName", firstName);
                        cmd.Parameters.AddWithValue("@LastName", lastName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@Salary", salary);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                SetStatus("Employee details updated successfully!", Color.FromArgb(128, 255, 219));

                // Refresh the dropdown in case they changed the name
                LoadEmployeeDropdown();
                ddlSelectEmployee.SelectedValue = employeeId.ToString();
            }
            catch (Exception ex)
            {
                SetStatus("Database error during update: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}