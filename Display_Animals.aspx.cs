using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Display_Animals : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            SQLiteConnection con = new SQLiteConnection(connStr);
            String qry = "Select * From Animal";
            con.Open();

            SQLiteCommand cmd = new SQLiteCommand(qry, con);

            SQLiteDataAdapter adapt = new SQLiteDataAdapter();
            DataSet ds = new DataSet();
            adapt.SelectCommand = cmd;
            adapt.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();
        }

        protected void btnMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Animals_DashBoard.aspx");
        }
    }
}