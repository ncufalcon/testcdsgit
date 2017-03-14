<%@ WebHandler Language="C#" Class="ashx_Company_SaveData" %>

using System;
using System.Web;

public class ashx_Company_SaveData : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(context.Request.Form["comName"]) 
                && !string.IsNullOrEmpty(context.Request.Form["comAbbreviate"])
                && !string.IsNullOrEmpty(context.Request.Form["comUniform"])
                || !string.IsNullOrEmpty(context.Request.Form["comGuid"]))
            {
                string comGuid = (!string.IsNullOrEmpty(context.Request.Form["comGuid"])) ? context.Request.Form["comGuid"].ToString() : "";
                
                string EditType = (!string.IsNullOrEmpty(context.Request.Form["EditType"])) ? context.Request.Form["EditType"].ToString() : "";
                
                string comName = (!string.IsNullOrEmpty(context.Request.Form["comName"])) ? context.Request.Form["comName"].ToString() : "";
                string comAbbreviate = (!string.IsNullOrEmpty(context.Request.Form["comAbbreviate"])) ? context.Request.Form["comAbbreviate"].ToString() : "";
                string comUniform = (!string.IsNullOrEmpty(context.Request.Form["comUniform"])) ? context.Request.Form["comUniform"].ToString() : "";
                
                string comNTA = (!string.IsNullOrEmpty(context.Request.Form["comNTA"])) ? context.Request.Form["comNTA"].ToString() : "";
                string comLaborProtection1 = (!string.IsNullOrEmpty(context.Request.Form["comLaborProtection1"])) ? context.Request.Form["comLaborProtection1"].ToString() : "";
                string comLaborProtection2 = (!string.IsNullOrEmpty(context.Request.Form["comLaborProtection2"])) ? context.Request.Form["comLaborProtection2"].ToString() : "";

                string comBIT = (!string.IsNullOrEmpty(context.Request.Form["comBIT"])) ? context.Request.Form["comBIT"].ToString() : "";
                string comNTB = (!string.IsNullOrEmpty(context.Request.Form["comNTB"])) ? context.Request.Form["comNTB"].ToString() : "";
                string comLaborProtectionCode = (!string.IsNullOrEmpty(context.Request.Form["comLaborProtectionCode"])) ? context.Request.Form["comLaborProtectionCode"].ToString() : "";
                                
                string comHouseTax = (!string.IsNullOrEmpty(context.Request.Form["comHouseTax"])) ? context.Request.Form["comHouseTax"].ToString() : "";
                string comCity = (!string.IsNullOrEmpty(context.Request.Form["comCity"])) ? context.Request.Form["comCity"].ToString() : "";
                string comHealthInsuranceCode = (!string.IsNullOrEmpty(context.Request.Form["comHealthInsuranceCode"])) ? context.Request.Form["comHealthInsuranceCode"].ToString() : "";
                
                string comBusinessEntity = (!string.IsNullOrEmpty(context.Request.Form["comBusinessEntity"])) ? context.Request.Form["comBusinessEntity"].ToString() : "";
                string comResponsible = (!string.IsNullOrEmpty(context.Request.Form["comResponsible"])) ? context.Request.Form["comResponsible"].ToString() : "";
                string comTel = (!string.IsNullOrEmpty(context.Request.Form["comTel"])) ? context.Request.Form["comTel"].ToString() : "";
                
                string comAddress1 = (!string.IsNullOrEmpty(context.Request.Form["comAddress1"])) ? context.Request.Form["comAddress1"].ToString() : "";
                string comAddress2 = (!string.IsNullOrEmpty(context.Request.Form["comAddress2"])) ? context.Request.Form["comAddress2"].ToString() : "";
                string comPs = (!string.IsNullOrEmpty(context.Request.Form["comPs"])) ? context.Request.Form["comPs"].ToString() : "";
                
                string comMail = (!string.IsNullOrEmpty(context.Request.Form["comMail"])) ? context.Request.Form["comMail"].ToString() : "";
                string comOfficeNumber = (!string.IsNullOrEmpty(context.Request.Form["comOfficeNumber"])) ? context.Request.Form["comOfficeNumber"].ToString() : "";
                string comAccountNumber = (!string.IsNullOrEmpty(context.Request.Form["comAccountNumber"])) ? context.Request.Form["comAccountNumber"].ToString() : "";


                string msg = CheckSqlInJection(comName, comAbbreviate, comUniform,
                    comNTA, comLaborProtection1, comHealthInsuranceCode,
                    comBIT, comNTB, comLaborProtectionCode,
                    comHouseTax, comCity, comHealthInsuranceCode,
                    comBusinessEntity, comResponsible, comTel,
                    comAddress1, comAddress2, comPs,
                    comMail, comOfficeNumber, comAccountNumber);
                
                if (msg == "")
                {
                    string Id = "12345";
                    DateTime Date = DateTime.Now;
                    
                    switch (EditType)
                    {
                        case "Ins":
                            dal.insertCompanyData(comName, comAbbreviate, comUniform,
                    comNTA, comLaborProtection1, comLaborProtection2,
                    comBIT, comNTB, comLaborProtectionCode,
                    comHouseTax, comCity, comHealthInsuranceCode,
                    comBusinessEntity, comResponsible, comTel,
                    comAddress1, comAddress2, comPs,
                    comMail, comOfficeNumber, comAccountNumber, Id);
                            //DataView dv = Rep.SelectID().DefaultView;
                            //Rep.InsertCC(Pro, dv[0]["ProjectID"].ToString());
                            //Rep.InsertDate(Pro, dv[0]["ProjectID"].ToString());
                            break;
                        case "Up":
                            dal.UpdateCompanyData(comName, comAbbreviate, comUniform,
                    comNTA, comLaborProtection1, comLaborProtection2,
                    comBIT, comNTB, comLaborProtectionCode,
                    comHouseTax, comCity, comHealthInsuranceCode,
                    comBusinessEntity, comResponsible, comTel,
                    comAddress1, comAddress2, comPs,
                    comMail, comOfficeNumber, comAccountNumber,
                    Id, Date,
                    comGuid);
                            break;
                        case "Del":
                            dal.Up_Status_CompanyData(comGuid, Id, Date);
                            break;
                    }
                    context.Response.Write("OK");
                }
                else { context.Response.Write("sign"); }
            }
            else { context.Response.Write("Timeout"); }
        }
        catch (Exception ex) { context.Response.Write("error"); }
    }

    /// <summary>
    /// 驗證危險字元
    /// </summary>
    private string CheckSqlInJection(string comName, string comAbbreviate, string comUniform,
                                  string comNTA, string comLaborProtection1, string comLaborProtection2,
                                  string comBIT, string comNTB, string comLaborProtectionCode,
                                  string comHouseTax, string comCity, string comHealthInsuranceCode,
                                  string comBusinessEntity, string comResponsible, string comTel,
                                  string comAddress1, string comAddress2, string comPs,
                                  string comMail, string comOfficeNumber, string comAccountNumber)
    {
        Common com = new Common();
        string msg = "";
        if (com.CheckSQLInjectionEncode(comName) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comAbbreviate) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comUniform) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(comNTA) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comLaborProtection1) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comLaborProtection2) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(comBIT) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comNTB) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comLaborProtectionCode) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(comHouseTax) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comCity) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comHealthInsuranceCode) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(comBusinessEntity) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comResponsible) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comTel) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(comAddress1) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comAddress2) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comPs) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(comMail) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comOfficeNumber) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(comAccountNumber) == false)
            msg = "1";

        return msg;
    }

 
    public bool IsReusable {
        get {
            return false;
        }
    }

}