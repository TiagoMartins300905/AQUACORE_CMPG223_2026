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
                LoadOrderDropdown();
            }
        }


        // =========================================================
        // LOAD ORDERS
        // =========================================================

        private void LoadOrderDropdown()
        {
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
                            OrderID,
                            'Order #' || OrderID ||
                            ' - ' || CustomerName AS OrderDisplay
                        FROM Orders
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
        // LOAD SELECTED ORDER
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
                SetStatus(
                    "Invalid order selected.",
                    Color.FromArgb(255, 107, 107)
                );

                pnlEditForm.Visible = false;

                return;
            }

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
                        SELECT
                            CustomerName,
                            TableNumber,
                            Quantity,
                            OrderDate,
                            FoodItems,
                            Status,
                            TotalPrice
                        FROM Orders
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
                                // Customer
                                txtCustomerName.Text =
                                    reader["CustomerName"]
                                    .ToString();


                                // Table
                                txtTable.Text =
                                    reader["TableNumber"]
                                    .ToString();


                                // Quantity
                                txtQuantity.Text =
                                    reader["Quantity"]
                                    .ToString();


                                // Date
                                if (reader["OrderDate"] != DBNull.Value)
                                {
                                    DateTime orderDate =
                                        Convert.ToDateTime(
                                            reader["OrderDate"]
                                        );

                                    txtDate.Text =
                                        orderDate.ToString(
                                            "yyyy-MM-dd"
                                        );
                                }
                                else
                                {
                                    txtDate.Text = "";
                                }


                                // Status
                                string status =
                                    reader["Status"]
                                    .ToString();

                                if (ddlStatus.Items
                                    .FindByValue(status) != null)
                                {
                                    ddlStatus.SelectedValue =
                                        status;
                                }
                                else
                                {
                                    ddlStatus.SelectedIndex = 0;
                                }


                                // Food items
                                string foodItems = "";

                                if (reader["FoodItems"] != DBNull.Value)
                                {
                                    foodItems =
                                        reader["FoodItems"]
                                        .ToString();
                                }

                                LoadFoodItems(foodItems);


                                // Total
                                if (reader["TotalPrice"] != DBNull.Value)
                                {
                                    decimal total =
                                        Convert.ToDecimal(
                                            reader["TotalPrice"]
                                        );

                                    lblPrize.Text =
                                        "R" +
                                        total.ToString("0.00");
                                }
                                else
                                {
                                    CalculateTotal();
                                }


                                // Show form
                                pnlEditForm.Visible = true;
                            }
                            else
                            {
                                SetStatus(
                                    "Order could not be found.",
                                    Color.FromArgb(255, 107, 107)
                                );

                                pnlEditForm.Visible = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error retrieving order: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107)
                );

                pnlEditForm.Visible = false;
            }
        }


        // =========================================================
        // LOAD FOOD ITEMS
        // =========================================================

        private void LoadFoodItems(string foodItems)
        {
            foreach (ListItem item in cblFooditems.Items)
            {
                item.Selected = false;
            }

            if (string.IsNullOrEmpty(foodItems))
            {
                CalculateTotal();

                return;
            }

            string[] selectedFoods =
                foodItems.Split(',');

            foreach (string food in selectedFoods)
            {
                string trimmedFood =
                    food.Trim();

                foreach (ListItem item in cblFooditems.Items)
                {
                    if (item.Text.Contains("Burger") &&
                        trimmedFood.Equals(
                            "Burger",
                            StringComparison.OrdinalIgnoreCase))
                    {
                        item.Selected = true;
                    }

                    else if (
                        item.Text.Contains("Pizza") &&
                        trimmedFood.Equals(
                            "Pizza",
                            StringComparison.OrdinalIgnoreCase))
                    {
                        item.Selected = true;
                    }

                    else if (
                        item.Text.Contains("Pasta") &&
                        trimmedFood.Equals(
                            "Pasta",
                            StringComparison.OrdinalIgnoreCase))
                    {
                        item.Selected = true;
                    }

                    else if (
                        item.Text.Contains("Drink") &&
                        trimmedFood.Equals(
                            "Drink",
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

            int.TryParse(
                txtQuantity.Text.Trim(),
                out quantity
            );

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

            total *= quantity;

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
                    string foodName = "";

                    if (item.Text.Contains("Burger"))
                    {
                        foodName = "Burger";
                    }
                    else if (item.Text.Contains("Pizza"))
                    {
                        foodName = "Pizza";
                    }
                    else if (item.Text.Contains("Pasta"))
                    {
                        foodName = "Pasta";
                    }
                    else if (item.Text.Contains("Drink"))
                    {
                        foodName = "Drink";
                    }

                    if (!string.IsNullOrEmpty(foodName))
                    {
                        if (!string.IsNullOrEmpty(foodItems))
                        {
                            foodItems += ",";
                        }

                        foodItems += foodName;
                    }
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
            if (string.IsNullOrEmpty(
                ddlSelectOrder.SelectedValue))
            {
                SetStatus(
                    "Please select an order.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // -----------------------------------------------------
            // Order ID
            // -----------------------------------------------------

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
            // Values
            // -----------------------------------------------------

            string customerName =
                txtCustomerName.Text.Trim();

            string tableNumber =
                txtTable.Text.Trim();

            string quantityInput =
                txtQuantity.Text.Trim();

            string dateInput =
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
                quantityInput,
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
                dateInput,
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
            // Validate food
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
            // Total
            // -----------------------------------------------------

            decimal totalPrice =
                CalculateTotal();


            // -----------------------------------------------------
            // Food items
            // -----------------------------------------------------

            string foodItems =
                GetSelectedFoodItems();


            // -----------------------------------------------------
            // Connection
            // -----------------------------------------------------

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


            // -----------------------------------------------------
            // Database update
            // -----------------------------------------------------

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        UPDATE Orders
                        SET
                            CustomerName = @CustomerName,
                            TableNumber = @TableNumber,
                            Quantity = @Quantity,
                            OrderDate = @OrderDate,
                            FoodItems = @FoodItems,
                            Status = @Status,
                            TotalPrice = @TotalPrice
                        WHERE OrderID = @OrderID";


                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@OrderID",
                            orderID
                        );

                        cmd.Parameters.AddWithValue(
                            "@CustomerName",
                            customerName
                        );

                        cmd.Parameters.AddWithValue(
                            "@TableNumber",
                            tableNumber
                        );

                        cmd.Parameters.AddWithValue(
                            "@Quantity",
                            quantity
                        );

                        cmd.Parameters.AddWithValue(
                            "@OrderDate",
                            orderDate
                        );

                        cmd.Parameters.AddWithValue(
                            "@FoodItems",
                            foodItems
                        );

                        cmd.Parameters.AddWithValue(
                            "@Status",
                            status
                        );

                        cmd.Parameters.AddWithValue(
                            "@TotalPrice",
                            totalPrice
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


                            // Refresh dropdown
                            LoadOrderDropdown();


                            // Select same order
                            if (ddlSelectOrder.Items
                                .FindByValue(
                                    orderID.ToString())
                                != null)
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


        // =========================================================
        // DASHBOARD BUTTON
        // =========================================================

        protected void btnDashboard_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Orders_Dashboard.aspx",
                false
            );

            Context.ApplicationInstance
                .CompleteRequest();
        }


        // =========================================================
        // STATUS MESSAGE
        // =========================================================

        private void SetStatus(
            string message,
            Color color)
        {
            lblStatus.Text =
                message;

            lblStatus.ForeColor =
                color;
        }
    }
}
