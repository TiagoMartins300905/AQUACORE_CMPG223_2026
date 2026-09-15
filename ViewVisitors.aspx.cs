using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class ViewVisitors : System.Web.UI.Page
    {
        // ============================================================
        // DATABASE CONNECTION
        // ============================================================

        private readonly string connStr =
            ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]
                .ConnectionString;


        // ============================================================
        // PAGE LOAD
        // ============================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadVisitors();
            }
        }


        // ============================================================
        // LOAD VISITORS
        // ============================================================

        private void LoadVisitors()
        {
            try
            {
                DataTable dt = new DataTable();

                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();

                    string sql = @"
                        SELECT
                            VisitorID,
                            Name,
                            Surname,
                            Email,
                            PhoneNumber,
                            CreatedDate
                        FROM Visitors
                        ORDER BY VisitorID ASC;
                    ";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(cmd))
                        {
                            adapter.Fill(dt);
                        }
                    }
                }


                // ====================================================
                // DISPLAY VISITORS
                // ====================================================

                gvVisitors.DataSource = dt;
                gvVisitors.DataBind();


                // ====================================================
                // LOAD TOTAL REVENUE
                // ====================================================

                LoadTotalRevenue();


                // ====================================================
                // CHECK FOR EMPTY TABLE
                // ====================================================

                if (dt.Rows.Count == 0)
                {
                    ShowMessage(
                        "No visitors were found."
                    );
                }
            }
            catch (SQLiteException ex)
            {
                gvVisitors.DataSource = null;
                gvVisitors.DataBind();

                lblTotalRevenue.Text = "R 0.00";

                ShowMessage(
                    "SQLite database error: " +
                    ex.Message
                );
            }
            catch (Exception ex)
            {
                gvVisitors.DataSource = null;
                gvVisitors.DataBind();

                lblTotalRevenue.Text = "R 0.00";

                ShowMessage(
                    "Could not load visitors: " +
                    ex.Message
                );
            }
        }


        // ============================================================
        // LOAD TOTAL TICKET REVENUE
        // ============================================================

        private void LoadTotalRevenue()
        {
            try
            {
                decimal totalRevenue = 0;

                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();

                    string sql = @"
                        SELECT
                            COALESCE(SUM(TotalCost), 0)
                        FROM Reservations;
                    ";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        object result =
                            cmd.ExecuteScalar();

                        if (result != null &&
                            result != DBNull.Value)
                        {
                            totalRevenue =
                                Convert.ToDecimal(result);
                        }
                    }
                }


                // ====================================================
                // DISPLAY REVENUE
                // ====================================================

                lblTotalRevenue.Text =
                    "R " + totalRevenue.ToString("N2");
            }
            catch (Exception ex)
            {
                lblTotalRevenue.Text = "R 0.00";

                System.Diagnostics.Debug.WriteLine(
                    "Revenue error: " + ex.Message
                );
            }
        }


        // ============================================================
        // SHOW MESSAGE
        // ============================================================

        private void ShowMessage(string message)
        {
            string safeMessage =
                message
                    .Replace("\\", "\\\\")
                    .Replace("'", "\\'")
                    .Replace("\r", "")
                    .Replace("\n", "\\n");

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "VisitorMessage",
                "alert('" + safeMessage + "');",
                true
            );
        }


        // ============================================================
        // DASHBOARD BUTTON
        // ============================================================

        protected void btnDashboard_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "VisitorsDashboard.aspx"
            );
        }
    }
}
