using QRCoder;
using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorTicket : System.Web.UI.Page
    {

        private string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Visitors.mdf;Integrated Security=True;Connect Timeout=30";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["id"] != null)
            {
                string id = Request.QueryString["id"];

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string sql = "SELECT * FROM Reservations WHERE ReservationID=@ID";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();

                    SqlDataReader dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        lblDetails.Text = $"<b>Ticket ID:</b> {dr["ReservationID"]}<br/>" + $"<b>Type:</b> {dr["TicketType"]}<br/>" + $"<b>Date:</b> {Convert.ToDateTime(dr["VisitDate"]).ToString("yyyy-MM-dd")}<br/>" +
                                          $"<b>Tickets:</b> {dr["NumTickets"]}<br/>" +
                                          $"<b>Total:</b> R{dr["TotalCost"]}";

                        //Generates a QR Code for the ticket
                        string qrText = $"Blue River Zoo - Reservation #{dr["ReservationID"]}";
                        QRCodeGenerator qrGen = new QRCodeGenerator();
                        QRCodeData qrData = qrGen.CreateQrCode(qrText, QRCodeGenerator.ECCLevel.Q);
                        QRCode qrCode = new QRCode(qrData);

                        using (Bitmap bmp = qrCode.GetGraphic(20))
                        using (MemoryStream ms = new MemoryStream())
                        {
                            bmp.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                            string base64 = Convert.ToBase64String(ms.ToArray());
                            imgQR.ImageUrl = "data:image/png;base64," + base64;
                        }
                    }
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("VisitorMyReservations.aspx");
        }
    }
}