using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UserManagementSystem
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PopulateColumnName();
        }

        private void PopulateColumnName()
        {
            DataTable col = new DataTable();
            col.Columns.Add("Name");
            col.Columns.Add("Email");
            col.Columns.Add("Phone Number");
            col.Columns.Add("Salary");

            col.Rows.Add();
            example.DataSource = col;
            example.DataBind();

            example.UseAccessibleHeader = true;
            example.HeaderRow.TableSection = TableRowSection.TableHeader;
        }



        [WebMethod]
        public static string LoadData()
        {
            return File.ReadAllText(HttpContext.Current.Server.MapPath("~/Resources/fakeData.json"));
        }
    }
}