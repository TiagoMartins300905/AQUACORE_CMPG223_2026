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

                // Generate current date and time
                SetPrintDateTime();

                // Load all animals
                LoadAnimals();
            }
            else
            {
                // Keep the print date/time updated
                SetPrintDateTime();
            }
        }


        // ==========================================
        // GENERATE PRINT DATE AND TIME
        // ==========================================

        private void SetPrintDateTime()
        {
            lblPrintDate.Text =
                DateTime.Now.ToString(
                    "dd MMMM yyyy, HH:mm:ss"
                );
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


                    // ==========================================
                    // GET FILTER COLUMN
                    // ==========================================

                    string filterColumn =
                        GetFilterColumn();


                    // ==========================================
                    // GET SORT COLUMN
                    // ==========================================

                    string sortColumn =
                        GetSortColumn();


                    // ==========================================
                    // GET SORT DIRECTION
                    // ==========================================

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
                    // CHECK IF FILTER IS BEING USED
                    // ==========================================

                    bool hasFilter =
                        !string.IsNullOrWhiteSpace(
                            filterColumn
                        )
                        &&
                        !string.IsNullOrWhiteSpace(
                            txtFilter.Text
                        );


                    // ==========================================
                    // ADD FILTER
                    // ==========================================

                    if (hasFilter)
                    {
                        /*
                         * Age is a number, so it uses
                         * an exact comparison.
                         *
                         * Name, Species and Gender
                         * use LIKE.
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
                    // ADD SORTING
                    // ==========================================

                    sql +=
                        " ORDER BY " +
                        sortColumn +
                        " " +
                        sortDirection;


                    // ==========================================
                    // CREATE SQL COMMAND
                    // ==========================================

                    using (SQLiteCommand cmd =
                           new SQLiteCommand(sql, con))
                    {
                        // ==========================================
                        // ADD FILTER PARAMETER
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


                                // Invalid age entered
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


                            // Bind data to GridView
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

            SetPrintDateTime();
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

            SetPrintDateTime();
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

            SetPrintDateTime();
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