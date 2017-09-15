<%@ WebHandler Language="C#" Class="getPPratio" %>

using System;
using System.Web;
using System.Data;
using System.IO;
using System.Xml;

public class getPPratio : IHttpHandler {
    PersonPension_DB PP_Db = new PersonPension_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string pNo = (context.Request["pNo"] != null) ? context.Request["pNo"].ToString() : "";
            string pName = (context.Request["pName"] != null) ? context.Request["pName"].ToString() : "";
            string pDep = (context.Request["pDep"] != null) ? context.Request["pDep"].ToString() : "";
            string pYear = (context.Request["pYear"] != null) ? context.Request["pYear"].ToString() : "";

            string xmlStr = "";
            DataTable dt = PP_Db.getPPRatio(pNo,pName,pDep,pYear);
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
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