<%@ WebHandler Language="C#" Class="ddlGroupInsYM" %>

using System;
using System.Web;
using System.Data;

public class ddlGroupInsYM : IHttpHandler {
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string xmlStr = "";
            DataTable dt = GI_Db.getGInsYM();
            if (dt.Rows.Count > 0)
            {
                for(int i = 0; i < dt.Rows.Count; i++)
                {
                    if (xmlStr != "") xmlStr += ",";
                    xmlStr += "<code desc=\"" + DateTime.Parse(dt.Rows[i]["v"].ToString()).ToString("yyyyMM") + "\"  v=\"" + DateTime.Parse(dt.Rows[i]["v"].ToString()).ToString("yyyy/MM") + "\" />";
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