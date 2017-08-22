using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// FamilyInsurance_DB 的摘要描述
/// </summary>
public class FamilyInsurance_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string pfiGuid = string.Empty;
    string pfiPerGuid = string.Empty;
    string pfiPfGuid = string.Empty;
    string pfiChange = string.Empty;
    string pfiDropOutReason = string.Empty;
    string pfiChangeDate = string.Empty;
    string pfiSubsidyLevel = string.Empty;
    string pfiCardNo = string.Empty;
    string pfiAreaPerson = string.Empty;
    string pfiPs = string.Empty;
    string pfiCreateId = string.Empty;
    string pfiModifyId = string.Empty;
    string pfiStatus = string.Empty;

    DateTime pfiCreateDate;
    DateTime pfiModifyDate;
    #endregion
    #region 公用
    public string _pfiGuid
    {
        set { pfiGuid = value; }
    }
    public string _pfiPerGuid
    {
        set { pfiPerGuid = value; }
    }
    public string _pfiPfGuid
    {
        set { pfiPfGuid = value; }
    }
    public string _pfiChange
    {
        set { pfiChange = value; }
    }
    public string _pfiDropOutReason
    {
        set { pfiDropOutReason = value; }
    }
    public string _pfiChangeDate
    {
        set { pfiChangeDate = value; }
    }
    public string _pfiSubsidyLevel
    {
        set { pfiSubsidyLevel = value; }
    }
    public string _pfiCardNo
    {
        set { pfiCardNo = value; }
    }
    public string _pfiAreaPerson
    {
        set { pfiAreaPerson = value; }
    }
    public string _pfiPs
    {
        set { pfiPs = value; }
    }
    public string _pfiCreateId
    {
        set { pfiCreateId = value; }
    }
    public string _pfiModifyId
    {
        set { pfiModifyId = value; }
    }
    public string _pfiStatus
    {
        set { pfiStatus = value; }
    }
    public DateTime _pfiCreateDate
    {
        set { pfiCreateDate = value; }
    }
    public DateTime _pfiModifyDate
    {
        set { pfiModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT top 200 pfiGuid,pfiPerGuid,pfiPfGuid,perNo,perName,pfName,pfTitle
,slSubsidyCode,pfiChangeDate,pfiChange,code_desc
from sy_PersonFamilyInsurance
left join sy_Person on perGuid=pfiPerGuid
left join sy_PersonFamily on pfGuid=pfiPfGuid
left join sy_SubsidyLevel on slGuid=pfiSubsidyLevel
left join sy_codetable on code_group='14' and code_value=pfiChange
where pfiStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }
        if (pfiChange != "")
        {
            sb.Append(@"and pfiChange=@pfiChange ");
        }
            sb.Append(@"order by sy_PersonFamilyInsurance.pfiChangeDate desc,pfiCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pfiChange", pfiChange);
        oda.Fill(ds);
        return ds;
    }

    public void addFamilyIns()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonFamilyInsurance (
pfiGuid,
pfiPerGuid,
pfiPfGuid,
pfiChange,
pfiDropOutReason,
pfiChangeDate,
pfiSubsidyLevel,
pfiCardNo,
pfiAreaPerson,
pfiPs,
pfiCreateId,
pfiModifyDate,
pfiModifyId,
pfiStatus
) values (
@pfiGuid,
@pfiPerGuid,
@pfiPfGuid,
@pfiChange,
@pfiDropOutReason,
@pfiChangeDate,
@pfiSubsidyLevel,
@pfiCardNo,
@pfiAreaPerson,
@pfiPs,
@pfiCreateId,
@pfiModifyDate,
@pfiModifyId,
@pfiStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pfiGuid", pfiGuid);
        oCmd.Parameters.AddWithValue("@pfiPerGuid", pfiPerGuid);
        oCmd.Parameters.AddWithValue("@pfiPfGuid", pfiPfGuid);
        oCmd.Parameters.AddWithValue("@pfiChange", pfiChange);
        oCmd.Parameters.AddWithValue("@pfiDropOutReason", pfiDropOutReason);
        oCmd.Parameters.AddWithValue("@pfiChangeDate", pfiChangeDate);
        oCmd.Parameters.AddWithValue("@pfiSubsidyLevel", pfiSubsidyLevel);
        oCmd.Parameters.AddWithValue("@pfiCardNo", pfiCardNo);
        oCmd.Parameters.AddWithValue("@pfiAreaPerson", pfiAreaPerson);
        oCmd.Parameters.AddWithValue("@pfiPs", pfiPs);
        oCmd.Parameters.AddWithValue("@pfiCreateId", pfiCreateId);
        oCmd.Parameters.AddWithValue("@pfiModifyId", pfiModifyId);
        oCmd.Parameters.AddWithValue("@pfiModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@pfiStatus", pfiStatus);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modFamilyIns()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonFamilyInsurance set
pfiPerGuid=@pfiPerGuid,
pfiPfGuid=@pfiPfGuid,
pfiChange=@pfiChange,
pfiDropOutReason=@pfiDropOutReason,
pfiChangeDate=@pfiChangeDate,
pfiSubsidyLevel=@pfiSubsidyLevel,
pfiCardNo=@pfiCardNo,
pfiAreaPerson=@pfiAreaPerson,
pfiPs=@pfiPs,
pfiModifyId=@pfiModifyId,
pfiModifyDate=@pfiModifyDate
where pfiGuid=@pfiGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pfiGuid", pfiGuid);
        oCmd.Parameters.AddWithValue("@pfiPerGuid", pfiPerGuid);
        oCmd.Parameters.AddWithValue("@pfiPfGuid", pfiPfGuid);
        oCmd.Parameters.AddWithValue("@pfiChange", pfiChange);
        oCmd.Parameters.AddWithValue("@pfiDropOutReason", pfiDropOutReason);
        oCmd.Parameters.AddWithValue("@pfiChangeDate", pfiChangeDate);
        oCmd.Parameters.AddWithValue("@pfiSubsidyLevel", pfiSubsidyLevel);
        oCmd.Parameters.AddWithValue("@pfiCardNo", pfiCardNo);
        oCmd.Parameters.AddWithValue("@pfiAreaPerson", pfiAreaPerson);
        oCmd.Parameters.AddWithValue("@pfiPs", pfiPs);
        oCmd.Parameters.AddWithValue("@pfiModifyId", pfiModifyId);
        oCmd.Parameters.AddWithValue("@pfiModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deleteFamilyIns()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonFamilyInsurance set 
pfiStatus='D',
pfiModifyId=@pfiModifyId,
pfiModifyDate=@pfiModifyDate
where pfiGuid=@pfiGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pfiGuid", pfiGuid);
        oCmd.Parameters.AddWithValue("@pfiModifyId", pfiModifyId);
        oCmd.Parameters.AddWithValue("@pfiModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getFamilyInsByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonFamilyInsurance 
left join sy_Person on perGuid=pfiPerGuid
left join sy_PersonFamily on pfGuid=pfiPfGuid
left join sy_SubsidyLevel on slGuid=pfiSubsidyLevel
left join sy_CodeBranches on cbGuid=perDep
where  pfiStatus<>'D' and pfiGuid=@pfiGuid  ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pfiGuid", pfiGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable FamilyHeal_3in1_add(string pfGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode GanBorID,perPensionIdentity,
(select min(ilItem2) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem2<>0) minLaborLv,
(select min(ilItem4) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem4<>0) minInsLv,
pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate,iiIdentityCode,ppEmployerRatio,ppLarboRatio,ppChangeDate
from sy_PersonFamily 
left join sy_Person on pfPerGuid=perGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonFamilyInsurance on pfiChange='01' and pfiPfGuid=pfGuid and pfiStatus='A'
left join sy_PersonPension on ppChange='01' and ppStatus='A' and ppPerGuid=perGuid
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where pfGuid in (" + pfGuid + @") and pfStatus='A'
order by perIDNumber ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable FamilyHeal_3in1_out(string pfGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode GanBorID,perPensionIdentity,
(select min(ilItem2) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem2<>0) minLaborLv,
(select min(ilItem4) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem4<>0) minInsLv,
pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate,iiIdentityCode,pfiDropOutReason,code_desc DORStr
from sy_PersonFamily 
left join sy_Person on pfPerGuid=perGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonFamilyInsurance on pfiChange='02' and pfiPfGuid=pfGuid and pfiStatus='A'
	and pfiCreateDate=(select MAX(pfiCreateDate) from sy_PersonFamilyInsurance where pfiChange='02' and pfiPfGuid=pfGuid and pfiStatus='A')
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
left join sy_codetable on code_group='20' and code_value=pfiDropOutReason
where pfGuid in (" + pfGuid + @") and pfStatus='A'
order by perIDNumber ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable Pgi_Export(string pgiGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select pgiType,
(select cbName from sy_CodeBranches where cbStatus='I' and cbGuid=perDep) perDep,
perNo,perName,perIDNumber,perBirthday,
(select code_desc from sy_codetable where code_group='02' and code_value=perPosition) perPosition,perFirstDate,
CONVERT(VARCHAR(10),(SELECT DATEADD(month, 1, perFirstDate)),111) startDate,
(select code_desc from sy_codetable where code_group='17' and code_value=pfTitle) pfTitle,pfName,pfIDNumber,pfBirthday,pgiChangeDate
from sy_PersonGroupInsurance
left join sy_Person on pgiPerGuid=perGuid and perStatus='A'
left join sy_PersonFamily on pgiPfGuid=pfGuid and pfStatus='A' 
where pgiGuid in (" + pgiGuid + @") and pgiStatus='A'
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkLastStatus(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonFamilyInsurance where pfiStatus='A' and pfiPerGuid=@perGuid 
and pfiChangeDate=(select MAX(pfiChangeDate) from sy_PersonFamilyInsurance where pfiStatus='A' and pfiPerGuid=@perGuid) 
and pfiCreateDate=(select MAX(pfiCreateDate) from sy_PersonFamilyInsurance where pfiStatus='A' and pfiPerGuid=@perGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }
}