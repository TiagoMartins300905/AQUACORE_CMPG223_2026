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
            try
            {
                DataTable dt = new DataTable();

                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();


                    // ====================================================
                    // IMPORTANT:
                    // CAST OrderDate AS TEXT
                    //
                    // This prevents SQLite/.NET from trying to
                    // automatically convert an invalid date value
                    // into DateTime.
                    // ====================================================

                    string sql = @"
                        SELECT
                            OrderID,
                            CustomerName,
                            TableNumber,
                            FoodItems,
                            Quantity,
                            TotalPrice,

                            CAST(OrderDate AS TEXT) AS OrderDate,

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


                // ====================================================
                // DISPLAY DATA
                // ====================================================

                gvOrders.DataSource = dt;

                gvOrders.DataBind();


                // ====================================================
                // CHECK FOR EMPTY TABLE
                // ====================================================

                if (dt.Rows.Count == 0)
                {
                    ShowMessage(
                        "No restaurant orders were found."
                    );
                }
            }
            catch (SQLiteException ex)
            {
                gvOrders.DataSource = null;

                gvOrders.DataBind();

                ShowMessage(
                    "SQLite database error: " +
                    ex.Message
                );
            }
            catch (Exception ex)
            {
                gvOrders.DataSource = null;

                gvOrders.DataBind();

                ShowMessage(
                    "Could not load orders: " +
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
