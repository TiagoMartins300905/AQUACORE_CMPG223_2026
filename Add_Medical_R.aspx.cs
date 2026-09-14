using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;

namespace AQUACORE_CMPG223
{
    public partial class Add_Medical_R : System.Web.UI.Page
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
                lblValidate.Visible = false;
            }
        }

        protected void rdbYes_CheckedChanged(object sender, EventArgs e)
        {
            lblValidate.Visible = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Medicals_Dashboard.aspx");
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Hide previous validation message
            lblValidate.Visible = false;

            // -----------------------------
            // Validate Animal ID
            // -----------------------------

            int animalID;

            if (!int.TryParse(txtAnimalID.Text.Trim(), out animalID))
            {
                ShowMessage(
                    "Please enter a valid Animal ID.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            // -----------------------------
            // Validate Veterinarian
            // -----------------------------

            string vetName = txtVet.Text.Trim();

            if (string.IsNullOrEmpty(vetName))
            {
                ShowMessage(
                    "Please enter the veterinarian's name.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            // -----------------------------
            // Validate Check-Up Date
            // -----------------------------

            DateTime checkUpDate;

            if (!DateTime.TryParse(
                txtCheckUp.Text,
                out checkUpDate))
            {
                ShowMessage(
                    "Please enter a valid check-up date.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            // -----------------------------
            // Validate Follow-Up
            // -----------------------------

            string followUpRequired;

            if (rdbYes.Checked)
            {
                followUpRequired = "Yes";
            }
            else if (rdbNo.Checked)
            {
                followUpRequired = "No";
            }
            else
            {
                ShowMessage(
                    "Please choose whether a follow-up is required.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            // -----------------------------
            // Get database connection
            // -----------------------------

            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                ShowMessage(
                    "Database connection string is missing.",
                    Color.FromArgb(255, 107, 122)
                );

                return;
            }

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();

                    // Check that the Animal exists
                    string checkAnimalSql = @"
                    SELECT COUNT(*)
                    FROM Animal
                    WHERE AnimalID = @AnimalID";

                    using (SQLiteCommand checkAnimalCmd =
                           new SQLiteCommand(checkAnimalSql, con))
                    {
                        checkAnimalCmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
                        );

                        long animalExists =
                            (long)checkAnimalCmd.ExecuteScalar();

                        if (animalExists == 0)
                        {
                            ShowMessage(
                                "The Animal ID does not exist. Please enter a valid Animal ID.",
                                Color.FromArgb(255, 107, 122)
                            );

                            return;
                        }
                    }

                    // -----------------------------
                    // Insert Medical Record
                    // -----------------------------

                    string insertSql = @"
                    INSERT INTO Medical_Record
                    (
                        AnimalID,
                        VetName,
                        DateOfCheckup,
                        IsFollowUpRequired
                    )
                    VALUES
                    (
                        @AnimalID,
                        @VetName,
                        @DateOfCheckup,
                        @IsFollowUpRequired
                    )";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(insertSql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@AnimalID",
                            animalID
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

                        cmd.ExecuteNonQuery();
                    }
                }

                // -----------------------------
                // Success
                // -----------------------------

                ShowMessage(
                    "Medical record successfully added.",
                    Color.FromArgb(128, 255, 219)
                );

                // Clear the form
                txtRecordID.Text = "";
                txtAnimalID.Text = "";
                txtVet.Text = "";
                txtCheckUp.Text = "";

                rdbYes.Checked = false;
                rdbNo.Checked = false;
            }
            catch (Exception ex)
            {
                ShowMessage(
                    "Error adding medical record: " + ex.Message,
                    Color.FromArgb(255, 107, 122)
                );
            }
        }

        private void ShowMessage(string message, Color color)
        {
            lblValidate.Text = message;
            lblValidate.ForeColor = color;
            lblValidate.Visible = true;
        }
    }


}