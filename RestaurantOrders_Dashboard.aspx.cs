using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class RestaurantOrders_Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (Session["LoggedInStaffID"] == null)
            {
                Response.Redirect("EmployeeLogin.aspx");
                return;
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddOrder.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect("Update_Orders.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Response.Redirect("DeleteOrder.aspx");
        }

        protected void btnDisplay_Click(object sender, EventArgs e)
        {
            Response.Redirect("Display Orders.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            HandleReturn();
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            HandleReturn();
        }

        // Shared logic to route correctly based on user role
        private void HandleReturn()
        {
            string role = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString().Trim().ToLower() : "";

            if (role == "admin" || role == "manager")
            {
                Response.Redirect("AdminDashBoard.aspx");
            }
            else
            {
                // Route restaurant employees and other staff to the standard dashboard
                Response.Redirect("EmployeeDashboard.aspx");
            }
        }
    }
}