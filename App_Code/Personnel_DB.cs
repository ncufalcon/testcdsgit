﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// Personnel_DB 的摘要描述
/// </summary>
public class Personnel_DB
{
	string KeyWord = string.Empty;
	public string _KeyWord
	{
		set { KeyWord = value; }
	}
	#region 私用
	string perGuid = string.Empty;
	string perNo = string.Empty;
	string perName = string.Empty;
	string perComGuid = string.Empty;
	string perCompName = string.Empty;
    string perDep = string.Empty;
    string perDepName = string.Empty;
    string perPosition = string.Empty;
	string perTel = string.Empty;
	string perPhone = string.Empty;
	string perContract = string.Empty;
	string perSex = string.Empty;
	string perBirthday = string.Empty;
	string perIDNumber = string.Empty;
	string perMarriage = string.Empty;
	string perFirstDate = string.Empty;
	string perLastDate = string.Empty;
	string perExaminationDate = string.Empty;
	string perExaminationLastDate = string.Empty;
	string perContractDeadline = string.Empty;
	string perResidentPermitDate = string.Empty;
	string perContactPerson = string.Empty;
	string perContactTel = string.Empty;
	string perRel = string.Empty;
	string perEmail = string.Empty;
	string perAddr = string.Empty;
	string perPostalCode = string.Empty;
	string perResidentAddr = string.Empty;
	string perResPostalCode = string.Empty;
	string perPs = string.Empty;
	string perLaborProtection = string.Empty;
	string perHealthInsurance = string.Empty;
	string perHIClass = string.Empty;
	string perInsuranceDes = string.Empty;
	string perGroupInsurance = string.Empty;
	string perLaborID = string.Empty;
	string perInsuranceID = string.Empty;
	string perSalaryClass = string.Empty;
	string perTaxable = string.Empty;
	string perBasicSalary = string.Empty;
	string perAllowance = string.Empty;
	string perSyAccountName = string.Empty;
	string perSyNumber = string.Empty;
	string perSyAccount = string.Empty;
	string perReferenceNumber = string.Empty;
	string perDetentionRatio = string.Empty;
	string perMonthPayroll = string.Empty;
	string perYearEndBonuses = string.Empty;
	string perCreateId = string.Empty;
	string perModifyId = string.Empty;
	string perStatus = string.Empty;

	DateTime perCreateDate;
	DateTime perModifyDate;
	#endregion
	#region 公用
	public string _perGuid
	{
		set { perGuid = value; }
	}
	public string _perNo
	{
		set { perNo = value; }
	}
	public string _perName
	{
		set { perName = value; }
	}
	public string _perComGuid
	{
		set { perComGuid = value; }
	}
	public string _perCompName
	{
		set { perCompName = value; }
	}
	public string _perDep
	{
		set { perDep = value; }
	}
	public string _perDepName
	{
		set { perDepName = value; }
	}
	public string _perPosition
	{
		set { perPosition = value; }
	}
	public string _perTel
	{
		set { perTel = value; }
	}
	public string _perPhone
	{
		set { perPhone = value; }
	}
	public string _perContract
	{
		set { perContract = value; }
	}
	public string _perSex
	{
		set { perSex = value; }
	}
	public string _perBirthday
	{
		set { perBirthday = value; }
	}
	public string _perIDNumber
	{
		set { perIDNumber = value; }
	}
	public string _perMarriage
	{
		set { perMarriage = value; }
	}
	public string _perFirstDate
	{
		set { perFirstDate = value; }
	}
	public string _perLastDate
	{
		set { perLastDate = value; }
	}
	public string _perExaminationDate
	{
		set { perExaminationDate = value; }
	}
	public string _perExaminationLastDate
	{
		set { perExaminationLastDate = value; }
	}
	public string _perContractDeadline
	{
		set { perContractDeadline = value; }
	}
	public string _perResidentPermitDate
	{
		set { perResidentPermitDate = value; }
	}
	public string _perContactPerson
	{
		set { perContactPerson = value; }
	}
	public string _perContactTel
	{
		set { perContactTel = value; }
	}
	public string _perRel
	{
		set { perRel = value; }
	}
	public string _perEmail
	{
		set { perEmail = value; }
	}
	public string _perAddr
	{
		set { perAddr = value; }
	}
	public string _perPostalCode
	{
		set { perPostalCode = value; }
	}
	public string _perResidentAddr
	{
		set { perResidentAddr = value; }
	}
	public string _perResPostalCode
	{
		set { perResPostalCode = value; }
	}
	public string _perPs
	{
		set { perPs = value; }
	}
	public string _perLaborProtection
	{
		set { perLaborProtection = value; }
	}
	public string _perHealthInsurance
	{
		set { perHealthInsurance = value; }
	}
	public string _perHIClass
	{
		set { perHIClass = value; }
	}
	public string _perInsuranceDes
	{
		set { perInsuranceDes = value; }
	}
	public string _perGroupInsurance
	{
		set { perGroupInsurance = value; }
	}
	public string _perLaborID
	{
		set { perLaborID = value; }
	}
	public string _perInsuranceID
	{
		set { perInsuranceID = value; }
	}
	public string _perSalaryClass
	{
		set { perSalaryClass = value; }
	}
	public string _perTaxable
	{
		set { perTaxable = value; }
	}
	public string _perBasicSalary
	{
		set { perBasicSalary = value; }
	}
	public string _perAllowance
	{
		set { perAllowance = value; }
	}
	public string _perSyAccountName
	{
		set { perSyAccountName = value; }
	}
	public string _perSyNumber
	{
		set { perSyNumber = value; }
	}
	public string _perSyAccount
	{
		set { perSyAccount = value; }
	}
	public string _perReferenceNumber
	{
		set { perReferenceNumber = value; }
	}
	public string _perDetentionRatio
	{
		set { perDetentionRatio = value; }
	}
	public string _perMonthPayroll
	{
		set { perMonthPayroll = value; }
	}
	public string _perYearEndBonuses
	{
		set { perYearEndBonuses = value; }
	}
	public string _perCreateId
	{
		set { perCreateId = value; }
	}
	public string _perModifyId
	{
		set { perModifyId = value; }
	}
	public string _perStatus
	{
		set { perStatus = value; }
	}
	public DateTime _perCreateDate
	{
		set { perCreateDate = value; }
	}
	public DateTime _perModifyDate
	{
		set { perModifyDate = value; }
	}
	#endregion

