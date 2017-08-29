<%@ WebHandler Language="C#" Class="addPerson" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.SessionState;
using System.Configuration;

public class addPerson : IHttpHandler,IRequiresSessionState {
    Personnel_DB Personnel_Db = new Personnel_DB();
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    PersonPension_DB PP_Db = new PersonPension_DB();
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            //基本資料
            string pNo = (context.Request.Form["pNo"] != null) ? context.Request.Form["pNo"].ToString() : "";
            string pName = (context.Request.Form["pName"] != null) ? context.Request.Form["pName"].ToString() : "";
            string pComGuid = (context.Request.Form["pComGuid"] != null) ? context.Request.Form["pComGuid"].ToString() : "";
            string pDepGuid = (context.Request.Form["pDepGuid"] != null) ? context.Request.Form["pDepGuid"].ToString() : "";
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
            string pYears = (context.Request.Form["pYears"] != null) ? context.Request.Form["pYears"].ToString() : "0";
            pYears = (pYears == "") ? "0" : pYears;
            string pAnnualLeave = (context.Request.Form["pAnnualLeave"] != null) ? context.Request.Form["pAnnualLeave"].ToString() : "0";
            pAnnualLeave = (pAnnualLeave == "") ? "0" : pAnnualLeave;
            //保險
            string pHIClass = (context.Request.Form["pHIClass"] != null) ? context.Request.Form["pHIClass"].ToString() : "";
            string pInsuranceDes = (context.Request.Form["plv_CodeGuid"] != null) ? context.Request.Form["plv_CodeGuid"].ToString() : "";
            string pGroupInsurance = (context.Request.Form["pGroupInsurance"] != null) ? context.Request.Form["pGroupInsurance"].ToString() : "";
            string pLaborID = (context.Request.Form["Labor_CodeGuid"] != null) ? context.Request.Form["Labor_CodeGuid"].ToString() : "";
            string pInsuranceID = (context.Request.Form["Health_CodeGuid"] != null) ? context.Request.Form["Health_CodeGuid"].ToString() : "";
            string pp_Identity = (context.Request.Form["pp_Identity"] != null) ? context.Request.Form["pp_Identity"].ToString() : "";
            //計薪
            string pSalaryClass = (context.Request.Form["pSalaryClass"] != null) ? context.Request.Form["pSalaryClass"].ToString() : "";
            string pTaxable = (context.Request.Form["pTaxable"] != null) ? context.Request.Form["pTaxable"].ToString() : "";
            string pBasicSalary = (context.Request.Form["pBasicSalary"] != null) ? context.Request.Form["pBasicSalary"].ToString() : "";
            string pAllowance = (context.Request.Form["pAllowance"] != null) ? context.Request.Form["pAllowance"].ToString() : "";
            string pSyAccountName = (context.Request.Form["pSyAccountName"] != null) ? context.Request.Form["pSyAccountName"].ToString() : "";
            string pSyNumber = (context.Request.Form["pSyNumber"] != null) ? context.Request.Form["pSyNumber"].ToString() : "";
            string pSyAccount = (context.Request.Form["pSyAccount"] != null) ? context.Request.Form["pSyAccount"].ToString() : "";
            //法院執行命令
            string pReferenceNumber = (context.Request.Form["pReferenceNumber"] != null) ? context.Request.Form["pReferenceNumber"].ToString() : "";
            string pDetentionRatio = (context.Request.Form["pDetentionRatio"] != null) ? context.Request.Form["pDetentionRatio"].ToString() : "";
            string pDetentionFee = (context.Request.Form["pDetentionFee"] != null) ? context.Request.Form["pDetentionFee"].ToString() : "";
            string pMonthPayroll = (context.Request.Form["pMonthPayroll"] != null) ? context.Request.Form["pMonthPayroll"].ToString() : "";
            string pYearEndBonuses = (context.Request.Form["pSyAccount"] != null) ? context.Request.Form["pYearEndBonuses"].ToString() : "";

            string newPersonGid = Guid.NewGuid().ToString();
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

