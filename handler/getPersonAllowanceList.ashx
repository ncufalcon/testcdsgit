<%@ WebHandler Language="C#" Class="getPersonAllowanceList" %>

using System;
using System.Web;
using System.Data;

public class getPersonAllowanceList : IHttpHandler {
    PersonAllowance_DB PA_Db = new PersonAllowance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string id = (context.Request.Form["id"] != null) ? context.Request.Form["id"].ToString() : "";

            string xmlStr = "";
            PA_Db._paPerGuid = id;
            DataTable dt = PA_Db.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "paList", "pa_item");
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