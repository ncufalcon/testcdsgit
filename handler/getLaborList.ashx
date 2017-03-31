<%@ WebHandler Language="C#" Class="getLaborList" %>

using System;
using System.Web;
using System.Data;

public class getLaborList : IHttpHandler {
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";

            string xmlStr = "";
            LH_Db._KeyWord = keyword;
            DataTable dt = LH_Db.SelectLaborList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "lbList", "lb_item");
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