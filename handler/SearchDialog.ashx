﻿<%@ WebHandler Language="C#" Class="SearchDialog" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class SearchDialog : IHttpHandler,IRequiresSessionState {
    Personnel_DB Personnel_Db = new Personnel_DB();
    sy_SalaryItem_DB si_db = new sy_SalaryItem_DB();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            if (string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                context.Response.Write("LoginFailed");
                return;
            }

            string type = (context.Request["type"] != null) ? context.Request["type"].ToString() : "";
            string pgid = (context.Request["perguid"] != null) ? context.Request["perguid"].ToString() : "";
            string SearchStr = (context.Request["SearchStr"] != null) ? context.Request["SearchStr"].ToString() : "";
            string CurrentPage = (context.Request.Form["CurrentPage"] == null) ? "" : context.Request.Form["CurrentPage"].ToString().Trim();

            int Paging = 10; //一頁幾筆
            int pageEnd = (int.Parse(CurrentPage) + 1) * Paging; // +1 是因為分頁從0開始算
            int pageStart = pageEnd - Paging + 1;

            string xmlStr = string.Empty;
            string xmlStr2 = string.Empty;

            switch (type)
            {
                case "Comp":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds = Personnel_Db.getCompany(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt = ds.Tables[1];

                    xmlStr = "<total>" + ds.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt, "dataList", "data_item");
                    break;
                case "Dep":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds2 = Personnel_Db.getDepartment(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt2 = ds2.Tables[1];

                    xmlStr = "<total>" + ds2.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt2, "dataList", "data_item");
                    break;
                case "Family":
                case "LB":
                case "Heal":
                case "LaborSL":
                case "HealSL":
                case "PFInsSL":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds3 = Personnel_Db.getSubsidyLevel(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt3 = ds3.Tables[1];

                    xmlStr = "<total>" + ds3.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt3, "dataList", "data_item");
                    break;
                case "Allowance":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds4 = Personnel_Db.getAllowance(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt4 = ds4.Tables[1];

                    xmlStr = "<total>" + ds4.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt4, "dataList", "data_item");
                    break;
                case "PLv":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds5 = Personnel_Db.getInsuranceIdentity(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt5 = ds5.Tables[1];

                    xmlStr = "<total>" + ds5.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt5, "dataList", "data_item");
                    break;
                case "Personnel":
                case "Personnel2":
                case "LInsPerson":
                case "HInsPerson":
                case "PPInsPerson":
                case "PFInsPerson":
                case "PGInsPerson":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds6 = Personnel_Db.getPersonnel(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt6 = ds6.Tables[1];

                    xmlStr = "<total>" + ds6.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt6, "dataList", "data_item");
                    break;
                case "PFInsFname":
                case "PGInsFname":
                    Personnel_Db._KeyWord = SearchStr;
                    Personnel_Db._perGuid = pgid;
                    DataSet ds7 = Personnel_Db.getFamilyList(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt7 = ds7.Tables[1];

                    xmlStr = "<total>" + ds7.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt7, "dataList", "data_item");
                    break;
                case "PG_IC":
                    Personnel_Db._KeyWord = SearchStr;
                    DataSet ds8 = Personnel_Db.getGroupInsList(pageStart.ToString(), pageEnd.ToString());
                    DataTable dt8 = ds8.Tables[1];

                    xmlStr = "<total>" + ds8.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt8, "dataList", "data_item");
                    break;
                case "SiItem":
                    si_db._str_keyword = SearchStr;
                    si_db._str_perguid = pgid;
                    //DataSet ds9 = si_db.SelectSalaryItemForWindow();
                    DataTable dt9 = si_db.SelectSalaryItemForWindow();

                    //xmlStr = "<total>" + ds9.Tables[0].Rows[0]["total"].ToString() + "</total>";
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt9, "dataList", "data_item");
                    break;
                case "SalaryRange":
                case "CityBankSR":
                    DataTable dt10 = dal.SelSy_SalaryRange(SearchStr);
                    xmlStr2 = DataTableToXml.ConvertDatatableToXML(dt10, "dataList", "data_item");
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