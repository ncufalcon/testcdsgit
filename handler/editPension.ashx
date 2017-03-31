<%@ WebHandler Language="C#" Class="editPension" %>

using System;
using System.Web;
using System.Data;

public class editPension : IHttpHandler {
    PersonPension_DB PP_Db = new PersonPension_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request["Mode"] != null) ? context.Request["Mode"].ToString() : "";
            string id = (context.Request["id"] != null) ? context.Request["id"].ToString() : "";

            switch (Mode)
            {
                case "D":
                    PP_Db._ppGuid = id;
                    PP_Db.deletePension();
                    context.Response.Write("資料已刪除");
                    break;
                case "E":
                    PP_Db._ppGuid = id;
                    DataTable dt = PP_Db.getPensionByGuid();
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