using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorMyOrders : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VisitorID"] == null)
            {
                Response.Redirect("VisitorLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders()
        {
            int visitorID =
                Convert.ToInt32(Session["VisitorID"]);

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            OrderID,
                            FoodItems,
                            Quantity,
                            TotalPrice,
                            OrderDate,
                            Status
                        FROM Restaurant_Order
                        WHERE VisitorID = @VisitorID
                        ORDER BY OrderID DESC";

                    using (SQLiteDataAdapter da =
                        new SQLiteDataAdapter(sql, con))
                    {
                        da.SelectCommand.Parameters.AddWithValue(
                            "@VisitorID",
                            visitorID
                        );

                        DataTable dt =
                            new DataTable();

                        da.Fill(dt);

                        gvMyOrders.DataSource = dt;
                        gvMyOrders.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Prevent the page from crashing if there is a database error
                gvMyOrders.DataSource = null;
                gvMyOrders.DataBind();
            }
        }

        protected void btnBack_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "VisitorDashboard.aspx",
                false
            );
        }
    }
}