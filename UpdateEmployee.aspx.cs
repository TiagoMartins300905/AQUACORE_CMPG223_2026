using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateEmployee : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"]?.ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployeeDropdown();
            }
        }

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
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT StaffID, Name || ' ' || Surname AS FullName FROM Staff ORDER BY Name";
                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        con.Open();
                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            ddlSelectEmployee.DataSource = reader;
                            ddlSelectEmployee.DataTextField = "FullName";
                            ddlSelectEmployee.DataValueField = "StaffID";
                            ddlSelectEmployee.DataBind();
                        }
                    }
                }

                ddlSelectEmployee.Items.Insert(0, new ListItem("-- Select a Staff Member --", ""));
            }
            catch (Exception ex)
            {
                SetStatus("Error loading staff: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblStatus.Text = string.Empty;

            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue))
            {
                pnlEditForm.Visible = false;
                return;
            }

            int selectedId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT Name, Surname, Username, PasswordHash, Role, ContactDetails FROM Staff WHERE StaffID = @StaffID";
                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@StaffID", selectedId);
                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                txtName.Text = reader["Name"].ToString();
                                txtSurname.Text = reader["Surname"].ToString();
                                txtUsername.Text = reader["Username"].ToString();
                                txtPassword.Text = reader["PasswordHash"].ToString();
                                txtContactDetails.Text = reader["ContactDetails"].ToString();

                                string role = reader["Role"].ToString();
                                if (ddlRole.Items.FindByValue(role) != null)
                                {
                                    ddlRole.SelectedValue = role;
                                }

                                pnlEditForm.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus("Error retrieving staff: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue)) return;

            int staffId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string name = txtName.Text.Trim();
            string surname = txtSurname.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string role = ddlRole.SelectedValue;
            string contactDetails = txtContactDetails.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(surname) || string.IsNullOrEmpty(role))
            {
                SetStatus("Name, Surname, and Role are required.", Color.FromArgb(255, 107, 107));
                return;
            }

            string connStr = GetConnectionString();
            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = @"UPDATE Staff 
                                   SET Name = @Name, Surname = @Surname, Username = @Username, 
                                       PasswordHash = @PasswordHash, Role = @Role, ContactDetails = @ContactDetails 
                                   WHERE StaffID = @StaffID";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@StaffID", staffId);
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Surname", surname);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", password);
                        cmd.Parameters.AddWithValue("@Role", role);
                        cmd.Parameters.AddWithValue("@ContactDetails", contactDetails);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                SetStatus("Staff details updated successfully!", Color.FromArgb(128, 255, 219));

                LoadEmployeeDropdown();
                ddlSelectEmployee.SelectedValue = staffId.ToString();
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