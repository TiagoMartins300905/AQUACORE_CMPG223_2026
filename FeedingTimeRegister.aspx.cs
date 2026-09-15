using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class FeedingTimeRegister : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAnimals();
                LoadKeepers();
            }
        }

        private void LoadAnimals()
        {
            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT AnimalID, Name FROM Animal ORDER BY Name";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        DataTable dt = new DataTable();

                        using (SQLiteDataAdapter da = new SQLiteDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }

                        ddlAnimal.DataSource = dt;
                        ddlAnimal.DataTextField = "Name";
                        ddlAnimal.DataValueField = "AnimalID";
                        ddlAnimal.DataBind();
                    }
                }

                ddlAnimal.Items.Insert(0, new ListItem("--Select Animal--", ""));
            }
            catch (Exception ex)
            {
                SetMessage("Error loading animals: " + ex.Message, true);
            }
        }

        private void LoadKeepers()
        {
            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = "SELECT StaffID, Name, Surname FROM Staff WHERE Role = 'Marine Keeper' ORDER BY Name";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        DataTable dt = new DataTable();

                        using (SQLiteDataAdapter da = new SQLiteDataAdapter(cmd))
                        {
                            da.Fill(dt);
                        }

                        // Build display name as "Name Surname"
                        dt.Columns.Add("DisplayName", typeof(string),
                            "Name + ' ' + Surname");

                        ddlKeeper.DataSource = dt;
                        ddlKeeper.DataTextField = "DisplayName";
                        ddlKeeper.DataValueField = "StaffID";
                        ddlKeeper.DataBind();
                    }
                }

                ddlKeeper.Items.Insert(0, new ListItem("--Select Keeper--", ""));
            }
            catch (Exception ex)
            {
                SetMessage("Error loading keepers: " + ex.Message, true);
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlAnimal.SelectedIndex = 0;
            ddlKeeper.SelectedIndex = 0;
            ddlTime.SelectedIndex = 0;
            ddlFoodType.SelectedIndex = 0;
            lblMessage.Text = "";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu_Feeding.aspx", false);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Backstop validation — validators should catch these first
            if (string.IsNullOrEmpty(ddlAnimal.SelectedValue))
            {
                SetMessage("Please select an animal.", true);
                return;
            }

            if (string.IsNullOrEmpty(ddlKeeper.SelectedValue))
            {
                SetMessage("Please select a marine keeper.", true);
                return;
            }

            if (string.IsNullOrEmpty(ddlTime.SelectedValue))
            {
                SetMessage("Please select a feeding time.", true);
                return;
            }

            if (string.IsNullOrEmpty(ddlFoodType.SelectedValue))
            {
                SetMessage("Please select a food type.", true);
                return;
            }

            int animalID = Convert.ToInt32(ddlAnimal.SelectedValue);
            int staffID = Convert.ToInt32(ddlKeeper.SelectedValue);
            string foodType = ddlFoodType.SelectedValue;
            string feedingTime = ddlTime.SelectedValue;

            try
            {
                using (SQLiteConnection conn = new SQLiteConnection(connStr))
                {
                    string qry = @"INSERT INTO FeedingSchedule
                                   (StaffID, AnimalID, FoodType, FeedingTime)
                                   VALUES
                                   (@StaffID, @AnimalID, @FoodType, @FeedingTime)";

                    using (SQLiteCommand command = new SQLiteCommand(qry, conn))
                    {
                        command.Parameters.AddWithValue("@StaffID", staffID);
                        command.Parameters.AddWithValue("@AnimalID", animalID);
                        command.Parameters.AddWithValue("@FoodType", foodType);
                        command.Parameters.AddWithValue("@FeedingTime", feedingTime);

                        conn.Open();
                        command.ExecuteNonQuery();
                    }
                }

                SetMessage("Feeding schedule added successfully.", false);

                ddlAnimal.SelectedIndex = 0;
                ddlKeeper.SelectedIndex = 0;
                ddlTime.SelectedIndex = 0;
                ddlFoodType.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                SetMessage("Database error: " + ex.Message, true);
            }
        }

        private void SetMessage(string message, bool isError)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = isError
                ? Color.FromArgb(255, 123, 123)
                : Color.FromArgb(0, 210, 255);
        }
    }
}