using System;

namespace AQUACORE_CMPG223
{
    public partial class DeleteEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // TODO (team, on campus): populate ddlSelectEmployee from the database.
        }

        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            // TODO (team, on campus): load the selected employee's details
            // (name/email/department) into lblName/lblEmail/lblDept below.
            pnlConfirmForm.Visible = !string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue);
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            // TODO (team, on campus): soft-delete (IsActive = 0) the selected
            // employee in the database. No DB logic yet - UI wiring only.
        }
    }
}
