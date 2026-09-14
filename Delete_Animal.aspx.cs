using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Delete_Animal : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]?
            .ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAnimalDropdown();
            }
        }

        // 1. Load all animals into the dropdown
        private void LoadAnimalDropdown()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string missing in Web.config.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            try
            {
                using (SQLiteConnection conn = new SQLiteConnection(connStr))
                {
                    string sql = @"
                    SELECT AnimalID, Name
                    FROM Animal
                    ORDER BY Name";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, conn))
                    {
                        conn.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            ddlAnimalID.DataSource = reader;

                            // What the user sees
                            ddlAnimalID.DataTextField = "Name";

                            // What is stored as the selected value
                            ddlAnimalID.DataValueField = "AnimalID";

                            ddlAnimalID.DataBind();
                        }
                    }
                }

                // Default option
                ddlAnimalID.Items.Insert(
                    0,
                    new ListItem("-- Select an Animal --", "")
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

        // 2. Runs when an animal is selected
        protected void ddlAnimalID_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblOutput.Text = string.Empty;

            // Nothing selected
            if (string.IsNullOrEmpty(ddlAnimalID.SelectedValue))
            {
                pnlConfirmForm.Visible = false;
                return;
            }

            int animalID;

            if (!int.TryParse(
                ddlAnimalID.SelectedValue,
                out animalID))
            {
                SetStatus(
                    "Invalid Animal ID selected.",
                    Color.FromArgb(255, 107, 107)
                );

                pnlConfirmForm.Visible = false;
                return;
            }

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                    SELECT Name,
                           Species,
                           Gender,
                           HabitatLocation
                    FROM Animal
                    WHERE AnimalID = @AnimalID";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        conn.Open();

                        using (SQLiteDataReader reader =
                               cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Display animal information
                                lblName.Text =
                                    reader["Name"].ToString();

                                lblSpecies.Text =
                                    reader["Species"].ToString();

                                lblGender.Text =
                                    reader["Gender"].ToString();

                                lblHabitat.Text =
                                    reader["HabitatLocation"].ToString();

                                // Show confirmation section
                                pnlConfirmForm.Visible = true;
                            }
                            else
                            {
                                pnlConfirmForm.Visible = false;

                                SetStatus(
                                    "Animal could not be found.",
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
                    "Error retrieving animal: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // 3. Delete selected animal
        protected void btnDeleteAnimal_Click(
            object sender,
            EventArgs e)
        {
            if (string.IsNullOrEmpty(
                ddlAnimalID.SelectedValue))
            {
                SetStatus(
                    "Please select an animal first.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            int animalID;

            if (!int.TryParse(
                ddlAnimalID.SelectedValue,
                out animalID))
            {
                SetStatus(
                    "Invalid Animal ID.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection conn =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                    DELETE FROM Animal
                    WHERE AnimalID = @AnimalID";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        conn.Open();

                        int rowsAffected =
                            cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            // Hide confirmation panel
                            pnlConfirmForm.Visible = false;

                            // Show success message
                            SetStatus(
                                "Animal successfully deleted from the system.",
                                Color.FromArgb(128, 255, 219)
                            );

                            // Refresh dropdown
                            LoadAnimalDropdown();
                        }
                        else
                        {
                            SetStatus(
                                "Animal could not be found.",
                                Color.FromArgb(255, 107, 107)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during deletion: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // 4. Return to Animal menu
        protected void btnMenu_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Animals_DashBoard.aspx",
                false
            );
        }

        // 5. Display status messages
        private void SetStatus(
            string message,
            Color color)
        {
            lblOutput.Text = message;
            lblOutput.ForeColor = color;
        }
    }


}