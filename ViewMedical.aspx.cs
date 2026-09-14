using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class ViewMedical : System.Web.UI.Page
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
                LoadSortOptions();

                // Default sort order
                rdoASC.Checked = true;

                LoadMedicalRecords();
            }
        }

        // Populate the Sort By dropdown
        private void LoadSortOptions()
        {
            DropDownList1.Items.Clear();

            DropDownList1.Items.Add(
                new ListItem("-- Select Sort --", "")
            );

            DropDownList1.Items.Add(
                new ListItem("Record ID", "RecordID")
            );

            DropDownList1.Items.Add(
                new ListItem("Animal Name", "AnimalName")
            );

            DropDownList1.Items.Add(
                new ListItem("Species", "Species")
            );

            DropDownList1.Items.Add(
                new ListItem("Veterinarian", "VetName")
            );

            DropDownList1.Items.Add(
                new ListItem("Check-Up Date", "DateOfCheckup")
            );

            DropDownList1.Items.Add(
                new ListItem("Follow-Up Required", "IsFollowUpRequired")
            );
        }

        // Load the medical records
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
                    string sortColumn = GetSortColumn();
                    string sortDirection = GetSortDirection();

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
                        + sortColumn + " " + sortDirection;

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        con.Open();

                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(cmd))
                        {
                            DataTable dt = new DataTable();

                            adapter.Fill(dt);

                            GridView1.DataSource = dt;
                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // You can add a status label later if you want
                // to display this error to the user.
                System.Diagnostics.Debug.WriteLine(
                    "Error loading medical records: " + ex.Message
                );
            }
        }

        // Determine which database column can safely be sorted
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
                    // Default sorting
                    return "mr.RecordID";
            }
        }

        // Determine ascending or descending order
        private string GetSortDirection()
        {
            if (rdoDESC.Checked)
            {
                return "DESC";
            }

            return "ASC";
        }

        // When the Sort By dropdown changes
        protected void DropDownList1_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
            LoadMedicalRecords();
        }

        // When Ascending/Descending changes
        protected void rdoASC_CheckedChanged(
            object sender,
            EventArgs e)
        {
            LoadMedicalRecords();
        }

        protected void rdoDESC_CheckedChanged(
            object sender,
            EventArgs e)
        {
            LoadMedicalRecords();
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Medicals_Dashboard.aspx");
        }

        protected void GridView1_SelectedIndexChanged(
            object sender,
            EventArgs e)
        {
        }
    }
}
