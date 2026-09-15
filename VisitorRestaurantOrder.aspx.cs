using System;
using System.Configuration;
using System.Data.SQLite;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class VisitorRestaurantOrder : System.Web.UI.Page
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
        }

        protected void btnPlaceOrder_Click(
            object sender,
            EventArgs e)
        {
            // Validate table number
            if (string.IsNullOrWhiteSpace(txtTable.Text))
            {
                ShowMessage(
                    "Please enter your table number.",
                    false
                );

                return;
            }

            // Validate quantity
            int quantity;

            if (!int.TryParse(
                txtQuantity.Text,
                out quantity) ||
                quantity <= 0)
            {
                ShowMessage(
                    "Please enter a valid quantity.",
                    false
                );

                return;
            }

            // Get selected food items
            StringBuilder foodItems =
                new StringBuilder();

            decimal itemTotal = 0;

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    if (foodItems.Length > 0)
                    {
                        foodItems.Append(", ");
                    }

                    foodItems.Append(item.Text);

                    itemTotal +=
                        decimal.Parse(item.Value);
                }
            }

            // Make sure at least one food item is selected
            if (foodItems.Length == 0)
            {
                ShowMessage(
                    "Please select at least one food item.",
                    false
                );

                return;
            }

            // Calculate total
            decimal total =
                itemTotal * quantity;

            int visitorID =
                Convert.ToInt32(
                    Session["VisitorID"]
                );

            string customerName =
                Session["VisitorName"] != null
                ? Session["VisitorName"].ToString()
                : "Visitor";

            long newOrderID;

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    // Use the actual Restaurant_Order table
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
                            'Pending'
                        )";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@VisitorID",
                            visitorID
                        );

                        cmd.Parameters.AddWithValue(
                            "@CustomerName",
                            customerName
                        );

                        cmd.Parameters.AddWithValue(
                            "@TableNumber",
                            txtTable.Text.Trim()
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
                            DateTime.Today.ToString(
                                "yyyy-MM-dd"
                            )
                        );

                        con.Open();

                        cmd.ExecuteNonQuery();

                        newOrderID =
                            con.LastInsertRowId;
                    }
                }

                ShowMessage(
                    $"Order #{newOrderID} placed successfully! Total: R{total:0.00}",
                    true
                );

                // Clear the form
                txtTable.Text = "";
                txtQuantity.Text = "";

                foreach (ListItem item in
                    cblFooditems.Items)
                {
                    item.Selected = false;
                }
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error placing order: " +
                    ex.Message,
                    false
                );
            }
        }

        protected void btnMyOrders_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "VisitorMyOrders.aspx",
                false
            );
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

        private void ShowMessage(
            string message,
            bool success)
        {
            lblMsg.Text = message;

            lblMsg.CssClass =
                success
                ? "msg msg-success"
                : "msg msg-error";
        }
    }
}