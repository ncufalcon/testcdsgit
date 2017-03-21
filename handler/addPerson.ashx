<%@ WebHandler Language="C#" Class="addPerson" %>

using System;
using System.Web;
using System.Data;

public class addPerson : IHttpHandler {
    Personnel_DB Personnel_Db = new Personnel_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            //基本資料
            string pNo = (context.Request.Form["pNo"] != null) ? context.Request.Form["pNo"].ToString() : "";
            string pName = (context.Request.Form["pName"] != null) ? context.Request.Form["pName"].ToString() : "";
            string pComGuid = (context.Request.Form["pComGuid"] != null) ? context.Request.Form["pComGuid"].ToString() : "";
            string pCompName = (context.Request.Form["pCompName"] != null) ? context.Request.Form["pCompName"].ToString() : "";
            string pDep = (context.Request.Form["pDep"] != null) ? context.Request.Form["pDep"].ToString() : "";
            string pDepName = (context.Request.Form["pDepName"] != null) ? context.Request.Form["pDepName"].ToString() : "";
            string pSex = (context.Request.Form["pSex"] != null) ? context.Request.Form["pSex"].ToString() : "";
            string perMarriage = (context.Request.Form["perMarriage"] != null) ? context.Request.Form["perMarriage"].ToString() : "";
            string pPosition = (context.Request.Form["pPosition"] != null) ? context.Request.Form["pPosition"].ToString() : "";
            string pBirthday = (context.Request.Form["pBirthday"] != null) ? context.Request.Form["pBirthday"].ToString() : "";
            string pIDNumber = (context.Request.Form["pIDNumber"] != null) ? context.Request.Form["pIDNumber"].ToString() : "";
            string pContract = (context.Request.Form["pContract"] != null) ? context.Request.Form["pContract"].ToString() : "";
            string pFirstDate = (context.Request.Form["pFirstDate"] != null) ? context.Request.Form["pFirstDate"].ToString() : "";
            string pLastDate = (context.Request.Form["pLastDate"] != null) ? context.Request.Form["pLastDate"].ToString() : "";
            string pExaminationDate = (context.Request.Form["pExaminationDate"] != null) ? context.Request.Form["pExaminationDate"].ToString() : "";
            string pExaminationLastDate = (context.Request.Form["pExaminationLastDate"] != null) ? context.Request.Form["pExaminationLastDate"].ToString() : "";
            string pContractDeadline = (context.Request.Form["pContractDeadline"] != null) ? context.Request.Form["pContractDeadline"].ToString() : "";
            string pResidentPermitDate = (context.Request.Form["pResidentPermitDate"] != null) ? context.Request.Form["pResidentPermitDate"].ToString() : "";
            string pTel = (context.Request.Form["pTel"] != null) ? context.Request.Form["pTel"].ToString() : "";
            string pPhone = (context.Request.Form["pPhone"] != null) ? context.Request.Form["pPhone"].ToString() : "";
            string pEmail = (context.Request.Form["pEmail"] != null) ? context.Request.Form["pEmail"].ToString() : "";
            string pPostalCode = (context.Request.Form["pPostalCode"] != null) ? context.Request.Form["pPostalCode"].ToString() : "";
            string pAddr = (context.Request.Form["pAddr"] != null) ? context.Request.Form["pAddr"].ToString() : "";
            string pResPostalCode = (context.Request.Form["pResPostalCode"] != null) ? context.Request.Form["pResPostalCode"].ToString() : "";
            string pResidentAddr = (context.Request.Form["pResidentAddr"] != null) ? context.Request.Form["pResidentAddr"].ToString() : "";
            string pContactPerson = (context.Request.Form["pContactPerson"] != null) ? context.Request.Form["pContactPerson"].ToString() : "";
            string pContactTel = (context.Request.Form["pContactTel"] != null) ? context.Request.Form["pContactTel"].ToString() : "";
            string pRel = (context.Request.Form["pRel"] != null) ? context.Request.Form["pRel"].ToString() : "";
            string pPs = (context.Request.Form["pPs"] != null) ? context.Request.Form["pPs"].ToString() : "";
            //保險
            string pHIClass = (context.Request.Form["pHIClass"] != null) ? context.Request.Form["pHIClass"].ToString() : "";
            string pInsuranceDes = (context.Request.Form["pInsuranceDes"] != null) ? context.Request.Form["pInsuranceDes"].ToString() : "";
            string pGroupInsurance = (context.Request.Form["pGroupInsurance"] != null) ? context.Request.Form["pGroupInsurance"].ToString() : "";
            string pLaborID = (context.Request.Form["pLaborID"] != null) ? context.Request.Form["pLaborID"].ToString() : "";
            string pInsuranceID = (context.Request.Form["pInsuranceID"] != null) ? context.Request.Form["pInsuranceID"].ToString() : "";
            //計薪
            string pSalaryClass = (context.Request.Form["pSalaryClass"] != null) ? context.Request.Form["pSalaryClass"].ToString() : "";
            string pTaxable = (context.Request.Form["pTaxable"] != null) ? context.Request.Form["pTaxable"].ToString() : "";
            string pBasicSalary = (context.Request.Form["pBasicSalary"] != null) ? context.Request.Form["pBasicSalary"].ToString() : "";
            string pAllowance = (context.Request.Form["pAllowance"] != null) ? context.Request.Form["pAllowance"].ToString() : "";
            string pSyAccountName = (context.Request.Form["pSyAccountName"] != null) ? context.Request.Form["pSyAccountName"].ToString() : "";
            string pSyNumber = (context.Request.Form["pSyNumber"] != null) ? context.Request.Form["pSyNumber"].ToString() : "";
            string pSyAccount = (context.Request.Form["pSyAccount"] != null) ? context.Request.Form["pSyAccount"].ToString() : "";


