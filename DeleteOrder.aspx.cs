using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
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
            if (!IsPostBack)
            {
                LoadOrderDropdown();
            }
        }

        // =========================================================
        // LOAD ORDERS INTO DROPDOWN
        // =========================================================

        private void LoadOrderDropdown()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            OrderID,
                            CustomerName,
                            TableNumber
                        FROM Restaurant_Order
                        ORDER BY OrderID DESC";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader =
                               cmd.ExecuteReader())
                        {
                            ddlSelectOrder.DataSource = reader;

                            ddlSelectOrder.DataTextField =
                                "CustomerName";

                            ddlSelectOrder.DataValueField =
                                "OrderID";

                            ddlSelectOrder.DataBind();
                        }
                    }
                }

                // Add default option
                ddlSelectOrder.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select an Order --",
                        ""
                    )
                );

                pnlOrderDetails.Visible = false;
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading orders: " + ex.Message,
                    Color.FromArgb(255, 107, 122)
                );
            }
        }


        // =========================================================
        // WHEN USER SELECTS AN ORDER
        // =========================================================

        protected void ddlSelectOrder_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblMessage.Text = "";

            if (string.IsNullOrEmpty(
                ddlSelectOrder.SelectedValue))
            {
                pnlOrderDetails.Visible = false;
                return;
            }

            int orderID;

            if (!int.TryParse(
                ddlSelectOrder.SelectedValue,
                out orderID))
            {
                pnlOrderDetails.Visible = false;
                return;
            }

            LoadOrderDetails(orderID);
        }


        // =========================================================
        // LOAD SELECTED ORDER DETAILS
        // =========================================================

        private void LoadOrderDetails(int orderID)
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
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
                        WHERE OrderID = @OrderID";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@OrderID",
                            orderID
                        );

                        con.Open();

                        using (SQLiteDataReader reader =
                               cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblOrderID.Text =
                                    reader["OrderID"].ToString();

                                lblCustomerName.Text =
                                    reader["CustomerName"].ToString();

                                lblTableNumber.Text =
                                    reader["TableNumber"].ToString();

                                lblFoodItems.Text =
                                    reader["FoodItems"].ToString();

                                lblQuantity.Text =
                                    reader["Quantity"].ToString();

                                decimal totalPrice;

                                if (decimal.TryParse(
                                    reader["TotalPrice"].ToString(),
                                    out totalPrice))
                                {
                                    lblTotalPrice.Text =
                                        "R" +
                                        totalPrice.ToString("0.00");
                                }
                                else
                                {
                                    lblTotalPrice.Text =
                                        reader["TotalPrice"].ToString();
                                }

                                lblOrderDate.Text =
                                    reader["OrderDate"].ToString();

                                lblStatus.Text =
                                    reader["Status"].ToString();

                                pnlOrderDetails.Visible = true;
                            }
                            else
                            {
                                pnlOrderDetails.Visible = false;

                                SetStatus(
                                    "Order could not be found.",
                                    Color.FromArgb(255, 107, 122)
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlOrderDetails.Visible = false;

                SetStatus(
                    "Error retrieving order details: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 122)
                );
            }
        }


        // =========================================================
        // DELETE ORDER
        // =========================================================

        protected void btnDelete_Click(
            object sender,
            EventArgs e)
        {
            if (string.IsNullOrEmpty(
                ddlSelectOrder.SelectedValue))
            {
                SetStatus(
                    "Please select an order first.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            int orderID;

            if (!int.TryParse(
                ddlSelectOrder.SelectedValue,
                out orderID))
            {
                SetStatus(
                    "Invalid Order ID.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                        DELETE FROM Restaurant_Order
                        WHERE OrderID = @OrderID";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@OrderID",
                            orderID
                        );

                        con.Open();

                        int rowsAffected =
                            cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            pnlOrderDetails.Visible = false;

                            SetStatus(
                                "Order #" +
                                orderID +
                                " was successfully deleted.",
                                Color.FromArgb(0, 191, 166)
                            );

                            // Reload dropdown
                            LoadOrderDropdown();
                        }
                        else
                        {
                            SetStatus(
                                "No order was found with ID #" +
                                orderID +
                                ".",
                                Color.FromArgb(255, 107, 122)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during deletion: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 122)
                );
            }
        }


        // =========================================================
        // RETURN TO ORDER DASHBOARD
        // =========================================================

        protected void btnDashboard_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "RestaurantOrders_Dashboard.aspx",
                false
            );
        }


        // =========================================================
        // STATUS MESSAGE
        // =========================================================

        private void SetStatus(
            string message,
            Color color)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = color;
        }
    }
}
