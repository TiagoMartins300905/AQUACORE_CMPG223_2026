using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorMyOrders : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VisitorID"] == null)
                Response.Redirect("VisitorLogin.aspx");

            if (!IsPostBack)
                LoadOrders();
        }

        private void LoadOrders()
        {
            int visitorID = Convert.ToInt32(Session["VisitorID"]);

            using (SQLiteConnection con = new SQLiteConnection(connStr))
            {
                string sql = @"SELECT OrderID, FoodItems, Quantity, TotalPrice, OrderDate, Status
                               FROM Visitor_Order
                               WHERE VisitorID = @VisitorID
                               ORDER BY OrderID DESC";

                SQLiteDataAdapter da = new SQLiteDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@VisitorID", visitorID);

                DataTable dt = new DataTable();
                da.Fill(dt);

                gvMyOrders.DataSource = dt;
                gvMyOrders.DataBind();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("VisitorDashboard.aspx");
        }
    }
}