	public DataTable SelectList()
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		StringBuilder sb = new StringBuilder();

		sb.Append(@"SELECT top 200 * from sy_Person where perStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%') or (upper(perDepName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        oCmd.CommandText = sb.ToString();
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oda.Fill(ds);
		return ds;
	}

	public DataTable getPersonByGuid()
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		StringBuilder sb = new StringBuilder();

		sb.Append(@"SELECT * from sy_Person where perGuid=@perGuid ");

		oCmd.CommandText = sb.ToString();
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		DataTable ds = new DataTable();
		oCmd.Parameters.AddWithValue("@perGuid", perGuid);
		oda.Fill(ds);
		return ds;
	}

	public void addPersonnelInfo()
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		oCmd.CommandText = @"insert into sy_Person (
perGuid,
perNo,
perName,
perComGuid,
perCompName,
perDep,
perDepName,
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
@perCreateId,
@perModifyId,
@perModifyDate,
@perStatus
) ";
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		oCmd.Parameters.AddWithValue("@perGuid", perGuid);
		oCmd.Parameters.AddWithValue("@perNo", perNo);
		oCmd.Parameters.AddWithValue("@perName", perName);
		oCmd.Parameters.AddWithValue("@perComGuid", perComGuid);
		oCmd.Parameters.AddWithValue("@perCompName", perCompName);
		oCmd.Parameters.AddWithValue("@perDep", perDep);
		oCmd.Parameters.AddWithValue("@perDepName", perDepName);
        oCmd.Parameters.AddWithValue("@perPosition", perPosition);
		oCmd.Parameters.AddWithValue("@perTel", perTel);
		oCmd.Parameters.AddWithValue("@perPhone", perPhone);
		oCmd.Parameters.AddWithValue("@perContract", perContract);
		oCmd.Parameters.AddWithValue("@perSex", perSex);
		oCmd.Parameters.AddWithValue("@perBirthday", perBirthday);
		oCmd.Parameters.AddWithValue("@perIDNumber", perIDNumber);
		oCmd.Parameters.AddWithValue("@perMarriage", perMarriage);
		oCmd.Parameters.AddWithValue("@perFirstDate", perFirstDate);
		oCmd.Parameters.AddWithValue("@perLastDate", perLastDate);
		oCmd.Parameters.AddWithValue("@perExaminationDate", perExaminationDate);
		oCmd.Parameters.AddWithValue("@perExaminationLastDate", perExaminationLastDate);
		oCmd.Parameters.AddWithValue("@perContractDeadline", perContractDeadline);
		oCmd.Parameters.AddWithValue("@perResidentPermitDate", perResidentPermitDate);
		oCmd.Parameters.AddWithValue("@perContactPerson", perContactPerson);
		oCmd.Parameters.AddWithValue("@perContactTel", perContactTel);
		oCmd.Parameters.AddWithValue("@perRel", perRel);
		oCmd.Parameters.AddWithValue("@perEmail", perEmail);
		oCmd.Parameters.AddWithValue("@perAddr", perAddr);
		oCmd.Parameters.AddWithValue("@perPostalCode", perPostalCode);
		oCmd.Parameters.AddWithValue("@perResidentAddr", perResidentAddr);
		oCmd.Parameters.AddWithValue("@perResPostalCode", perResPostalCode);
		oCmd.Parameters.AddWithValue("@perPs", perPs);
		oCmd.Parameters.AddWithValue("@perCreateId", perCreateId);
		oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);
		oCmd.Parameters.AddWithValue("@perStatus", "A");

		oCmd.Connection.Open();
		oCmd.ExecuteNonQuery();
		oCmd.Connection.Close();
	}

    public void modPersonnelInfo()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_Person set
