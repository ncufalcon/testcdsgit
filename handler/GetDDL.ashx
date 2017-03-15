<%@ WebHandler Language="C#" Class="GetDDL" %>

using System;
using System.Web;
using System.Data;

public class GetDDL : IHttpHandler {
    CodeTable_DB Code_Db = new CodeTable_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Group = (context.Request["Group"] != null) ? context.Request["Group"].ToString() : "";
            string xmlStr = "";
            DataTable dt = Code_Db.getGroup(Group);
            if (dt.Rows.Count > 0)
            {
                for(int i = 0; i < dt.Rows.Count; i++)
                {
                    if (xmlStr != "") xmlStr += ",";
                    xmlStr += "<code desc=\""+dt.Rows[i]["code_desc"]+"\"  v=\""+dt.Rows[i]["code_value"]+"\" />";
                }
            }
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