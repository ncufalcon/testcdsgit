<%@ WebHandler Language="C#" Class="getPersonList" %>

using System;
using System.Web;
using System.Data;

public class getPersonList : IHttpHandler {
    Personnel_DB Personnel_Db = new Personnel_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";

            string xmlStr = "";
            Personnel_Db._KeyWord = keyword;
            DataTable dt = Personnel_Db.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "infoList", "info_item");
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