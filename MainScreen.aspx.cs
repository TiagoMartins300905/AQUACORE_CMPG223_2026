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
        public const string ADMIN = "Admin";
        public const string STAFF = "Staff";
        public const string CUSTOMER = "Customer";

        // TODO: StaffLogin.aspx does not exist yet (auth is a separate module).
        // Until it's built, staff/admin land on a dead redirect here - the
        // "Employee Management" link in the nav bar (MainScreen.aspx) is the
        // working way into the Employee Management module in the meantime.
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
