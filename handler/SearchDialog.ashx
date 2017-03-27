﻿<%@ WebHandler Language="C#" Class="SearchDialog" %>

using System;
using System.Web;
using System.Data;

public class SearchDialog : IHttpHandler {
    Personnel_DB Personnel_Db = new Personnel_DB();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string type = (context.Request["type"] != null) ? context.Request["type"].ToString() : "";
            string SearchStr = (context.Request["SearchStr"] != null) ? context.Request["SearchStr"].ToString() : "";
            string CurrentPage = (context.Request.Form["CurrentPage"] == null) ? "" : context.Request.Form["CurrentPage"].ToString().Trim();

            int Paging = 10; //一頁幾筆
            int pageEnd = (int.Parse(CurrentPage) + 1) * Paging; // +1 是因為分頁從0開始算
            int pageStart = pageEnd - Paging + 1;

            string xmlStr = string.Empty;
            string xmlStr2 = string.Empty;

            switch (type)
            {
                case "C":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds = Personnel_Db.getCompany(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt = ds.Tables[1];

                    xmlStr = "<total>" + ds.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt, "CompList", "comp_item");
                    break;
                case "D":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds2 = Personnel_Db.getDepartment(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt2 = ds2.Tables[1];

                    xmlStr = "<total>" + ds2.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt2, "DepList", "dep_item");
                    break;
            }
            xmlStr = "<root>" + xmlStr + xmlStr2 + "</root>";
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