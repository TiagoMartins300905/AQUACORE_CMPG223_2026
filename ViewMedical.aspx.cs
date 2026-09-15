using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class ViewMedical : System.Web.UI.Page
    {
        // ============================================================
        // CONNECTION STRING
        // ============================================================

        private string GetConnectionString()
        {
            return ConfigurationManager
                .ConnectionStrings["AquaCoreConnectionString"]
                ?.ConnectionString;
        }


        // ============================================================
        // PAGE LOAD
        // ============================================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Load the sorting options
                LoadSortOptions();

                // Default sorting
                rdoASC.Checked = true;

                // Load medical records
                LoadMedicalRecords();
            }
        }


        // ============================================================
        // LOAD SORT OPTIONS
        // ============================================================

        private void LoadSortOptions()
        {
            DropDownList1.Items.Clear();

            DropDownList1.Items.Add(
                new ListItem(
                    "-- Select Sort --",
                    ""
                )
            );

            DropDownList1.Items.Add(
                new ListItem(
                    "Record ID",
                    "RecordID"
                )
            );

            DropDownList1.Items.Add(
                new ListItem(
                    "Animal Name",
                    "AnimalName"
                )
            );

            DropDownList1.Items.Add(
                new ListItem(
                    "Species",
                    "Species"
                )
            );

            DropDownList1.Items.Add(
                new ListItem(
                    "Veterinarian",
                    "VetName"
                )
            );

            DropDownList1.Items.Add(
                new ListItem(
                    "Check-Up Date",
                    "DateOfCheckup"
                )
            );

            DropDownList1.Items.Add(
                new ListItem(
                    "Follow-Up Required",
                    "IsFollowUpRequired"
                )
            );
        }


        // ============================================================
        // LOAD MEDICAL RECORDS
        // ============================================================

        private void LoadMedicalRecords()
        {
            string connStr = GetConnectionString();

            if (string.IsNullOrEmpty(connStr))
            {
                return;
            }

            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    string sortColumn =
                        GetSortColumn();

                    string sortDirection =
                        GetSortDirection();


                    string sql = @"
                        SELECT
                            mr.RecordID,
                            a.Name AS AnimalName,
                            a.Species,
                            mr.VetName,
                            mr.DateOfCheckup,
                            mr.IsFollowUpRequired

                        FROM Medical_Record mr

                        INNER JOIN Animal a
                            ON mr.AnimalID = a.AnimalID

                        ORDER BY "
                        + sortColumn
                        + " "
                        + sortDirection;


                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        con.Open();


                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(cmd))
                        {
                            DataTable dt =
                                new DataTable();


                            adapter.Fill(dt);


                            GridView1.DataSource =
                                dt;

                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    "Error loading medical records: "
                    + ex.Message
                );
            }
        }


        // ============================================================
        // GET SORT COLUMN
        // ============================================================

        private string GetSortColumn()
        {
            switch (DropDownList1.SelectedValue)
            {
                case "RecordID":

                    return "mr.RecordID";


                case "AnimalName":

                    return "a.Name";


                case "Species":

                    return "a.Species";


                case "VetName":

                    return "mr.VetName";


                case "DateOfCheckup":

                    return "mr.DateOfCheckup";


                case "IsFollowUpRequired":

                    return "mr.IsFollowUpRequired";


                default:

                    return "mr.RecordID";
            }
        }


        // ============================================================
        // GET SORT DIRECTION
        // ============================================================

        private string GetSortDirection()
        {
            if (rdoDESC.Checked)
            {
                return "DESC";
            }

            return "ASC";
        }


        // ============================================================
        // SORT DROPDOWN CHANGED
        // ============================================================

        protected void DropDownList1_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            LoadMedicalRecords();
        }


        // ============================================================
        // ASCENDING CHANGED
        // ============================================================

        protected void rdoASC_CheckedChanged(
            object sender,
            EventArgs e)
        {
            if (rdoASC.Checked)
            {
                LoadMedicalRecords();
            }
        }


        // ============================================================
        // DESCENDING CHANGED
        // ============================================================

        protected void rdoDESC_CheckedChanged(
            object sender,
            EventArgs e)
        {
            if (rdoDESC.Checked)
            {
                LoadMedicalRecords();
            }
        }


        // ============================================================
        // BACK BUTTON
        // ============================================================

        protected void btnBack_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Medicals_Dashboard.aspx"
            );
        }
    }
}
