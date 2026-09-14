using System;

namespace AQUACORE_CMPG223
{
    public partial class UpdateEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO (team, on campus): populate ddlSelectEmployee from the database.
        }

        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            // TODO (team, on campus): load the selected employee's details into
            // the form fields below. No DB logic yet - UI wiring only.
            pnlEditForm.Visible = !string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue);
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            // TODO (team, on campus): validate and save these changes to the database.
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string contactDetails = txtContactDetails.Text.Trim();
            string department = ddlDepartment.SelectedValue;
            string role = ddlRole.SelectedValue;
            string workSchedule = txtWorkSchedule.Text.Trim();
        }
    }
}
