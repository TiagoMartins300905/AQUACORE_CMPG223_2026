using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;

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
                LoadAnimals();

                pnlEditForm.Visible = false;
                lblOutput.Text = "";
            }
        }

        // =========================================================
        // LOAD ANIMALS
        // =========================================================
        private void LoadAnimals()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                lblOutput.Text =
                    "Database connection string is missing.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            try
            {
                ddlSelectAnimal.Items.Clear();

                ddlSelectAnimal.Items.Add(
                    new System.Web.UI.WebControls.ListItem(
                        "-- Select Animal --",
                        ""
                    )
                );

                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            AnimalID,
                            Name
                        FROM Animal
                        ORDER BY Name ASC";

                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader =
                            cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                string animalID =
                                    reader["AnimalID"].ToString();

                                string animalName =
                                    reader["Name"].ToString();

                                ddlSelectAnimal.Items.Add(
                                    new System.Web.UI.WebControls.ListItem(
                                        animalName +
                                        " (ID: " +
                                        animalID +
                                        ")",
                                        animalID
                                    )
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblOutput.Text =
                    "Error loading animals: " +
                    ex.Message;

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);
            }
        }

        // =========================================================
        // SELECT ANIMAL
        // =========================================================
        protected void ddlSelectAnimal_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            if (string.IsNullOrEmpty(
                ddlSelectAnimal.SelectedValue))
            {
                pnlEditForm.Visible = false;
                lblOutput.Text = "";

                return;
            }

            int animalID;

            if (!int.TryParse(
                ddlSelectAnimal.SelectedValue,
                out animalID))
            {
                pnlEditForm.Visible = false;

                lblOutput.Text =
                    "Invalid animal selected.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            LoadAnimal(animalID);
        }

        // =========================================================
        // LOAD SELECTED ANIMAL
        // =========================================================
        private void LoadAnimal(int animalID)
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                lblOutput.Text =
                    "Database connection string is missing.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT
                            AnimalID,
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
                                txtName.Text =
                                    reader["Name"].ToString();

                                txtSpecies.Text =
                                    reader["Species"].ToString();

                                if (reader["DateOfBirth"] != DBNull.Value)
                                {
                                    DateTime dob;

                                    if (DateTime.TryParse(
                                        reader["DateOfBirth"].ToString(),
                                        out dob))
                                    {
                                        txtDOB.Text =
                                            dob.ToString("yyyy-MM-dd");
                                    }
                                    else
                                    {
                                        txtDOB.Text = "";
                                    }
                                }
                                else
                                {
                                    txtDOB.Text = "";
                                }

                                string gender =
                                    reader["Gender"].ToString();

                                rdbMale.Checked =
                                    gender.Equals(
                                        "Male",
                                        StringComparison.OrdinalIgnoreCase
                                    );

                                rdbFemale.Checked =
                                    gender.Equals(
                                        "Female",
                                        StringComparison.OrdinalIgnoreCase
                                    );

                                string habitat =
                                    reader["HabitatLocation"].ToString();

                                if (ddHabitat.Items.FindByValue(
                                    habitat) != null)
                                {
                                    ddHabitat.SelectedValue =
                                        habitat;
                                }
                                else
                                {
                                    ddHabitat.SelectedIndex = 0;
                                }

                                pnlEditForm.Visible = true;

                                lblOutput.Text =
                                    "Animal loaded. Make your changes and click Save Changes.";

                                lblOutput.ForeColor =
                                    Color.FromArgb(128, 255, 219);
                            }
                            else
                            {
                                pnlEditForm.Visible = false;

                                lblOutput.Text =
                                    "Animal could not be found.";

                                lblOutput.ForeColor =
                                    Color.FromArgb(255, 107, 122);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                pnlEditForm.Visible = false;

                lblOutput.Text =
                    "Error loading animal: " +
                    ex.Message;

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);
            }
        }

        // =========================================================
        // UPDATE ANIMAL
        // =========================================================
        protected void btnUpdate_Click(
            object sender,
            EventArgs e)
        {
            if (string.IsNullOrEmpty(
                ddlSelectAnimal.SelectedValue))
            {
                lblOutput.Text =
                    "Please select an animal first.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            int animalID;

            if (!int.TryParse(
                ddlSelectAnimal.SelectedValue,
                out animalID))
            {
                lblOutput.Text =
                    "Invalid animal ID.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            string name =
                txtName.Text.Trim();

            string species =
                txtSpecies.Text.Trim();

            string dateOfBirth =
                txtDOB.Text.Trim();

            string gender = "";

            if (rdbMale.Checked)
            {
                gender = "Male";
            }
            else if (rdbFemale.Checked)
            {
                gender = "Female";
            }

            string habitat =
                ddHabitat.SelectedValue;

            // =====================================================
            // VALIDATION
            // =====================================================

            if (string.IsNullOrEmpty(name))
            {
                lblOutput.Text =
                    "Animal name is required.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            if (string.IsNullOrEmpty(species))
            {
                lblOutput.Text =
                    "Species is required.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            if (string.IsNullOrEmpty(dateOfBirth))
            {
                lblOutput.Text =
                    "Date of birth is required.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            DateTime parsedDOB;

            if (!DateTime.TryParse(
                dateOfBirth,
                out parsedDOB))
            {
                lblOutput.Text =
                    "Please enter a valid date of birth.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            if (string.IsNullOrEmpty(gender))
            {
                lblOutput.Text =
                    "Please select a gender.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            if (string.IsNullOrEmpty(habitat))
            {
                lblOutput.Text =
                    "Please select a habitat.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            // =====================================================
            // CONNECTION
            // =====================================================

            string connStr =
                GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                lblOutput.Text =
                    "Database connection string is missing.";

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);

                return;
            }

            // =====================================================
            // UPDATE DATABASE
            // =====================================================

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
                            "@Name",
                            name
                        );

                        cmd.Parameters.AddWithValue(
                            "@Species",
                            species
                        );

                        cmd.Parameters.AddWithValue(
                            "@DateOfBirth",
                            parsedDOB.ToString("yyyy-MM-dd")
                        );

                        cmd.Parameters.AddWithValue(
                            "@Gender",
                            gender
                        );

                        cmd.Parameters.AddWithValue(
                            "@HabitatLocation",
                            habitat
                        );

                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        con.Open();

                        int rowsAffected =
                            cmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            lblOutput.Text =
                                "Animal #" +
                                animalID +
                                " updated successfully!";

                            lblOutput.ForeColor =
                                Color.FromArgb(128, 255, 219);

                            string selectedID =
                                animalID.ToString();

                            LoadAnimals();

                            if (ddlSelectAnimal.Items.FindByValue(
                                selectedID) != null)
                            {
                                ddlSelectAnimal.SelectedValue =
                                    selectedID;
                            }

                            pnlEditForm.Visible = true;
                        }
                        else
                        {
                            lblOutput.Text =
                                "Animal could not be updated.";

                            lblOutput.ForeColor =
                                Color.FromArgb(255, 107, 122);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                lblOutput.Text =
                    "Database error while updating animal: " +
                    ex.Message;

                lblOutput.ForeColor =
                    Color.FromArgb(255, 107, 122);
            }
        }

        // =========================================================
        // BACK / CANCEL
        // GOES TO ANIMAL MANAGEMENT DASHBOARD
        // =========================================================
        protected void btnMenu_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Animals_DashBoard.aspx",
                false
            );

            Context.ApplicationInstance.CompleteRequest();
        }
    }
}
