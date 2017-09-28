<%@ WebHandler Language="C#" Class="editPersonBuckle" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
public class editPersonBuckle : IHttpHandler,IRequiresSessionState {
    PersonBuckle_DB PB_Db = new PersonBuckle_DB();
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
                    PB_Db._pbGuid = id;
                    PB_Db.deletePersonBuckle();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    PB_Db._pbGuid = id;
                    DataTable dt = PB_Db.getPbByID();
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