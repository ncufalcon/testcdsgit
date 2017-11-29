<%@ WebHandler Language="C#" Class="PersonImport" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Configuration;

public class PersonImport : IHttpHandler,IRequiresSessionState {
    ErrorLog err = new ErrorLog();
    Personnel_DB Personnel_Db = new Personnel_DB();
    PersonFamily_DB pf_db = new PersonFamily_DB();
    public void ProcessRequest(HttpContext context)
    {
        if (string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LoginFailed');</script>");
            return;
        }

        bool status = true;
        string exStr = string.Empty; //錯誤訊息
        int PerCount = 0; //人員計數
        int FamilyCount = 0; //眷屬計數
        HttpFileCollection uploadFiles = context.Request.Files;//檔案集合

        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            for (int i = 0; i < uploadFiles.Count; i++)
            {
                HttpPostedFile aFile = uploadFiles[i];
                //if (aFile.ContentLength == 0 || String.IsNullOrEmpty(System.IO.Path.GetFileName(aFile.FileName)))
                //{
                //    continue;
                //}
                ExcelFile Xls = new XlsFile(true);
                string UpLoadPath = context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName));
                //如果上傳路徑中沒有該目錄，則自動新增
                if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))
                {
                    Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                }
                aFile.SaveAs(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName)));

                Xls.Open(UpLoadPath);
                Xls.ActiveSheet = 1;

                //勞保
                oCmd.Parameters.Add("@plGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@plLaborPayroll", SqlDbType.Decimal);
                //健保
                oCmd.Parameters.Add("@piGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@piInsurancePayroll", SqlDbType.Decimal);
                //勞退
                oCmd.Parameters.Add("@ppGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ppEmployerRatio", SqlDbType.Decimal);
                oCmd.Parameters.Add("@ppPayPayroll", SqlDbType.Decimal);
                //團保
                oCmd.Parameters.Add("@pgiGuid", SqlDbType.NVarChar);

                oCmd.Parameters.Add("@perGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perNo", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perName", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perComGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perDep", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perPosition", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perTel", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perPhone", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perContract", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perSex", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perBirthday", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perIDNumber", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perMarriage", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perFirstDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perLastDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perExaminationDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perExaminationLastDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perContractDeadline", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perResidentPermitDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perContactPerson", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perContactTel", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perRel", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perEmail", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perAddr", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perPostalCode", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perResidentAddr", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perResPostalCode", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perPs", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perHIClass", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perInsuranceDes", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perGroupInsurance", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perLaborID", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perInsuranceID", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perSalaryClass", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perTaxable", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perBasicSalary", SqlDbType.Decimal);
                oCmd.Parameters.Add("@perAllowance", SqlDbType.Decimal);
                oCmd.Parameters.Add("@perSyAccountName", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perSyNumber", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perSyAccount", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perYears", SqlDbType.Decimal);
                oCmd.Parameters.Add("@perPensionIdentity", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perCreateId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perModifyId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perModifyDate", SqlDbType.DateTime);
                oCmd.Parameters.Add("@perStatus", SqlDbType.NVarChar);

                //勞健保卡號
                oCmd.Parameters.Add("@LaborNo", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@HealNo", SqlDbType.NVarChar);

                for (int j = 3; j <= Xls.GetRowCount(1); j++)
                {
                    string perIDNumber = (Xls.GetCellValue(j, 1) != null) ? Xls.GetCellValue(j, 1).ToString() : "";
                    string perNo = (Xls.GetCellValue(j, 2) != null) ? Xls.GetCellValue(j, 2).ToString() : "";
                    string perComGuid = (Xls.GetCellValue(j, 3) != null) ? Xls.GetCellValue(j, 3).ToString() : "";
                    string perDep = (Xls.GetCellValue(j, 4) != null) ? Xls.GetCellValue(j, 4).ToString() : "";
                    string perName = (Xls.GetCellValue(j, 5) != null) ? Xls.GetCellValue(j, 5).ToString() : "";
                    string perPosition = (Xls.GetCellValue(j, 6) != null) ? Xls.GetCellValue(j, 6).ToString() : "";
                    string perBirthday = (Xls.GetCellValue(j, 7) != null) ? Xls.GetCellValue(j, 7).ToString() : "";
                    string perSex = (Xls.GetCellValue(j, 8) != null) ? Xls.GetCellValue(j, 8).ToString() : "";
                    string perMarriage = (Xls.GetCellValue(j, 9) != null) ? Xls.GetCellValue(j, 9).ToString() : "";
                    string perYears = (Xls.GetCellValue(j, 10) != null) ? Xls.GetCellValue(j, 10).ToString() : "0";
                    string perContract = (Xls.GetCellValue(j, 11) != null) ? Xls.GetCellValue(j, 11).ToString() : "";
                    string perFirstDate = (Xls.GetCellValue(j, 12) != null) ? Xls.GetCellValue(j, 12).ToString() : "";
                    string perLastDate = (Xls.GetCellValue(j, 13) != null) ? Xls.GetCellValue(j, 13).ToString() : "";
                    string perExaminationDate = (Xls.GetCellValue(j, 14) != null) ? Xls.GetCellValue(j, 14).ToString() : "";
                    string perExaminationLastDate = (Xls.GetCellValue(j, 15) != null) ? Xls.GetCellValue(j, 15).ToString() : "";
                    string perContractDeadline = (Xls.GetCellValue(j, 16) != null) ? Xls.GetCellValue(j, 16).ToString() : "";
                    string perResidentPermitDate = (Xls.GetCellValue(j, 17) != null) ? Xls.GetCellValue(j, 17).ToString() : "";
                    string perTel = (Xls.GetCellValue(j, 18) != null) ? Xls.GetCellValue(j, 18).ToString() : "";
                    string perPhone = (Xls.GetCellValue(j, 19) != null) ? Xls.GetCellValue(j, 19).ToString() : "";
                    string perEmail = (Xls.GetCellValue(j, 20) != null) ? Xls.GetCellValue(j, 20).ToString() : "";
                    string perPostalCode = (Xls.GetCellValue(j, 21) != null) ? Xls.GetCellValue(j, 21).ToString() : "";
                    string perAddr = (Xls.GetCellValue(j, 22) != null) ? Xls.GetCellValue(j, 22).ToString() : "";
                    string perResPostalCode = (Xls.GetCellValue(j, 23) != null) ? Xls.GetCellValue(j, 23).ToString() : "";
                    string perResidentAddr = (Xls.GetCellValue(j, 24) != null) ? Xls.GetCellValue(j, 24).ToString() : "";
                    string perContactPerson = (Xls.GetCellValue(j, 25) != null) ? Xls.GetCellValue(j, 25).ToString() : "";
                    string perContactTel = (Xls.GetCellValue(j, 26) != null) ? Xls.GetCellValue(j, 26).ToString() : "";
                    string perRel = (Xls.GetCellValue(j, 27) != null) ? Xls.GetCellValue(j, 27).ToString() : "";
                    string perPs = (Xls.GetCellValue(j, 28) != null) ? Xls.GetCellValue(j, 28).ToString() : "";
                    string perHIClass = (Xls.GetCellValue(j, 29) != null) ? Xls.GetCellValue(j, 29).ToString() : "";
                    string perInsuranceDes = (Xls.GetCellValue(j, 30) != null) ? Xls.GetCellValue(j, 30).ToString() : "";
                    string perGroupInsurance = (Xls.GetCellValue(j, 31) != null) ? Xls.GetCellValue(j, 31).ToString() : "";
                    string perLaborID = (Xls.GetCellValue(j, 32) != null) ? Xls.GetCellValue(j, 32).ToString() : "";
                    string perInsuranceID = (Xls.GetCellValue(j, 33) != null) ? Xls.GetCellValue(j, 33).ToString() : "";
                    string perPensionIdentity = (Xls.GetCellValue(j, 34) != null) ? Xls.GetCellValue(j, 34).ToString() : "";
                    string perSalaryClass = (Xls.GetCellValue(j, 35) != null) ? Xls.GetCellValue(j, 35).ToString() : "";
                    string perTaxable = (Xls.GetCellValue(j, 36) != null) ? Xls.GetCellValue(j, 36).ToString() : "";
                    string perBasicSalary = (Xls.GetCellValue(j, 37) != null) ? Xls.GetCellValue(j, 37).ToString() : "0";
                    string perAllowance = (Xls.GetCellValue(j, 38) != null) ? Xls.GetCellValue(j, 38).ToString() : "0";
                    string perSyAccountName = (Xls.GetCellValue(j, 39) != null) ? Xls.GetCellValue(j, 39).ToString() : "";
                    string perSyNumber = (Xls.GetCellValue(j, 40) != null) ? Xls.GetCellValue(j, 40).ToString() : "";
                    string perSyAccount = (Xls.GetCellValue(j, 41) != null) ? Xls.GetCellValue(j, 41).ToString() : "";

                    //檢查員編與身分證字號是否重複
                    DataSet ckds = Personnel_Db.checkPerson(perNo, perIDNumber);
                    DataTable cdt1 = ckds.Tables[0];
                    if (cdt1.Rows.Count > 0)
                    {
                        continue;
                    }
                    DataTable cdt2 = ckds.Tables[1];
                    if (cdt2.Rows.Count > 0)
                    {
                        continue;
                    }
                    //判斷身分證字號是否為空
                    if (perIDNumber == "")
                        continue;

                    PerCount += 1;

                    //勞保
                    oCmd.Parameters["@plGuid"].Value = Guid.NewGuid().ToString();
                    oCmd.Parameters["@plLaborPayroll"].Value = decimal.Parse(getStartIns("ssi_labor"));
                    //健保
                    oCmd.Parameters["@piGuid"].Value = Guid.NewGuid().ToString();
                    oCmd.Parameters["@piInsurancePayroll"].Value = decimal.Parse(getStartIns("ssi_ganbor"));
                    //勞退
                    oCmd.Parameters["@ppGuid"].Value = Guid.NewGuid().ToString();
                    string tmpEratio = getCnValue("sy_InsuranceIdentity", "iiIdentityCode", perInsuranceDes, "iiRetirement","iiStatus");
                    tmpEratio = (tmpEratio != "") ? tmpEratio : "0";
                    oCmd.Parameters["@ppEmployerRatio"].Value = decimal.Parse(tmpEratio);
                    //20170703修改 word上面說"員工到職勞退提撥，雇主提繳比率統一為6%、勞退月提繳工資應為11100" 原本撈ilItem3 現在改撈ilItem2勞保
                    oCmd.Parameters["@ppPayPayroll"].Value = decimal.Parse(getStartIns("ssi_tahui"));
                    //團保
                    oCmd.Parameters["@pgiGuid"].Value = Guid.NewGuid().ToString();
                    //勞健保卡號
                    string CompanyGid = getCnValue("sy_Company", "comAbbreviate", perComGuid, "comGuid","comStatus");
                    oCmd.Parameters["@LaborNo"].Value =  getCnValue("sy_Company", "comGuid", CompanyGid, "comLaborProtectionCode","comStatus");
                    oCmd.Parameters["@HealNo"].Value = getCnValue("sy_Company", "comGuid", CompanyGid, "comHealthInsuranceCode","comStatus");

                    oCmd.Parameters["@perGuid"].Value = Guid.NewGuid().ToString();
                    oCmd.Parameters["@perNo"].Value = perNo;
                    oCmd.Parameters["@perName"].Value = perName;
                    oCmd.Parameters["@perComGuid"].Value = CompanyGid;
                    oCmd.Parameters["@perDep"].Value = getCnValue("sy_CodeBranches", "cbValue", perDep, "cbGuid","cbStatus");
                    oCmd.Parameters["@perPosition"].Value = perPosition;
                    oCmd.Parameters["@perTel"].Value = perTel;
                    oCmd.Parameters["@perPhone"].Value = perPhone;
                    oCmd.Parameters["@perContract"].Value = perContract;
                    oCmd.Parameters["@perSex"].Value = perSex;
                    oCmd.Parameters["@perBirthday"].Value = xlsDateTimeFormat(perBirthday);
                    oCmd.Parameters["@perIDNumber"].Value = perIDNumber;
                    oCmd.Parameters["@perMarriage"].Value = perMarriage;
                    oCmd.Parameters["@perFirstDate"].Value = xlsDateTimeFormat(perFirstDate);
                    oCmd.Parameters["@perLastDate"].Value = xlsDateTimeFormat(perLastDate);
                    oCmd.Parameters["@perExaminationDate"].Value = xlsDateTimeFormat(perExaminationDate);
                    oCmd.Parameters["@perExaminationLastDate"].Value = xlsDateTimeFormat(perExaminationLastDate);
                    oCmd.Parameters["@perContractDeadline"].Value = xlsDateTimeFormat(perContractDeadline);
                    oCmd.Parameters["@perResidentPermitDate"].Value = perResidentPermitDate;
                    oCmd.Parameters["@perContactPerson"].Value = perContactPerson;
                    oCmd.Parameters["@perContactTel"].Value = perContactTel;
                    oCmd.Parameters["@perRel"].Value = perRel;
                    oCmd.Parameters["@perEmail"].Value = perEmail;
                    oCmd.Parameters["@perAddr"].Value = perAddr;
                    oCmd.Parameters["@perPostalCode"].Value = perPostalCode;
                    oCmd.Parameters["@perResidentAddr"].Value = perResidentAddr;
                    oCmd.Parameters["@perResPostalCode"].Value = perResPostalCode;
                    oCmd.Parameters["@perPs"].Value = perPs;
                    oCmd.Parameters["@perHIClass"].Value = perHIClass;
                    oCmd.Parameters["@perInsuranceDes"].Value = getCnValue("sy_InsuranceIdentity", "iiIdentityCode", perInsuranceDes, "iiGuid","iiStatus");
                    oCmd.Parameters["@perGroupInsurance"].Value = perGroupInsurance;
                    oCmd.Parameters["@perLaborID"].Value = getCnValue("sy_SubsidyLevel", "slSubsidyCode", perLaborID, "slGuid","slStatus");
                    oCmd.Parameters["@perInsuranceID"].Value = getCnValue("sy_SubsidyLevel", "slSubsidyCode", perInsuranceID, "slGuid","slStatus");
                    oCmd.Parameters["@perSalaryClass"].Value = perSalaryClass;
                    oCmd.Parameters["@perTaxable"].Value = perTaxable;
                    oCmd.Parameters["@perBasicSalary"].Value = decimal.Parse(perBasicSalary);
                    oCmd.Parameters["@perAllowance"].Value = decimal.Parse(perAllowance);
                    oCmd.Parameters["@perSyAccountName"].Value = perSyAccountName;
                    oCmd.Parameters["@perSyNumber"].Value = perSyNumber;
                    oCmd.Parameters["@perSyAccount"].Value = perSyAccount;
                    oCmd.Parameters["@perYears"].Value = decimal.Parse(perYears);
                    oCmd.Parameters["@perPensionIdentity"].Value = perPensionIdentity;
                    oCmd.Parameters["@perCreateId"].Value = USERINFO.MemberGuid;
                    oCmd.Parameters["@perModifyId"].Value = USERINFO.MemberGuid;
                    oCmd.Parameters["@perModifyDate"].Value = DateTime.Now;
                    oCmd.Parameters["@perStatus"].Value = "A";

                    oCmd.CommandText = @"INSERT INTO sy_Person (
perGuid,
perNo,
perName,
perComGuid,
perDep,
perPosition,
perTel,
perPhone,
perContract,
perSex,
perBirthday,
perIDNumber,
perMarriage,
perFirstDate,
perLastDate,
perExaminationDate,
perExaminationLastDate,
perContractDeadline,
perResidentPermitDate,
perContactPerson,
perContactTel,
perRel,
perEmail,
perAddr,
perPostalCode,
perResidentAddr,
perResPostalCode,
perPs,
perHIClass,
perInsuranceDes,
perGroupInsurance,
perLaborID,
perInsuranceID,
perSalaryClass,
perTaxable,
perBasicSalary,
perAllowance,
perSyAccountName,
perSyNumber,
perSyAccount,
perYears,
perPensionIdentity,
perCreateId,
perModifyId,
perModifyDate,
perStatus
) values (
@perGuid,
@perNo,
@perName,
@perComGuid,
@perDep,
@perPosition,
@perTel,
@perPhone,
@perContract,
@perSex,
@perBirthday,
@perIDNumber,
@perMarriage,
@perFirstDate,
@perLastDate,
@perExaminationDate,
@perExaminationLastDate,
@perContractDeadline,
@perResidentPermitDate,
@perContactPerson,
@perContactTel,
@perRel,
@perEmail,
@perAddr,
@perPostalCode,
@perResidentAddr,
@perResPostalCode,
@perPs,
@perHIClass,
@perInsuranceDes,
@perGroupInsurance,
@perLaborID,
@perInsuranceID,
@perSalaryClass,
@perTaxable,
@perBasicSalary,
@perAllowance,
@perSyAccountName,
@perSyNumber,
@perSyAccount,
@perYears,
@perPensionIdentity,
@perCreateId,
@perModifyId,
@perModifyDate,
@perStatus
                    ) ";

                    //勞保
                    oCmd.CommandText += @"insert into sy_PersonLabor (
                    plGuid,
                    plPerGuid,
                    plSubsidyLevel,
                    plLaborNo,
                    plChangeDate,
                    plChange,
                    plLaborPayroll,
                    plCreateId,
                    plModifyDate,
                    plModifyId,
                    plStatus
                    ) values (
                    @plGuid,
                    @perGuid,
                    @perLaborID,
                    @LaborNo,
                    @perFirstDate,
                    '01',
                    @plLaborPayroll,
                    @perCreateId,
                    @perModifyDate,
                    @perModifyId,
                    @perStatus
                    ) ";

                    //健保
                    oCmd.CommandText += @"insert into sy_PersonInsurance (
                    piGuid,
                    piPerGuid,
                    piSubsidyLevel,
                    piCardNo,
                    piChangeDate,
                    piChange,
                    piInsurancePayroll,
                    piCreateId,
                    piModifyDate,
                    piModifyId,
                    piStatus
                    ) values (
                    @piGuid,
                    @perGuid,
                    @perInsuranceID,
                    @HealNo,
                    @perFirstDate,
                    '01',
                    @piInsurancePayroll,
                    @perCreateId,
                    @perModifyDate,
                    @perModifyId,
                    @perStatus
                    ) ";

                    //勞退
                    oCmd.CommandText += @"insert into sy_PersonPension (
                    ppGuid,
                    ppPerGuid,
                    ppChange,
                    ppChangeDate,
                    ppLarboRatio,
                    ppEmployerRatio,
                    ppPayPayroll,
                    ppCreateId,
                    ppModifyDate,
                    ppModifyId,
                    ppStatus
                    ) values (
                    @ppGuid,
                    @perGuid,
                    '01',
                    @perFirstDate,
                    '0',
                    @ppEmployerRatio,
                    @ppPayPayroll,
                    @perCreateId,
                    @perModifyDate,
                    @perModifyId,
                    @perStatus
                    ) ";

                    //團保
                    if (perGroupInsurance == "Y")
                    {
                        oCmd.CommandText += @"insert into sy_PersonGroupInsurance (
                    pgiGuid,
                    pgiPerGuid,
                    pgiPfGuid,
                    pgiType,
                    pgiChange,
                    pgiChangeDate,
                    pgiCreateId,
                    pgiModifyDate,
                    pgiModifyId,
                    pgiStatus
                    ) values (
                    @pgiGuid,
                    @perGuid,
                    '',
                    '01',
                    '01',
                    @perFirstDate,
                    @perCreateId,
                    @perModifyDate,
                    @perModifyId,
                    @perStatus
                    ) ";
                    }
                    oCmd.ExecuteNonQuery();
                }

                //眷屬資料
                oCmd.Parameters.Clear();
                Xls.ActiveSheet = 2;

                //健保
                oCmd.Parameters.Add("@pfiGuid", SqlDbType.NVarChar);
                //團保
                oCmd.Parameters.Add("@pgiGuid", SqlDbType.NVarChar);

                oCmd.Parameters.Add("@pfGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfPerGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfName", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfTitle", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfBirthday", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfIDNumber", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfHealthInsurance", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfCode", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfGroupInsurance", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfCreateId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfModifyId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pfModifyDate", SqlDbType.DateTime);
                oCmd.Parameters.Add("@pfStatus", SqlDbType.NVarChar);
                //到職日
                oCmd.Parameters.Add("@ChangeDate", SqlDbType.NVarChar);

                for (int k = 3; k <= Xls.GetRowCount(2); k++)
                {
                    string pfPerGuid = (Xls.GetCellValue(k, 1) != null) ? Xls.GetCellValue(k, 1).ToString() : "";
                    string pfName = (Xls.GetCellValue(k, 2) != null) ? Xls.GetCellValue(k, 2).ToString() : "";
                    string pfTitle = (Xls.GetCellValue(k, 3) != null) ? Xls.GetCellValue(k, 3).ToString() : "";
                    string pfBirthday = (Xls.GetCellValue(k, 4) != null) ? Xls.GetCellValue(k, 4).ToString() : "";
                    string pfIDNumber = (Xls.GetCellValue(k, 5) != null) ? Xls.GetCellValue(k, 5).ToString() : "";
                    string pfCode = (Xls.GetCellValue(k, 6) != null) ? Xls.GetCellValue(k, 6).ToString() : "";
                    string pfGroupInsurance = (Xls.GetCellValue(k, 7) != null) ? Xls.GetCellValue(k, 7).ToString() : "";
                    string pfHealthInsurance = (Xls.GetCellValue(k, 8) != null) ? Xls.GetCellValue(k, 8).ToString() : "";

                    //判斷身分證字號是否為空
                    if (pfIDNumber == "")
                        continue;

                    pf_db._pfIDNumber = pfIDNumber;
                    DataTable pfdt = pf_db.checkPFbyIDNum();
                    if (pfdt.Rows.Count > 0)
                        continue;

                    //無對應工號則不Insert
                    if (getCnValue("sy_Person", "perNo", pfPerGuid, "perGuid","perStatus") == "")
                        continue;

                    FamilyCount += 1;

                    //健保
                    oCmd.Parameters["@pfiGuid"].Value = Guid.NewGuid().ToString();
                    //團保
                    oCmd.Parameters["@pgiGuid"].Value = Guid.NewGuid().ToString();
                    //到職日
                    string PersonGid = getCnValue("sy_Person", "perNo", pfPerGuid, "perGuid","perStatus");
                    oCmd.Parameters["@ChangeDate"].Value = getCnValue("sy_Person", "perGuid", PersonGid, "perFirstDate","perStatus");

                    oCmd.Parameters["@pfGuid"].Value = Guid.NewGuid().ToString();
                    oCmd.Parameters["@pfPerGuid"].Value = PersonGid;
                    oCmd.Parameters["@pfName"].Value = pfName;
                    oCmd.Parameters["@pfTitle"].Value = pfTitle;
                    oCmd.Parameters["@pfBirthday"].Value = xlsDateTimeFormat(pfBirthday);
                    oCmd.Parameters["@pfIDNumber"].Value = pfIDNumber;
                    oCmd.Parameters["@pfHealthInsurance"].Value = pfHealthInsurance;
                    oCmd.Parameters["@pfCode"].Value = getCnValue("sy_SubsidyLevel", "slSubsidyCode", pfCode, "slGuid","slStatus");
                    oCmd.Parameters["@pfGroupInsurance"].Value = pfGroupInsurance;
                    oCmd.Parameters["@pfCreateId"].Value = USERINFO.MemberGuid;
                    oCmd.Parameters["@pfModifyId"].Value = USERINFO.MemberGuid;
                    oCmd.Parameters["@pfModifyDate"].Value = DateTime.Now;
                    oCmd.Parameters["@pfStatus"].Value = "A";

                    oCmd.CommandText = @"INSERT INTO sy_PersonFamily (
    pfGuid,
    pfPerGuid,
    pfName,
    pfTitle,
    pfBirthday,
    pfIDNumber,
    pfHealthInsurance,
    pfCode,
    pfGroupInsurance,
    pfCreateId,
    pfModifyId,
    pfModifyDate,
    pfStatus
    ) values (
    @pfGuid,
    @pfPerGuid,
    @pfName,
    @pfTitle,
    @pfBirthday,
    @pfIDNumber,
    @pfHealthInsurance,
    @pfCode,
    @pfGroupInsurance,
    @pfCreateId,
    @pfModifyId,
    @pfModifyDate,
    @pfStatus
                        ) ";

                    //健保
                    if (pfHealthInsurance == "Y")
                    {
                        oCmd.CommandText += @"insert into sy_PersonFamilyInsurance (
                    pfiGuid,
                    pfiPerGuid,
                    pfiPfGuid,
                    pfiChange,
                    pfiChangeDate,
                    pfiSubsidyLevel,
                    pfiCreateId,
                    pfiModifyDate,
                    pfiModifyId,
                    pfiStatus
                    ) values (
                    @pfiGuid,
                    @pfPerGuid,
                    @pfGuid,
                    '01',
                    @ChangeDate,
                    @pfCode,
                    @pfCreateId,
                    @pfModifyDate,
                    @pfModifyId,
                    @pfStatus
                    )  ";
                    }

                    //團保
                    if (pfGroupInsurance == "Y")
                    {
                        oCmd.CommandText += @"insert into sy_PersonGroupInsurance (
                    pgiGuid,
                    pgiPerGuid,
                    pgiPfGuid,
                    pgiType,
                    pgiChange,
                    pgiChangeDate,
                    pgiCreateId,
                    pgiModifyDate,
                    pgiModifyId,
                    pgiStatus
                    ) values (
                    @pgiGuid,
                    @pfPerGuid,
                    @pfGuid,
                    '02',
                    '01',
                    @ChangeDate,
                    @pfCreateId,
                    @pfModifyDate,
                    @pfModifyId,
                    @pfStatus
                    ) ";
                    }
                    oCmd.ExecuteNonQuery();
                }
                myTrans.Commit();

                File.Delete(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName)));
            }
        }
        catch (Exception ex)
        {
            status = false;
            err.InsErrorLog("PersonImport.ashx", ex.Message, USERINFO.MemberName);
            myTrans.Rollback();
            exStr = ex.Message;
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
            context.Response.ContentType = "text/html";
            if (status == false)
            {
                string genStr = "Error：";
                if (FamilyCount == 0)
                    genStr += "人員資料第" + PerCount + "筆<br />";
                else
                    genStr += "眷屬資料第" + FamilyCount + "筆<br />";
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('" + genStr + context.Server.UrlEncode(exStr).Replace("+", " ") + "');</script>");
            }
            else
            {
                string genStr = "資料匯入完成<br />";
                genStr += "人員資料：" + PerCount + "筆<br />";
                genStr += "眷屬資料：" + FamilyCount + "筆";
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('" + genStr + "');</script>");
            }
        }
    }

    /// <summary>
    /// <para>TableName : 資料表名稱</para>
    /// <para>conName : 條件欄位名稱</para>
    /// <para>InputVal : 查詢條件值</para>
    /// <para>reName : 讀取欄位名稱</para>
    /// <para>statusName : 狀態欄位名稱</para>
    /// </summary>
    private string getCnValue(string TableName, string conName, string InputVal, string reName,string statusName)
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

    private string xlsDateTimeFormat(string str)
    {
        if (str.Length != 10 && str !="")
            str = DateTime.FromOADate(Double.Parse(str)).ToString("yyyy/MM/dd");
        return str;
    }

    public bool IsReusable {
        get {
            return false;
        }
    }
}