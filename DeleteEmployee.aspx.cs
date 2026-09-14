using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class DeleteEmployee : System.Web.UI.Page
    {
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

        // 1. Fetch all employees to populate the dropdown
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

                ddlSelectEmployee.Items.Insert(0, new ListItem("-- Select an Employee --", ""));
            }
            catch (Exception ex)
            {
                SetStatus("Error loading employees: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        // 2. Fetch and display details when an employee is selected
        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblStatus.Text = string.Empty;

            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue))
            {
                pnlConfirmForm.Visible = false;
                return;
            }

            int selectedId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string connStr = GetConnectionString();

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "SELECT FirstName, LastName, Email, Department FROM Employees WHERE EmployeeID = @EmployeeID";
                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", selectedId);
                        con.Open();

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblName.Text = reader["FirstName"].ToString() + " " + reader["LastName"].ToString();
                                lblEmail.Text = reader["Email"].ToString();
                                lblDept.Text = reader["Department"].ToString();

                                pnlConfirmForm.Visible = true;
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

        // 3. Delete the employee from the database
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue)) return;

            int employeeId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string connStr = GetConnectionString();

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "DELETE FROM Employees WHERE EmployeeID = @EmployeeID";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@EmployeeID", employeeId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // Hide the panel and show success message
                pnlConfirmForm.Visible = false;
                SetStatus("Employee successfully deleted from the system.", Color.FromArgb(128, 255, 219));

                // Refresh the dropdown so the deleted employee is gone
                LoadEmployeeDropdown();
            }
            catch (Exception ex)
            {
                SetStatus("Database error during deletion: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}