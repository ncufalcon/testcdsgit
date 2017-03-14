<%@ WebHandler Language="C#" Class="ashx_Company_Edit" %>

using System;
using System.Web;
using System.Data;

public class ashx_Company_Edit : IHttpHandler {
    
    Dal dal = new Dal();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string comGuid = (!string.IsNullOrEmpty(context.Request.Form["comGuid"])) ? context.Request.Form["comGuid"].ToString() : "";
            string XmlStr = "";
            DataView dv = dal.GetCompanyData(comGuid).DefaultView;

            //int minNo = (pageNnumber * 10) + 1 - 10; //算sql切割 起始比數
            //int maxNo = minNo + 9; //算sql切割 迄比數
            //int topMin = ((dvList.Count - minNo) >= 10) ? 10 : dvList.Count - minNo + 1;
            //Lic.minNumber = minNo;
            //Lic.maxNumber = maxNo;
            //Lic.topMin = topMin;
            //DataView dv = dal.selLicPage(Lic).DefaultView;

            XmlStr += "<dList>";
            //XmlStr += "<quity>" + dvList.Count + "</quity>";
            //XmlStr += "<paging>" + 10 + "</paging>";
            //XmlStr += "<cur>" + pageNnumber + "</cur>";
            DateTime Today = DateTime.Now;
            for (int i = 0; i < dv.Count; i++)
            {
                XmlStr += "<dView>";

                XmlStr += "<comName>" + dv[i]["comName"].ToString() + "</comName>";
                XmlStr += "<comAbbreviate>" + dv[i]["comAbbreviate"].ToString() + "</comAbbreviate>";
                XmlStr += "<comUniform>" + dv[i]["comUniform"].ToString() + "</comUniform>";

                XmlStr += "<comNTA>" + dv[i]["comNTA"].ToString() + "</comNTA>";
                XmlStr += "<comLaborProtection1>" + dv[i]["comLaborProtection1"].ToString() + "</comLaborProtection1>";
                XmlStr += "<comLaborProtection2>" + dv[i]["comLaborProtection2"].ToString() + "</comLaborProtection2>";

                XmlStr += "<comBIT>" + dv[i]["comBIT"].ToString() + "</comBIT>";
                XmlStr += "<comNTB>" + dv[i]["comNTB"].ToString() + "</comNTB>";
                XmlStr += "<comLaborProtectionCode>" + dv[i]["comLaborProtectionCode"].ToString() + "</comLaborProtectionCode>";

                XmlStr += "<comHouseTax>" + dv[i]["comHouseTax"].ToString() + "</comHouseTax>";
                XmlStr += "<comCity>" + dv[i]["comCity"].ToString() + "</comCity>";
                XmlStr += "<comHealthInsuranceCode>" + dv[i]["comHealthInsuranceCode"].ToString() + "</comHealthInsuranceCode>";

                XmlStr += "<comBusinessEntity>" + dv[i]["comBusinessEntity"].ToString() + "</comBusinessEntity>";
                XmlStr += "<comResponsible>" + dv[i]["comResponsible"].ToString() + "</comResponsible>";
                XmlStr += "<comTel>" + dv[i]["comTel"].ToString() + "</comTel>";

                XmlStr += "<comAddress1>" + dv[i]["comAddress1"].ToString() + "</comAddress1>";
                XmlStr += "<comAddress2>" + dv[i]["comAddress2"].ToString() + "</comAddress2>";
                XmlStr += "<comPs>" + dv[i]["comPs"].ToString() + "</comPs>";

                XmlStr += "<comMail>" + dv[i]["comMail"].ToString() + "</comMail>";
                XmlStr += "<comOfficeNumber>" + dv[i]["comOfficeNumber"].ToString() + "</comOfficeNumber>";
                XmlStr += "<comAccountNumber>" + dv[i]["comAccountNumber"].ToString() + "</comAccountNumber>";
                
                XmlStr += "</dView>";
            }
            XmlStr += "</dList>";
            context.Response.ContentType = "text/xml";
            context.Response.Write(XmlStr);
        }
        catch (Exception ex)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("error");
        }
    }
 
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}