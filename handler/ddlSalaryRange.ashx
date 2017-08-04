<%@ WebHandler Language="C#" Class="ddlSalaryRange" %>

using System;
using System.Web;
using System.Data;
using System.Xml;

public class ddlSalaryRange : IHttpHandler {
    SalaryRange_DB SR_Db = new SalaryRange_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string xmlStr = "";
            DataTable dt = SR_Db.ddlSelectList();
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