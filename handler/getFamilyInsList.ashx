<%@ WebHandler Language="C#" Class="getFamilyInsList" %>

using System;
using System.Web;
using System.Data;

public class getFamilyInsList : IHttpHandler {
    FamilyInsurance_DB FI_Db = new FamilyInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";
            string ddlPfExport = (context.Request["ddlPfExport"] != null) ? context.Request["ddlPfExport"].ToString() : "";

            string xmlStr = "";
            FI_Db._KeyWord = keyword;
            FI_Db._pfiChange = ddlPfExport;
            DataTable dt = FI_Db.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "pfiList", "pfi_item");
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