                    Personnel_Db._perGuid = newPersonGid;
                    Personnel_Db._perNo = pNo;
                    Personnel_Db._perName = pName;
                    Personnel_Db._perComGuid = pComGuid;
                    Personnel_Db._perDep = pDepGuid;
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
                    Personnel_Db._perYears = decimal.Parse(pYears);
                    Personnel_Db._perAnnualLeave = decimal.Parse(pAnnualLeave);
                    Personnel_Db._perCreateId = USERINFO.MemberGuid;
                    Personnel_Db._perModifyId = USERINFO.MemberGuid;
                    Personnel_Db.addPersonnelInfo();
                    break;
                case "Modify":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perNo = pNo;
                    Personnel_Db._perName = pName;
                    Personnel_Db._perComGuid = pComGuid;
                    Personnel_Db._perDep = pDepGuid;
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
                    Personnel_Db._perYears = decimal.Parse(pYears);
                    Personnel_Db._perAnnualLeave = decimal.Parse(pAnnualLeave);
                    Personnel_Db._perModifyId = USERINFO.MemberGuid;
                    Personnel_Db.modPersonnelInfo();
                    break;
                case "Insurance":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perHIClass = pHIClass;
                    Personnel_Db._perInsuranceDes = pInsuranceDes;
                    Personnel_Db._perGroupInsurance = pGroupInsurance;
                    Personnel_Db._perLaborID = pLaborID;
                    Personnel_Db._perInsuranceID = pInsuranceID;
                    Personnel_Db._perPensionIdentity = pp_Identity;
                    Personnel_Db._perModifyId = USERINFO.MemberGuid;
                    Personnel_Db.modInsurance();

