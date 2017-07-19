using System;
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
    string perDep = string.Empty;
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
    decimal perBasicSalary;
    decimal perAllowance;
	string perSyAccountName = string.Empty;
	string perSyNumber = string.Empty;
	string perSyAccount = string.Empty;
	string perReferenceNumber = string.Empty;
    decimal perDetentionRatio;
    decimal perDetentionFee;    
    decimal perMonthPayroll;
    decimal perYearEndBonuses;
    decimal perYears;
    decimal perAnnualLeave;
    string perPensionIdentity = string.Empty;
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
	public string _perDep
	{
		set { perDep = value; }
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
	public decimal _perBasicSalary
	{
		set { perBasicSalary = value; }
	}
	public decimal _perAllowance
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
	public decimal _perDetentionRatio
	{
		set { perDetentionRatio = value; }
	}
    public decimal _perDetentionFee
    {
        set { perDetentionFee = value; }
    }
    public decimal _perMonthPayroll
	{
		set { perMonthPayroll = value; }
	}
	public decimal _perYearEndBonuses
	{
		set { perYearEndBonuses = value; }
	}
	public decimal _perYears
	{
		set { perYears = value; }
	}
	public decimal _perAnnualLeave
    {
		set { perAnnualLeave = value; }
	}
	public string _perPensionIdentity
    {
		set { perPensionIdentity = value; }
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

	public DataTable SelectList(string sortMethod,string sortName)
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		StringBuilder sb = new StringBuilder();

		sb.Append(@"SELECT top 200 perGuid,perNo,perName,cbName,perSex,iiIdentityCode,iiIdentity,perFirstDate from sy_Person 
left join sy_Company on comGuid=perComGuid
left join sy_CodeBranches on cbGuid=perDep
left join sy_InsuranceIdentity on iiGuid=perInsuranceDes
where perStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }
        if (sortName == "")
            sb.Append(@"order by perFirstDate desc,perCreateDate desc ");
        else
            sb.Append(@"order by " + sortName + " " + sortMethod + " ");

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
        //20170703 修改 
        //1. join sy_InsuranceIdentity 的時候加上 perStatus<>'D'
        //2. join sy_SubsidyLevel 的時候加上 slStatus<>'D'
        //原本join是沒有判斷iiStatus跟slStatus
        //所以就算sy_InsuranceIdentity裡面的身分刪除了status變成D還是可以join到值
        //現在改成要對應status<>'D'
        //這樣的話因為適用GUID去對應，如果對應不到畫面上頭保身分 勞保補助身分 健保補助身分都會變成空白的
        //廣哥怕他們如果有去刪身分，但人員這邊，因為還有資料，所以他們也不會記得去改，
        //乾脆空白給他們，看到就會去改
        sb.Append(@"SELECT *,a.slGuid Lgv,a.slSubsidyCode LCode,a.slSubsidyIdentity LStr,b.slGuid Hgv,b.slSubsidyCode HCode,b.slSubsidyIdentity HStr from sy_Person 
left join sy_Company on comGuid=perComGuid
left join sy_CodeBranches on cbGuid=perDep
left join sy_InsuranceIdentity on iiGuid=perInsuranceDes and iiStatus<>'D'
left join sy_SubsidyLevel a on a.slGuid=perLaborID and a.slStatus<>'D'
left join sy_SubsidyLevel b on b.slGuid=perInsuranceID and b.slStatus<>'D'
where perGuid=@perGuid ");

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
perYears,
perAnnualLeave,
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
@perYears,
@perAnnualLeave,
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
		oCmd.Parameters.AddWithValue("@perDep", perDep);
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
		oCmd.Parameters.AddWithValue("@perYears", perYears);
		oCmd.Parameters.AddWithValue("@perAnnualLeave", perAnnualLeave);
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
perDep=@perDep,
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
perYears=@perYears,
perAnnualLeave=@perAnnualLeave,
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
        oCmd.Parameters.AddWithValue("@perDep", perDep);
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
        oCmd.Parameters.AddWithValue("@perYears", perYears);
        oCmd.Parameters.AddWithValue("@perAnnualLeave", perAnnualLeave);
        oCmd.Parameters.AddWithValue("@perCreateId", perCreateId);
        oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataSet checkPerson(string ckNo,string ckID)
	{
		SqlCommand oComd = new SqlCommand();
        oComd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		StringBuilder sb = new StringBuilder();

		sb.Append(@"SELECT * from sy_Person with (nolock) where perNo=@ckNo and perStatus='A'
SELECT * from sy_Person with (nolock) where perIDNumber=@ckID and perStatus='A' ");

        oComd.CommandText = sb.ToString();
        oComd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oComd);
		DataSet ds = new DataSet();

        oComd.Parameters.AddWithValue("@ckNo", ckNo);
        oComd.Parameters.AddWithValue("@ckID", ckID);
		oda.Fill(ds);
        oda.Dispose();
        oComd.Connection.Close();
        oComd.Connection.Dispose();
        return ds;
	}

	public void deletePerson()
	{
		SqlCommand oCmd = new SqlCommand();
		oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
		oCmd.CommandText = @"update sy_Person set 
perStatus='D',
perModifyId=@perModifyId,
perModifyDate=@perModifyDate
where perGuid=@perGuid ";
		oCmd.CommandType = CommandType.Text;
		SqlDataAdapter oda = new SqlDataAdapter(oCmd);
		oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);
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

    public DataSet getAllowance(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT COUNT(*) total from sy_SalaryItem where siStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(siItemName) LIKE '%' + upper(@KeyWord) + '%') or (upper(siItemCode) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by siCreatDate) itemNo,
          * from sy_SalaryItem where siStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(siItemName) LIKE '%' + upper(@KeyWord) + '%') or (upper(siItemCode) LIKE '%' + upper(@KeyWord) + '%')) ");
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

    public DataSet getInsuranceIdentity(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT COUNT(*) total from sy_InsuranceIdentity where iiStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(iiIdentityCode) LIKE '%' + upper(@KeyWord) + '%') or (upper(iiIdentity) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by iiCreatDate) itemNo,
          * from sy_InsuranceIdentity where iiStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(iiIdentityCode) LIKE '%' + upper(@KeyWord) + '%') or (upper(iiIdentity) LIKE '%' + upper(@KeyWord) + '%')) ");
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

    public DataSet getPersonnel(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT COUNT(*) total from sy_Person where perStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by perCreateDate) itemNo,perGuid,perNo,perName,comAbbreviate,cbName,code_desc
        from sy_Person 
        left join sy_Company on comGuid=perComGuid
        left join sy_CodeBranches on cbGuid=perDep
        left join sy_codetable on code_group='02' and code_value=perPosition
        where perStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
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

    public DataSet getFamilyList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT COUNT(*) total from sy_Person where perStatus<>'D' and perGuid=@perGuid ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by perCreateDate) itemNo,
        pfGuid,pfName,pfBirthday,pfTitle,pfIDNumber
        from sy_Person 
        left join sy_PersonFamily on pfPerGuid=perGuid and pfStatus<>'D'
        where perStatus<>'D' and perGuid=@perGuid ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@")#tmp where itemNo between @pStart and @pEnd ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oCmd.Parameters.AddWithValue("@pStart", pStart);
        oCmd.Parameters.AddWithValue("@pEnd", pEnd);
        oda.Fill(ds);
        return ds;
    }

    public DataSet getSubsidyLevel(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT COUNT(*) total from sy_SubsidyLevel where slStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(slSubsidyCode) LIKE '%' + upper(@KeyWord) + '%') or (upper(slSubsidyIdentity) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
          select ROW_NUMBER() over (order by slSubsidyCode,slCreatDate) itemNo,
          * from sy_SubsidyLevel where slStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(slSubsidyCode) LIKE '%' + upper(@KeyWord) + '%') or (upper(slSubsidyIdentity) LIKE '%' + upper(@KeyWord) + '%')) ");
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

    public DataSet getGroupInsList(string pStart, string pEnd)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT COUNT(*) total from sy_GroupInsurance where giStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(giInsuranceCode) LIKE '%' + upper(@KeyWord) + '%') or (upper(giInsuranceName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        sb.Append(@"select * from (
           select ROW_NUMBER() over (order by giCreatDate) itemNo,
        * from sy_GroupInsurance where giStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(giInsuranceCode) LIKE '%' + upper(@KeyWord) + '%') or (upper(giInsuranceName) LIKE '%' + upper(@KeyWord) + '%')) ");
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

    public DataTable checkPerson(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_Person
left join sy_CodeBranches on cbGuid=perDep
where perNo=@ckStr and perStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkComp(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_Company where (comAbbreviate=@ckStr or comUniform=@ckStr) and comStatus<>'D' ");

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

        sb.Append(@"SELECT * from sy_CodeBranches where cbValue=@ckStr and cbStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkSLevel(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_SubsidyLevel where slSubsidyCode=@ckStr and slStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPAllowance(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_SalaryItem where siItemCode=@ckStr and siStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }


    public DataTable checkInsuranceID(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_InsuranceIdentity where iiIdentityCode=@ckStr and iiStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkFamilyName(string ckStr,string perNo)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_Person
left join sy_PersonFamily on pfPerGuid=perGuid and pfName=@ckStr
where perNo=@perNo   and perStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@ckStr", ckStr);
        oCmd.Parameters.AddWithValue("@perNo", perNo);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkGroupIns(string ckStr)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_GroupInsurance where giInsuranceCode=@ckStr and giStatus<>'D' ");

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
perInsuranceID=@perInsuranceID,
perPensionIdentity=@perPensionIdentity,
perModifyId=@perModifyId,
perModifyDate=@perModifyDate
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
        oCmd.Parameters.AddWithValue("@perPensionIdentity", perPensionIdentity);
        oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

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
perSyAccount=@perSyAccount,
perModifyId=@perModifyId,
perModifyDate=@perModifyDate
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
        oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modBuckle()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_Person set
perReferenceNumber=@perReferenceNumber,
perDetentionRatio=@perDetentionRatio,
perDetentionFee=@perDetentionFee,
perMonthPayroll=@perMonthPayroll,
perYearEndBonuses=@perYearEndBonuses,
perModifyId=@perModifyId,
perModifyDate=@perModifyDate
where perGuid=@perGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oCmd.Parameters.AddWithValue("@perReferenceNumber", perReferenceNumber);
        oCmd.Parameters.AddWithValue("@perDetentionRatio", perDetentionRatio);
        oCmd.Parameters.AddWithValue("@perDetentionFee", perDetentionFee);
        oCmd.Parameters.AddWithValue("@perMonthPayroll", perMonthPayroll);
        oCmd.Parameters.AddWithValue("@perYearEndBonuses", perYearEndBonuses);
        oCmd.Parameters.AddWithValue("@perModifyId", perModifyId);
        oCmd.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getLHcode(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select comLaborProtectionCode,comHealthInsuranceCode from sy_Company
where comGuid=(select perComGuid from sy_Person where perGuid=@perGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable mutiPersonnel()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();


        sb.Append(@"select perGuid,perNo,perName,perComGuid,comAbbreviate,perDep,cbName from sy_Person
left join sy_Company on comGuid=perComGuid
left join sy_CodeBranches on cbGuid=perDep
where perStatus<>'D'
order by perComGuid,perDep ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();

        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oda.Fill(ds);
        return ds;
    }
}