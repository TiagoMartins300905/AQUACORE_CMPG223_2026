using System;
using System.Configuration;
using System.Data.SQLite;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class AddOrder : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("RestaurantOrders_Dashboard.aspx", false);
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            // Build the food items list and total price from the checked items
            StringBuilder foodItems = new StringBuilder();
            decimal itemsTotal = 0;

            foreach (ListItem item in cblFooditems.Items)
            {
                if (item.Selected)
                {
                    if (foodItems.Length > 0) foodItems.Append(", ");
                    foodItems.Append(item.Text);
                    itemsTotal += decimal.Parse(item.Value);
                }
            }

            if (foodItems.Length == 0)
            {
                lblPrize.Text = "Please select at least one food item.";
                return;
            }

            int quantity;
            if (!int.TryParse(txtQuantity.Text, out quantity) || quantity <= 0)
            {
                lblPrize.Text = "Please enter a valid quantity.";
                return;
            }

            decimal total = itemsTotal * quantity;

            using (SQLiteConnection con = new SQLiteConnection(connStr))
            {
                string sql = @"INSERT INTO Restaurant_Order (VisitorID, CustomerName, TableNumber, FoodItems, Quantity, TotalPrice, OrderDate, Status)
                               VALUES (@VisitorID, @CustomerName, @TableNumber, @FoodItems, @Quantity, @TotalPrice, @OrderDate, @Status)";

                SQLiteCommand cmd = new SQLiteCommand(sql, con);

                // This form is for staff logging walk-in orders, so there's no
                // logged-in visitor session to attach. VisitorID stays null here.
                if (Session["VisitorID"] != null)
                    cmd.Parameters.AddWithValue("@VisitorID", Convert.ToInt32(Session["VisitorID"]));
                else
                    cmd.Parameters.AddWithValue("@VisitorID", DBNull.Value);

                cmd.Parameters.AddWithValue("@CustomerName", txtCustomerName.Text.Trim());
                cmd.Parameters.AddWithValue("@TableNumber", txtTable.Text.Trim());
                cmd.Parameters.AddWithValue("@FoodItems", foodItems.ToString());
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@TotalPrice", total);
                cmd.Parameters.AddWithValue("@OrderDate", txtDate.Text.Trim());
                cmd.Parameters.AddWithValue("@Status", DropDownList1.SelectedValue == "0" ? "Pending" : DropDownList1.SelectedValue);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblPrize.Text = "R" + total.ToString("0.00");

            // Clear the form for the next order
            txtCustomerName.Text = "";
            txtTable.Text = "";
            txtQuantity.Text = "";
            txtDate.Text = "";
            foreach (ListItem item in cblFooditems.Items)
                item.Selected = false;
        }
    }
}