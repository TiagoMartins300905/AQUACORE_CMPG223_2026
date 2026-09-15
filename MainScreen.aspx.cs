using System;
using System.Web;
using System.Web.UI;

/*
R. Nyabvure 49948989
L. Tshona	5174858
Z. Claassens  50959042
*/

namespace AQUACORE_CMPG223
{
    public partial class MainScreen : Page
    {
        public const string STAFF = "Staff";
        public const string CUSTOMER = "Customer";

        protected void btnStaff_Click(object sender, EventArgs e)
        {
            HttpCookie user = new HttpCookie("Selection");
            user["Selection"] = STAFF;
            user.Expires = DateTime.Now.AddMinutes(15);
            Response.Cookies.Add(user);

            // Redirects to EmployeeLogin
            Response.Redirect("EmployeeLogin.aspx");
        }

        protected void btnVisitors_Click(object sender, EventArgs e)
        {
            HttpCookie user = new HttpCookie("Selection");
            user["Selection"] = CUSTOMER;
            user.Expires = DateTime.Now.AddMinutes(15);
            Response.Cookies.Add(user);

            Response.Redirect("VisitorWelcomePage.aspx");
        }
    }
}