<%@ WebHandler Language="C#" Class="editPersonFamily" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
public class editPersonFamily : IHttpHandler,IRequiresSessionState {
    PersonFamily_DB PF_DB = new PersonFamily_DB();
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
                    PF_DB._pfGuid = id;
                    PF_DB.deletePersonFamily();
                    context.Response.Write("成員已刪除");
                    break;
                case "E":
                    PF_DB._pfGuid = id;
                    DataTable dt = PF_DB.getPFByID();
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