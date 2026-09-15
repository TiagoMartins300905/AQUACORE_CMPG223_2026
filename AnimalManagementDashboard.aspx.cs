using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class AnimalManagementDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security check: If someone tries to access this page via URL without logging in, boot them to login
            if (Session["LoggedInStaffID"] == null)
            {
                Response.Redirect("EmployeeLogin.aspx");
                return;
            }
        }

        protected void btnFeeding_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu_Feeding.aspx");
        }

        protected void btnAnimals_Click(object sender, EventArgs e)
        {
            Response.Redirect("Animals_DashBoard.aspx");
        }

        protected void btnMedical_Click(object sender, EventArgs e)
        {
            Response.Redirect("Medicals_Dashboard.aspx");
        }

        protected void btnReturn_Click(object sender, EventArgs e)
        {
            // Fetch the logged-in role from the session
            string role = Session["LoggedInRole"] != null ? Session["LoggedInRole"].ToString().Trim().ToLower() : "";

            // Route based on role
            if (role == "admin" || role == "manager")
            {
                Response.Redirect("AdminDashBoard.aspx");
            }
            else
            {
                // Send Marine Keepers, Restaurant Employees, and any other staff back to the standard dashboard
                Response.Redirect("EmployeeDashboard.aspx");
            }
        }
    }
}