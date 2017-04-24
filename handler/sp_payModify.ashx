<%@ WebHandler Language="C#" Class="sp_payModify" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

public class sp_payModify : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        try
        {
            string id = (context.Request.Form["id"] != null) ? context.Request.Form["id"].ToString() : "";
            SqlCommand oCmd = new SqlCommand();
            oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
            StringBuilder sb = new StringBuilder();

            sb.Append(@"sp_payModify");
            oCmd.CommandTimeout = 120;
            oCmd.CommandText = sb.ToString();
            oCmd.CommandType = CommandType.StoredProcedure;
            oCmd.Connection.Open();

            SqlDataAdapter oda = new SqlDataAdapter(oCmd);
            oCmd.Parameters.AddWithValue("@pGuid", "");

            DataTable ds = new DataTable();
            oda.Fill(ds);
            oCmd.Connection.Close();
            oCmd.Connection.Dispose();
            oCmd.Dispose();

            string xmlStr = "";

            xmlStr = DataTableToXml.ConvertDatatableToXML(ds, "dataList", "data_item");
            xmlStr = "<root>" + xmlStr + "</root>";
            context.Response.Write(xmlStr);
        }
        catch (Exception ex) { context.Response.Write("error"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}