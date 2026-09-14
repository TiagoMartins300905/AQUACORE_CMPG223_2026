using System;

namespace AQUACORE_CMPG223
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnGeneral_Click(object sender, EventArgs e)
        {
            lblInfo.Text = "The AquaCore Aquarium is open daily from 9:00 AM - 6:00 PM. Come explore the underwater world!";
        }

        protected void btnTickets_Click(object sender, EventArgs e)
        {
            lblInfo.Text = "For ticket bookings and inquiries, please call: 012-345-6789 or visit the Ticket Office.";
        }

        protected void btnLost_Click(object sender, EventArgs e)
        {
            lblInfo.Text = "Lost & Found is located at the Main Gate Help Desk. Ask any staff member for assistance.";
        }

        protected void btnEmergency_Click(object sender, EventArgs e)
        {
            lblInfo.Text = "In case of emergency, call 10111 or notify the nearest staff member immediately.";
        }
    }
}