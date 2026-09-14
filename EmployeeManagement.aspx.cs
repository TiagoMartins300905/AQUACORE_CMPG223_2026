using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace AQUACORE_CMPG223
{
    public partial class EmployeeManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDirectory();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadDirectory(txtSearch.Text.Trim());
        }

        private void LoadDirectory(string searchTerm = "")
        {
            string connStr = ConfigurationManager.ConnectionStrings["AquaCoreDB"]?.ConnectionString;

            if (string.IsNullOrEmpty(connStr))
            {
                lblStatus.Text = "Database connection string 'AquaCoreDB' is missing from Web.config.";
                lblStatus.ForeColor = Color.FromArgb(255, 107, 107);
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = @"SELECT EmployeeID, FirstName, LastName, Email, Department, Salary 
                                   FROM Employees";

                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        sql += " WHERE FirstName LIKE @Search OR LastName LIKE @Search OR Department LIKE @Search";
                    }

                    sql += " ORDER BY EmployeeID DESC";

                    using (SqlCommand cmd = new SqlCommand(sql, con))
                    {
                        if (!string.IsNullOrEmpty(searchTerm))
                        {
                            cmd.Parameters.AddWithValue("@Search", "%" + searchTerm + "%");
                        }

                        using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();
                            sda.Fill(dt);
                            gvEmployees.DataSource = dt;
                            gvEmployees.DataBind();
                        }
                    }
                }
                lblStatus.Text = string.Empty;
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error loading directory: " + ex.Message;
                lblStatus.ForeColor = Color.FromArgb(255, 107, 107);
            }
        }
    }
}