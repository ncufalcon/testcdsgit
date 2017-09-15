<%@ WebHandler Language="C#" Class="getSalaryRange" %>

using System;
using System.Web;
using System.Data;

public class getSalaryRange : IHttpHandler {
    SalaryRange_DB sr_db = new SalaryRange_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string sDate = (context.Request["sDate"] != null) ? context.Request["sDate"].ToString() : "";

            string xmlStr = "";
            DataTable dt = sr_db.getSalaryThree(sDate);
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
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