using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace AQUACORE_CMPG223
{
    public partial class VisitorLogin : System.Web.UI.Page
    {

        string connStr = @"Data Source=(LocalDB)\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\Visitors.mdf;Integrated Security=True;Connect Timeout=30";

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

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string hashed = HashPassword(password);

            if (string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtPassword.Text))
            {
                lblMsg.Text = "⚠ All fields are required.";
                lblMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            using (SqlConnection con = new SqlConnection(connStr))
            {
                try
                {

                    con.Open();

                    string sql = "SELECT VisitorID, Name FROM Visitors WHERE Email=@Email AND PasswordHash=@PasswordHash";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@PasswordHash", hashed);


                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        Session["VisitorID"] = reader["VisitorID"];
                        Session["VisitorName"] = reader["Name"].ToString();
                        Session["VisitorEmail"] = email;

                        Response.Redirect("VisitorDashboard.aspx");
                    }
                    else
                    {
                        lblMsg.Text = "⚠ Invalid login. Try again.";
                        lblMsg.ForeColor = System.Drawing.Color.Red;
                    }
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