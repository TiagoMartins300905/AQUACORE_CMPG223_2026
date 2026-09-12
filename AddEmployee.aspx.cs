using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace AQUACORE_CMPG223
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string department = ddlDepartment.SelectedValue;
            string contactDetails = txtContactDetails.Text.Trim();

            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName))
            {
                SetStatus("First name and last name are required.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (string.IsNullOrEmpty(department))
            {
                SetStatus("Please select a department.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (string.IsNullOrEmpty(contactDetails))
            {
                SetStatus("Please enter contact details.", Color.FromArgb(255, 107, 107));
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["AquaCoreDB"]?.ConnectionString;
            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus("Database connection string 'AquaCoreDB' is missing from Web.config.", Color.FromArgb(255, 107, 107));
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Ensure your SQL Employees table has a ContactDetails column replacing Salary
                    string sql = @"INSERT INTO Employees (FirstName, LastName, Email, Department, ContactDetails) 
                                   VALUES (@FirstName, @LastName, @Email, @Department, @ContactDetails)";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@FirstName", firstName);
                        cmd.Parameters.AddWithValue("@LastName", lastName);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Department", department);
                        cmd.Parameters.AddWithValue("@ContactDetails", contactDetails);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                SetStatus("Employee registered successfully!", Color.FromArgb(128, 255, 219));
                ClearFields();
            }
            catch (Exception ex)
            {
                SetStatus("Database error: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void ClearFields()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtContactDetails.Text = string.Empty;
            ddlDepartment.SelectedIndex = 0;
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}