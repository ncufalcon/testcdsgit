<%@ WebHandler Language="C#" Class="getPersonBuckleList" %>

using System;
using System.Web;
using System.Data;

public class getPersonBuckleList : IHttpHandler {
    PersonBuckle_DB PB_Db = new PersonBuckle_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string id = (context.Request.Form["id"] != null) ? context.Request.Form["id"].ToString() : "";

            string xmlStr = "";
            PB_Db._pbPerGuid = id;
            DataTable dt = PB_Db.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "pbList", "pb_item");
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