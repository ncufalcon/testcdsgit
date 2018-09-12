<%@ WebHandler Language="C#" Class="sp_payModify" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

public class sp_payModify : IHttpHandler {
    SalaryRange_DB sr_db = new SalaryRange_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string SalaryRange = (context.Request.Form["SalaryRange"] != null) ? context.Request.Form["SalaryRange"].ToString() : "";

            SqlCommand oCmd = new SqlCommand();
            oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
            StringBuilder sb = new StringBuilder();

            sb.Append(@"sp_payModify_20180808new");
            oCmd.CommandTimeout = 120;
            oCmd.CommandText = sb.ToString();
            oCmd.CommandType = CommandType.StoredProcedure;
            oCmd.Connection.Open();

            SqlDataAdapter oda = new SqlDataAdapter(oCmd);
            //oCmd.Parameters.AddWithValue("@pGuid", "");
            oCmd.Parameters.AddWithValue("@rangeGuid", SalaryRange);

            DataTable dt = new DataTable();
            oda.Fill(dt);
            oCmd.Connection.Close();
            oCmd.Connection.Dispose();
            oCmd.Dispose();

            //三個計薪週期薪資
            //dt = addColumn(dt);
            //if (dt.Rows.Count > 0)
            //{
            //    for (int i = 0; i < dt.Rows.Count; i++)
            //    {
            //        DataTable srdt = sr_db.getSalaryThreeByPerson(SalaryRange, dt.Rows[i]["pPerGuid"].ToString());
            //        if (srdt.Rows.Count > 0)
            //        {
            //            dt.Rows[i]["Pay1"] = srdt.Rows[0]["pPay"].ToString();
            //            dt.Rows[i]["Pay2"] = srdt.Rows[1]["pPay"].ToString();
            //            dt.Rows[i]["Pay3"] = srdt.Rows[2]["pPay"].ToString();
            //        }
            //    }
            //}

            string xmlStr = string.Empty;

            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
            xmlStr = "<root>" + xmlStr + "</root>";
            context.Response.Write(xmlStr);
        }
        catch (Exception ex)
        {
            context.Response.Write("error");
        }
    }

    private DataTable addColumn(DataTable dt)
    {
        DataColumn column;
        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Pay1";
        dt.Columns.Add(column);

        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Pay2";
        dt.Columns.Add(column);

        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Pay3";
        dt.Columns.Add(column);

        return dt;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}