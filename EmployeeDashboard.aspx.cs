using System;

namespace AQUACORE_CMPG223
{
    public partial class EmployeeDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["LoggedInStaffID"] == null)
            {
                Response.Redirect("EmployeeLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LblWelcomeName.Text = "Welcome, " + (Session["LoggedInStaffName"] != null ? Session["LoggedInStaffName"].ToString() : "");

                string userRole = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString() : "";
                LblRole.Text = "Active Role: " + userRole;

                ConfigureAccess(userRole);
            }
        }

        private void ConfigureAccess(string role)
        {
            BtnAnimal.Visible = false;
            BtnRestaurant.Visible = false;

            if (string.IsNullOrEmpty(role)) return;

            role = role.Trim().ToLower();
            bool isAdminOrManager = (role == "admin" || role == "manager");

            // 1. Animal Management access (Admin, Manager, Marine Keeper)
            if (isAdminOrManager || role == "marine keeper")
            {
                BtnAnimal.Visible = true;
            }

            // 2. Restaurant access (Admin, Manager, RestaurantEmployee)
            if (isAdminOrManager || role == "restaurantemployee")
            {
                BtnRestaurant.Visible = true;
            }

            // 3. Adaptive Action Button configuration
            if (isAdminOrManager)
            {
                LitBtnText.Text = "Manage Employees";
                SpanIcon.InnerHtml = "👥";
            }
            else
            {
                LitBtnText.Text = "Update My Details";
                SpanIcon.InnerHtml = "✏️";
            }
        }

        protected void BtnAnimal_Click(object sender, EventArgs e)
        {
            Response.Redirect("AnimalManagementDashboard.aspx");
        }

        protected void BtnRestaurant_Click(object sender, EventArgs e)
        {
            Response.Redirect("RestaurantOrders_Dashboard.aspx");
        }

        protected void BtnAdaptiveAction_Click(object sender, EventArgs e)
        {
            string role = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString().Trim().ToLower() : "";
            bool isAdminOrManager = (role == "admin" || role == "manager");

            if (isAdminOrManager)
            {
                // Admins/Managers go to the full staff management directory
                Response.Redirect("EmployeeManagement.aspx");
            }
            else
            {
                // Regular employees go straight to update their own profile
                Response.Redirect("UpdateEmployee.aspx");
            }
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("EmployeeLogin.aspx");
        }
    }
}