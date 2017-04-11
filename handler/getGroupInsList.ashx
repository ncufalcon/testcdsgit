﻿<%@ WebHandler Language="C#" Class="getGroupInsList" %>

using System;
using System.Web;
using System.Data;

public class getGroupInsList : IHttpHandler {
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
    public void ProcessRequest (HttpContext context) {
          try
        {
            string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";

            string xmlStr = "";
            GI_Db._KeyWord = keyword;
            DataTable dt = GI_Db.SelectList();
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "pgiList", "pgi_item");
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