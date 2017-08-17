<%@ WebHandler Language="C#" Class="getPersonList" %>

using System;
using System.Web;
using System.Data;

public class getPersonList : IHttpHandler {
    Personnel_DB Personnel_Db = new Personnel_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            //string keyword = (context.Request["keyword"] != null) ? context.Request["keyword"].ToString() : "";
            string pno = (context.Request["pno"] != null) ? context.Request["pno"].ToString() : "";
            string pname = (context.Request["pname"] != null) ? context.Request["pname"].ToString() : "";
            string pidno = (context.Request["pidno"] != null) ? context.Request["pidno"].ToString() : "";
            string pcomp = (context.Request["pcomp"] != null) ? context.Request["pcomp"].ToString() : "";
            string pdep = (context.Request["pdep"] != null) ? context.Request["pdep"].ToString() : "";
            string pposit = (context.Request["pposit"] != null) ? context.Request["pposit"].ToString() : "";
            string sortMethod = (context.Request["sortMethod"] != null) ? context.Request["sortMethod"].ToString() : "";
            string sortName = (context.Request["sortName"] != null) ? context.Request["sortName"].ToString() : "";

            string xmlStr = "";
            Personnel_Db._perNo = pno;
            Personnel_Db._perName = pname;
            Personnel_Db._perIDNumber = pidno;
            Personnel_Db._perPosition = pposit;
            DataTable dt = Personnel_Db.SelectList(sortMethod,sortName,pcomp,pdep);
            xmlStr = DataTableToXml.ConvertDatatableToXML(dt, "infoList", "info_item");
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