                    //勞保
                    LH_Db._plPerGuid = id;
                    DataTable ldt = LH_Db.checkPerLabor();
                    if (ldt.Rows.Count == 0)
                    {
                        LH_Db._plGuid = Guid.NewGuid().ToString();
                        LH_Db._plSubsidyLevel = pLaborID;
                        LH_Db._plPerGuid = id;
                        LH_Db._plLaborNo = getLH_Code(id, "L");
                        LH_Db._plChange = "01";
                        LH_Db._plChangeDate = getValue("sy_Person", "perGuid", id, "perFirstDate", "perStatus");
                        LH_Db._plLaborPayroll = decimal.Parse(getStartIns("ssi_labor"));
                        LH_Db._plModifyId = USERINFO.MemberGuid;
                        LH_Db.addLabor();
                    }
                    //健保
                    LH_Db._piPerGuid = id;
                    DataTable hdt = LH_Db.checkPerHeal();
                    if (hdt.Rows.Count == 0)
                    {
                        LH_Db._piGuid = Guid.NewGuid().ToString();
                        LH_Db._piSubsidyLevel = pInsuranceID;
                        LH_Db._piPerGuid = id;
                        LH_Db._piCardNo = getLH_Code(id, "H");
                        LH_Db._piChange = "01";
                        LH_Db._piChangeDate = getValue("sy_Person", "perGuid", id, "perFirstDate", "perStatus");
                        LH_Db._piInsurancePayroll = decimal.Parse(getStartIns("ssi_ganbor"));
                        LH_Db._piModifyId = USERINFO.MemberGuid;
                        LH_Db.addHeal();
                    }
                    //勞退
                    PP_Db._ppPerGuid = id;
                    DataTable ppdt = PP_Db.checkPerPension();
                    if (ppdt.Rows.Count == 0)
                    {
                        PP_Db._ppGuid = Guid.NewGuid().ToString();
                        PP_Db._ppPerGuid = id;
                        PP_Db._ppModifyId = USERINFO.MemberGuid;
                        PP_Db._ppChange = "01";
                        PP_Db._ppChangeDate = getValue("sy_Person", "perGuid", id, "perFirstDate", "perStatus");
                        PP_Db._ppPayPayroll = decimal.Parse(getStartIns("ssi_tahui"));
                        string tmpEratio = getValue("sy_InsuranceIdentity", "iiGuid", pInsuranceDes, "iiRetirement","iiStatus");
                        tmpEratio = (tmpEratio != "") ? tmpEratio : "0";
                        PP_Db._ppEmployerRatio = decimal.Parse(tmpEratio);
                        PP_Db.addPension();
                    }
                    //團保
                    if (pGroupInsurance == "Y")
                    {
                        GI_Db._pgiPerGuid = id;
                        DataTable pgidt = GI_Db.checkPerGroupIns();
                        if (pgidt.Rows.Count == 0)
                        {
                            GI_Db._pgiGuid = Guid.NewGuid().ToString();
                            GI_Db._pgiPerGuid = id;
                            GI_Db._pgiType = "01"; //身份
                            GI_Db._pgiChange = "01"; //異動別
                            //團保加保生效日應為員工到職日起滿一個月
                            string sDay = getValue("sy_Person", "perGuid", id, "perFirstDate", "perStatus");
                            DateTime daytmp = DateTime.Parse(sDay).AddMonths(1);
                            GI_Db._pgiChangeDate = daytmp.ToString("yyyy/MM/dd");
                            GI_Db._pgiModifyId = USERINFO.MemberGuid;
                            GI_Db.addGroupInsurance();
                        }
                    }
                    break;
                case "Salary":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perSalaryClass = pSalaryClass;
                    Personnel_Db._perTaxable = pTaxable;
                    Personnel_Db._perBasicSalary = decimal.Parse(pBasicSalary);
                    Personnel_Db._perAllowance = decimal.Parse(pAllowance);
                    Personnel_Db._perSyAccountName = pSyAccountName;
                    Personnel_Db._perSyNumber = pSyNumber;
                    Personnel_Db._perSyAccount = pSyAccount;
                    Personnel_Db._perModifyId = USERINFO.MemberGuid;
                    Personnel_Db.modSalary();
                    break;
                case "Buckle":
                    Personnel_Db._perGuid = id;
                    Personnel_Db._perReferenceNumber = pReferenceNumber;
                    Personnel_Db._perDetentionRatio = decimal.Parse(pDetentionRatio);
                    Personnel_Db._perDetentionFee = decimal.Parse(pDetentionFee);
                    Personnel_Db._perMonthPayroll = decimal.Parse(pMonthPayroll);
                    Personnel_Db._perYearEndBonuses = decimal.Parse(pYearEndBonuses);
                    Personnel_Db._perModifyId = USERINFO.MemberGuid;
                    Personnel_Db.modBuckle();
                    break;
            }

            context.Response.ContentType = "text/html";
            if (Mode == "New")
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('add','" + newPersonGid + "');</script>");
            else
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun();</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addPerson');</script>"); }
    }

    private string getLH_Code(string perGuid,string type)
    {
        string codeStr = string.Empty;
        DataTable dt = Personnel_Db.getLHcode(perGuid);
        if (dt.Rows.Count > 0)
        {
            if (type == "L")
                codeStr = dt.Rows[0]["comLaborProtectionCode"].ToString();
            else
                codeStr = dt.Rows[0]["comHealthInsuranceCode"].ToString();
        }
        return codeStr;
    }

    /// <summary>
    /// <para>TableName : 資料表名稱,conName : 條件欄位名稱,InputVal : 查詢條件值,reName : 讀取欄位名稱,statusName : 狀態欄位名稱</para>
    /// </summary>
    private string getValue(string TableName, string conName, string InputVal, string reName,string statusName)
    {
        string str = string.Empty;
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.Connection.Open();
        oCmd.CommandText = "SELECT * from " + TableName + " with (nolock) where " + conName + "='" + InputVal + "' "; //with (nolock) SqlTransaction不加會TimeOut
        if (statusName != "")
            oCmd.CommandText += " and " + statusName + "<>'D'";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oda.Fill(ds);
        oda.Dispose();
        oCmd.Connection.Close();
        oCmd.Connection.Dispose();

        if (ds.Rows.Count > 0)
            str = ds.Rows[0][reName].ToString();

        return str;
    }


    /// <summary>
    /// <para>ssi_labor : 勞保</para>
    /// <para>ssi_tahui : 勞退</para>
    /// <para>ssi_ganbor : 健保</para>
    /// </summary>
    private string getStartIns(string ColunmName)
    {
        string str = string.Empty;
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.Connection.Open();
        oCmd.CommandText = "SELECT * from sy_SetStartInsurance with (nolock) "; //with (nolock) SqlTransaction不加會TimeOut

        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oda.Fill(ds);
        oda.Dispose();
        oCmd.Connection.Close();
        oCmd.Connection.Dispose();

        if (ds.Rows.Count > 0)
            str = ds.Rows[0][ColunmName].ToString();

        return str;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}