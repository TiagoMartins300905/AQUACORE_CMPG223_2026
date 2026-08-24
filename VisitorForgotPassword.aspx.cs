using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorForgotPassword : System.Web.UI.Page
    {
        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Visitors.mdf;Integrated Security=True;Connect Timeout=30";
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                lblMsg.Text = "⚠ Please enter your email.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                string sql = "SELECT COUNT(*) FROM Visitors WHERE Email=@Email";
                SqlCommand cmd = new SqlCommand(sql, con);
                cmd.Parameters.AddWithValue("@Email", email);

                int exists = (int)cmd.ExecuteScalar();

                if (exists > 0)
                {

                    Session["ResetEmail"] = email;
                    Response.Redirect("VisitorResetPassword.aspx");
                }
                else
                {
                    lblMsg.Text = "⚠ This email does not exist in our records.";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }
    }
}