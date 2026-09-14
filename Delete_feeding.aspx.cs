using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Delete_feeding : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            SQLiteCommand command;
            SQLiteConnection conn = new SQLiteConnection(connStr);
            conn.Open();
            string qry = "Select ScheduleID from FeedingSchedule";
            command = new SQLiteCommand(qry, conn);

            DataSet ds = new DataSet();
            SQLiteDataAdapter adapter = new SQLiteDataAdapter();
            adapter.SelectCommand = command;
            adapter.Fill(ds);

            DropDownList1.DataTextField = "ScheduleID";
            DropDownList1.DataValueField = "ScheduleID";
            DropDownList1.DataSource = ds;
            DropDownList1.DataBind();


            conn.Close();
            command.Dispose();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu_Feeding.aspx");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            
        }
    }
}