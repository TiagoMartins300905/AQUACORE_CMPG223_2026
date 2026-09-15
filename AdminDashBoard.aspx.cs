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
                
            }
        }

        // =========================================================
        // VISITORS DASHBOARD
        // =========================================================

        protected void btnVisitors_Click(object sender, EventArgs e)
        {

            Response.Redirect("ViewVisitors.aspx");
        }


        // =========================================================
        // EMPLOYEES DASHBOARD
        // =========================================================

        protected void btnEmployees_Click(object sender, EventArgs e)
        {
            // Add your Employees dashboard redirect here.
            Response.Redirect("EmployeeManagement.aspx");
            
        }


        // =========================================================
        // ANIMALS DASHBOARD
        // =========================================================

        protected void btnAnimals_Click(object sender, EventArgs e)
        {
            // Add your Animals dashboard redirect here.
            Response.Redirect("AnimalManagementDashboard.aspx");
            
        }


        // =========================================================
        // RESTAURANT DASHBOARD
        // =========================================================

        protected void btnRestaurant_Click(object sender, EventArgs e)
        {
            // Add your Restaurant dashboard redirect here.
            Response.Redirect("RestaurantOrders_Dashboard.aspx");
            
        }


        // =========================================================
        // LOGOUT
        // =========================================================

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Add your logout redirect here.
            Response.Redirect("EmployeeLogin.aspx");
            
        }
    }
}
