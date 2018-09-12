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
            string ddlLabor = (context.Request["ddlLabor"] != null) ? context.Request["ddlLabor"].ToString() : "";
            string startday = (context.Request["startday"] != null) ? context.Request["startday"].ToString() : "";
            string endday = (context.Request["endday"] != null) ? context.Request["endday"].ToString() : "";

            string xmlStr = "";
            LH_Db._KeyWord = keyword;
            LH_Db._plChange = ddlLabor;
            LH_Db._StartDate = startday;
            LH_Db._EndDate = endday;
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