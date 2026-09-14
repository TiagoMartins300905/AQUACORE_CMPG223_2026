using System;

namespace AQUACORE_CMPG223
{
    public partial class EmployeeManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // TODO (team, on campus): query the database for employees matching
            // this term and bind gvEmployees. No DB logic yet - UI wiring only.
            string searchTerm = txtSearch.Text.Trim();
        }
    }
}
