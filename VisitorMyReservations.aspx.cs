using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class VisitorMyReservations : System.Web.UI.Page
    {

        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["VisitorID"] == null)
            {
                Response.Redirect("VisitorLogin.aspx");
                return;
            }

            if (!IsPostBack)
                LoadReservations();
        }

        private void LoadReservations()
        {
            int visitorID = Convert.ToInt32(Session["VisitorID"]);

            using (SQLiteConnection con = new SQLiteConnection(connStr))
            {
                string sql = "SELECT * FROM Reservations WHERE VisitorID=@VisitorID";
                SQLiteDataAdapter da = new SQLiteDataAdapter(sql, con);
                da.SelectCommand.Parameters.AddWithValue("@VisitorID", visitorID);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvReservations.DataSource = dt;
                gvReservations.DataBind();
            }
        }
        protected void gvReservations_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

                Button btnCancel = (Button)e.Row.FindControl("btnCancel");
                Button btnTicket = (Button)e.Row.FindControl("btnTicket");

                if (status == "Cancelled")
                {
                    if (btnCancel != null) btnCancel.Visible = false;
                    if (btnTicket != null) btnTicket.Visible = false;
                }
            }
        }
        protected void gvReservations_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int reservationID = Convert.ToInt32(e.CommandArgument);
            int visitorID = Convert.ToInt32(Session["VisitorID"]);

            if (e.CommandName == "CancelRes")
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "UPDATE Reservations SET Status='Cancelled' WHERE ReservationID=@ReservationID AND VisitorID=@VisitorID";
                    SQLiteCommand cmd = new SQLiteCommand(sql, con);
                    cmd.Parameters.AddWithValue("@ReservationID", reservationID);
                    cmd.Parameters.AddWithValue("@VisitorID", visitorID);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                lblMsg.ForeColor = System.Drawing.Color.Green;
                lblMsg.Text = "Reservation cancelled successfully.";
                LoadReservations();
            }
            else if (e.CommandName == "ViewTicket")
            {
                Response.Redirect("VisitorTicket.aspx?id=" + reservationID);
            }
        }



        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("VisitorWelcomePage.aspx");
        }
    }
}