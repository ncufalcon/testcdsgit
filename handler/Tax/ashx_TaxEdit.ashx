<%@ WebHandler Language="C#" Class="ashx_TaxEdit" %>

using System;
using System.Web;

public class ashx_TaxEdit : IHttpHandler, System.Web.SessionState.IReadOnlySessionState{

    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {


                //xml 解析
                string iitGuid = (!string.IsNullOrEmpty(context.Request.Form["iitGuid"])) ? context.Request.Form["iitGuid"].ToString() : "";
                string iitFormat = (!string.IsNullOrEmpty(context.Request.Form["iitFormat"])) ?context.Request.Form["iitFormat"].ToString() : "";
                string iitMark = (!string.IsNullOrEmpty(context.Request.Form["iitMark"])) ? context.Request.Form["iitMark"].ToString() : "";
                string iitManner = (!string.IsNullOrEmpty(context.Request.Form["iitManner"])) ?context.Request.Form["iitManner"].ToString() : "";
                string iitYearStart = (!string.IsNullOrEmpty(context.Request.Form["iitYearStart"])) ? context.Request.Form["iitYearStart"].ToString() : "";
                string iitYearEnd = (!string.IsNullOrEmpty(context.Request.Form["iitYearEnd"])) ?context.Request.Form["iitYearEnd"].ToString() : "";
                string iitIdentify = (!string.IsNullOrEmpty(context.Request.Form["iitIdentify"])) ? context.Request.Form["iitIdentify"].ToString() : "";
                string iitErrMark = (!string.IsNullOrEmpty(context.Request.Form["iitErrMark"])) ?context.Request.Form["iitErrMark"].ToString() : "";
                string iitHouseTax = (!string.IsNullOrEmpty(context.Request.Form["iitHouseTax"])) ? context.Request.Form["iitHouseTax"].ToString() : "";
                string iitIndustryCode = (!string.IsNullOrEmpty(context.Request.Form["iitIndustryCode"])) ?context.Request.Form["iitIndustryCode"].ToString() : "";
                string iitCode = (!string.IsNullOrEmpty(context.Request.Form["iitCode"])) ? context.Request.Form["iitCode"].ToString() : "";
                decimal iitPaySum = (!string.IsNullOrEmpty(context.Request.Form["iitPaySum"])) ? decimal.Parse(context.Request.Form["iitPaySum"].ToString()) : 0;
                decimal iitPayTax = (!string.IsNullOrEmpty(context.Request.Form["iitPayTax"])) ? decimal.Parse(context.Request.Form["iitPayTax"].ToString()) : 0;
                decimal iitPayAmount = (!string.IsNullOrEmpty(context.Request.Form["iitPayAmount"])) ? decimal.Parse(context.Request.Form["iitPayAmount"].ToString()) : 0;
                decimal iitStock = (!string.IsNullOrEmpty(context.Request.Form["iitStock"])) ? decimal.Parse(context.Request.Form["iitStock"].ToString()) : 0;


                string[] str = { "" };
                string sqlinj = com.CheckSqlInJection(str);

                if (sqlinj == "")
                {
                    payroll.model.sy_Tax p = new payroll.model.sy_Tax();
                    p.iitGuid = iitGuid;
                    p.iitFormat = iitFormat;
                    p.iitMark = iitMark;
                    p.iitManner = iitManner;
                    p.iitYearStart = iitYearStart;
                    p.iitYearEnd = iitYearEnd;
                    p.iitIdentify = iitIdentify;
                    p.iitErrMark = iitErrMark;
                    p.iitHouseTax = iitHouseTax;
                    p.iitIndustryCode = iitIndustryCode;
                    p.iitCode = iitCode;
                    p.iitPaySum = iitPaySum;
                    p.iitPayTax = iitPayTax;
                    p.iitPayAmount = iitPayAmount;
                    p.iitStock = iitStock;               
                    p.UserInfo = USERINFO.MemberGuid;
                    dal.Upsy_Tax(p);
                    context.Response.Write("ok");
                }
                else { context.Response.Write("d"); }
            }
            else { context.Response.Write("t"); }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_TaxEdit.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("e");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}