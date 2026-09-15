using System;
using System.Configuration;
using System.Data.SQLite;
using System.Text;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class AddOrder : System.Web.UI.Page
    {
        private string connStr =
            ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]?
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only set the date when the page first loads.
            // This prevents the date from being reset after
            // the user submits the form.
            if (!IsPostBack)
            {
                txtDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }

        // -----------------------------------------
        // RETURN BUTTON
        // -----------------------------------------

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("RestaurantOrders_Dashboard.aspx");
        }

        // -----------------------------------------
        // SUBMIT ORDER
        // -----------------------------------------

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            // -----------------------------------------
            // CHECK DATABASE CONNECTION
            // -----------------------------------------

            if (string.IsNullOrEmpty(connStr))
            {
                lblPrize.Text =
                    "Database connection string 'AquaCoreConnectionString' was not found.";

                return;
            }

            // -----------------------------------------
            // GET SELECTED FOOD ITEMS
            // -----------------------------------------

            StringBuilder foodItems = new StringBuilder();

            decimal itemsTotal = 0;

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    // Add comma between food items
                    if (foodItems.Length > 0)
                    {
                        foodItems.Append(", ");
                    }

                    foodItems.Append(item.Text);

                    // Get food price
                    decimal itemPrice;

                    if (!decimal.TryParse(item.Value, out itemPrice))
                    {
                        lblPrize.Text =
                            "Invalid price for food item: " +
                            item.Text;

                        return;
                    }

                    itemsTotal += itemPrice;
                }
            }

            // -----------------------------------------
            // CHECK FOOD ITEMS
            // -----------------------------------------

            if (foodItems.Length == 0)
            {
                lblPrize.Text =
                    "Please select at least one food item.";

                return;
            }

            // -----------------------------------------
            // VALIDATE QUANTITY
            // -----------------------------------------

            int quantity;

            if (!int.TryParse(
                    txtQuantity.Text.Trim(),
                    out quantity) ||
                quantity <= 0)
            {
                lblPrize.Text =
                    "Please enter a valid quantity.";

                return;
            }

            // -----------------------------------------
            // VALIDATE ORDER DATE
            // -----------------------------------------

            DateTime orderDate;

            if (!DateTime.TryParse(
                    txtDate.Text.Trim(),
                    out orderDate))
            {
                lblPrize.Text =
                    "Please select a valid order date.";

                return;
            }

            // -----------------------------------------
            // CALCULATE TOTAL
            // -----------------------------------------

            decimal total = itemsTotal * quantity;

            // -----------------------------------------
            // INSERT ORDER INTO DATABASE
            // -----------------------------------------

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                        INSERT INTO Restaurant_Order
                        (
                            VisitorID,
                            CustomerName,
                            TableNumber,
                            FoodItems,
                            Quantity,
                            TotalPrice,
                            OrderDate,
                            Status
                        )
                        VALUES
                        (
                            @VisitorID,
                            @CustomerName,
                            @TableNumber,
                            @FoodItems,
                            @Quantity,
                            @TotalPrice,
                            @OrderDate,
                            @Status
                        )";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        // -----------------------------------------
                        // VISITOR ID
                        // -----------------------------------------

                        if (Session["VisitorID"] != null)
                        {
                            int visitorID;

                            if (int.TryParse(
                                    Session["VisitorID"].ToString(),
                                    out visitorID))
                            {
                                cmd.Parameters.AddWithValue(
                                    "@VisitorID",
                                    visitorID);
                            }
                            else
                            {
                                cmd.Parameters.AddWithValue(
                                    "@VisitorID",
                                    DBNull.Value);
                            }
                        }
                        else
                        {
                            // Staff may create a walk-in order.
                            // Therefore VisitorID can be NULL.
                            cmd.Parameters.AddWithValue(
                                "@VisitorID",
                                DBNull.Value);
                        }

                        // -----------------------------------------
                        // CUSTOMER NAME
                        // -----------------------------------------

                        cmd.Parameters.AddWithValue(
                            "@CustomerName",
                            txtCustomerName.Text.Trim());

                        // -----------------------------------------
                        // TABLE NUMBER
                        // -----------------------------------------

                        cmd.Parameters.AddWithValue(
                            "@TableNumber",
                            txtTable.Text.Trim());

                        // -----------------------------------------
                        // FOOD ITEMS
                        // -----------------------------------------

                        cmd.Parameters.AddWithValue(
                            "@FoodItems",
                            foodItems.ToString());

                        // -----------------------------------------
                        // QUANTITY
                        // -----------------------------------------

                        cmd.Parameters.AddWithValue(
                            "@Quantity",
                            quantity);

                        // -----------------------------------------
                        // TOTAL PRICE
                        // -----------------------------------------

                        cmd.Parameters.AddWithValue(
                            "@TotalPrice",
                            total);

                        // -----------------------------------------
                        // ORDER DATE
                        // -----------------------------------------

                        // Store the date in SQLite as:
                        // yyyy-MM-dd
                        //
                        // Example:
                        // 2026-09-15

                        cmd.Parameters.AddWithValue(
                            "@OrderDate",
                            orderDate.ToString("yyyy-MM-dd"));

                        // -----------------------------------------
                        // ORDER STATUS
                        // -----------------------------------------

                        string status =
                            DropDownList1.SelectedValue;

                        if (string.IsNullOrEmpty(status) ||
                            status == "0")
                        {
                            status = "Pending";
                        }

                        cmd.Parameters.AddWithValue(
                            "@Status",
                            status);

                        // -----------------------------------------
                        // OPEN DATABASE
                        // -----------------------------------------

                        con.Open();

                        // -----------------------------------------
                        // INSERT ORDER
                        // -----------------------------------------

                        cmd.ExecuteNonQuery();
                    }
                }

                // -----------------------------------------
                // SUCCESS MESSAGE
                // -----------------------------------------

                lblPrize.Text =
                    "Order successfully added! Total: R" +
                    total.ToString("0.00");

                // -----------------------------------------
                // CLEAR FORM
                // -----------------------------------------

                txtCustomerName.Text = "";

                txtTable.Text = "";

                txtQuantity.Text = "";

                // Reset date to today's date
                txtDate.Text =
                    DateTime.Now.ToString("yyyy-MM-dd");

                // Uncheck all food items
                foreach (ListItem item in cblFooditems.Items)
                {
                    item.Selected = false;
                }

                // Reset status
                if (DropDownList1.Items.Count > 0)
                {
                    DropDownList1.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                // -----------------------------------------
                // DATABASE ERROR
                // -----------------------------------------

                lblPrize.Text =
                    "Error adding order: " +
                    ex.Message;
            }
        }
    }
}
