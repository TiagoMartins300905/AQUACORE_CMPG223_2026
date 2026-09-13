using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Add_Medical_R : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lblValidate.Visible = false;
        }

        protected void rdbYes_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Medicals_Dashboard.aspx");
        }
    }
}