            switch (Mode)
            {
                case "New":
                    //檢查員編與身分證字號是否重複
                    DataSet ckds = Personnel_Db.checkPerson(pNo, pIDNumber);
                    DataTable cdt1 = ckds.Tables[0];
                    if (cdt1.Rows.Count > 0)
                    {
                        context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('repeatNo');</script>");
                        return;
                    }
                    DataTable cdt2 = ckds.Tables[1];
                    if (cdt2.Rows.Count > 0)
                    {
                        context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('repeatID');</script>");
                        return;
                    }

                    Personnel_Db._perGuid = Guid.NewGuid().ToString();
                    Personnel_Db._perNo = pNo;
                    Personnel_Db._perName = pName;
                    Personnel_Db._perComGuid = pComGuid;
                    Personnel_Db._perCompName = pCompName;
                    Personnel_Db._perDep = pDep;
                    Personnel_Db._perDepName = pDepName;
                    Personnel_Db._perPosition = pPosition;
                    Personnel_Db._perTel = pTel;
                    Personnel_Db._perPhone = pPhone;
                    Personnel_Db._perContract = pContract;
                    Personnel_Db._perSex = pSex;
                    Personnel_Db._perBirthday = pBirthday;
                    Personnel_Db._perIDNumber = pIDNumber;
                    Personnel_Db._perMarriage = perMarriage;
                    Personnel_Db._perFirstDate = pFirstDate;
                    Personnel_Db._perLastDate = pLastDate;
                    Personnel_Db._perExaminationDate = pExaminationDate;
                    Personnel_Db._perExaminationLastDate = pExaminationLastDate;
                    Personnel_Db._perContractDeadline = pContractDeadline;
                    Personnel_Db._perResidentPermitDate = pResidentPermitDate;
                    Personnel_Db._perContactPerson = pContactPerson;
                    Personnel_Db._perContactTel = pContactTel;
                    Personnel_Db._perRel = pRel;
                    Personnel_Db._perEmail = pEmail;
                    Personnel_Db._perAddr = pAddr;
                    Personnel_Db._perPostalCode = pPostalCode;
                    Personnel_Db._perResidentAddr = pResidentAddr;
                    Personnel_Db._perResPostalCode = pResPostalCode;
                    Personnel_Db._perPs = pPs;
                    Personnel_Db.addPersonnelInfo();
                    break;
                case "Modify":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perNo = pNo;
                    Personnel_Db._perName = pName;
                    Personnel_Db._perComGuid = pComGuid;
                    Personnel_Db._perCompName = pCompName;
                    Personnel_Db._perDep = pDep;
                    Personnel_Db._perDepName = pDepName;
                    Personnel_Db._perPosition = pPosition;
                    Personnel_Db._perTel = pTel;
                    Personnel_Db._perPhone = pPhone;
                    Personnel_Db._perContract = pContract;
                    Personnel_Db._perSex = pSex;
                    Personnel_Db._perBirthday = pBirthday;
                    Personnel_Db._perIDNumber = pIDNumber;
                    Personnel_Db._perMarriage = perMarriage;
                    Personnel_Db._perFirstDate = pFirstDate;
                    Personnel_Db._perLastDate = pLastDate;
                    Personnel_Db._perExaminationDate = pExaminationDate;
                    Personnel_Db._perExaminationLastDate = pExaminationLastDate;
                    Personnel_Db._perContractDeadline = pContractDeadline;
                    Personnel_Db._perResidentPermitDate = pResidentPermitDate;
                    Personnel_Db._perContactPerson = pContactPerson;
                    Personnel_Db._perContactTel = pContactTel;
                    Personnel_Db._perRel = pRel;
                    Personnel_Db._perEmail = pEmail;
                    Personnel_Db._perAddr = pAddr;
                    Personnel_Db._perPostalCode = pPostalCode;
                    Personnel_Db._perResidentAddr = pResidentAddr;
                    Personnel_Db._perResPostalCode = pResPostalCode;
                    Personnel_Db._perPs = pPs;
                    Personnel_Db.modPersonnelInfo();
                    break;
                case "Insurance":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perHIClass = pHIClass;
                    Personnel_Db._perInsuranceDes = pInsuranceDes;
                    Personnel_Db._perGroupInsurance = pGroupInsurance;
                    Personnel_Db._perLaborID = pLaborID;
                    Personnel_Db._perInsuranceID = pInsuranceID;
                    Personnel_Db.modInsurance();
                    break;
                case "Salary":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perSalaryClass = pSalaryClass;
                    Personnel_Db._perTaxable = pTaxable;
                    Personnel_Db._perBasicSalary = pBasicSalary;
                    Personnel_Db._perAllowance = pAllowance;
                    Personnel_Db._perSyAccountName = pSyAccountName;
                    Personnel_Db._perSyNumber = pSyNumber;
                    Personnel_Db._perSyAccount = pSyAccount;
                    Personnel_Db.modSalary();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun();</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addPerson');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}