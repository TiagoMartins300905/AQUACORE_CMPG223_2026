using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class Display_Orders : System.Web.UI.Page
    {
        private string connStr =
            ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    con.Open();

                    string sql = @"
                        SELECT OrderID,
                               CustomerName,
                               TableNumber,
                               FoodItems,
                               Quantity,
                               TotalPrice,
                               OrderDate,
                               Status
                        FROM Restaurant_Order
                        ORDER BY OrderID";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        using (SQLiteDataAdapter adapter = new SQLiteDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            adapter.Fill(dt);

                            gvOrders.DataSource = dt;
                            gvOrders.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    "Error loading orders: " + ex.Message
                );
            }
        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("RestaurantOrders_Dashboard.aspx", false);
        }
    }
}