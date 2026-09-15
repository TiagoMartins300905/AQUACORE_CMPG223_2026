using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Update_Animal : System.Web.UI.Page
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
                LoadAnimalDropdown();
                lblGender.Text = "";

                string today =
                    DateTime.Now.ToString("yyyy-MM-dd");

                txtDOB.Attributes["max"] = today;
            }
        }

        // 1. Load all animals into the dropdown
        private void LoadAnimalDropdown()
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
                        SELECT AnimalID, Name
                        FROM Animal
                        ORDER BY Name";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            ddlSelectAnimal.DataSource = reader;
                            ddlSelectAnimal.DataTextField = "Name";
                            ddlSelectAnimal.DataValueField = "AnimalID";
                            ddlSelectAnimal.DataBind();
                        }
                    }
                }

                ddlSelectAnimal.Items.Insert(
                    0,
                    new ListItem(
                        "-- Select an Animal --",
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

        // 2. Load the selected animal's information
        protected void ddlSelectAnimal_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblOutput.Text = "";
            lblGender.Text = "";

            if (string.IsNullOrEmpty(
                ddlSelectAnimal.SelectedValue))
            {
                pnlEditForm.Visible = false;
                return;
            }

            string connStr = GetConnectionString();

            int animalID =
                Convert.ToInt32(
                    ddlSelectAnimal.SelectedValue
                );

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            Name,
                            Species,
                            DateOfBirth,
                            Gender,
                            HabitatLocation
                        FROM Animal
                        WHERE AnimalID = @AnimalID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Name
                                txtName.Text =
                                    reader["Name"].ToString();

                                // Species
                                txtSpecies.Text =
                                    reader["Species"].ToString();

                                // Date of Birth
                                if (reader["DateOfBirth"] != DBNull.Value)
                                {
                                    DateTime dob =
                                        Convert.ToDateTime(
                                            reader["DateOfBirth"]
                                        );

                                    txtDOB.Text =
                                        dob.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    txtDOB.Text = "";
                                }

                                // Gender
                                rdbMale.Checked = false;
                                rdbFemale.Checked = false;

                                string gender =
                                    reader["Gender"].ToString();

                                if (gender == "Male")
                                {
                                    rdbMale.Checked = true;
                                }
                                else if (gender == "Female")
                                {
                                    rdbFemale.Checked = true;
                                }

                                // Habitat
                                string habitat =
                                    reader["HabitatLocation"].ToString();

                                if (ddHabitat.Items.FindByValue(habitat)
                                    != null)
                                {
                                    ddHabitat.SelectedValue =
                                        habitat;
                                }
                                else
                                {
                                    ddHabitat.SelectedIndex = 0;
                                }

                                // Show edit form
                                pnlEditForm.Visible = true;
                            }
                            else
                            {
                                SetStatus(
                                    "Animal could not be found.",
                                    Color.FromArgb(255, 107, 107)
                                );

                                pnlEditForm.Visible = false;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error retrieving animal: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // 3. Clear the gender error label when a radio is picked
        protected void rdbGender_CheckedChanged(object sender, EventArgs e)
        {
            if (rdbMale.Checked || rdbFemale.Checked)
            {
                lblGender.Text = "";
            }
        }

        // 4. Update the animal
        protected void btnUpdate_Click(
            object sender,
            EventArgs e)
        {
            if (string.IsNullOrEmpty(
                ddlSelectAnimal.SelectedValue))
            {
                SetStatus(
                    "Please select an animal.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            int animalID =
                Convert.ToInt32(
                    ddlSelectAnimal.SelectedValue
                );

            string name =
                txtName.Text.Trim();

            string species =
                txtSpecies.Text.Trim();

            string dobInput =
                txtDOB.Text.Trim();

            string habitat =
                ddHabitat.SelectedValue;

            string gender = "";

            if (rdbMale.Checked)
            {
                gender = "Male";
            }
            else if (rdbFemale.Checked)
            {
                gender = "Female";
            }

            // Validation
            if (int.TryParse(name, out _))
            {
                SetStatus(
                    "Please enter a valid name",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            if (int.TryParse(species, out _))
            {
                SetStatus(
                    "Please enter a valid species",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            if (string.IsNullOrEmpty(name))
            {
                SetStatus(
                    "Animal name is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            if (string.IsNullOrEmpty(species))
            {
                SetStatus(
                    "Animal species is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            if (string.IsNullOrEmpty(dobInput))
            {
                SetStatus(
                    "Date of birth is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            DateTime dob;

            if (!DateTime.TryParse(
                dobInput,
                out dob))
            {
                SetStatus(
                    "Please enter a valid date of birth.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // DOB cannot be in the future
            if (dob.Date > DateTime.Now.Date)
            {
                SetStatus(
                    "Date of birth cannot be in the future.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            if (string.IsNullOrEmpty(gender))
            {
                lblGender.Text = "Animal Gender cannot be left out!";
                return;
            }

            if (string.IsNullOrEmpty(habitat))
            {
                SetStatus(
                    "Please select a habitat.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }

            // Update database
            string connStr =
                GetConnectionString();

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        UPDATE Animal
                        SET
                            Name = @Name,
                            Species = @Species,
                            DateOfBirth = @DateOfBirth,
                            Gender = @Gender,
                            HabitatLocation = @HabitatLocation
                        WHERE AnimalID = @AnimalID";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        cmd.Parameters.AddWithValue(
                            "@Name",
                            name
                        );

                        cmd.Parameters.AddWithValue(
                            "@Species",
                            species
                        );

                        cmd.Parameters.AddWithValue(
                            "@DateOfBirth",
                            dob
                        );

                        cmd.Parameters.AddWithValue(
                            "@Gender",
                            gender
                        );

                        cmd.Parameters.AddWithValue(
                            "@HabitatLocation",
                            habitat
                        );

                        con.Open();

                        int rowsAffected =
                            cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            SetStatus(
                                "Animal details updated successfully!",
                                Color.FromArgb(128, 255, 219)
                            );

                            // Refresh dropdown
                            LoadAnimalDropdown();

                            // Select the same animal again
                            ddlSelectAnimal.SelectedValue =
                                animalID.ToString();

                            pnlEditForm.Visible = true;

                            lblGender.Text = "";
                        }
                        else
                        {
                            SetStatus(
                                "Animal could not be updated.",
                                Color.FromArgb(255, 107, 107)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during update: " +
                    ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }

        // 5. Menu button
        protected void btnMenu_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Animals_DashBoard.aspx",
                false
            );
        }

        // 6. Display messages
        private void SetStatus(
            string message,
            Color color)
        {
            lblOutput.Text = message;
            lblOutput.ForeColor = color;
        }
    }
}

