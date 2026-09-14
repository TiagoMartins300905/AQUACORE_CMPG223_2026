using System;
using System.Configuration;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Delete : System.Web.UI.Page
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
                LoadMedicalRecords();
            }
        }

        private void LoadMedicalRecords()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                SetStatus(
                    "Database connection string is missing.",
                    Color.Red
                );
                return;
            }

            try
            {
                using (SQLiteConnection con = new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT 
                            mr.RecordID,
                            a.Name || ' - ' || mr.VetName || ' - ' ||
                            mr.DateOfCheckup AS RecordDetails
                        FROM Medical_Record mr
                        INNER JOIN Animal a
                            ON mr.AnimalID = a.AnimalID
                        ORDER BY mr.DateOfCheckup DESC";

                    using (SQLiteCommand cmd = new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataReader reader = cmd.ExecuteReader())
                        {
                            ddlSelectMedical.DataSource = reader;
                            ddlSelectMedical.DataTextField = "RecordDetails";
                            ddlSelectMedical.DataValueField = "RecordID";
                            ddlSelectMedical.DataBind();
                        }
                    }
                }

                ddlSelectMedical.Items.Insert(
                    0,
                    new ListItem("-- Select Medical Record --", "")
                );
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Error loading medical records: " + ex.Message,
                    Color.Red
                );
            }
        }

        protected void ddlSelectMedical_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            lblStatus.Text = "";

            if (string.IsNullOrEmpty(ddlSelectMedical.SelectedValue))
            {
                pnlConfirmForm.Visible = false;
                return;
            }

            int recordId = Convert.ToInt32(
                ddlSelectMedical.SelectedValue
            );

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                        SELECT 
                            mr.RecordID,
                            mr.AnimalID,
                            a.Name,
                            a.Species,
                            mr.VetName,
                            mr.DateOfCheckup,
                            mr.IsFollowUpRequired
                        FROM Medical_Record mr
                        INNER JOIN Animal a
                            ON mr.AnimalID = a.AnimalID
                        WHERE mr.RecordID = @RecordID";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@RecordID",
                            recordId
                        );

                        con.Open();

                        using (SQLiteDataReader reader =
                               cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                lblRecordID.Text =
                                    reader["RecordID"].ToString();

                                lblAnimalID.Text =
                                    reader["AnimalID"].ToString();

                                lblAnimal.Text =
                                    reader["Name"].ToString();

                                lblSpecies.Text =
                                    reader["Species"].ToString();

                                lblVet.Text =
                                    reader["VetName"].ToString();

                                lblCheckupDate.Text =
                                    reader["DateOfCheckup"].ToString();

                                lblFollowUp.Text =
                                    reader["IsFollowUpRequired"].ToString();

                                pnlConfirmForm.Visible = true;
                            }
                            else
                            {
                                pnlConfirmForm.Visible = false;

                                SetStatus(
                                    "Medical record could not be found.",
                                    Color.Red
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
                    Color.Red
                );
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(
                ddlSelectMedical.SelectedValue))
            {
                SetStatus(
                    "Please select a medical record first.",
                    Color.Red
                );
                return;
            }

            int recordId = Convert.ToInt32(
                ddlSelectMedical.SelectedValue
            );

            string connStr = GetConnectionString();

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    string sql = @"
                        DELETE FROM Medical_Record
                        WHERE RecordID = @RecordID";

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        cmd.Parameters.AddWithValue(
                            "@RecordID",
                            recordId
                        );

                        con.Open();

                        int rowsDeleted = cmd.ExecuteNonQuery();

                        if (rowsDeleted > 0)
                        {
                            pnlConfirmForm.Visible = false;

                            SetStatus(
                                "Medical record successfully deleted.",
                                Color.FromArgb(128, 255, 219)
                            );

                            LoadMedicalRecords();
                        }
                        else
                        {
                            SetStatus(
                                "Medical record could not be found.",
                                Color.Red
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                SetStatus(
                    "Database error during deletion: " + ex.Message,
                    Color.Red
                );
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Medicals_Dashboard.aspx");
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}
