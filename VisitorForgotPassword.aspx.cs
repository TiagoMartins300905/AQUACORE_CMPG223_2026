using System;
using System.Configuration;
using System.Data.SQLite;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorForgotPassword : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["AquaCoreConnectionString"].ConnectionString;
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

            using (SQLiteConnection con = new SQLiteConnection(connStr))
            {
                con.Open();
                string sql = "SELECT COUNT(*) FROM Visitors WHERE Email=@Email";
                SQLiteCommand cmd = new SQLiteCommand(sql, con);
                cmd.Parameters.AddWithValue("@Email", email);

                int exists = Convert.ToInt32(cmd.ExecuteScalar());

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