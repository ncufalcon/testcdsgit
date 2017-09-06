<%@ WebHandler Language="C#" Class="ashx_TaxList" %>

using System;
using System.Web;
using System.Data;
public class ashx_TaxList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {

    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "text/xml";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {


                string XmlStr = "";
                DataView dv = new DataView();
                string PerNo = (!string.IsNullOrEmpty(context.Request.Form["PerNo"])) ? context.Request.Form["PerNo"].ToString() : "";
                string PerName = (!string.IsNullOrEmpty(context.Request.Form["PerName"])) ? context.Request.Form["PerName"].ToString() : "";
                string Company = (!string.IsNullOrEmpty(context.Request.Form["Company"])) ? context.Request.Form["Company"].ToString() : "";
                string Dep = (!string.IsNullOrEmpty(context.Request.Form["Dep"])) ? context.Request.Form["Dep"].ToString() : "";
                string yyyy = (!string.IsNullOrEmpty(context.Request.Form["yyyy"])) ? context.Request.Form["yyyy"].ToString() : "";
                string Guid = (!string.IsNullOrEmpty(context.Request.Form["Guid"])) ? context.Request.Form["Guid"].ToString() : "";
                string typ = (!string.IsNullOrEmpty(context.Request.Form["typ"])) ? context.Request.Form["typ"].ToString() : "";


                string[] str = { PerNo, PerName, Company, Dep, yyyy };
                string sqlinj = com.CheckSqlInJection(str);

                payroll.model.sy_Tax pModel = new payroll.model.sy_Tax();
                pModel.iitPerNo = PerNo;
                pModel.iitPerName = PerName;
                pModel.iitComName = Company;
                pModel.iitPerDep = Dep;
                pModel.iitYyyy = yyyy;
                pModel.iitGuid = Guid;
                if (sqlinj == "")
                {
                    if (typ == "Y") //代表第一次進入畫面 Top 200
                        dv = dal.SelSy_TaxTop200().DefaultView;
                    else
                        dv = dal.SelSy_Tax(pModel).DefaultView;

                    //string paging = (Math.Ceiling(decimal.Parse((dvList.Count / 10).ToString())) + 1).ToString();
                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<iitGuid>" + dv[i]["iitGuid"].ToString() + "</iitGuid>";
                        XmlStr += "<iitComGuid>" + dv[i]["iitComGuid"].ToString() + "</iitComGuid>";
                        XmlStr += "<iitComName>" + dv[i]["iitComName"].ToString() + "</iitComName>";
                        XmlStr += "<iitComUniform>" + dv[i]["iitComUniform"].ToString() + "</iitComUniform>";
                        XmlStr += "<iitPerGuid>" + dv[i]["iitPerGuid"].ToString() + "</iitPerGuid>";
                        XmlStr += "<iitPerName>" + dv[i]["iitPerName"].ToString() + "</iitPerName>";
                        XmlStr += "<iitPerNo>" + dv[i]["iitPerNo"].ToString() + "</iitPerNo>";

                        XmlStr += "<iitPerIDNumber>" + dv[i]["iitPerIDNumber"].ToString() + "</iitPerIDNumber>";
                        XmlStr += "<iitPerResidentAddr>" + dv[i]["iitPerResidentAddr"].ToString() + "</iitPerResidentAddr>";
                        XmlStr += "<iitPerAdds>" + dv[i]["iitPerAdds"].ToString() + "</iitPerAdds>";
                        XmlStr += "<iitPassPort>" + dv[i]["iitPassPort"].ToString() + "</iitPassPort>";
                        XmlStr += "<iitPerDep>" + dv[i]["iitPerDep"].ToString() + "</iitPerDep>";
                        XmlStr += "<iitMark>" + dv[i]["iitMark"].ToString() + "</iitMark>";

                        XmlStr += "<iitFormat>" + dv[i]["iitFormat"].ToString() + "</iitFormat>";
                        XmlStr += "<iiPayRatio>" + dv[i]["iiPayRatio"].ToString() + "</iiPayRatio>";
                        XmlStr += "<iitPaySum>" + dv[i]["iitPaySum"].ToString() + "</iitPaySum>";
                        XmlStr += "<iitPayAmount>" + dv[i]["iitPayAmount"].ToString() + "</iitPayAmount>";
                        XmlStr += "<iitPayTax>" + dv[i]["iitPayTax"].ToString() + "</iitPayTax>";
                        XmlStr += "<iitYearStart>" + dv[i]["iitYearStart"].ToString() + "</iitYearStart>";
                        XmlStr += "<iitYearEnd>" + dv[i]["iitYearEnd"].ToString() + "</iitYearEnd>";
                        XmlStr += "<iitStock>" + dv[i]["iitStock"].ToString() + "</iitStock>";
                        XmlStr += "<iitStockDate>" + dv[i]["iitStockDate"].ToString() + "</iitStockDate>";
                        XmlStr += "<iitStockPrice>" + dv[i]["iitStockPrice"].ToString() + "</iitStockPrice>";
                        XmlStr += "<iitTaxMark>" + dv[i]["iitTaxMark"].ToString() + "</iitTaxMark>";
                        XmlStr += "<iitManner>" + dv[i]["iitManner"].ToString() + "</iitManner>";
                        XmlStr += "<iitCountryCode>" + dv[i]["iitCountryCode"].ToString() + "</iitCountryCode>";
                        XmlStr += "<iitCode>" + dv[i]["iitCode"].ToString() + "</iitCode>";

                        XmlStr += "<iitYyyy>" + dv[i]["iitYyyy"].ToString() + "</iitYyyy>";
                        XmlStr += "<iitPension>" + dv[i]["iitPension"].ToString() + "</iitPension>";
                        XmlStr += "<iitStockNumber>" + dv[i]["iitStockNumber"].ToString() + "</iitStockNumber>";
                        XmlStr += "<iitIdentify>" + dv[i]["iitIdentify"].ToString() + "</iitIdentify>";
                        XmlStr += "<iitErrMark>" + dv[i]["iitErrMark"].ToString() + "</iitErrMark>";
                        XmlStr += "<iitHouseTax>" + dv[i]["iitHouseTax"].ToString() + "</iitHouseTax>";
                        XmlStr += "<iitIndustryCode>" + dv[i]["iitIndustryCode"].ToString() + "</iitIndustryCode>";

                        XmlStr += "<iitDistribution>" + dv[i]["iitDistribution"].ToString() + "</iitDistribution>";
                        XmlStr += "<iitDividend>" + dv[i]["iitDividend"].ToString() + "</iitDividend>";
                        XmlStr += "<iitDeductedTax>" + dv[i]["iitDeductedTax"].ToString() + "</iitDeductedTax>";
                        XmlStr += "<iitDeductedRaito>" + dv[i]["iitDeductedRaito"].ToString() + "</iitDeductedRaito>";
                        XmlStr += "<iitNetAmount>" + dv[i]["iitNetAmount"].ToString() + "</iitNetAmount>";
                        XmlStr += "<iitInstitutionCode>" + dv[i]["iitInstitutionCode"].ToString() + "</iitInstitutionCode>";
                        XmlStr += "<iitBatchDate>" + dv[i]["iitBatchDate"].ToString() + "</iitBatchDate>";
                        XmlStr += "<iitBatchPrice>" + dv[i]["iitBatchPrice"].ToString() + "</iitBatchPrice>";

                        XmlStr += "</dView>";
                    }
                    XmlStr += "</dList>";

                    context.Response.Write(XmlStr);
                }
                else { context.Response.Write("<dList>d</dList>"); }
            }
            else { context.Response.Write("<dList>t</dList>"); }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_TaxList.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("<dList>e</dList>");
        }


    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}