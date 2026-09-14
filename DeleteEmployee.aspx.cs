using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class DeleteEmployee : System.Web.UI.Page
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
                    // SQLite uses || for string concatenation, not +
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
                pnlConfirmForm.Visible = false;
                return;
            }

            int selectedId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT Name, Surname, Username, Role FROM Staff WHERE StaffID = @StaffID";
                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@StaffID", selectedId);
                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblName.Text = reader["Name"].ToString() + " " + reader["Surname"].ToString();
                                lblUsername.Text = reader["Username"].ToString();
                                lblRole.Text = reader["Role"].ToString();

                                pnlConfirmForm.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus("Error retrieving staff details: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue)) return;

            int staffId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "DELETE FROM Staff WHERE StaffID = @StaffID";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@StaffID", staffId);
                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                pnlConfirmForm.Visible = false;
                SetStatus("Staff member successfully deleted from the system.", Color.FromArgb(128, 255, 219));

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