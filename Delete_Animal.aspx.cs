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
    public partial class Delete_Animal : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                SQLiteCommand command;
                SQLiteConnection conn = new SQLiteConnection(connStr);
                conn.Open();
                string qry = "Select AnimalID from Animal";
                command = new SQLiteCommand(qry, conn);

                DataSet ds = new DataSet();
                SQLiteDataAdapter adapter = new SQLiteDataAdapter();
                adapter.SelectCommand = command;
                adapter.Fill(ds);

                ddlAnimalID.DataTextField = "AnimalID";
                ddlAnimalID.DataValueField = "AnimalID";
                ddlAnimalID.DataSource = ds;
                ddlAnimalID.DataBind();


                conn.Close();
                command.Dispose();
            }
            catch (Exception ex)
            {
                lblOutput.Text = ex.Message;
            }
            

        }

        protected void btnMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Animals_DashBoard.aspx");
        }

        protected void btnDeleteAnimal_Click(object sender, EventArgs e)
        {
            try
            {
                SQLiteCommand command;
                SQLiteConnection conn = new SQLiteConnection(connStr);
                conn.Open();
                string qry = "Delete From Animal Where AnimalID = @ID";
                command = new SQLiteCommand(qry, conn);
                command.Parameters.AddWithValue("@ID", ddlAnimalID.SelectedValue.ToString().Trim());
                command.ExecuteNonQuery();

                lblOutput.Text = "Animal deleted successfully";

                command.Dispose();
                conn.Close();
            }
            catch (Exception ex)
            {
                lblOutput.Text = ex.Message;
            }

            }
            
    }
}