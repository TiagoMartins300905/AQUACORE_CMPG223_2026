using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Medicals_Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            Response.Redirect("Add_Medical_R.aspx");
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateMedical.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Response.Redirect("Delete_Medical_R.aspx");
        }

        protected void btnDisplay_Click(object sender, EventArgs e)
        {
            Response.Redirect("ViewMedical.aspx");
        }
    }
}