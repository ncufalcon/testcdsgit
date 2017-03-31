<%@ WebHandler Language="C#" Class="editHeal" %>

using System;
using System.Web;
using System.Data;

public class editHeal : IHttpHandler {
    LaborHealth_DB LB_Db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request["Mode"] != null) ? context.Request["Mode"].ToString() : "";
            string id = (context.Request["id"] != null) ? context.Request["id"].ToString() : "";

            switch (Mode)
            {
                case "D":
                    LB_Db._piGuid = id;
                    LB_Db.deleteHeal();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    LB_Db._piGuid = id;
                    DataTable dt = LB_Db.getHealByGuid();
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