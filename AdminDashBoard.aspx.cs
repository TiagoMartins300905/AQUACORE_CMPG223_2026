using System;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class AdminDashBoard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Dashboard initialization code goes here.
            }
        }

        // =========================================================
        // VISITORS DASHBOARD
        // =========================================================

        protected void btnVisitors_Click(object sender, EventArgs e)
        {
            // Add your Visitors dashboard redirect here.

            // Example:
            // Response.Redirect("VisitorsDashboard.aspx");
        }


        // =========================================================
        // EMPLOYEES DASHBOARD
        // =========================================================

        protected void btnEmployees_Click(object sender, EventArgs e)
        {
            // Add your Employees dashboard redirect here.
            Response.Redirect("EmployeeManagement.aspx");
            // Example:
            // Response.Redirect("EmployeesDashboard.aspx");
        }


        // =========================================================
        // ANIMALS DASHBOARD
        // =========================================================

        protected void btnAnimals_Click(object sender, EventArgs e)
        {
            // Add your Animals dashboard redirect here.
            Response.Redirect("AnimalManagementDashboard.aspx");
            // Example:
            // Response.Redirect("AnimalsDashboard.aspx");
        }


        // =========================================================
        // RESTAURANT DASHBOARD
        // =========================================================

        protected void btnRestaurant_Click(object sender, EventArgs e)
        {
            // Add your Restaurant dashboard redirect here.
            Response.Redirect("RestaurantOrders_Dashboard.aspx");
            // Example:
            // Response.Redirect("RestaurantDashboard.aspx");
        }


        // =========================================================
        // LOGOUT
        // =========================================================

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Add your logout redirect here.
            Response.Redirect("EmployeeLogin.aspx");
            // Example:
            // Session.Clear();
            // Session.Abandon();
            // Response.Redirect("Login.aspx");
        }
    }
}
