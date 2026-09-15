using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Update_Orders : System.Web.UI.Page
    {
        // =========================================================
        // CONNECTION STRING
        // =========================================================

        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]
                ?.ConnectionString;
        }

        // =========================================================
        // PAGE LOAD
        // =========================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlEditForm.Visible = false;
                LoadOrderDropdown();
            }
        }

        // =========================================================
        // LOAD ORDER DROPDOWN
        // =========================================================

        private void LoadOrderDropdown()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string missing in Web.config.",
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
                        OrderID,
                        'Order #' || OrderID ||
                        ' - ' ||
                        COALESCE(CustomerName, 'Unknown Customer')
                        AS OrderDisplay
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
                                "OrderDisplay";

                            ddlSelectOrder.DataValueField =
                                "OrderID";

                            ddlSelectOrder.DataBind();
                        }
                    }
                }

                ddlSelectOrder.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select an Order --",
                        ""
                    )
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading orders: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // =========================================================
        // SELECT ORDER
        // =========================================================

        protected void ddlSelectOrder_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblStatus.Text = "";

            if (string.IsNullOrEmpty(
                ddlSelectOrder.SelectedValue))
            {
                pnlEditForm.Visible = false;
                return;
            }

            int orderID;

            if (!int.TryParse(
                ddlSelectOrder.SelectedValue,
                out orderID))
            {
                pnlEditForm.Visible = false;

                SetStatus(
                    "Invalid order selected.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            LoadOrder(orderID);
        }

        // =========================================================
        // LOAD SELECTED ORDER
        // =========================================================

        private void LoadOrder(int orderID)
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string missing in Web.config.",
                    Color.FromArgb(255, 107, 107)
                );

                pnlEditForm.Visible = false;
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
                                    reader["CustomerName"] == DBNull.Value
                                        ? ""
                                        : reader["CustomerName"].ToString();

                                // Table number
                                txtTable.Text =
                                    reader["TableNumber"] == DBNull.Value
                                        ? ""
                                        : reader["TableNumber"].ToString();

                                // Quantity
                                txtQuantity.Text =
                                    reader["Quantity"] == DBNull.Value
                                        ? "1"
                                        : reader["Quantity"].ToString();

                                // Order date
                                if (reader["OrderDate"] != DBNull.Value)
                                {
                                    DateTime orderDate;

                                    if (DateTime.TryParse(
                                        reader["OrderDate"].ToString(),
                                        out orderDate))
                                    {
                                        txtDate.Text =
                                            orderDate.ToString("yyyy-MM-dd");
                                    }
                                    else
                                    {
                                        txtDate.Text = "";
                                    }
                                }
                                else
                                {
                                    txtDate.Text = "";
                                }

                                // Status
                                string status =
                                    reader["Status"] == DBNull.Value
                                        ? ""
                                        : reader["Status"].ToString();

                                ListItem statusItem =
                                    ddlStatus.Items.FindByValue(status);

                                if (statusItem != null)
                                {
                                    ddlStatus.SelectedValue = status;
                                }
                                else
                                {
                                    ddlStatus.SelectedIndex = 0;
                                }

                                // Food items
                                string foodItems =
                                    reader["FoodItems"] == DBNull.Value
                                        ? ""
                                        : reader["FoodItems"].ToString();

                                LoadFoodItems(foodItems);

                                // Calculate total
                                CalculateTotal();

                                pnlEditForm.Visible = true;
                            }
                            else
                            {
                                pnlEditForm.Visible = false;

                                SetStatus(
                                    "Order could not be found.",
                                    Color.FromArgb(255, 107, 107)
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlEditForm.Visible = false;

                SetStatus(
                    "Error retrieving order: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // =========================================================
        // LOAD FOOD ITEMS
        // =========================================================

        private void LoadFoodItems(string foodItems)
        {
            // Clear all existing selections first
            foreach (ListItem item in cblFooditems.Items)
            {
                item.Selected = false;
            }

            if (string.IsNullOrWhiteSpace(foodItems))
            {
                CalculateTotal();
                return;
            }

            string[] selectedItems =
                foodItems.Split(',');

            foreach (string selectedFood in selectedItems)
            {
                string food =
                    selectedFood.Trim();

                foreach (ListItem item in cblFooditems.Items)
                {
                    /*
                     * The database stores the Value.
                     *
                     * Burger = 55
                     * Pizza = 85
                     * Pasta = 65
                     * Drink = 25
                     */

                    if (item.Value.Equals(
                        food,
                        StringComparison.OrdinalIgnoreCase))
                    {
                        item.Selected = true;
                    }
                }
            }

            CalculateTotal();
        }

        // =========================================================
        // CALCULATE TOTAL
        // =========================================================

        private decimal CalculateTotal()
        {
            decimal total = 0;

            int quantity = 1;

            if (!int.TryParse(
                txtQuantity.Text.Trim(),
                out quantity))
            {
                quantity = 1;
            }

            if (quantity <= 0)
            {
                quantity = 1;
            }

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    decimal price;

                    if (decimal.TryParse(
                        item.Value,
                        out price))
                    {
                        total += price;
                    }
                }
            }

            total = total * quantity;

            lblPrize.Text =
                "R" + total.ToString("0.00");

            return total;
        }

        // =========================================================
        // GET SELECTED FOOD ITEMS
        // =========================================================

        private string GetSelectedFoodItems()
        {
            string foodItems = "";

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    if (!string.IsNullOrEmpty(foodItems))
                    {
                        foodItems += ",";
                    }

                    /*
                     * Store the Value rather than the display text.
                     *
                     * Example:
                     *
                     * 55,85
                     *
                     * instead of:
                     *
                     * Burger — R55,Pizza — R85
                     */

                    foodItems += item.Value;
                }
            }

            return foodItems;
        }

        // =========================================================
        // UPDATE ORDER
        // =========================================================

        protected void btnUpdate_Click(
            object sender,
            EventArgs e)
        {
            lblStatus.Text = "";

            // -----------------------------------------------------
            // Check selected order
            // -----------------------------------------------------

            if (string.IsNullOrEmpty(
                ddlSelectOrder.SelectedValue))
            {
                SetStatus(
                    "Please select an order first.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            int orderID;

            if (!int.TryParse(
                ddlSelectOrder.SelectedValue,
                out orderID))
            {
                SetStatus(
                    "Invalid order selected.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Get form values
            // -----------------------------------------------------

            string customerName =
                txtCustomerName.Text.Trim();

            string tableNumber =
                txtTable.Text.Trim();

            string quantityText =
                txtQuantity.Text.Trim();

            string dateText =
                txtDate.Text.Trim();

            string status =
                ddlStatus.SelectedValue;

            // -----------------------------------------------------
            // Validate customer
            // -----------------------------------------------------

            if (string.IsNullOrEmpty(customerName))
            {
                SetStatus(
                    "Customer name is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Validate table
            // -----------------------------------------------------

            if (string.IsNullOrEmpty(tableNumber))
            {
                SetStatus(
                    "Table number is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Validate quantity
            // -----------------------------------------------------

            int quantity;

            if (!int.TryParse(
                quantityText,
                out quantity) ||
                quantity <= 0)
            {
                SetStatus(
                    "Please enter a valid quantity.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Validate date
            // -----------------------------------------------------

            DateTime orderDate;

            if (!DateTime.TryParse(
                dateText,
                out orderDate))
            {
                SetStatus(
                    "Please enter a valid order date.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Validate status
            // -----------------------------------------------------

            if (string.IsNullOrEmpty(status))
            {
                SetStatus(
                    "Please select an order status.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Validate food selection
            // -----------------------------------------------------

            bool foodSelected = false;

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    foodSelected = true;
                    break;
                }
            }

            if (!foodSelected)
            {
                SetStatus(
                    "Please select at least one food item.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Get selected food items
            // -----------------------------------------------------

            string foodItems =
                GetSelectedFoodItems();

            // -----------------------------------------------------
            // Calculate total
            // -----------------------------------------------------

            decimal totalPrice =
                CalculateTotal();

            // -----------------------------------------------------
            // Database connection
            // -----------------------------------------------------

            string connStr =
                GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string missing in Web.config.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // -----------------------------------------------------
            // Update database
            // -----------------------------------------------------

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
                            foodItems
                        );

                        cmd.Parameters.AddWithValue(
                            "@Quantity",
                            quantity
                        );

                        cmd.Parameters.AddWithValue(
                            "@TotalPrice",
                            totalPrice
                        );

                        cmd.Parameters.AddWithValue(
                            "@OrderDate",
                            orderDate.ToString("yyyy-MM-dd")
                        );

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
                            SetStatus(
                                "Order details updated successfully!",
                                Color.FromArgb(128, 255, 219)
                            );

                            // Refresh order dropdown
                            LoadOrderDropdown();

                            // Select the updated order
                            if (ddlSelectOrder.Items.FindByValue(
                                orderID.ToString()) != null)
                            {
                                ddlSelectOrder.SelectedValue =
                                    orderID.ToString();
                            }

                            // Keep edit form visible
                            pnlEditForm.Visible = true;
                        }
                        else
                        {
                            SetStatus(
                                "No order was updated.",
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

        // =========================================================
        // BACK TO RESTAURANT ORDERS DASHBOARD
        // =========================================================

        protected void btnDashboard_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "RestaurantOrders_Dashboard.aspx"
            );
        }

        // =========================================================
        // STATUS MESSAGE
        // =========================================================

        private void SetStatus(
            string message,
            Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }

}