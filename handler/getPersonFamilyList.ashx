<%@ WebHandler Language="C#" Class="getPersonFamilyList" %>

using System;
using System.Web;
using System.Data;

public class getPersonFamilyList : IHttpHandler {
    PersonFamily_DB PF_DB = new PersonFamily_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string id = (context.Request.Form["id"] != null) ? context.Request.Form["id"].ToString() : "";

            string xmlStr = "";
            PF_DB._pfPerGuid = id;
            DataTable dt = PF_DB.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "pfList", "pf_item");
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