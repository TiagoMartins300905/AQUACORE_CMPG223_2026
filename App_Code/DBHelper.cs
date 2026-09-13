using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace AQUACORE_CMPG223
{
    /// <summary>
    /// Generic, reusable ADO.NET helper for the AquaCoreDB Azure SQL database.
    /// Holds no table-specific logic - that belongs in the *Repository classes.
    /// </summary>
    public static class DBHelper
    {
        private static string ConnectionString
        {
            get { return ConfigurationManager.ConnectionStrings["AquaCoreDB"].ConnectionString; }
        }

        public static DataTable GetDataTable(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                if (parameters != null && parameters.Length > 0)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                DataTable table = new DataTable();
                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(table);
                }
                return table;
            }
        }

        public static int ExecuteNonQuery(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                if (parameters != null && parameters.Length > 0)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                con.Open();
                return cmd.ExecuteNonQuery();
            }
        }

        public static object ExecuteScalar(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            using (SqlCommand cmd = new SqlCommand(sql, con))
            {
                if (parameters != null && parameters.Length > 0)
                {
                    cmd.Parameters.AddRange(parameters);
                }

                con.Open();
                return cmd.ExecuteScalar();
            }
        }

        /// <summary>
        /// Binds a DropDownList from a query. Used to populate lookup dropdowns
        /// (Department, Role, ...) straight from the database instead of hardcoded ListItems.
        /// </summary>
        public static void PopulateDropDown(DropDownList list, string sql, string dataTextField, string dataValueField, params SqlParameter[] parameters)
        {
            DataTable table = GetDataTable(sql, parameters);
            list.DataSource = table;
            list.DataTextField = dataTextField;
            list.DataValueField = dataValueField;
            list.DataBind();
        }
    }
}
