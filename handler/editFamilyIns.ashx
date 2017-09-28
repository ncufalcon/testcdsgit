<%@ WebHandler Language="C#" Class="editFamilyIns" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class editFamilyIns : IHttpHandler,IRequiresSessionState {
    FamilyInsurance_DB FI_Db = new FamilyInsurance_DB();
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
                    FI_Db._pfiGuid = id;
                    FI_Db.deleteFamilyIns();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    FI_Db._pfiGuid = id;
                    DataTable dt = FI_Db.getFamilyInsByGuid();
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