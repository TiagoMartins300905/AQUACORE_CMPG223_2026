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
            if (Session["LoggedInStaffID"] == null)
            {
                Response.Redirect("EmployeeLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                string role = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString().Trim().ToLower() : "";
                bool isAdminOrManager = (role == "admin" || role == "manager");

                if (isAdminOrManager)
                {
                    DivSelectStaff.Visible = true;
                    LoadEmployeeDropdown();
                }
                else
                {
                    DivSelectStaff.Visible = false;
                    int currentUserId = Convert.ToInt32(Session["LoggedInStaffID"]);
                    LoadEmployeeDetails(currentUserId);
                }
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
                            DdlSelectEmployee.DataSource = reader;
                            DdlSelectEmployee.DataTextField = "FullName";
                            DdlSelectEmployee.DataValueField = "StaffID";
                            DdlSelectEmployee.DataBind();
                        }
                    }
                }

                DdlSelectEmployee.Items.Insert(0, new ListItem("-- Select a Staff Member --", ""));
            }
            catch (Exception ex)
            {
                SetStatus("Error loading staff: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        protected void DdlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            LblStatus.Text = string.Empty;

            if (string.IsNullOrEmpty(DdlSelectEmployee.SelectedValue))
            {
                PnlEditForm.Visible = false;
                return;
            }

            int selectedId = Convert.ToInt32(DdlSelectEmployee.SelectedValue);
            LoadEmployeeDetails(selectedId);
        }

        private void LoadEmployeeDetails(int staffId)
        {
            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT Name, Surname, Username, PasswordHash, Role, ContactDetails FROM Staff WHERE StaffID = @StaffID";
                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue("@StaffID", staffId);
                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                TxtName.Text = reader["Name"].ToString();
                                TxtSurname.Text = reader["Surname"].ToString();
                                TxtUsername.Text = reader["Username"].ToString();
                                TxtPassword.Text = reader["PasswordHash"].ToString();
                                TxtContactDetails.Text = reader["ContactDetails"].ToString();

                                string roleVal = reader["Role"].ToString();
                                if (DdlRole.Items.FindByValue(roleVal) != null)
                                {
                                    DdlRole.SelectedValue = roleVal;
                                }

                                string sessionRole = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString().Trim().ToLower() : "";
                                if (sessionRole != "admin" && sessionRole != "manager")
                                {
                                    DdlRole.Enabled = false;
                                }

                                PnlEditForm.Visible = true;
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

        protected void BtnUpdate_Click(object sender, EventArgs e)
        {
            string sessionRole = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString().Trim().ToLower() : "";
            bool isAdminOrManager = (sessionRole == "admin" || sessionRole == "manager");

            int staffId;
            if (isAdminOrManager)
            {
                if (string.IsNullOrEmpty(DdlSelectEmployee.SelectedValue)) return;
                staffId = Convert.ToInt32(DdlSelectEmployee.SelectedValue);
            }
            else
            {
                staffId = Convert.ToInt32(Session["LoggedInStaffID"]);
            }

            string name = TxtName.Text.Trim();
            string surname = TxtSurname.Text.Trim();
            string username = TxtUsername.Text.Trim();
            string password = TxtPassword.Text.Trim();
            string role = isAdminOrManager ? DdlRole.SelectedValue : (Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString() : "");
            string contactDetails = TxtContactDetails.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(surname))
            {
                SetStatus("Name and Surname are required.", Color.FromArgb(255, 107, 107));
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

                if (Session["LoggedInStaffID"] != null && staffId.ToString() == Session["LoggedInStaffID"].ToString())
                {
                    Session["LoggedInStaffName"] = name;
                }

                // If Admin or Manager, redirect straight back to Employee Management directory!
                if (isAdminOrManager)
                {
                    Response.Redirect("EmployeeManagement.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                else
                {
                    SetStatus("Details updated successfully!", Color.FromArgb(128, 255, 219));
                }
            }
            catch (Exception ex)
            {
                SetStatus("Database error during update: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void SetStatus(string message, Color color)
        {
            LblStatus.Text = message;
            LblStatus.ForeColor = color;
        }
    }
}