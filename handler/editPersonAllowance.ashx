<%@ WebHandler Language="C#" Class="editPersonAllowance" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class editPersonAllowance : IHttpHandler,IRequiresSessionState {
    PersonAllowance_DB PA_Db = new PersonAllowance_DB();
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
                    PA_Db._paGuid = id;
                    PA_Db.deletePersonAllowance();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    PA_Db._paGuid = id;
                    DataTable dt = PA_Db.getPaByID();
                    string xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "info", "info_item");
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