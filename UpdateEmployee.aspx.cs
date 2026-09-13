using System;
using System.Drawing;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    public partial class UpdateEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployeeDropdown();
            }
        }

        // 1. Fetch all active employees to populate the selection dropdown
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

        private void PopulateLookupDropDowns()
        {
            DBHelper.PopulateDropDown(ddlDepartment,
                "SELECT DepartmentID, DepartmentName FROM Department ORDER BY DepartmentName",
                "DepartmentName", "DepartmentID");

            DBHelper.PopulateDropDown(ddlRole,
                "SELECT RoleID, RoleName FROM [Role] ORDER BY RoleName",
                "RoleName", "RoleID");
        }

        // 2. Fires automatically when the user selects a name from the dropdown
        protected void ddlSelectEmployee_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblStatus.Text = string.Empty;

            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue))
            {
                pnlEditForm.Visible = false;
                return;
            }

            int selectedId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);

            try
            {
                Employee employee = EmployeeRepository.GetById(selectedId);
                if (employee == null)
                {
                    SetStatus("That employee could not be found (it may already have been removed).", Color.FromArgb(255, 107, 107));
                    pnlEditForm.Visible = false;
                    return;
                }

                PopulateLookupDropDowns();

                txtFirstName.Text = employee.FirstName;
                txtLastName.Text = employee.LastName;
                txtEmail.Text = employee.Email;
                txtContactDetails.Text = employee.ContactDetails;
                txtWorkSchedule.Text = employee.WorkSchedule;
                ddlDepartment.SelectedValue = employee.DepartmentID.ToString();
                ddlRole.SelectedValue = employee.RoleID.ToString();

                pnlEditForm.Visible = true;
            }
            catch (Exception ex)
            {
                SetStatus("Error retrieving employee: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        // 3. Perform the UPDATE in the database
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlSelectEmployee.SelectedValue)) return;

            int employeeId = Convert.ToInt32(ddlSelectEmployee.SelectedValue);
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName) || string.IsNullOrEmpty(email)
                || string.IsNullOrEmpty(ddlDepartment.SelectedValue) || string.IsNullOrEmpty(ddlRole.SelectedValue))
            {
                SetStatus("First Name, Last Name, Email, Department and Role are required.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (EmployeeRepository.EmailExists(email, employeeId))
            {
                SetStatus("Another employee already uses this email.", Color.FromArgb(255, 107, 107));
                return;
            }

            try
            {
                Employee employee = new Employee
                {
                    EmployeeID = employeeId,
                    FirstName = firstName,
                    LastName = lastName,
                    Email = email,
                    ContactDetails = string.IsNullOrWhiteSpace(txtContactDetails.Text) ? null : txtContactDetails.Text.Trim(),
                    DepartmentID = int.Parse(ddlDepartment.SelectedValue),
                    RoleID = int.Parse(ddlRole.SelectedValue),
                    WorkSchedule = string.IsNullOrWhiteSpace(txtWorkSchedule.Text) ? null : txtWorkSchedule.Text.Trim()
                };

                EmployeeRepository.Update(employee);

                SetStatus("Employee details updated successfully!", Color.FromArgb(128, 255, 219));

                // Refresh the dropdown in case they changed the name
                LoadEmployeeDropdown();
                ddlSelectEmployee.SelectedValue = employeeId.ToString();
            }
            catch (Exception ex)
            {
                SetStatus("Database error during update: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}
