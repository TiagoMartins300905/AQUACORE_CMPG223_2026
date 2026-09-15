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
            string searchTerm = TxtSearch.Text.Trim();

            LoadDirectory(searchTerm);
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminDashBoard.aspx");
        }

        private void LoadDirectory(string searchTerm = "")
        {
            string connStr =
                ConfigurationManager
                    .ConnectionStrings["AquaCoreConnectionString"]?
                    .ConnectionString;

            if (string.IsNullOrEmpty(connStr))
            {
                GvEmployees.DataSource = null;
                GvEmployees.DataBind();

                LblStatus.Text =
                    "Database connection string " +
                    "'AquaCoreConnectionString' is missing " +
                    "from Web.config.";

                LblStatus.ForeColor =
                    Color.FromArgb(
                        255,
                        107,
                        107
                    );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();

                    string sql = @"
                    SELECT
                        StaffID,
                        Name,
                        Surname,
                        Role,
                        ContactDetails,
                        Username,
                        CreatedDate
                    FROM Staff
                ";

                    if (!string.IsNullOrWhiteSpace(searchTerm))
                    {
                        sql += @"
                        WHERE
                            Name LIKE @Search
                            OR Surname LIKE @Search
                            OR Role LIKE @Search
                            OR Username LIKE @Search
                            OR ContactDetails LIKE @Search
                    ";
                    }

                    sql += " ORDER BY StaffID DESC";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        if (!string.IsNullOrWhiteSpace(searchTerm))
                        {
                            cmd.Parameters.AddWithValue(
                                "@Search",
                                "%" + searchTerm + "%"
                            );
                        }

                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(cmd))
                        {
                            DataTable dt =
                                new DataTable();

                            adapter.Fill(dt);

                            GvEmployees.DataSource = dt;

                            GvEmployees.DataBind();

                            if (dt.Rows.Count == 0)
                            {
                                LblStatus.Text =
                                    "No employee records were found.";

                                LblStatus.ForeColor =
                                    Color.FromArgb(
                                        255,
                                        193,
                                        7
                                    );
                            }
                            else
                            {
                                LblStatus.Text =
                                    dt.Rows.Count +
                                    " employee record(s) found.";

                                LblStatus.ForeColor =
                                    Color.FromArgb(
                                        0,
                                        210,
                                        255
                                    );
                            }
                        }
                    }
                }
            }
            catch (SQLiteException ex)
            {
                GvEmployees.DataSource = null;
                GvEmployees.DataBind();

                LblStatus.Text =
                    "SQLite database error: " +
                    ex.Message;

                LblStatus.ForeColor =
                    Color.FromArgb(
                        255,
                        107,
                        107
                    );
            }
            catch (Exception ex)
            {
                GvEmployees.DataSource = null;
                GvEmployees.DataBind();

                LblStatus.Text =
                    "Error loading employee directory: " +
                    ex.Message;

                LblStatus.ForeColor =
                    Color.FromArgb(
                        255,
                        107,
                        107
                    );
            }
        }
    }


}