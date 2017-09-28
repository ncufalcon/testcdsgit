<%@ WebHandler Language="C#" Class="editGroupIns" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class editGroupIns : IHttpHandler,IRequiresSessionState {
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
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
                    GI_Db._pgiGuid = id;
                    GI_Db.deleteGroupInsurance();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    GI_Db._pgiGuid = id;
                    DataTable dt = GI_Db.getGroupInsByGuid();
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