using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateAnimalFeeding : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]
                ?.ConnectionString;
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadScheduleDropdown();
                LoadAnimalDropdown();
                LoadKeeperDropdown();
            }
        }


        // =========================================================
        // LOAD FEEDING SCHEDULES
        // =========================================================

        private void LoadScheduleDropdown()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            ScheduleID,
                            'Schedule ' || ScheduleID ||
                            ' - ' || FeedingTime AS ScheduleName
                        FROM FeedingSchedule
                        ORDER BY ScheduleID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            ddlScheduleID.DataSource = reader;

                            ddlScheduleID.DataTextField =
                                "ScheduleName";

                            ddlScheduleID.DataValueField =
                                "ScheduleID";

                            ddlScheduleID.DataBind();
                        }
                    }
                }

                ddlScheduleID.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select a Feeding Schedule --",
                        ""
                    )
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading feeding schedules: "
                    + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // LOAD ANIMALS
        // =========================================================

        private void LoadAnimalDropdown()
        {
            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            AnimalID,
                            Name
                        FROM Animal
                        ORDER BY Name";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            ddlAnimal.DataSource = reader;

                            ddlAnimal.DataTextField = "Name";
                            ddlAnimal.DataValueField = "AnimalID";

                            ddlAnimal.DataBind();
                        }
                    }
                }

                ddlAnimal.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select Animal --",
                        ""
                    )
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading animals: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // LOAD MARINE KEEPERS
        // =========================================================

        private void LoadKeeperDropdown()
        {
            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            StaffID,
                            Name,
                            Surname
                        FROM Staff
                        WHERE Role = 'Marine Keeper'
                        ORDER BY Name, Surname";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            ddlKeeper.DataSource = reader;

                            ddlKeeper.DataTextField = "Name";
                            ddlKeeper.DataValueField = "StaffID";

                            ddlKeeper.DataBind();
                        }
                    }
                }

                ddlKeeper.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select Keeper --",
                        ""
                    )
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading marine keepers: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // LOAD SELECTED FEEDING SCHEDULE
        // =========================================================

        protected void ddlScheduleID_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblMessage.Text = "";

            if (string.IsNullOrEmpty(
                ddlScheduleID.SelectedValue))
            {
                pnlEditForm.Visible = false;
                return;
            }

            int scheduleID;

            if (!int.TryParse(
                ddlScheduleID.SelectedValue,
                out scheduleID))
            {
                SetStatus(
                    "Invalid feeding schedule selected.",
                    Color.FromArgb(255, 107, 107)
                );

                pnlEditForm.Visible = false;
                return;
            }

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            StaffID,
                            AnimalID,
                            FoodType,
                            FeedingTime
                        FROM FeedingSchedule
                        WHERE ScheduleID = @ScheduleID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ScheduleID",
                            scheduleID
                        );

                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Animal
                                string animalID =
                                    reader["AnimalID"].ToString();

                                if (ddlAnimal.Items.FindByValue(
                                    animalID) != null)
                                {
                                    ddlAnimal.SelectedValue =
                                        animalID;
                                }


                                // Marine Keeper
                                string staffID =
                                    reader["StaffID"].ToString();

                                if (ddlKeeper.Items.FindByValue(
                                    staffID) != null)
                                {
                                    ddlKeeper.SelectedValue =
                                        staffID;
                                }


                                // Food Type
                                string foodType =
                                    reader["FoodType"].ToString();

                                if (ddlFoodType.Items.FindByValue(
                                    foodType) != null)
                                {
                                    ddlFoodType.SelectedValue =
                                        foodType;
                                }


                                // Feeding Time
                                string feedingTime =
                                    reader["FeedingTime"].ToString();

                                if (ddlTime.Items.FindByValue(
                                    feedingTime) != null)
                                {
                                    ddlTime.SelectedValue =
                                        feedingTime;
                                }


                                // Show edit form
                                pnlEditForm.Visible = true;
                            }
                            else
                            {
                                pnlEditForm.Visible = false;

                                SetStatus(
                                    "Feeding schedule could not be found.",
                                    Color.FromArgb(255, 107, 107)
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlEditForm.Visible = false;

                SetStatus(
                    "Error retrieving feeding schedule: "
                    + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // UPDATE FEEDING SCHEDULE
        // =========================================================

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Check schedule
            if (string.IsNullOrEmpty(
                ddlScheduleID.SelectedValue))
            {
                SetStatus(
                    "Please select a feeding schedule.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Check animal
            if (string.IsNullOrEmpty(
                ddlAnimal.SelectedValue))
            {
                SetStatus(
                    "Please select an animal.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Check keeper
            if (string.IsNullOrEmpty(
                ddlKeeper.SelectedValue))
            {
                SetStatus(
                    "Please select a marine keeper.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Check feeding time
            if (string.IsNullOrEmpty(
                ddlTime.SelectedValue))
            {
                SetStatus(
                    "Please select a feeding time.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Check food type
            if (string.IsNullOrEmpty(
                ddlFoodType.SelectedValue))
            {
                SetStatus(
                    "Please select a food type.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Get values
            int scheduleID =
                Convert.ToInt32(
                    ddlScheduleID.SelectedValue
                );

            int animalID =
                Convert.ToInt32(
                    ddlAnimal.SelectedValue
                );

            int staffID =
                Convert.ToInt32(
                    ddlKeeper.SelectedValue
                );

            string foodType =
                ddlFoodType.SelectedValue;

            string feedingTime =
                ddlTime.SelectedValue;


            string connStr = GetConnectionString();


            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        UPDATE FeedingSchedule
                        SET
                            StaffID = @StaffID,
                            AnimalID = @AnimalID,
                            FoodType = @FoodType,
                            FeedingTime = @FeedingTime
                        WHERE ScheduleID = @ScheduleID";


                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@StaffID",
                            staffID
                        );

                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        cmd.Parameters.AddWithValue(
                            "@FoodType",
                            foodType
                        );

                        cmd.Parameters.AddWithValue(
                            "@FeedingTime",
                            feedingTime
                        );

                        cmd.Parameters.AddWithValue(
                            "@ScheduleID",
                            scheduleID
                        );


                        con.Open();


                        int rowsAffected =
                            cmd.ExecuteNonQuery();


                        if (rowsAffected > 0)
                        {
                            SetStatus(
                                "Feeding schedule updated successfully!",
                                Color.FromArgb(74, 222, 128)
                            );

                            // Reload schedule list
                            LoadScheduleDropdown();

                            // Keep selected schedule
                            ddlScheduleID.SelectedValue =
                                scheduleID.ToString();

                            // Keep form visible
                            pnlEditForm.Visible = true;
                        }
                        else
                        {
                            SetStatus(
                                "Feeding schedule could not be updated.",
                                Color.FromArgb(255, 107, 107)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during update: "
                    + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // BACK BUTTON
        // =========================================================

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect(
                "Menu_Feeding.aspx",
                false
            );
        }


        // =========================================================
        // STATUS MESSAGE
        // =========================================================

        private void SetStatus(
            string message,
            Color color)
        {
            lblMessage.Text = message;
            lblMessage.ForeColor = color;
        }
    }
}
