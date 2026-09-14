using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;

        public string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

        public bool IsValidPassword(string password)
        {
            // Password requirements:
            // - At least 6 characters
            // - At least 1 uppercase letter
            // - At least 1 lowercase letter
            // - At least 1 digit
            // - At least 1 special symbol
            string pattern = @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?/~\-]).{6,}$";
            return Regex.IsMatch(password, pattern);
        }

        protected void btnSignup_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtName.Text) || string.IsNullOrEmpty(txtSurname.Text) ||
                string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtPassword.Text) ||
                string.IsNullOrEmpty(txtConfirmPassword.Text))
            {
                lblMsg.Text = "⚠ Please fill in all required fields.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string password = txtPassword.Text.Trim();
            string confirm = txtConfirmPassword.Text.Trim();

            if (password != confirm)
            {
                lblMsg.Text = "⚠ Passwords do not match!";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            if (!IsValidPassword(password))
            {
                lblMsg.Text = "⚠ Password must be at least 6 characters and include an uppercase letter, lowercase letter, number, and symbol.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string hashedPassword = HashPassword(password);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                try
                {
                    con.Open();

                    // Check if email already exists
                    string checkEmail = "SELECT COUNT(*) FROM Visitors WHERE Email=@Email";
                    SqlCommand checkCmd = new SqlCommand(checkEmail, con);
                    checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        lblMsg.Text = "⚠ This email is already registered.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    // Check if phone exists
                    string checkPhone = "SELECT COUNT(*) FROM Visitors WHERE PhoneNumber=@PhoneNumber";
                    SqlCommand phoneCmd = new SqlCommand(checkPhone, con);
                    phoneCmd.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text.Trim());
                    int phoneCount = (int)phoneCmd.ExecuteScalar();

                    if (phoneCount > 0)
                    {
                        lblMsg.Text = "⚠ This phone number is already registered.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    // Insert new visitor
                    string sql = @"INSERT INTO Visitors (Name, Surname, Email, PhoneNumber, PasswordHash) 
                                   VALUES (@Name, @Surname, @Email, @PhoneNumber, @PasswordHash)";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Surname", txtSurname.Text.Trim());
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                    cmd.Parameters.AddWithValue("@PhoneNumber", txtPhone.Text.Trim());
                    cmd.Parameters.AddWithValue("@PasswordHash", hashedPassword);

                    cmd.ExecuteNonQuery();

                    lblMsg.Text = "✅ Account created successfully. Please login.";
                    lblMsg.ForeColor = System.Drawing.Color.Green;

                    txtName.Text = "";
                    txtSurname.Text = "";
                    txtEmail.Text = "";
                    txtPhone.Text = "";
                    txtPassword.Text = "";
                    txtConfirmPassword.Text = "";
                }
                catch (Exception ex)
                {
                    lblMsg.Text = "⚠ Error: " + ex.Message;
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}