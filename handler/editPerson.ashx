<%@ WebHandler Language="C#" Class="editPerson" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class editPerson : IHttpHandler,IRequiresSessionState {
    Personnel_DB Personnel_Db = new Personnel_DB();
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
                    Personnel_Db._perGuid = id;
                    Personnel_Db.deletePerson();
                    context.Response.Write("人員已刪除");
                    break;
                case "E":
                    Personnel_Db._perGuid = id;
                    DataTable dt = Personnel_Db.getPersonByGuid();
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