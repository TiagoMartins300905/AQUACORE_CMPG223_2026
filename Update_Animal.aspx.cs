using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SQLite;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class Update_Animal : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void rdbMale_CheckedChanged1(object sender, EventArgs e)
        {

        }

        protected void btnMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("Animals_DashBoard.aspx", false);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // Animal ID is required because we need to know which animal to update
            if (!int.TryParse(txtID.Text, out int animalID))
            {
                lblOutput.Text = "Please enter a valid Animal ID.";
                return;
            }

            string qry = "UPDATE Animal SET ";
            List<string> updates = new List<string>();

            SQLiteCommand command;
            SQLiteConnection conn = new SQLiteConnection(connStr);

            // Name
            if (!string.IsNullOrWhiteSpace(txtName.Text))
            {
                if (int.TryParse(txtName.Text, out _))
                {
                    lblOutput.Text = "Please enter a valid name.";
                    return;
                }

                updates.Add("Name = @name");
            }

            // Species
            if (!string.IsNullOrWhiteSpace(txtSpecies.Text))
            {
                if (int.TryParse(txtSpecies.Text, out _))
                {
                    lblOutput.Text = "Please enter a valid species.";
                    return;
                }

                updates.Add("Species = @species");
            }

            // Date of Birth
            DateTime dob = DateTime.MinValue;

            if (!string.IsNullOrWhiteSpace(txtDOB.Text))
            {
                if (!DateTime.TryParse(txtDOB.Text, out dob))
                {
                    lblOutput.Text = "Please enter a valid date.";
                    return;
                }

                updates.Add("DateOfBirth = @DOB");
            }

            // Gender
            string gender = "";

            if (rdbMale.Checked)
            {
                gender = "Male";
                updates.Add("Gender = @gender");
            }
            else if (rdbFemale.Checked)
            {
                gender = "Female";
                updates.Add("Gender = @gender");
            }

            // Habitat
            if (ddHabitat.SelectedIndex != 0)
            {
                updates.Add("HabitatLocation = @habitat");
            }

            // Make sure the user changed something
            if (updates.Count == 0)
            {
                lblOutput.Text = "Please enter at least one value to update.";
                return;
            }

            // Complete the UPDATE statement
            qry += string.Join(", ", updates);
            qry += " WHERE AnimalID = @ID";

            command = new SQLiteCommand(qry, conn);

            // Animal ID
            command.Parameters.AddWithValue("@ID", animalID);

            // Only add parameters for fields that were changed
            if (!string.IsNullOrWhiteSpace(txtName.Text))
            {
                command.Parameters.AddWithValue("@name", txtName.Text);
            }

            if (!string.IsNullOrWhiteSpace(txtSpecies.Text))
            {
                command.Parameters.AddWithValue("@species", txtSpecies.Text);
            }

            
            if (!string.IsNullOrWhiteSpace(txtDOB.Text))
            {
                command.Parameters.AddWithValue("@DOB", dob);
            }

            if (rdbMale.Checked || rdbFemale.Checked)
            {
                command.Parameters.AddWithValue("@gender", gender);
            }

            if (ddHabitat.SelectedIndex != 0)
            {
                command.Parameters.AddWithValue("@habitat", ddHabitat.SelectedValue);
            }

            conn.Open();

            int rowsAffected = command.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                lblOutput.Text = "Animal updated successfully.";
            }
            else
            {
                lblOutput.Text = "Animal ID not found.";
            }

            command.Dispose();
            conn.Close();
        }
    }
}