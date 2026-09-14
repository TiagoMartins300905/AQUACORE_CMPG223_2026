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
            Response.Redirect("MainScreen.aspx");
        }
    }
}