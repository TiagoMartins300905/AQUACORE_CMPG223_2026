using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateAnimalFeeding : System.Web.UI.Page
    {
        private readonly string connStr =
            ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]
                .ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadScheduleDropdown();
                LoadAnimals();
                LoadKeepers();
                LoadFoodTypes();

                pnlEditForm.Visible = false;
            }
        }

        // =========================================================
        // LOAD FEEDING SCHEDULE DROPDOWN
        // =========================================================

        private void LoadScheduleDropdown()
        {
            try
            {
                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    conn.Open();

                    string sql = @"
                        SELECT
                            ScheduleID,
                            'Schedule ' || ScheduleID ||
                            ' - ' || FeedingTime AS ScheduleName
                        FROM FeedingSchedule
                        ORDER BY ScheduleID";

                    using (SQLiteCommand command =
                           new SQLiteCommand(sql, conn))
                    {
                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(command))
                        {
                            DataTable dt = new DataTable();

                            adapter.Fill(dt);

                            ddlScheduleID.Items.Clear();

                            ddlScheduleID.DataSource = dt;
                            ddlScheduleID.DataTextField =
                                "ScheduleName";
                            ddlScheduleID.DataValueField =
                                "ScheduleID";

                            ddlScheduleID.DataBind();

                            ddlScheduleID.Items.Insert(
                                0,
                                new ListItem(
                                    "-- Select a Feeding Schedule --",
                                    ""));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading feeding schedules: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107));
            }
        }

        // =========================================================
        // LOAD ANIMALS
        // =========================================================

        private void LoadAnimals()
        {
            try
            {
                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    conn.Open();

                    string sql = @"
                        SELECT
                            AnimalID,
                            Name
                        FROM Animal
                        ORDER BY Name";

                    using (SQLiteCommand command =
                           new SQLiteCommand(sql, conn))
                    {
                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(command))
                        {
                            DataTable dt = new DataTable();

                            adapter.Fill(dt);

                            ddlAnimal.Items.Clear();

                            ddlAnimal.DataSource = dt;
                            ddlAnimal.DataTextField = "Name";
                            ddlAnimal.DataValueField = "AnimalID";

                            ddlAnimal.DataBind();

                            ddlAnimal.Items.Insert(
                                0,
                                new ListItem(
                                    "--Select Animal--",
                                    ""));
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading animals: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107));
            }
        }

        // =========================================================
        // LOAD MARINE KEEPERS
        // =========================================================

        private void LoadKeepers()
        {
            try
            {
                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    conn.Open();

                    string sql = @"
                        SELECT
                            StaffID,
                            Name,
                            Surname
                        FROM Staff
                        WHERE Role = 'Marine Keeper'
                        ORDER BY Name, Surname";

                    using (SQLiteCommand command =
                           new SQLiteCommand(sql, conn))
                    {
                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(command))
                        {
                            DataTable dt = new DataTable();

                            adapter.Fill(dt);

                            ddlKeeper.Items.Clear();

                            ddlKeeper.Items.Add(
                                new ListItem(
                                    "--Select Keeper--",
                                    ""));

                            foreach (DataRow row in dt.Rows)
                            {
                                string staffID =
                                    row["StaffID"].ToString();

                                string name =
                                    row["Name"].ToString();

                                string surname =
                                    row["Surname"].ToString();

                                ddlKeeper.Items.Add(
                                    new ListItem(
                                        name + " " + surname,
                                        staffID));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading marine keepers: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107));
            }
        }

        // =========================================================
        // LOAD FOOD TYPES
        // =========================================================

        private void LoadFoodTypes()
        {
            ddlFoodType.Items.Clear();

            ddlFoodType.Items.Add(
                new ListItem(
                    "--Select food type--",
                    ""));

            ddlFoodType.Items.Add(
                new ListItem(
                    "Fish",
                    "Fish"));

            ddlFoodType.Items.Add(
                new ListItem(
                    "Meat",
                    "Meat"));

            ddlFoodType.Items.Add(
                new ListItem(
                    "Pellets",
                    "Pellets"));

            ddlFoodType.Items.Add(
                new ListItem(
                    "Vegetables",
                    "Vegetables"));

            ddlFoodType.Items.Add(
                new ListItem(
                    "Fruits",
                    "Fruits"));

            ddlFoodType.Items.Add(
                new ListItem(
                    "Live Food",
                    "Live Food"));
        }

        // =========================================================
        // WHEN SCHEDULE IS SELECTED
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
                pnlEditForm.Visible = false;

                SetStatus(
                    "Invalid feeding schedule selected.",
                    Color.FromArgb(255, 107, 107));

                return;
            }

            LoadSelectedSchedule(scheduleID);
        }

        // =========================================================
        // LOAD SELECTED SCHEDULE
        // =========================================================

        private void LoadSelectedSchedule(int scheduleID)
        {
            try
            {
                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    conn.Open();

                    string sql = @"
                        SELECT
                            StaffID,
                            AnimalID,
                            FoodType,
                            FeedingTime
                        FROM FeedingSchedule
                        WHERE ScheduleID = @ScheduleID";

                    using (SQLiteCommand command =
                           new SQLiteCommand(sql, conn))
                    {
                        command.Parameters.AddWithValue(
                            "@ScheduleID",
                            scheduleID);

                        using (SQLiteDataReader reader =
                               command.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // =================================================
                                // ANIMAL
                                // =================================================

                                string animalID =
                                    reader["AnimalID"].ToString();

                                ddlAnimal.ClearSelection();

                                ListItem animalItem =
                                    ddlAnimal.Items.FindByValue(
                                        animalID);

                                if (animalItem != null)
                                {
                                    animalItem.Selected = true;
                                }

                                // =================================================
                                // MARINE KEEPER
                                // =================================================

                                string staffID =
                                    reader["StaffID"].ToString();

                                ddlKeeper.ClearSelection();

                                ListItem keeperItem =
                                    ddlKeeper.Items.FindByValue(
                                        staffID);

                                if (keeperItem != null)
                                {
                                    keeperItem.Selected = true;
                                }

                                // =================================================
                                // FOOD TYPE
                                // =================================================

                                string foodType =
                                    reader["FoodType"].ToString().Trim();

                                ddlFoodType.ClearSelection();

                                ListItem foodItem =
                                    ddlFoodType.Items.FindByValue(
                                        foodType);

                                if (foodItem != null)
                                {
                                    foodItem.Selected = true;
                                }

                                // =================================================
                                // FEEDING TIME
                                // =================================================

                                string databaseTime =
                                    reader["FeedingTime"]
                                    .ToString()
                                    .Trim();

                                string dropdownTime =
                                    ConvertToDropdownTime(
                                        databaseTime);

                                ddlTime.ClearSelection();

                                ListItem timeItem =
                                    ddlTime.Items.FindByValue(
                                        dropdownTime);

                                if (timeItem != null)
                                {
                                    timeItem.Selected = true;
                                }
                                else
                                {
                                    SetStatus(
                                        "Saved feeding time '" +
                                        databaseTime +
                                        "' could not be matched.",
                                        Color.FromArgb(
                                            255,
                                            107,
                                            107));
                                }

                                // Show form
                                pnlEditForm.Visible = true;
                            }
                            else
                            {
                                pnlEditForm.Visible = false;

                                SetStatus(
                                    "Feeding schedule could not be found.",
                                    Color.FromArgb(
                                        255,
                                        107,
                                        107));
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlEditForm.Visible = false;

                SetStatus(
                    "Error retrieving feeding schedule: " +
                    ex.Message,
                    Color.FromArgb(
                        255,
                        107,
                        107));
            }
        }

        // =========================================================
        // CONVERT DATABASE TIME TO DROPDOWN TIME
        // =========================================================
        //
        // Database examples:
        //
        // 2026/09/14 09:00:00
        // 2026-09-14 09:00:00
        // 09:00
        // 09:00:00
        //
        // Dropdown values:
        //
        // 09:00
        //
        // =========================================================

        private string ConvertToDropdownTime(
            string databaseTime)
        {
            if (string.IsNullOrWhiteSpace(databaseTime))
            {
                return "";
            }

            DateTime parsedDateTime;

            // Try normal DateTime parsing first
            if (DateTime.TryParse(
                databaseTime,
                out parsedDateTime))
            {
                return parsedDateTime.ToString("HH:mm");
            }

            // If parsing failed, try to extract the time manually
            if (databaseTime.Contains(" "))
            {
                string[] parts =
                    databaseTime.Split(' ');

                if (parts.Length >= 2)
                {
                    string timePart = parts[1];

                    if (timePart.Length >= 5)
                    {
                        return timePart.Substring(0, 5);
                    }
                }
            }

            // If value is already something like 09:00
            if (databaseTime.Length >= 5 &&
                databaseTime.Contains(":"))
            {
                return databaseTime.Substring(0, 5);
            }

            return databaseTime;
        }

        // =========================================================
        // UPDATE
        // =========================================================

        protected void btnUpdate_Click(
            object sender,
            EventArgs e)
        {
            // =====================================================
            // VALIDATE SCHEDULE
            // =====================================================

            if (string.IsNullOrEmpty(
                ddlScheduleID.SelectedValue))
            {
                SetStatus(
                    "Please select a feeding schedule.",
                    Color.FromArgb(
                        255,
                        107,
                        107));

                return;
            }

            // =====================================================
            // VALIDATE ANIMAL
            // =====================================================

            if (string.IsNullOrEmpty(
                ddlAnimal.SelectedValue))
            {
                SetStatus(
                    "Please select an animal.",
                    Color.FromArgb(
                        255,
                        107,
                        107));

                return;
            }

            // =====================================================
            // VALIDATE KEEPER
            // =====================================================

            if (string.IsNullOrEmpty(
                ddlKeeper.SelectedValue))
            {
                SetStatus(
                    "Please select a marine keeper.",
                    Color.FromArgb(
                        255,
                        107,
                        107));

                return;
            }

            // =====================================================
            // VALIDATE TIME
            // =====================================================

            if (string.IsNullOrEmpty(
                ddlTime.SelectedValue))
            {
                SetStatus(
                    "Please select a feeding time.",
                    Color.FromArgb(
                        255,
                        107,
                        107));

                return;
            }

            // =====================================================
            // VALIDATE FOOD
            // =====================================================

            if (string.IsNullOrEmpty(
                ddlFoodType.SelectedValue))
            {
                SetStatus(
                    "Please select a food type.",
                    Color.FromArgb(
                        255,
                        107,
                        107));

                return;
            }

            try
            {
                int scheduleID =
                    Convert.ToInt32(
                        ddlScheduleID.SelectedValue);

                int animalID =
                    Convert.ToInt32(
                        ddlAnimal.SelectedValue);

                int staffID =
                    Convert.ToInt32(
                        ddlKeeper.SelectedValue);

                string foodType =
                    ddlFoodType.SelectedValue;

                string feedingTime =
                    ddlTime.SelectedValue;

                // =================================================
                // UPDATE
                // =================================================
                //
                // We save HH:mm because that is what the dropdown
                // uses and what this page reads.
                //
                // =================================================

                string sql = @"
                    UPDATE FeedingSchedule
                    SET
                        StaffID = @StaffID,
                        AnimalID = @AnimalID,
                        FoodType = @FoodType,
                        FeedingTime = @FeedingTime
                    WHERE ScheduleID = @ScheduleID";

                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    conn.Open();

                    using (SQLiteCommand command =
                           new SQLiteCommand(sql, conn))
                    {
                        command.Parameters.AddWithValue(
                            "@StaffID",
                            staffID);

                        command.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID);

                        command.Parameters.AddWithValue(
                            "@FoodType",
                            foodType);

                        command.Parameters.AddWithValue(
                            "@FeedingTime",
                            feedingTime);

                        command.Parameters.AddWithValue(
                            "@ScheduleID",
                            scheduleID);

                        int rowsAffected =
                            command.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SetStatus(
                                "Feeding schedule updated successfully!",
                                Color.FromArgb(
                                    74,
                                    222,
                                    128));

                            // Reload schedule list
                            LoadScheduleDropdown();

                            // Select the same schedule
                            if (ddlScheduleID.Items.FindByValue(
                                scheduleID.ToString()) != null)
                            {
                                ddlScheduleID.SelectedValue =
                                    scheduleID.ToString();
                            }

                            // Reload edited values
                            LoadSelectedSchedule(
                                scheduleID);

                            pnlEditForm.Visible = true;
                        }
                        else
                        {
                            SetStatus(
                                "Feeding schedule could not be updated.",
                                Color.FromArgb(
                                    255,
                                    107,
                                    107));
                        }
                    }
                }
            }
            catch (SQLiteException ex)
            {
                SetStatus(
                    "Database error during update: " +
                    ex.Message,
                    Color.FromArgb(
                        255,
                        107,
                        107));
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error during update: " +
                    ex.Message,
                    Color.FromArgb(
                        255,
                        107,
                        107));
            }
        }

        // =========================================================
        // BACK BUTTON
        // =========================================================

        protected void btnBack_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Menu_Feeding.aspx");
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
