<%@ WebHandler Language="C#" Class="getGroupInsList" %>

using System;
using System.Web;
using System.Data;

public class getGroupInsList : IHttpHandler {
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";
            string ddlPgExport = (context.Request["ddlPgExport"] != null) ? context.Request["ddlPgExport"].ToString() : "";
            string dateMinus1Month = (ddlPgExport != "") ? DateTime.Parse(ddlPgExport).AddMonths(-1).ToString("yyyy/MM") : "";
            string xmlStr = "";
            GI_Db._KeyWord = keyword;
            GI_Db._pgiChangeDate = ddlPgExport;
            DataTable dt = GI_Db.SelectList(dateMinus1Month);
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "pgiList", "pgi_item");
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