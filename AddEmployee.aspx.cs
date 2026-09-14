using System;
using System.Configuration;
using System.Data.SQLite;
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
            string name = txtName.Text.Trim();
            string surname = txtSurname.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;
            string contactDetails = txtContactDetails.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(surname) || string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                SetStatus("Name, Surname, Username, and Password are required.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (string.IsNullOrEmpty(role))
            {
                SetStatus("Please select a role.", Color.FromArgb(255, 107, 107));
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
                    string sql = @"INSERT INTO Staff (Name, Surname, Role, ContactDetails, Username, PasswordHash) 
                                   VALUES (@Name, @Surname, @Role, @ContactDetails, @Username, @PasswordHash)";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Surname", surname);
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@ContactDetails", contactDetails);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", password);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                SetStatus("Staff member registered successfully!", Color.FromArgb(128, 255, 219));
                ClearFields();
            }
            catch (Exception ex)
            {
                SetStatus("Database error: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void ClearFields()
        {
            txtName.Text = string.Empty;
            txtSurname.Text = string.Empty;
            txtUsername.Text = string.Empty;
            txtPassword.Text = string.Empty;
            txtContactDetails.Text = string.Empty;
            ddlRole.SelectedIndex = 0;
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}