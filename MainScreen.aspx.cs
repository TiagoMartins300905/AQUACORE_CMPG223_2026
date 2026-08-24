using System;
using System.Web;
using System.Web.UI;

/*


K. Zhou	51705532
L. Tshona	51748584
R. Mokadi	48642096
T. Mongake	42077605
WJ. King	51569655
Z. Claassens  50959042
Y. Dawood  50434098



*/

namespace AQUACORE_CMPG223
{
    public partial class MainScreen : Page
    {
        public const string ADMIN = "Admin";
        public const string STAFF = "Staff";
        public const string CUSTOMER = "Customer";

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            HttpCookie user = new HttpCookie("Selection");
            user["Selection"] = ADMIN;
            user.Expires = DateTime.Now.AddMinutes(15);
            Response.Cookies.Add(user);

            Response.Redirect("StaffLogin.aspx");
        }

        protected void btnStaff_Click(object sender, EventArgs e)
        {
            HttpCookie user = new HttpCookie("Selection");
            user["Selection"] = STAFF;
            user.Expires = DateTime.Now.AddMinutes(15);
            Response.Cookies.Add(user);

            Response.Redirect("StaffLogin.aspx");
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
