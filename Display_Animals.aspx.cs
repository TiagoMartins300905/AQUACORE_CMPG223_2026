using System;
using System.Configuration;
using System.Data;
using System.Data.SQLite;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class Display_Animals : System.Web.UI.Page
    {
        // ==========================================
        // DATABASE CONNECTION
        // ==========================================

        private string connStr =
            ConfigurationManager
            .ConnectionStrings["AquaCoreConnectionString"]
            .ConnectionString;


        // ==========================================
        // PAGE LOAD
        // ==========================================

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Default filter
                ddlFilter.SelectedValue = "";

                // Default sorting
                ddlSort.SelectedValue = "AnimalID";

                // Default order
                rdoASC.Checked = true;
                rdoDESC.Checked = false;

                // Clear search box
                txtFilter.Text = "";

                // Load all animals
                LoadAnimals();
            }
        }


        // ==========================================
        // LOAD ANIMALS
        // ==========================================

        private void LoadAnimals()
        {
            try
            {
                using (SQLiteConnection con =
                       new SQLiteConnection(connStr))
                {
                    con.Open();


                    // Get filter column
                    string filterColumn =
                        GetFilterColumn();


                    // Get sort column
                    string sortColumn =
                        GetSortColumn();


                    // Get sort direction
                    string sortDirection =
                        GetSortDirection();


                    // ==========================================
                    // BASE SQL QUERY
                    // ==========================================

                    string sql = @"
                        SELECT *
                        FROM Animal
                    ";


                    // ==========================================
                    // FILTER
                    // ==========================================

                    bool hasFilter =
                        !string.IsNullOrWhiteSpace(
                            filterColumn
                        )
                        &&
                        !string.IsNullOrWhiteSpace(
                            txtFilter.Text
                        );


                    if (hasFilter)
                    {
                        /*
                         * Age is normally a number.
                         *
                         * Therefore:
                         *
                         * Name / Species / Gender
                         * use LIKE.
                         *
                         * Age
                         * uses an exact number comparison.
                         */

                        if (ddlFilter.SelectedValue == "Age")
                        {
                            sql +=
                                " WHERE " +
                                filterColumn +
                                " = @FilterValue ";
                        }
                        else
                        {
                            sql +=
                                " WHERE " +
                                filterColumn +
                                " LIKE @FilterValue ";
                        }
                    }


                    // ==========================================
                    // SORTING
                    // ==========================================

                    sql +=
                        " ORDER BY " +
                        sortColumn +
                        " " +
                        sortDirection;


                    // ==========================================
                    // SQL COMMAND
                    // ==========================================

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        // ==========================================
                        // FILTER PARAMETER
                        // ==========================================

                        if (hasFilter)
                        {
                            // ==========================================
                            // AGE FILTER
                            // ==========================================

                            if (ddlFilter.SelectedValue == "Age")
                            {
                                int age;

                                bool validAge =
                                    int.TryParse(
                                        txtFilter.Text.Trim(),
                                        out age
                                    );


                                // If the user entered
                                // something that isn't a number
                                if (!validAge)
                                {
                                    GridView1.DataSource = null;

                                    GridView1.DataBind();

                                    return;
                                }


                                cmd.Parameters.AddWithValue(
                                    "@FilterValue",
                                    age
                                );
                            }


                            // ==========================================
                            // TEXT FILTER
                            // ==========================================

                            else
                            {
                                cmd.Parameters.AddWithValue(
                                    "@FilterValue",
                                    "%" +
                                    txtFilter.Text.Trim() +
                                    "%"
                                );
                            }
                        }


                        // ==========================================
                        // LOAD DATA
                        // ==========================================

                        using (SQLiteDataAdapter adapter =
                               new SQLiteDataAdapter(cmd))
                        {
                            DataTable dt =
                                new DataTable();


                            adapter.Fill(dt);


                            // Put data into GridView
                            GridView1.DataSource = dt;

                            GridView1.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine(
                    "Error loading animals: " +
                    ex.Message
                );
            }
        }


        // ==========================================
        // GET FILTER COLUMN
        // ==========================================

        private string GetFilterColumn()
        {
            switch (ddlFilter.SelectedValue)
            {
                case "Name":

                    return "Name";


                case "Species":

                    return "Species";


                case "Gender":

                    return "Gender";


                case "Age":

                    return "Age";


                default:

                    return "";
            }
        }


        // ==========================================
        // GET SORT COLUMN
        // ==========================================

        private string GetSortColumn()
        {
            switch (ddlSort.SelectedValue)
            {
                case "AnimalID":

                    return "AnimalID";


                case "Name":

                    return "Name";


                case "Species":

                    return "Species";


                case "Gender":

                    return "Gender";


                case "Age":

                    return "Age";


                default:

                    return "AnimalID";
            }
        }


        // ==========================================
        // GET SORT DIRECTION
        // ==========================================

        private string GetSortDirection()
        {
            if (rdoDESC.Checked)
            {
                return "DESC";
            }

            return "ASC";
        }


        // ==========================================
        // APPLY FILTER AND SORT
        // ==========================================

        protected void btnApply_Click(
            object sender,
            EventArgs e)
        {
            LoadAnimals();
        }


        // ==========================================
        // ASCENDING
        // ==========================================

        protected void rdoASC_CheckedChanged(
            object sender,
            EventArgs e)
        {
            rdoASC.Checked = true;

            rdoDESC.Checked = false;

            LoadAnimals();
        }


        // ==========================================
        // DESCENDING
        // ==========================================

        protected void rdoDESC_CheckedChanged(
            object sender,
            EventArgs e)
        {
            rdoDESC.Checked = true;

            rdoASC.Checked = false;

            LoadAnimals();
        }


        // ==========================================
        // ANIMAL MENU / BACK BUTTON
        // ==========================================

        protected void btnMenu_Click(
            object sender,
            EventArgs e)
        {
            Response.Redirect(
                "Animals_DashBoard.aspx"
            );
        }
    }
}
