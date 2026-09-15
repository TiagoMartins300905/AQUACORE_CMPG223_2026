using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;

namespace AQUACORE_CMPG223
{
    public partial class View_Feeding : System.Web.UI.Page
    {
        private string connStr;

        protected void Page_Load(object sender, EventArgs e)
        {
            connStr =
                ConfigurationManager
                    .ConnectionStrings["AquaCoreConnectionString"]
                    .ConnectionString;

            if (!IsPostBack)
            {
                LoadFeedingSchedules();
            }
        }


        // ============================================================
        // LOAD FEEDING SCHEDULES
        // ============================================================

        private void LoadFeedingSchedules()
        {
            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();

                    string qry =
                        "SELECT * FROM FeedingSchedule";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(qry, con))
                    {
                        using (SQLiteDataAdapter adapt =
                               new SQLiteDataAdapter(cmd))
                        {
                            DataSet ds =
                                new DataSet();

                            adapt.Fill(ds);

                            GridView1.DataSource =
                                ds.Tables[0];

                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (SQLiteException ex)
            {
                GridView1.DataSource = null;

                GridView1.DataBind();

                Response.Write(
                    "<script>alert('Database error: " +
                    ex.Message.Replace("'", "\\'") +
                    "');</script>"
                );
            }
            catch (Exception ex)
            {
                GridView1.DataSource = null;

                GridView1.DataBind();

                Response.Write(
                    "<script>alert('Error loading feeding schedules: " +
                    ex.Message.Replace("'", "\\'") +
                    "');</script>"
                );
            }
        }


        // ============================================================
        // BACK BUTTON
        // ============================================================

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu_Feeding.aspx");
        }
    }
}
