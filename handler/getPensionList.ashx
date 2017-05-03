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

            string xmlStr = "";
            PP_Db._KeyWord = keyword;
            PP_Db._ppChange = ddlPension;
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