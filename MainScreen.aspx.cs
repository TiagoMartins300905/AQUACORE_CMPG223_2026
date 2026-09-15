using System;
using System.Web;
using System.Web.UI;

/*
Tiago Martins	52052532
Zoe Claassens	50959042
Knowledge Tshabalala	55456367
Ruby Nyabvure	49948989
Lihle Tshona	51748584
Thokozani Mahlangu	50833464
Arnold Photsane	39156222
Tebogo Jr Mabuza	49461168
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

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}