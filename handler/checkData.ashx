<%@ WebHandler Language="C#" Class="checkData" %>

using System;
using System.Web;
using System.Data;

public class checkData : IHttpHandler
{
    Personnel_DB Personnel_Db = new Personnel_DB();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string type = (context.Request["tp"] != null) ? context.Request["tp"].ToString() : "";
            string str = (context.Request["str"] != null) ? context.Request["str"].ToString() : "";

            string xmlStr = "";
            switch (type)
            {
                case "Company":
                    DataTable dt = Personnel_Db.checkComp(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                    break;
                case "Dep":
                    DataTable dt2 = Personnel_Db.checkDep(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt2, "dataList", "data_item");
                    break;
                case "PF":
                    DataTable dt3 = Personnel_Db.checkPFamily(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt3, "dataList", "data_item");
                    break;
                case "PA":
                    DataTable dt4 = Personnel_Db.checkPAllowance(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt4, "dataList", "data_item");
                    break;
            }
            xmlStr = "<root>" + xmlStr + "</root>";
            context.Response.Write(xmlStr);
        }
        catch (Exception ex) { context.Response.Write("error"); }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}