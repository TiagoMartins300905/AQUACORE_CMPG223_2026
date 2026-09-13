using System;
using System.Drawing;

namespace AQUACORE_CMPG223
{
    public partial class AddEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateDropDowns();
            }
        }

        private void PopulateDropDowns()
        {
            DBHelper.PopulateDropDown(ddlDepartment,
                "SELECT DepartmentID, DepartmentName FROM Department ORDER BY DepartmentName",
                "DepartmentName", "DepartmentID");

            DBHelper.PopulateDropDown(ddlRole,
                "SELECT RoleID, RoleName FROM [Role] ORDER BY RoleName",
                "RoleName", "RoleID");
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text.Trim();
            string lastName = txtLastName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string contactDetails = txtContactDetails.Text.Trim();

            if (string.IsNullOrEmpty(firstName) || string.IsNullOrEmpty(lastName))
            {
                SetStatus("First name and last name are required.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (string.IsNullOrEmpty(email))
            {
                SetStatus("Email is required.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (string.IsNullOrEmpty(ddlDepartment.SelectedValue))
            {
                SetStatus("Please select a department.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (string.IsNullOrEmpty(ddlRole.SelectedValue))
            {
                SetStatus("Please select a role.", Color.FromArgb(255, 107, 107));
                return;
            }

            if (EmployeeRepository.EmailExists(email))
            {
                SetStatus("An employee with this email already exists.", Color.FromArgb(255, 107, 107));
                return;
            }

            try
            {
                Employee employee = new Employee
                {
                    FirstName = firstName,
                    LastName = lastName,
                    Email = email,
                    ContactDetails = string.IsNullOrEmpty(contactDetails) ? null : contactDetails,
                    DepartmentID = int.Parse(ddlDepartment.SelectedValue),
                    RoleID = int.Parse(ddlRole.SelectedValue),
                    WorkSchedule = string.IsNullOrWhiteSpace(txtWorkSchedule.Text) ? null : txtWorkSchedule.Text.Trim()
                };

                EmployeeRepository.Insert(employee);

                SetStatus("Employee registered successfully!", Color.FromArgb(128, 255, 219));
                ClearFields();
            }
            catch (Exception ex)
            {
                SetStatus("Database error: " + ex.Message, Color.FromArgb(255, 107, 107));
            }
        }

        private void ClearFields()
        {
            txtFirstName.Text = string.Empty;
            txtLastName.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtContactDetails.Text = string.Empty;
            txtWorkSchedule.Text = string.Empty;
            ddlDepartment.SelectedIndex = 0;
            ddlRole.SelectedIndex = 0;
        }

        private void SetStatus(string message, Color color)
        {
            lblStatus.Text = message;
            lblStatus.ForeColor = color;
        }
    }
}
