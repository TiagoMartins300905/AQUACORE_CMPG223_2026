using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class FeedingMenu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click1(object sender, EventArgs e)
        {
            Response.Redirect("FeedingTimeRegister.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateFeeding.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Response.Redirect("RemoveFeeding.aspx");
        }

        protected void btnView_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewFeedings.aspx");
        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Redirect("AnimalMenuDashboard.aspx");
        }
    }
}