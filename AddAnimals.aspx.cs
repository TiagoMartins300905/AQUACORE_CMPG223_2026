using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SQLite;
using System.Data.SqlClient;

namespace AQUACORE_CMPG223
{
    public partial class AddAnimals : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblGender.Text = "";
            }
        }

        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;

        protected void rdbFemale_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void rdbMale_CheckedChanged(object sender, EventArgs e)
        {

        }

        protected void rdbMale_CheckedChanged1(object sender, EventArgs e)
        {

        }


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            string name = txtName.Text;
            string species = txtSpecies.Text;
            string gender = "";
            

            if (int.TryParse(name, out _))
            {
                lblOutput.Text = "Please enter a valid name";
                return;
            }

            if (int.TryParse(species, out _))
            {
                lblOutput.Text = "Please enter a valid species";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtDOB.Text))
            {
                lblOutput.Text = "Date of birth is required.";
                return;
            }

            if (!DateTime.TryParse(txtDOB.Text, out DateTime dob))
            {
                lblOutput.Text = "Invalid date.";
                return;
            }

            if (!rdbMale.Checked && !rdbFemale.Checked)
            {
                lblGender.Text = "Animal Gender cannot be left out!";
                return;
            }

            if (rdbMale.Checked)
            {
                gender = "Male";
            }

            if (rdbFemale.Checked)
            {
                gender = "Female";
            }

            SQLiteCommand cmd;
            SQLiteConnection con = new SQLiteConnection(connStr);
            con.Open();
            String qry = "Insert Into Animal(Name, Species, DateOfBirth, Gender, HabitatLocation) Values (@name, @species, @DOB, @gender, @habitat)";
            cmd = new SQLiteCommand(qry, con);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@species", species);
            cmd.Parameters.AddWithValue("@DOB", dob);
            cmd.Parameters.AddWithValue("@gender", gender);
            cmd.Parameters.AddWithValue("@habitat", ddHabitat.SelectedItem.ToString().Trim());

            cmd.ExecuteNonQuery();
            cmd.Dispose();
            con.Close();

            txtName.Text = "";
            txtSpecies.Text = "";
            txtDOB.Text = "";
            rdbMale.Checked = false;
            rdbFemale.Checked = false;
            ddHabitat.SelectedIndex = 0;
            lblGender.Text = "";
        }


        protected void txtName_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Animals_DashBoard.aspx", false);
        }
    }
}