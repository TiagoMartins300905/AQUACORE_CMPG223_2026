using System;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class VisitorReservations : System.Web.UI.Page
    {

        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Visitors.mdf;Integrated Security=True;Connect Timeout=30"; protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VisitorID"] == null)
                Response.Redirect("VisitorLogin.aspx");

            if (!IsPostBack)
                lblTotal.Text = "R0";
        }

        protected void Recalculate(object sender, EventArgs e)
        {
            try
            {
                int price = int.Parse(ddlTicketType.SelectedValue);
                int tickets = string.IsNullOrEmpty(txtTickets.Text) ? 0 : int.Parse(txtTickets.Text);
                if (tickets < 0)
                {
                    tickets = 0;
                }
                lblTotal.Text = "R" + (price * tickets).ToString("0.00");
            }
            catch
            {
                lblTotal.Text = "R0";
            }
        }

        protected void calVisitDate_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.Date < DateTime.Today)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor = System.Drawing.Color.Gray;
            }
        }

        protected void btnReserve_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(txtTickets.Text, out int tickets) || tickets <= 0)
            {
                lblMsg.Text = "⚠ Please enter a valid number of tickets (greater than 0).";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }


            if (calVisitDate.SelectedDate == DateTime.MinValue)
            {
                lblMsg.Text = "⚠ Select a visit date.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            int visitorID = Convert.ToInt32(Session["VisitorID"]);
            int price = int.Parse(ddlTicketType.SelectedValue);
            //int tickets = int.Parse(txtTickets.Text);
            decimal total = price * tickets;
            DateTime visitDate = calVisitDate.SelectedDate;
            string payment = ddlPayment.SelectedValue;

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO Reservations (VisitorID, TicketType, VisitDate, NumTickets, TotalCost, PaymentMethod, Status) VALUES (@VisitorID,@TicketType,@VisitDate,@NumTickets,@TotalCost,@Payment,@Status)";

                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@VisitorID", visitorID);
                cmd.Parameters.AddWithValue("@TicketType", ddlTicketType.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@VisitDate", visitDate);
                cmd.Parameters.AddWithValue("@NumTickets", tickets);
                cmd.Parameters.AddWithValue("@TotalCost", total);
                cmd.Parameters.AddWithValue("@Payment", payment);
                cmd.Parameters.AddWithValue("@Status", "Pending");

                con.Open();
                cmd.ExecuteNonQuery();
            }

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = $"✅ Reservation successful!<br/>💵 Payment Method: <b>{payment}</b><br/>" + $"Please pay at the Blue River Zoo gate upon arrival.";
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("VisitorLogin.aspx");
        }
    }
}