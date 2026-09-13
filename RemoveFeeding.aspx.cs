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

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            string qry = "DELETE FROM Feeding WHERE ID = @ID";

        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
         
        Response.Redirect("FeedingMenu.aspx");
        
        }
    }
}