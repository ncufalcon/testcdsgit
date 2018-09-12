<%@ WebHandler Language="C#" Class="getHealList" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class getHealList : IHttpHandler,IRequiresSessionState {
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";
            string ddlHeal = (context.Request["ddlHeal"] != null) ? context.Request["ddlHeal"].ToString() : "";
            string startday = (context.Request["startday"] != null) ? context.Request["startday"].ToString() : "";
            string endday = (context.Request["endday"] != null) ? context.Request["endday"].ToString() : "";

            string xmlStr = "";
            LH_Db._KeyWord = keyword;
            LH_Db._piChange = ddlHeal;
            LH_Db._StartDate = startday;
            LH_Db._EndDate = endday;
            DataTable dt = LH_Db.SelectHealList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "hList", "h_item");
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