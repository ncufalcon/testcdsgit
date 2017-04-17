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
            string pNo = (context.Request["pNo"] != null) ? context.Request["pNo"].ToString() : "";

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
                case "LB":
                case "Heal":
                case "LB_SL":
                case "H_SL":
                case "PF_SL":
                    DataTable dt3 = Personnel_Db.checkSLevel(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt3, "dataList", "data_item");
                    break;
                case "PA":
                    DataTable dt4 = Personnel_Db.checkPAllowance(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt4, "dataList", "data_item");
                    break;
                case "PLv":
                    DataTable dt5 = Personnel_Db.checkInsuranceID(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt5, "dataList", "data_item");
                    break;
                case "LB_Person":
                case "H_Person":
                case "PP_Person":
                case "PF_Person":
                case "PG_Person":
                    DataTable dt6 = Personnel_Db.checkPerson(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt6, "dataList", "data_item");
                    break;
                case "PF_FName":
                case "PG_FName":
                    DataTable dt7 = Personnel_Db.checkFamilyName(str, pNo);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt7, "dataList", "data_item");
                    break;
                case "PG_IC":
                    DataTable dt8 = Personnel_Db.checkGroupIns(str);
                    xmlStr = DataTableToXml.ConvertDatatableToXML(dt8, "dataList", "data_item");
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