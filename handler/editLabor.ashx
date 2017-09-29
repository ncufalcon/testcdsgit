<%@ WebHandler Language="C#" Class="editLabor" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class editLabor : IHttpHandler,IRequiresSessionState {
    LaborHealth_DB LB_Db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
             if (string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                context.Response.Write("LoginFailed");
                return;
            }

            string Mode = (context.Request["Mode"] != null) ? context.Request["Mode"].ToString() : "";
            string id = (context.Request["id"] != null) ? context.Request["id"].ToString() : "";

            switch (Mode)
            {
                case "D":
                    LB_Db._plGuid = id;
                    LB_Db.deleteLabor();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    LB_Db._plGuid = id;
                    DataTable dt = LB_Db.getLaborByGuid();
                    string xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "datalist", "data_item");
                    xmlStr = "<root>" + xmlStr + "</root>";
                    context.Response.Write(xmlStr);
                    break;
            }
        }
        catch (Exception ex) { context.Response.Write("error"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}