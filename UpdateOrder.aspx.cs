using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Text;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateOrder : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]
                ?.ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // 1. Load the selected order
        protected void txtOrderID_TextChanged(object sender, EventArgs e)
        {
            int orderID;

            if (!int.TryParse(txtOrderID.Text.Trim(), out orderID))
            {
                SetStatus(
                    "Please enter a valid numeric Order ID.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 107)
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
                                // Customer name
                                txtCustomerName.Text =
                                    reader["CustomerName"].ToString();

                                // Table number
                                txtTable.Text =
                                    reader["TableNumber"].ToString();

                                // Quantity
                                txtQuantity.Text =
                                    reader["Quantity"].ToString();

                                // Order date
                                txtDate.Text =
                                    reader["OrderDate"].ToString();

                                // Food items
                                string savedFoodItems =
                                    reader["FoodItems"].ToString();

                                string[] savedNames =
                                    savedFoodItems.Split(
                                        new[] { ", " },
                                        StringSplitOptions.RemoveEmptyEntries
                                    );

                                // Clear all food selections first
                                foreach (ListItem item in cblFooditems.Items)
                                {
                                    item.Selected = false;
                                }

                                // Select saved food items
                                foreach (string savedName in savedNames)
                                {
                                    foreach (ListItem item in cblFooditems.Items)
                                    {
                                        if (item.Text.Trim().Equals(
                                            savedName.Trim(),
                                            StringComparison.OrdinalIgnoreCase))
                                        {
                                            item.Selected = true;
                                        }
                                    }
                                }

                                // Status
                                string status =
                                    reader["Status"].ToString();

                                if (DropDownList1.Items.FindByValue(status) != null)
                                {
                                    DropDownList1.SelectedValue = status;
                                }
                                else if (DropDownList1.Items.FindByText(status) != null)
                                {
                                    DropDownList1.SelectedValue =
                                        DropDownList1.Items.FindByText(status).Value;
                                }

                                // Total price
                                if (reader["TotalPrice"] != DBNull.Value)
                                {
                                    decimal totalPrice =
                                        Convert.ToDecimal(
                                            reader["TotalPrice"]
                                        );

                                    lblPrize.Text =
                                        "R" + totalPrice.ToString("0.00");
                                }

                                SetStatus(
                                    "Order loaded. Make your changes and click Update Order.",
                                    Color.FromArgb(128, 255, 219)
                                );
                            }
                            else
                            {
                                SetStatus(
                                    "No order found with that ID.",
                                    Color.FromArgb(255, 107, 107)
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error retrieving order: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // 2. Update the order
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int orderID;

            if (!int.TryParse(
                txtOrderID.Text.Trim(),
                out orderID))
            {
                SetStatus(
                    "Please enter a valid numeric Order ID.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            string customerName =
                txtCustomerName.Text.Trim();

            string tableNumber =
                txtTable.Text.Trim();

            string date =
                txtDate.Text.Trim();

            int quantity;

            if (!int.TryParse(
                txtQuantity.Text.Trim(),
                out quantity) || quantity <= 0)
            {
                SetStatus(
                    "Please enter a valid quantity.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // Validation
            if (string.IsNullOrEmpty(customerName))
            {
                SetStatus(
                    "Customer name is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // Get selected food items
            StringBuilder foodItems =
                new StringBuilder();

            decimal itemsTotal = 0;

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    if (foodItems.Length > 0)
                    {
                        foodItems.Append(", ");
                    }

                    foodItems.Append(
                        item.Text.Trim()
                    );

                    itemsTotal +=
                        decimal.Parse(item.Value);
                }
            }

            if (foodItems.Length == 0)
            {
                SetStatus(
                    "Please select at least one food item.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // Calculate total
            decimal total =
                itemsTotal * quantity;

            string connStr =
                GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        UPDATE Restaurant_Order
                        SET
                            CustomerName = @CustomerName,
                            TableNumber = @TableNumber,
                            FoodItems = @FoodItems,
                            Quantity = @Quantity,
                            TotalPrice = @TotalPrice,
                            OrderDate = @OrderDate,
                            Status = @Status
                        WHERE OrderID = @OrderID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@CustomerName",
                            customerName
                        );

                        cmd.Parameters.AddWithValue(
                            "@TableNumber",
                            tableNumber
                        );

                        cmd.Parameters.AddWithValue(
                            "@FoodItems",
                            foodItems.ToString()
                        );

                        cmd.Parameters.AddWithValue(
                            "@Quantity",
                            quantity
                        );

                        cmd.Parameters.AddWithValue(
                            "@TotalPrice",
                            total
                        );

                        cmd.Parameters.AddWithValue(
                            "@OrderDate",
                            date
                        );

                        string status =
                            DropDownList1.SelectedValue;

                        if (status == "0")
                        {
                            status = "Pending";
                        }

                        cmd.Parameters.AddWithValue(
                            "@Status",
                            status
                        );

                        cmd.Parameters.AddWithValue(
                            "@OrderID",
                            orderID
                        );

                        con.Open();

                        int rowsAffected =
                            cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblPrize.Text =
                                "R" + total.ToString("0.00");

                            SetStatus(
                                "Order #" + orderID +
                                " updated successfully!",
                                Color.FromArgb(128, 255, 219)
                            );
                        }
                        else
                        {
                            SetStatus(
                                "Order could not be updated.",
                                Color.FromArgb(255, 107, 107)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during update: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // 3. Dashboard button
        protected void btnDashboard_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "RestaurantOrders_Dashboard.aspx",
                false
            );
        }

        // 4. Display messages
        private void SetStatus(
            string message,
            Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}