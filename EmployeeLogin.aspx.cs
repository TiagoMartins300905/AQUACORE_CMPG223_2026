using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;

namespace AQUACORE_CMPG223
{
    public partial class EmployeeLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string username = TxtUsername.Text.Trim();
            string password = TxtPassword.Text.Trim();

            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                SetStatus("Please enter both username and password.", Color.FromArgb(255, 107, 107));
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"]?.ConnectionString;
            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus("Database connection string missing.", Color.FromArgb(255, 107, 107));
                return;
            }

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT StaffID, Name, Role FROM Staff WHERE Username = @Username AND PasswordHash = @PasswordHash";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", password);

                        con.Open();
                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Successfully authenticated, save user info in session
                                Session["LoggedInStaffID"] = reader["StaffID"].ToString();
                                Session["LoggedInStaffName"] = reader["Name"].ToString();
                                Session["LoggedInRole"] = reader["Role"].ToString();

                                // Redirect to the new Employee Dashboard!
                                Response.Redirect("EmployeeDashboard.aspx", false);
                                Context.ApplicationInstance.CompleteRequest();
                            }
                            else
                            {
                                SetStatus("Invalid username or password.", Color.FromArgb(255, 107, 107));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus("Database error: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void SetStatus(string message, Color color)
        {
            LblStatus.Text = message;
            LblStatus.ForeColor = color;
        }
    }
}