perNo=@perNo,
perName=@perName,
perComGuid=@perComGuid,
perCompName=@perCompName,
perDep=@perDep,
perDepName=@perDepName,
perPosition=@perPosition,
perTel=@perTel,
perPhone=@perPhone,
perContract=@perContract,
perSex=@perSex,
perBirthday=@perBirthday,
perIDNumber=@perIDNumber,
perMarriage=@perMarriage,
perFirstDate=@perFirstDate,
perLastDate=@perLastDate,
perExaminationDate=@perExaminationDate,
perExaminationLastDate=@perExaminationLastDate,
perContractDeadline=@perContractDeadline,
perResidentPermitDate=@perResidentPermitDate,
perContactPerson=@perContactPerson,
perContactTel=@perContactTel,
perRel=@perRel,
perEmail=@perEmail,
perAddr=@perAddr,
perPostalCode=@perPostalCode,
perResidentAddr=@perResidentAddr,
perResPostalCode=@perResPostalCode,
perPs=@perPs,
perModifyId=@perModifyId,
perModifyDate=@perModifyDate
where perGuid=@perGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oCmd.Parameters.AddWithValue("@perNo", perNo);
        oCmd.Parameters.AddWithValue("@perName", perName);
        oCmd.Parameters.AddWithValue("@perComGuid", perComGuid);
		oCmd.Parameters.AddWithValue("@perCompName", perCompName);
        oCmd.Parameters.AddWithValue("@perDep", perDep);
        oCmd.Parameters.AddWithValue("@perDepName", perDepName);
        oCmd.Parameters.AddWithValue("@perPosition", perPosition);
        oCmd.Parameters.AddWithValue("@perTel", perTel);
        oCmd.Parameters.AddWithValue("@perPhone", perPhone);
        oCmd.Parameters.AddWithValue("@perContract", perContract);
        oCmd.Parameters.AddWithValue("@perSex", perSex);
        oCmd.Parameters.AddWithValue("@perBirthday", perBirthday);
        oCmd.Parameters.AddWithValue("@perIDNumber", perIDNumber);
        oCmd.Parameters.AddWithValue("@perMarriage", perMarriage);
        oCmd.Parameters.AddWithValue("@perFirstDate", perFirstDate);
        oCmd.Parameters.AddWithValue("@perLastDate", perLastDate);
        oCmd.Parameters.AddWithValue("@perExaminationDate", perExaminationDate);
        oCmd.Parameters.AddWithValue("@perExaminationLastDate", perExaminationLastDate);
        oCmd.Parameters.AddWithValue("@perContractDeadline", perContractDeadline);
        oCmd.Parameters.AddWithValue("@perResidentPermitDate", perResidentPermitDate);
        oCmd.Parameters.AddWithValue("@perContactPerson", perContactPerson);
        oCmd.Parameters.AddWithValue("@perContactTel", perContactTel);
        oCmd.Parameters.AddWithValue("@perRel", perRel);
        oCmd.Parameters.AddWithValue("@perEmail", perEmail);
        oCmd.Parameters.AddWithValue("@perAddr", perAddr);
        oCmd.Parameters.AddWithValue("@perPostalCode", perPostalCode);
        oCmd.Parameters.AddWithValue("@perResidentAddr", perResidentAddr);
        oCmd.Parameters.AddWithValue("@perResPostalCode", perResPostalCode);
        oCmd.Parameters.AddWithValue("@perPs", perPs);
        oCmd.Parameters.AddWithValue("@perCreateId", perCreateId);
        oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataSet checkPerson(string ckNo,string ckID)
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		StringBuilder sb = new StringBuilder();

		sb.Append(@"SELECT * from sy_Person where perNo=@ckNo
SELECT * from sy_Person where perIDNumber=@ckID ");

		oCmd.CommandText = sb.ToString();
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		DataSet ds = new DataSet();

		oCmd.Parameters.AddWithValue("@ckNo", ckNo);
		oCmd.Parameters.AddWithValue("@ckID", ckID);
		oda.Fill(ds);
		return ds;
	}

	public void deletePerson()
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		oCmd.CommandText = @"update sy_Person set perStatus='D' where perGuid=@perGuid ";
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		oCmd.Parameters.AddWithValue("@perGuid", perGuid);
		oCmd.Connection.Open();
		oCmd.ExecuteNonQuery();
		oCmd.Connection.Close();
	}

    public DataSet getCompany(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();


        sb.Append(@"SELECT COUNT(*) total from sy_Company where comStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(comName) LIKE '%' + upper(@KeyWord) + '%') or (upper(comAbbreviate) LIKE '%' + upper(@KeyWord) + '%') or (upper(comUniform) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by comCreatDate) itemNo,
          * from sy_Company where comStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(comName) LIKE '%' + upper(@KeyWord) + '%') or (upper(comAbbreviate) LIKE '%' + upper(@KeyWord) + '%') or (upper(comUniform) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@")#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oda.Fill(ds);
        return ds;
    }

    public DataSet getDepartment(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();
        
        sb.Append(@"SELECT COUNT(*) total from sy_CodeBranches where cbStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(cbName) LIKE '%' + upper(@KeyWord) + '%') or (upper(cbValue) LIKE '%' + upper(@KeyWord) + '%') or (upper(cbDesc) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by cbCreateDate) itemNo,
          * from sy_CodeBranches where cbStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(cbName) LIKE '%' + upper(@KeyWord) + '%') or (upper(cbValue) LIKE '%' + upper(@KeyWord) + '%') or (upper(cbDesc) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@")#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkComp(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT comGuid from sy_Company where comAbbreviate=@ckStr ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkDep(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT cbGuid from sy_CodeBranches where cbName=@ckStr ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }

    public void modInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_Person set
perHIClass=@perHIClass,
perInsuranceDes=@perInsuranceDes,
perGroupInsurance=@perGroupInsurance,
perLaborID=@perLaborID,
perInsuranceID=@perInsuranceID
where perGuid=@perGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oCmd.Parameters.AddWithValue("@perHIClass", perHIClass);
        oCmd.Parameters.AddWithValue("@perInsuranceDes", perInsuranceDes);
        oCmd.Parameters.AddWithValue("@perGroupInsurance", perGroupInsurance);
        oCmd.Parameters.AddWithValue("@perLaborID", perLaborID);
        oCmd.Parameters.AddWithValue("@perInsuranceID", perInsuranceID);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modSalary()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_Person set
perSalaryClass=@perSalaryClass,
perTaxable=@perTaxable,
perBasicSalary=@perBasicSalary,
perAllowance=@perAllowance,
perSyAccountName=@perSyAccountName,
perSyNumber=@perSyNumber,
perSyAccount=@perSyAccount
where perGuid=@perGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oCmd.Parameters.AddWithValue("@perSalaryClass", perSalaryClass);
        oCmd.Parameters.AddWithValue("@perTaxable", perTaxable);
        oCmd.Parameters.AddWithValue("@perBasicSalary", perBasicSalary);
        oCmd.Parameters.AddWithValue("@perAllowance", perAllowance);
        oCmd.Parameters.AddWithValue("@perSyAccountName", perSyAccountName);
        oCmd.Parameters.AddWithValue("@perSyNumber", perSyNumber);
        oCmd.Parameters.AddWithValue("@perSyAccount", perSyAccount);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
}