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


                // ====================================================
                // DATABASE CONNECTION
                // ====================================================

                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();


                    // =================================================
                    // SQL QUERY
                    // =================================================

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
                // CALCULATE TOTAL REVENUE
                // ====================================================

                decimal totalRevenue = 0;


                foreach (DataRow row in dt.Rows)
                {
                    if (row["TotalPrice"] != DBNull.Value)
                    {
                        decimal orderTotal;


                        if (decimal.TryParse(
                            row["TotalPrice"].ToString(),
                            out orderTotal))
                        {
                            totalRevenue += orderTotal;
                        }
                    }
                }


                // ====================================================
                // DISPLAY TOTAL REVENUE
                // ====================================================

                lblTotalRevenue.Text =
                    "R " + totalRevenue.ToString("N2");


                // ====================================================
                // CHECK FOR EMPTY TABLE
                // ====================================================

                if (dt.Rows.Count == 0)
                {
                    lblTotalRevenue.Text = "R 0.00";

                    ShowMessage(
                        "No restaurant orders were found."
                    );
                }
            }
            catch (SQLiteException ex)
            {
                gvOrders.DataSource = null;

                gvOrders.DataBind();

                lblTotalRevenue.Text = "R 0.00";


                ShowMessage(
                    "SQLite database error: " +
                    ex.Message
                );
            }
            catch (Exception ex)
            {
                gvOrders.DataSource = null;

                gvOrders.DataBind();

                lblTotalRevenue.Text = "R 0.00";


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
