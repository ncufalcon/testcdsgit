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
            string sortMethod = (context.Request["sortMethod"] != null) ? context.Request["sortMethod"].ToString() : "";
            string sortName = (context.Request["sortName"] != null) ? context.Request["sortName"].ToString() : "";

            string xmlStr = "";
            Personnel_Db._KeyWord = keyword;
            DataTable dt = Personnel_Db.SelectList(sortMethod,sortName);
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