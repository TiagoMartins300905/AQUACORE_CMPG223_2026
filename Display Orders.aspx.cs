using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class Display_Orders : System.Web.UI.Page
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
                LoadOrders();
            }
        }


        // ============================================================
        // LOAD ORDERS
        // ============================================================

        private void LoadOrders()
        {
            DataTable dt = new DataTable();

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    con.Open();

                    // ------------------------------------------------
                    // Make sure SQLite foreign keys are enabled
                    // ------------------------------------------------

                    using (SQLiteCommand pragma =
                           new SQLiteCommand(
                               "PRAGMA foreign_keys = ON;",
                               con))
                    {
                        pragma.ExecuteNonQuery();
                    }


                    // ------------------------------------------------
                    // Query orders
                    // ------------------------------------------------

                    string sql = @"
                        SELECT
                            OrderID,
                            CustomerName,
                            TableNumber,
                            FoodItems,
                            Quantity,
                            TotalPrice,
                            OrderDate,
                            Status
                        FROM Restaurant_Order
                        ORDER BY OrderID ASC;
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


                // ----------------------------------------------------
                // Display data in GridView
                // ----------------------------------------------------

                gvOrders.DataSource = dt;
                gvOrders.DataBind();


                // ----------------------------------------------------
                // No records
                // ----------------------------------------------------

                if (dt.Rows.Count == 0)
                {
                    ShowMessage(
                        "The Restaurant_Order table is empty. " +
                        "No restaurant orders were found."
                    );
                }
            }
            catch (SQLiteException ex)
            {
                gvOrders.DataSource = null;
                gvOrders.DataBind();

                ShowMessage(
                    "SQLite database error:\n\n" +
                    ex.Message
                );
            }
            catch (Exception ex)
            {
                gvOrders.DataSource = null;
                gvOrders.DataBind();

                ShowMessage(
                    "Error loading restaurant orders:\n\n" +
                    ex.Message
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
                "OrderMessage",
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
                "RestaurantOrders_Dashboard.aspx"
            );
        }
    }
}
