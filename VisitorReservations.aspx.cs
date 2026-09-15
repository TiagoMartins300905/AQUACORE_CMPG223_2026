using System;
using System.Configuration;
using System.Data.SQLite;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class VisitorReservations : System.Web.UI.Page
    {
        string connStr =
            ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]
            .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VisitorID"] == null)
            {
                Response.Redirect("VisitorLogin.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblTotal.Text = "R0";
            }
        }


        protected void Recalculate(object sender, EventArgs e)
        {
            try
            {
                int price =
                    int.Parse(ddlTicketType.SelectedValue);

                int tickets;

                if (string.IsNullOrEmpty(txtTickets.Text))
                {
                    tickets = 0;
                }
                else
                {
                    tickets =
                        int.Parse(txtTickets.Text);
                }

                if (tickets < 0)
                {
                    tickets = 0;
                }

                lblTotal.Text =
                    "R" +
                    (price * tickets).ToString("0.00");
            }
            catch
            {
                lblTotal.Text = "R0";
            }
        }


        protected void calVisitDate_DayRender(
            object sender,
            DayRenderEventArgs e)
        {
            // Prevent selecting dates before today
            if (e.Day.Date < DateTime.Today)
            {
                e.Day.IsSelectable = false;
                e.Cell.ForeColor =
                    System.Drawing.Color.Gray;
            }
        }


        protected void btnReserve_Click(
            object sender,
            EventArgs e)
        {
            // Validate number of tickets
            int tickets;

            if (!int.TryParse(
                txtTickets.Text,
                out tickets) ||
                tickets <= 0)
            {
                lblMsg.Text =
                    "⚠ Please enter a valid number of tickets (greater than 0).";

                lblMsg.ForeColor =
                    System.Drawing.Color.Red;

                return;
            }


            // Validate visit date
            if (calVisitDate.SelectedDate ==
                DateTime.MinValue)
            {
                lblMsg.Text =
                    "⚠ Select a visit date.";

                lblMsg.ForeColor =
                    System.Drawing.Color.Red;

                return;
            }


            // Visit date must be today or a future date
            if (calVisitDate.SelectedDate.Date <
                DateTime.Today)
            {
                lblMsg.Text =
                    "⚠ Visit date cannot be before today.";

                lblMsg.ForeColor =
                    System.Drawing.Color.Red;

                return;
            }


            // Validate ticket type
            if (string.IsNullOrEmpty(
                ddlTicketType.SelectedValue))
            {
                lblMsg.Text =
                    "⚠ Please select a ticket type.";

                lblMsg.ForeColor =
                    System.Drawing.Color.Red;

                return;
            }


            // Validate payment method
            if (string.IsNullOrEmpty(
                ddlPayment.SelectedValue))
            {
                lblMsg.Text =
                    "⚠ Please select a payment method.";

                lblMsg.ForeColor =
                    System.Drawing.Color.Red;

                return;
            }


            int visitorID =
                Convert.ToInt32(
                    Session["VisitorID"]
                );

            int price =
                int.Parse(
                    ddlTicketType.SelectedValue
                );

            decimal total =
                price * tickets;

            DateTime visitDate =
                calVisitDate.SelectedDate;

            string payment =
                ddlPayment.SelectedValue;


            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        INSERT INTO Reservations
                        (
                            VisitorID,
                            TicketType,
                            VisitDate,
                            NumTickets,
                            TotalCost,
                            PaymentMethod,
                            Status
                        )
                        VALUES
                        (
                            @VisitorID,
                            @TicketType,
                            @VisitDate,
                            @NumTickets,
                            @TotalCost,
                            @Payment,
                            @Status
                        )";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@VisitorID",
                            visitorID
                        );

                        cmd.Parameters.AddWithValue(
                            "@TicketType",
                            ddlTicketType.SelectedItem.Text
                        );

                        cmd.Parameters.AddWithValue(
                            "@VisitDate",
                            visitDate
                        );

                        cmd.Parameters.AddWithValue(
                            "@NumTickets",
                            tickets
                        );

                        cmd.Parameters.AddWithValue(
                            "@TotalCost",
                            total
                        );

                        cmd.Parameters.AddWithValue(
                            "@Payment",
                            payment
                        );

                        cmd.Parameters.AddWithValue(
                            "@Status",
                            "Pending"
                        );

                        con.Open();

                        cmd.ExecuteNonQuery();
                    }
                }

                lblMsg.ForeColor =
                    System.Drawing.Color.Green;

                lblMsg.Text =
                    "✅ Reservation successful!<br/>" +
                    "💵 Payment Method: <b>" +
                    payment +
                    "</b><br/>" +
                    "Please pay at the Blue River Zoo gate upon arrival.";
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor =
                    System.Drawing.Color.Red;

                lblMsg.Text =
                    "⚠ Error making reservation: " +
                    ex.Message;
            }
        }


        protected void btnLogout_Click(
            object sender,
            EventArgs e)
        {
            Session.Clear();

            Response.Redirect(
                "VisitorLogin.aspx",
                false
            );
        }
    }
}