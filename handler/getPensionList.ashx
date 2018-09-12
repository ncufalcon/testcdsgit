<%@ WebHandler Language="C#" Class="getPensionList" %>

using System;
using System.Web;
using System.Data;

public class getPensionList : IHttpHandler {
    PersonPension_DB PP_Db = new PersonPension_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";
            string ddlPension = (context.Request["ddlPension"] != null) ? context.Request["ddlPension"].ToString() : "";
            string startday = (context.Request["startday"] != null) ? context.Request["startday"].ToString() : "";
            string endday = (context.Request["endday"] != null) ? context.Request["endday"].ToString() : "";

            string xmlStr = "";
            PP_Db._KeyWord = keyword;
            PP_Db._ppChange = ddlPension;
            PP_Db._StartDate = startday;
            PP_Db._EndDate = endday;
            DataTable dt = PP_Db.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "ppList", "pp_item");
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