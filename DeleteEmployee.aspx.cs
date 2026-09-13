using System;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class DeleteEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployeeDropdown();
            }
        }

        // 1. Fetch all active employees to populate the dropdown
        private void LoadEmployeeDropdown()
        {
            try
            {
                ddlSelectEmployee.DataSource = EmployeeRepository.GetActiveForDropdown();
                ddlSelectEmployee.DataTextField = "FullName";
                ddlSelectEmployee.DataValueField = "EmployeeID";
                ddlSelectEmployee.DataBind();

                ddlSelectEmployee.Items.Insert(0, new ListItem("-- Select an Employee --", ""));
            }
            catch (Exception ex)
            {
                SetStatus("Error loading employees: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        // 2. Fetch and display details when an employee is selected
        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblStatus.Text = string.Empty;

            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue))
            {
                pnlConfirmForm.Visible = false;
                return;
            }

            int selectedId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);

            try
            {
                Employee employee = EmployeeRepository.GetById(selectedId);
                if (employee == null)
                {
                    SetStatus("That employee could not be found (it may already have been removed).", Color.FromArgb(255, 107, 107));
                    pnlConfirmForm.Visible = false;
                    return;
                }

                lblName.Text = employee.FirstName + " " + employee.LastName;
                lblEmail.Text = employee.Email;
                lblDept.Text = employee.DepartmentName;

                pnlConfirmForm.Visible = true;
            }
            catch (Exception ex)
            {
                SetStatus("Error retrieving employee: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        // 3. Soft-delete: deactivate the employee instead of a hard DELETE, so
        // Ticket/Animal/Restaurant records that reference EmployeeID stay intact.
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue)) return;

            int employeeId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);

            try
            {
                EmployeeRepository.Deactivate(employeeId);

                pnlConfirmForm.Visible = false;
                SetStatus("Employee successfully deactivated.", Color.FromArgb(128, 255, 219));

                // Refresh the dropdown so the deactivated employee is gone
                LoadEmployeeDropdown();
            }
            catch (Exception ex)
            {
                SetStatus("Database error during removal: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}
