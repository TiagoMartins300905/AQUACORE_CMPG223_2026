using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateMedical : System.Web.UI.Page
    {
        // Get SQLite connection string from Web.config
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
                LoadMedicalDropdown();
                LoadAnimalDropdown();
            }
        }


        // 1. Load all medical records into the dropdown
        private void LoadMedicalDropdown()
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
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = @"
                    SELECT 
                        RecordID,
                        'Record #' || RecordID || 
                        ' - ' || 
                        COALESCE(VetName, 'Unknown Vet') AS RecordName
                    FROM Medical_Record
                    ORDER BY RecordID";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            ddlMedical.DataSource = reader;
                            ddlMedical.DataTextField = "RecordName";
                            ddlMedical.DataValueField = "RecordID";
                            ddlMedical.DataBind();
                        }
                    }
                }

                ddlMedical.Items.Insert(
                    0,
                    new ListItem("-- Select a Medical Record --", "")
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading medical records: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // 2. Load animals into the Animal dropdown
        private void LoadAnimalDropdown()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                return;
            }

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = @"
                    SELECT 
                        AnimalID,
                        Name || ' - ' || Species AS AnimalName
                    FROM Animal
                    ORDER BY Name";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            ddlAnimal.DataSource = reader;
                            ddlAnimal.DataTextField = "AnimalName";
                            ddlAnimal.DataValueField = "AnimalID";
                            ddlAnimal.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading animals: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // 3. When the user selects a medical record
        protected void ddlMedical_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblStatus.Text = "";

            if (string.IsNullOrEmpty(ddlMedical.SelectedValue))
            {
                pnlEditForm.Visible = false;
                return;
            }

            int recordId = Convert.ToInt32(ddlMedical.SelectedValue);

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = @"
                    SELECT
                        AnimalID,
                        VetName,
                        DateOfCheckup,
                        IsFollowUpRequired
                    FROM Medical_Record
                    WHERE RecordID = @RecordID";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@RecordID",
                            recordId
                        );

                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Load Animal
                                string animalId =
                                    reader["AnimalID"].ToString();

                                if (ddlAnimal.Items.FindByValue(animalId) != null)
                                {
                                    ddlAnimal.SelectedValue = animalId;
                                }


                                // Load Veterinarian
                                txtVet.Text =
                                    reader["VetName"].ToString();


                                // Load Check-Up Date
                                if (reader["DateOfCheckup"] != DBNull.Value)
                                {
                                    DateTime date =
                                        Convert.ToDateTime(
                                            reader["DateOfCheckup"]
                                        );

                                    txtCheckUp.Text =
                                        date.ToString("yyyy-MM-dd");
                                }
                                else
                                {
                                    txtCheckUp.Text = "";
                                }


                                // Load Follow-Up
                                string followUp =
                                    reader["IsFollowUpRequired"].ToString();

                                if (followUp.Equals(
                                    "Yes",
                                    StringComparison.OrdinalIgnoreCase))
                                {
                                    rdbYes.Checked = true;
                                    rdbNo.Checked = false;
                                }
                                else
                                {
                                    rdbYes.Checked = false;
                                    rdbNo.Checked = true;
                                }


                                // Show the edit form
                                pnlEditForm.Visible = true;
                            }
                            else
                            {
                                pnlEditForm.Visible = false;

                                SetStatus(
                                    "Medical record not found.",
                                    Color.FromArgb(255, 107, 107)
                                );
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error retrieving medical record: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // 4. Update the medical record
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlMedical.SelectedValue))
            {
                SetStatus(
                    "Please select a medical record first.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            int recordId =
                Convert.ToInt32(ddlMedical.SelectedValue);


            // Get Animal ID
            int animalId;

            if (!int.TryParse(
                ddlAnimal.SelectedValue,
                out animalId))
            {
                SetStatus(
                    "Please select an animal.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Get veterinarian
            string vetName =
                txtVet.Text.Trim();


            if (string.IsNullOrEmpty(vetName))
            {
                SetStatus(
                    "Veterinarian name is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Get check-up date
            DateTime checkUpDate;

            if (!DateTime.TryParse(
                txtCheckUp.Text,
                out checkUpDate))
            {
                SetStatus(
                    "Please enter a valid check-up date.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            // Check follow-up selection
            if (!rdbYes.Checked && !rdbNo.Checked)
            {
                SetStatus(
                    "Please select whether a follow-up is required.",
                    Color.FromArgb(255, 107, 107)
                );

                return;
            }


            string followUpRequired =
                rdbYes.Checked ? "Yes" : "No";


            string connStr = GetConnectionString();


            try
            {
                using (SQLiteConnection con =
                    new SQLiteConnection(connStr))
                {
                    string sql = @"
                    UPDATE Medical_Record
                    SET
                        AnimalID = @AnimalID,
                        VetName = @VetName,
                        DateOfCheckup = @DateOfCheckup,
                        IsFollowUpRequired = @IsFollowUpRequired
                    WHERE RecordID = @RecordID";


                    using (SQLiteCommand cmd =
                        new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@RecordID",
                            recordId
                        );

                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalId
                        );

                        cmd.Parameters.AddWithValue(
                            "@VetName",
                            vetName
                        );

                        cmd.Parameters.AddWithValue(
                            "@DateOfCheckup",
                            checkUpDate.ToString("yyyy-MM-dd")
                        );

                        cmd.Parameters.AddWithValue(
                            "@IsFollowUpRequired",
                            followUpRequired
                        );


                        con.Open();

                        int rowsAffected =
                            cmd.ExecuteNonQuery();


                        if (rowsAffected > 0)
                        {
                            SetStatus(
                                "Medical record updated successfully!",
                                Color.FromArgb(128, 255, 219)
                            );


                            // Refresh medical records
                            LoadMedicalDropdown();


                            // Keep the updated record selected
                            ddlMedical.SelectedValue =
                                recordId.ToString();


                            // Keep edit form visible
                            pnlEditForm.Visible = true;
                        }
                        else
                        {
                            SetStatus(
                                "No medical record was updated.",
                                Color.FromArgb(255, 107, 107)
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during update: " + ex.Message,
                    Color.FromArgb(255, 107, 107)
                );
            }
        }


        // 5. Back button
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Medicals_Dashboard.aspx");
        }


        // 6. Optional radio button event
        protected void rdbYes_CheckedChanged(object sender, EventArgs e)
        {
            // No code is required here.
            // The selected value is checked when Update is clicked.
        }


        // 7. Display status messages
        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }


}