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
    string StartDate = string.Empty;
    string EndDate = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    public string _StartDate
    {
        set { StartDate = value; }
    }
    public string _EndDate
    {
        set { EndDate = value; }
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

        sb.Append(@"SELECT ");
        if (pfiChange == "")
            sb.Append(@"top 200 ");

        sb.Append(@"pfiGuid,pfiPerGuid,pfiPfGuid,perNo,perName,pfName,pfTitle
,slSubsidyCode,pfiChangeDate,pfiChange,code_desc
from sy_PersonFamilyInsurance
left join sy_Person on perGuid=pfiPerGuid
left join sy_PersonFamily on pfGuid=pfiPfGuid
left join sy_SubsidyLevel on slGuid=pfiSubsidyLevel
left join sy_codetable on code_group='14' and code_value=pfiChange
where pfiStatus<>'D' ");

        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%') or (upper(pfName) LIKE '%' + upper(@KeyWord) + '%')
 or (upper(pfIDNumber) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        if (pfiChange != "")
        {
            if (pfiChange == "02")
                sb.Append(@"and pfiChange='02' or pfiChange='03' ");
            else
                sb.Append(@"and pfiChange=@pfiChange ");
        }

        if (StartDate != "")
            sb.Append(@"and CONVERT(datetime,pfiChangeDate) >= CONVERT(datetime,@StartDate) ");
        if (EndDate != "")
            sb.Append(@"and CONVERT(datetime,pfiChangeDate) <= CONVERT(datetime,@EndDate) ");

        sb.Append(@"order by sy_PersonFamilyInsurance.pfiChangeDate desc,pfiCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pfiChange", pfiChange);
        oCmd.Parameters.AddWithValue("@StartDate", StartDate);
        oCmd.Parameters.AddWithValue("@EndDate", EndDate);
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

    public DataTable FamilyHeal_3in1_add(string pfiGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode GanBorID,perPensionIdentity,
plLaborPayroll,piInsurancePayroll,pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate,iiIdentityCode,ppEmployerRatio,ppLarboRatio,ppChangeDate
from sy_PersonFamilyInsurance 
left join sy_Person on perGuid=pfiPerGuid
left join sy_PersonFamily on pfGuid=pfiPfGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonLabor on (plChange='01' or plChange='03') and plStatus='A' and plPerGuid=perGuid
	and plChangeDate=(select MAX(plChangeDate) from sy_PersonLabor where (plChange='01' or plChange='03') and plStatus='A' and plPerGuid=perGuid)
	and plCreateDate=(select MAX(plCreateDate) from sy_PersonLabor where (plChange='01' or plChange='03') and plStatus='A' and plPerGuid=perGuid)	
left join sy_PersonInsurance on (piChange='01' or piChange='03' or piChange='05') and piStatus='A' and piPerGuid=perGuid
	and piCreateDate=(select MAX(piCreateDate) from sy_PersonInsurance where (piChange='01' or piChange='03' or piChange='05') and piStatus='A' and piPerGuid=perGuid)
	and piChangeDate=(select MAX(piChangeDate) from sy_PersonInsurance where (piChange='01' or piChange='03' or piChange='05') and piStatus='A' and piPerGuid=perGuid)
left join sy_PersonPension on (ppChange='01' or ppChange='02') and ppStatus='A' and ppPerGuid=perGuid
	and ppCreateDate=(select MAX(ppCreateDate) from sy_PersonPension where (ppChange='01' or ppChange='02') and ppStatus='A' and ppPerGuid=perGuid)
	and ppChangeDate=(select MAX(ppChangeDate) from sy_PersonPension where (ppChange='01' or ppChange='02') and ppStatus='A' and ppPerGuid=perGuid)
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where pfiGuid in (" + pfiGuid + @")
order by perIDNumber ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable FamilyHeal_3in1_out(string pfiGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode GanBorID,perPensionIdentity,
pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate,iiIdentityCode,pfiDropOutReason,a.code_desc DORStr1,b.code_desc DORStr2
from sy_PersonFamilyInsurance 
left join sy_Person on pfiPerGuid=perGuid
left join sy_PersonFamily on pfGuid=pfiPfGuid
left join sy_Company on perComGuid=comGuid
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
left join sy_codetable a on a.code_group='20' and a.code_value=pfiDropOutReason
left join sy_codetable b on b.code_group='21' and b.code_value=pfiDropOutReason
where pfiGuid in (" + pfiGuid + @") 
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
(select CONVERT(int,cbValue) from sy_CodeBranches where cbStatus<>'D' and cbGuid=perDep) DepCode,
(select cbName from sy_CodeBranches where cbStatus<>'D' and cbGuid=perDep) perDep,
perNo,perName,perIDNumber,perBirthday,
(select code_desc from sy_codetable where code_group='02' and code_value=perPosition) perPosition,perFirstDate,
(select code_desc from sy_codetable where code_group='17' and code_value=pfTitle) pfTitle,
(select code_value from sy_codetable where code_group='17' and code_value=pfTitle) TitleCode,
pfName,pfIDNumber,pfBirthday,pgiChange,pgiChangeDate
from sy_PersonGroupInsurance
left join sy_Person on pgiPerGuid=perGuid
left join sy_PersonFamily on pgiPfGuid=pfGuid
where pgiGuid in (" + pgiGuid + @")
order by pgiChange,DepCode,perNo,pgiType,TitleCode
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkLastStatus(string pfiPfGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonFamilyInsurance where pfiStatus='A' and pfiPfGuid=@pfiPfGuid 
and pfiChangeDate=(select MAX(pfiChangeDate) from sy_PersonFamilyInsurance where pfiStatus='A' and pfiPfGuid=@pfiPfGuid) 
and pfiCreateDate=(select MAX(pfiCreateDate) from sy_PersonFamilyInsurance where pfiStatus='A' and pfiPfGuid=@pfiPfGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pfiPfGuid", pfiPfGuid);
        oda.Fill(ds);
        return ds;
    }
}