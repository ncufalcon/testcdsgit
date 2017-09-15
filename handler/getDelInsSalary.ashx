<%@ WebHandler Language="C#" Class="getDelInsSalary" %>

using System;
using System.Web;
using System.Data;

public class getDelInsSalary : IHttpHandler {
    LaborHealth_DB lh_db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string sortMethod = (context.Request["sortMethod"] != null) ? context.Request["sortMethod"].ToString() : "";
            string sortName = (context.Request["sortName"] != null) ? context.Request["sortName"].ToString() : "";
            string changedate = (context.Request["changedate"] != null) ? context.Request["changedate"].ToString() : "";

            string xmlStr = "";
            DataTable dt = lh_db.getDelInsSalary(changedate,sortName,sortMethod);
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