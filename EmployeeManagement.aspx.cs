using System;
using System.Drawing;

namespace AQUACORE_CMPG223
{
    public partial class EmployeeManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDirectory();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadDirectory(txtSearch.Text.Trim());
        }

        private void LoadDirectory(string searchTerm = "")
        {
            try
            {
                gvEmployees.DataSource = EmployeeRepository.SearchActive(searchTerm);
                gvEmployees.DataBind();
                lblStatus.Text = string.Empty;
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error loading directory: " + ex.Message;
                lblStatus.ForeColor = Color.FromArgb(255, 107, 107);
            }
        }
    }
}
