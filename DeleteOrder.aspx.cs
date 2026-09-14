using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class DeleteOrder : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]?
                .ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnDashboard_Click(object sender, EventArgs e)
        {
            Response.Redirect("RestaurantOrders_Dashboard.aspx", false);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            int orderID;

            if (!int.TryParse(TextBox1.Text.Trim(), out orderID))
            {
                SetStatus(
                    "Please enter a valid numeric Order ID.",
                    Color.FromArgb(255, 107, 122)
                );
                return;
            }

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection conn = new SQLiteConnection(connStr))
                {
                    string sql = "DELETE FROM Restaurant_Order WHERE OrderID = @OrderID";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@OrderID", orderID);

                        conn.Open();

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SetStatus(
                                "Order #" + orderID + " was successfully deleted.",
                                Color.FromArgb(0, 191, 166)
                            );

                            TextBox1.Text = "";
                        }
                        else
                        {
                            SetStatus(
                                "No order found with that ID.",
                                Color.FromArgb(255, 107, 122)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during deletion: " + ex.Message,
                    Color.FromArgb(255, 107, 122)
                );
            }
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}