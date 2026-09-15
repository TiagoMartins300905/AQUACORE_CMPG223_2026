using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
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

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            LoadDirectory(TxtSearch.Text.Trim());
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashBoard.aspx");
        }

        private void LoadDirectory(string searchTerm = "")
        {
            string connStr = ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]?
                .ConnectionString;

            if (string.IsNullOrEmpty(connStr))
            {
                LblStatus.Text =
                    "Database connection string 'AquaCoreConnectionString' is missing from Web.config.";

                LblStatus.ForeColor =
                    Color.FromArgb(255, 107, 107);

                return;
            }

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT 
                            StaffID,
                            Name,
                            Surname,
                            Role,
                            ContactDetails,
                            Username,
                            CreatedDate 
                        FROM Staff";

                    if (!string.IsNullOrEmpty(searchTerm))
                    {
                        sql += @"
                            WHERE Name LIKE @Search
                            OR Surname LIKE @Search
                            OR Role LIKE @Search";
                    }

                    sql += " ORDER BY StaffID DESC";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        if (!string.IsNullOrEmpty(searchTerm))
                        {
                            cmd.Parameters.AddWithValue(
                                "@Search",
                                "%" + searchTerm + "%"
                            );
                        }

                        using (SQLiteDataAdapter sda =
                               new SQLiteDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            sda.Fill(dt);

                            GvEmployees.DataSource = dt;
                            GvEmployees.DataBind();
                        }
                    }
                }

                LblStatus.Text = string.Empty;
            }
            catch (Exception ex)
            {
                LblStatus.Text =
                    "Error loading directory: " + ex.Message;

                LblStatus.ForeColor =
                    Color.FromArgb(255, 107, 107);
            }
        }
    }
}