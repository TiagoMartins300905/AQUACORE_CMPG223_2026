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
    public partial class WebForm1 : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            SQLiteCommand command;
            SQLiteConnection conn = new SQLiteConnection(connStr);

            conn.Open();

            string qry = "SELECT AnimalID FROM Animal";

            command = new SQLiteCommand(qry, conn);

            DataSet ds = new DataSet();

            SQLiteDataAdapter adapter = new SQLiteDataAdapter();

            adapter.SelectCommand = command;

            adapter.Fill(ds);

            ddlAnimal.DataTextField = "AnimalID";
            ddlAnimal.DataValueField = "AnimalID";

            ddlAnimal.DataSource = ds;
            ddlAnimal.DataBind();

            ddlAnimal.Items.Insert(0, "--Select Animal--");

            command.Dispose();
            conn.Close();


            SQLiteCommand comm;
            SQLiteConnection con = new SQLiteConnection(connStr);

            con.Open();

            string sql = "SELECT StaffID, Name, Surname FROM Staff WHERE Role = 'Marine Keeper'";

            comm = new SQLiteCommand(sql, con);

            DataSet Ds = new DataSet();

            SQLiteDataAdapter adapt = new SQLiteDataAdapter();

            adapt.SelectCommand = comm;

            adapt.Fill(ds);

            ddlKeeper.DataTextField = "Name";
            ddlKeeper.DataValueField = "StaffID";

            ddlKeeper.DataSource = ds;

            ddlKeeper.DataBind();

            ddlKeeper.Items.Insert(0, "--Select Keeper--");

            comm.Dispose();
            con.Close();

        }

        protected void btnClear_Click(System.Object sender, System.EventArgs e)
        {
            ddlAnimal.SelectedIndex = 0;
            ddlFoodType.SelectedIndex = 0;
            ddlKeeper.SelectedIndex = 0;
            ddlTime.SelectedIndex = 0;
        }

        protected void btnBack_Click(System.Object sender, System.EventArgs e)
        {
            Response.Redirect("Menu_Feeding.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (ddlAnimal.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select an animal.";
                return;
            }

            if (ddlKeeper.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a marine keeper.";
                return;
            }

            if (ddlTime.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a feeding time.";
                return;
            }

            if (ddlFoodType.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a food type.";
                return;
            }


            // Get the selected values
            int animalID = int.Parse(ddlAnimal.SelectedValue);

            int staffID = int.Parse(ddlKeeper.SelectedValue);

            string foodType = ddlFoodType.SelectedValue;

            string feedingTime = ddlTime.SelectedValue;


            // SQL INSERT
            string qry = @"INSERT INTO FeedingSchedule
                   (StaffID, AnimalID, FoodType, FeedingTime)
                   VALUES
                   (@StaffID, @AnimalID, @FoodType, @FeedingTime)";


            SQLiteConnection conn = new SQLiteConnection(connStr);

            SQLiteCommand command = new SQLiteCommand(qry, conn);


            // Parameters
            command.Parameters.AddWithValue("@StaffID", staffID);

            command.Parameters.AddWithValue("@AnimalID", animalID);

            command.Parameters.AddWithValue("@FoodType", foodType);

            command.Parameters.AddWithValue("@FeedingTime", feedingTime);


            // Execute
            conn.Open();

            command.ExecuteNonQuery();

            command.Dispose();

            conn.Close();


            // Success message
            lblMessage.Text = "Feeding schedule added successfully.";


            // Clear selections
            ddlAnimal.SelectedIndex = 0;
            ddlKeeper.SelectedIndex = 0;
            ddlTime.SelectedIndex = 0;
            ddlFoodType.SelectedIndex = 0;
        }
    }
}