using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class RemoveFeeding : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected System.Void btnBack_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("FeedingMenu.aspx");
        }
    }
}