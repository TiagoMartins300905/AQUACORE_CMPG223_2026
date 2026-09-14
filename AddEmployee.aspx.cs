using System;

namespace AQUACORE_CMPG223
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // TODO (team, on campus): validate these fields and save the new
            // employee to the database. No DB logic yet - UI wiring only.
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string department = ddlDepartment.SelectedValue;
            string role = ddlRole.SelectedValue;
            string contactDetails = txtContactDetails.Text.Trim();
            string workSchedule = txtWorkSchedule.Text.Trim();
        }
    }
}
