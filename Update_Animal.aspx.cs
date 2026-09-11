using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Update_Animal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblGender.Visible = false;
        }

        protected void rdbMale_CheckedChanged1(object sender, EventArgs e)
        {

        }

        protected void btnMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Animals_DashBoard.aspx", false);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {

        }
    }
}