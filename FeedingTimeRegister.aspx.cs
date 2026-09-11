using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected System.Void btnClear_Click(System.Object sender, System.EventArgs e)
        {
            ddlAnimal.SelectedIndex = 0;
            ddlFoodType.SelectedIndex = 0;
            ddlKeeper.SelectedIndex = 0;
            ddlTime.SelectedIndex = 0;
        }

        protected System.Void btnBack_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("FeedingMenu.aspx");
        }
    }
}