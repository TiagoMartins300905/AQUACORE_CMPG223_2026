using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Delete_feeding : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]
            .ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeedingSchedules();

                pnlConfirmForm.Visible = false;
                lblStatus.Text = "";
            }
        }

        // =========================================================
        // 1. LOAD ALL FEEDING SCHEDULES INTO THE DROPDOWN
        // =========================================================
        private void LoadFeedingSchedules()
        {
            try
            {
                using (SQLiteConnection conn = new SQLiteConnection(GetConnectionString()))
                {
                    string query = @"
                    SELECT ScheduleID
                    FROM FeedingSchedule
                    ORDER BY ScheduleID";

                    using (SQLiteCommand cmd = new SQLiteCommand(query, conn))
                    {
                        conn.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            ddlSelectSchedule.DataSource = reader;

                            ddlSelectSchedule.DataTextField = "ScheduleID";
                            ddlSelectSchedule.DataValueField = "ScheduleID";

                            ddlSelectSchedule.DataBind();
                        }
                    }
                }

                // Add default item at the top
                ddlSelectSchedule.Items.Insert(
                    0,
                    new ListItem("-- Select a Feeding Schedule --", "")
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading feeding schedules: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // 2. WHEN A SCHEDULE IS SELECTED, SHOW ITS DETAILS
        // =========================================================
        protected void ddlSelectSchedule_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblStatus.Text = "";

            // Nothing selected
            if (string.IsNullOrEmpty(ddlSelectSchedule.SelectedValue))
            {
                pnlConfirmForm.Visible = false;
                return;
            }

            int scheduleId;

            if (!int.TryParse(
                ddlSelectSchedule.SelectedValue,
                out scheduleId))
            {
                SetStatus(
                    "Invalid feeding schedule selected.",
                    Color.FromArgb(255, 107, 107)
                );

                pnlConfirmForm.Visible = false;
                return;
            }

            try
            {
                using (SQLiteConnection conn =
                    new SQLiteConnection(GetConnectionString()))
                {
                    string query = @"
                    SELECT
                        ScheduleID,
                        AnimalID,
                        KeeperID,
                        FeedingTime,
                        FoodType
                    FROM FeedingSchedule
                    WHERE ScheduleID = @ScheduleID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ScheduleID",
                            scheduleId
                        );

                        conn.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Schedule ID
                                lblScheduleID.Text =
                                    reader["ScheduleID"].ToString();

                                // Animal
                                lblAnimal.Text =
                                    reader["AnimalID"].ToString();

                                // Keeper
                                lblKeeper.Text =
                                    reader["KeeperID"].ToString();

                                // Feeding time
                                lblTime.Text =
                                    reader["FeedingTime"].ToString();

                                // Food type
                                lblFoodType.Text =
                                    reader["FoodType"].ToString();

                                // Show confirmation section
                                pnlConfirmForm.Visible = true;
                            }
                            else
                            {
                                pnlConfirmForm.Visible = false;

                                SetStatus(
                                    "The selected feeding schedule could not be found.",
                                    Color.FromArgb(255, 107, 107)
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlConfirmForm.Visible = false;

                SetStatus(
                    "Error retrieving feeding schedule: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // 3. DELETE THE SELECTED FEEDING SCHEDULE
        // =========================================================
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectSchedule.SelectedValue))
            {
                SetStatus(
                    "Please select a feeding schedule first.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            int scheduleId;

            if (!int.TryParse(
                ddlSelectSchedule.SelectedValue,
                out scheduleId))
            {
                SetStatus(
                    "Invalid feeding schedule selected.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            try
            {
                using (SQLiteConnection conn =
                    new SQLiteConnection(GetConnectionString()))
                {
                    string query = @"
                    DELETE FROM FeedingSchedule
                    WHERE ScheduleID = @ScheduleID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue(
                            "@ScheduleID",
                            scheduleId
                        );

                        conn.Open();

                        int rowsAffected = cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            pnlConfirmForm.Visible = false;

                            SetStatus(
                                "Feeding schedule successfully deleted.",
                                Color.FromArgb(128, 255, 219)
                            );

                            // Reload dropdown
                            LoadFeedingSchedules();
                        }
                        else
                        {
                            SetStatus(
                                "The feeding schedule could not be deleted because it no longer exists.",
                                Color.FromArgb(255, 107, 107)
                            );
                        }
                    }
                }
            }
            catch (SQLiteException ex)
            {
                SetStatus(
                    "Database error during deletion: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error deleting feeding schedule: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // =========================================================
        // 4. BACK TO FEEDING MENU
        // =========================================================
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Menu_Feeding.aspx");
        }


        // =========================================================
        // STATUS MESSAGE
        // =========================================================
        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }


}