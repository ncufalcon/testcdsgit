using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// LaborHealth_DB 的摘要描述
/// </summary>
public class LaborHealth_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 勞保私用
    string plGuid = string.Empty;
    string plPerGuid = string.Empty;
    string plSubsidyLevel = string.Empty;
    string plLaborNo = string.Empty;
    string plChangeDate = string.Empty;
    string plChange = string.Empty;
    decimal plLaborPayroll;
    string plPs = string.Empty;
    string plCreateId = string.Empty;
    string plModifyId = string.Empty;
    string plStatus = string.Empty;

    DateTime plCreateDate;
    DateTime plModifyDate;
    #endregion
    #region 勞保公用
    public string _plGuid
    {
        set { plGuid = value; }
    }
    public string _plPerGuid
    {
        set { plPerGuid = value; }
    }
    public string _plSubsidyLevel
    {
        set { plSubsidyLevel = value; }
    }
    public string _plLaborNo
    {
        set { plLaborNo = value; }
    }
    public string _plChangeDate
    {
        set { plChangeDate = value; }
    }
    public string _plChange
    {
        set { plChange = value; }
    }
    public decimal _plLaborPayroll
    {
        set { plLaborPayroll = value; }
    }
    public string _plPs
    {
        set { plPs = value; }
    }
    public string _plCreateId
    {
        set { plCreateId = value; }
    }
    public string _plModifyId
    {
        set { plModifyId = value; }
    }
    public string _plStatus
    {
        set { plStatus = value; }
    }
    public DateTime _plCreateDate
    {
        set { plCreateDate = value; }
    }
    public DateTime _plModifyDate
    {
        set { plModifyDate = value; }
    }
    #endregion
    #region 健保私用
    string piGuid = string.Empty;
    string piPerGuid = string.Empty;
    string piSubsidyLevel = string.Empty;
    string piCardNo = string.Empty;
    string piChangeDate = string.Empty;
    string piChange = string.Empty;
    string piDropOutReason = string.Empty;
    decimal piInsurancePayroll;
    string piPs = string.Empty;
    string piCreateId = string.Empty;
    string piModifyId = string.Empty;
    string piStatus = string.Empty;

    DateTime piCreateDate;
    DateTime piModifyDate;
    #endregion
    #region 健保公用
    public string _piGuid
    {
        set { piGuid = value; }
    }
    public string _piPerGuid
    {
        set { piPerGuid = value; }
    }
    public string _piSubsidyLevel
    {
        set { piSubsidyLevel = value; }
    }
    public string _piCardNo
    {
        set { piCardNo = value; }
    }
    public string _piChangeDate
    {
        set { piChangeDate = value; }
    }
    public string _piChange
    {
        set { piChange = value; }
    }
    public string _piDropOutReason
    {
        set { piDropOutReason = value; }
    }
    public decimal _piInsurancePayroll
    {
        set { piInsurancePayroll = value; }
    }
    public string _piPs
    {
        set { piPs = value; }
    }
    public string _piCreateId
    {
        set { piCreateId = value; }
    }
    public string _piModifyId
    {
        set { piModifyId = value; }
    }
    public string _piStatus
    {
        set { piStatus = value; }
    }
    public DateTime _piCreateDate
    {
        set { piCreateDate = value; }
    }
    public DateTime _piModifyDate
    {
        set { piModifyDate = value; }
    }
    #endregion

    public DataTable SelectLaborList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT top 200 plGuid,plPerGuid,perNo,perName,plSubsidyLevel,slSubsidyCode,plLaborNo,plChangeDate,plChange,code_desc,
plLaborPayroll,plChangeDate,plChangeDate,iiIdentity
from sy_PersonLabor
left join sy_Person on perGuid=plPerGuid
left join sy_SubsidyLevel on slGuid=plSubsidyLevel
left join sy_codetable on code_group='11' and code_value=plChange
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where plStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }
        if (plChange != "")
        {
            sb.Append(@"and plChange=@plChange ");
        }
        sb.Append(@"order by sy_PersonLabor.plChangeDate desc,plCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@plChange", plChange);
        oda.Fill(ds);
        return ds;
    }

    public void addLabor()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonLabor (
plGuid,
plPerGuid,
plSubsidyLevel,
plLaborNo,
plChangeDate,
plChange,
plLaborPayroll,
plPs,
plCreateId,
plModifyDate,
plModifyId,
plStatus
) values (
@plGuid,
@plPerGuid,
@plSubsidyLevel,
@plLaborNo,
@plChangeDate,
@plChange,
@plLaborPayroll,
@plPs,
@plCreateId,
@plModifyDate,
@plModifyId,
@plStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@plGuid", plGuid);
        oCmd.Parameters.AddWithValue("@plPerGuid", plPerGuid);
        oCmd.Parameters.AddWithValue("@plSubsidyLevel", plSubsidyLevel);
        oCmd.Parameters.AddWithValue("@plLaborNo", plLaborNo);
        oCmd.Parameters.AddWithValue("@plChangeDate", plChangeDate);
        oCmd.Parameters.AddWithValue("@plChange", plChange);
        oCmd.Parameters.AddWithValue("@plLaborPayroll", plLaborPayroll);
        oCmd.Parameters.AddWithValue("@plPs", plPs);
        oCmd.Parameters.AddWithValue("@plCreateId", plCreateId);
        oCmd.Parameters.AddWithValue("@plModifyId", plModifyId);
        oCmd.Parameters.AddWithValue("@plModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@plStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modLabor()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonLabor set
plPerGuid=@plPerGuid,
plSubsidyLevel=@plSubsidyLevel,
plLaborNo=@plLaborNo,
plChangeDate=@plChangeDate,
plChange=@plChange,
plLaborPayroll=@plLaborPayroll,
plPs=@plPs,
plModifyId=@plModifyId,
plModifyDate=@plModifyDate
where plGuid=@plGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@plGuid", plGuid);
        oCmd.Parameters.AddWithValue("@plPerGuid", plPerGuid);
        oCmd.Parameters.AddWithValue("@plSubsidyLevel", plSubsidyLevel);
        oCmd.Parameters.AddWithValue("@plLaborNo", plLaborNo);
        oCmd.Parameters.AddWithValue("@plChangeDate", plChangeDate);
        oCmd.Parameters.AddWithValue("@plChange", plChange);
        oCmd.Parameters.AddWithValue("@plLaborPayroll", plLaborPayroll);
        oCmd.Parameters.AddWithValue("@plPs", plPs);
        oCmd.Parameters.AddWithValue("@plModifyId", plModifyId);
        oCmd.Parameters.AddWithValue("@plModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deleteLabor()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonLabor set 
plStatus='D',
plModifyId=@plModifyId,
plModifyDate=@plModifyDate
where plGuid=@plGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@plGuid", plGuid);
        oCmd.Parameters.AddWithValue("@plModifyId", plModifyId);
        oCmd.Parameters.AddWithValue("@plModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getLaborByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonLabor 
left join sy_Person on perGuid=plPerGuid
left join sy_SubsidyLevel on slGuid=plSubsidyLevel
left join sy_CodeBranches on cbGuid=perDep
where  plStatus<>'D' and plGuid=@plGuid  ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@plGuid", plGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerLabor()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonLabor where plPerGuid=@plPerGuid and plStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@plPerGuid", plPerGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable SelectHealList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT top 200 piGuid,piPerGuid,perNo,perName,piSubsidyLevel,slSubsidyCode,piCardNo,piChangeDate,piChange,code_desc,piInsurancePayroll,
piChangeDate
from sy_PersonInsurance 
left join sy_Person on perGuid=piPerGuid
left join sy_SubsidyLevel on slGuid=piSubsidyLevel
left join sy_codetable on code_group='12' and code_value=piChange
where piStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }
        if (piChange != "")
        {
            if (piChange == "02")
                sb.Append(@"and (piChange='02' or piChange='04' or piChange='06' or piChange='07') ");
            else
                sb.Append(@"and piChange=@piChange ");
        }
        sb.Append(@"order by sy_PersonInsurance.piChangeDate desc,piCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@piChange", piChange);
        oda.Fill(ds);
        return ds;
    }

    public void addHeal()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonInsurance (
piGuid,
piPerGuid,
piSubsidyLevel,
piCardNo,
piChangeDate,
piChange,
piDropOutReason,
piInsurancePayroll,
piPs,
piCreateId,
piModifyDate,
piModifyId,
piStatus
) values (
@piGuid,
@piPerGuid,
@piSubsidyLevel,
@piCardNo,
@piChangeDate,
@piChange,
@piDropOutReason,
@piInsurancePayroll,
@piPs,
@piCreateId,
@piModifyDate,
@piModifyId,
@piStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@piGuid", piGuid);
        oCmd.Parameters.AddWithValue("@piPerGuid", piPerGuid);
        oCmd.Parameters.AddWithValue("@piSubsidyLevel", piSubsidyLevel);
        oCmd.Parameters.AddWithValue("@piCardNo", piCardNo);
        oCmd.Parameters.AddWithValue("@piChangeDate", piChangeDate);
        oCmd.Parameters.AddWithValue("@piChange", piChange);
        oCmd.Parameters.AddWithValue("@piDropOutReason", piDropOutReason);
        oCmd.Parameters.AddWithValue("@piInsurancePayroll", piInsurancePayroll);
        oCmd.Parameters.AddWithValue("@piPs", piPs);
        oCmd.Parameters.AddWithValue("@piCreateId", piCreateId);
        oCmd.Parameters.AddWithValue("@piModifyId", piModifyId);
        oCmd.Parameters.AddWithValue("@piModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@piStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modHeal()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonInsurance set
piPerGuid=@piPerGuid,
piSubsidyLevel=@piSubsidyLevel,
piCardNo=@piCardNo,
piChangeDate=@piChangeDate,
piChange=@piChange,
piDropOutReason=@piDropOutReason,
piInsurancePayroll=@piInsurancePayroll,
piPs=@piPs,
piModifyId=@piModifyId,
piModifyDate=@piModifyDate
where piGuid=@piGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@piGuid", piGuid);
        oCmd.Parameters.AddWithValue("@piPerGuid", piPerGuid);
        oCmd.Parameters.AddWithValue("@piSubsidyLevel", piSubsidyLevel);
        oCmd.Parameters.AddWithValue("@piCardNo", piCardNo);
        oCmd.Parameters.AddWithValue("@piChangeDate", piChangeDate);
        oCmd.Parameters.AddWithValue("@piChange", piChange);
        oCmd.Parameters.AddWithValue("@piDropOutReason", piDropOutReason);
        oCmd.Parameters.AddWithValue("@piInsurancePayroll", piInsurancePayroll);
        oCmd.Parameters.AddWithValue("@piPs", piPs);
        oCmd.Parameters.AddWithValue("@piModifyId", piModifyId);
        oCmd.Parameters.AddWithValue("@piModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deleteHeal()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonInsurance set 
piStatus='D',
piModifyId=@piModifyId,
piModifyDate=@piModifyDate
where piGuid=@piGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@piGuid", piGuid);
        oCmd.Parameters.AddWithValue("@piModifyId", piModifyId);
        oCmd.Parameters.AddWithValue("@piModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getHealByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonInsurance 
left join sy_Person on perGuid=piPerGuid
left join sy_SubsidyLevel on slGuid=piSubsidyLevel
left join sy_CodeBranches on cbGuid=perDep
where  piStatus<>'D' and piGuid=@piGuid  ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@piGuid", piGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerHeal()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonInsurance where piPerGuid=@piPerGuid and piStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@piPerGuid", piPerGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable L_3in1_add(string itemGv)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@" select plPerGuid into #tmp 
 from
 (
	select plPerGuid from sy_PersonLabor where plGuid in ("+ itemGv + @")
 )#tmp

select perIDNumber,perName,perBirthday,perSex,comLaborProtection1 LaborID1,comLaborProtection2 LaborID2,comHealthInsuranceCode GanBorID
,'' fID,'' fName,'' fBirth,'' fTitle,piChangeDate ChangeDate,ppEmployerRatio,ppLarboRatio,ppChangeDate,plLaborPayroll,piInsurancePayroll,
iiIdentityCode,perPensionIdentity,plChangeDate
from sy_PersonLabor
left join sy_Person on perGuid=plPerGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonInsurance on (piChange='01' or piChange='05') and piStatus='A' and piPerGuid=perGuid 
	and piChangeDate=(select MAX(piChangeDate) from sy_PersonInsurance where (piChange='01' or piChange='05') and piStatus='A' and piPerGuid=perGuid)
	and piCreateDate=(select MAX(piCreateDate) from sy_PersonInsurance where (piChange='01' or piChange='05') and piStatus='A' and piPerGuid=perGuid)
left join sy_PersonPension on ppChange='01' and ppStatus='A' and ppPerGuid=perGuid 
	and ppChangeDate=(select MAX(ppChangeDate) from sy_PersonPension where ppChange='01' and ppStatus='A' and ppPerGuid=perGuid)
	and ppCreateDate=(select MAX(ppCreateDate) from sy_PersonPension where ppChange='01' and ppStatus='A' and ppPerGuid=perGuid)
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where plGuid in (" + itemGv + @")
union
select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode,pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate ChangeDate,0,0,'',
'0','0','','',''
from sy_PersonFamilyInsurance 
left join sy_Person on pfiPerGuid=perGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonFamily on pfPerGuid=perGuid and pfStatus='A'
where pfiPerGuid in (select * from #tmp) and pfiChange='01' and pfiPfGuid=pfGuid and pfiStatus='A' 
and pfiChangeDate=(select MAX(pfiChangeDate) from sy_PersonFamilyInsurance where pfiPfGuid=pfGuid and pfiStatus='A')
and pfiCreateDate=(select MAX(pfiCreateDate) from sy_PersonFamilyInsurance where pfiPfGuid=pfGuid and pfiStatus='A')
order by perIDNumber,fID
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable H_3in1_add(string itemGv)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@" 
 select piPerGuid into #tmp 
 from
 (
	select piPerGuid from sy_PersonInsurance where piGuid in (" + itemGv + @")
 )#tmp

select perIDNumber,perName,perBirthday,perSex,comLaborProtection1 LaborID1,comLaborProtection2 LaborID2,comHealthInsuranceCode GanBorID
,'' fID,'' fName,'' fBirth,'' fTitle,piChangeDate ChangeDate,ppEmployerRatio,ppLarboRatio,ppChangeDate,plLaborPayroll,piInsurancePayroll,
iiIdentityCode,perPensionIdentity,plChangeDate
from sy_PersonInsurance
left join sy_Person on perGuid=piPerGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonLabor on plChange='01' and plStatus='A' and plPerGuid=perGuid 
	and plChangeDate=(select MAX(plChangeDate) from sy_PersonLabor where plChange='01' and plStatus='A' and plPerGuid=perGuid)
	and plCreateDate=(select MAX(plCreateDate) from sy_PersonLabor where plChange='01' and plStatus='A' and plPerGuid=perGuid)
left join sy_PersonPension on ppChange='01' and ppStatus='A' and ppPerGuid=perGuid 
	and ppChangeDate=(select MAX(ppChangeDate) from sy_PersonPension where ppChange='01' and ppStatus='A' and ppPerGuid=perGuid)
	and ppCreateDate=(select MAX(ppCreateDate) from sy_PersonPension where ppChange='01' and ppStatus='A' and ppPerGuid=perGuid)
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where piGuid in (" + itemGv + @")
union
select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode,pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate ChangeDate,0,0,'',
'0','0','','',''
from sy_PersonFamilyInsurance 
left join sy_Person on pfiPerGuid=perGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonFamily on pfPerGuid=perGuid and pfStatus='A'
where pfiPerGuid in (select * from #tmp) and pfiChange='01'and pfiPfGuid=pfGuid and pfiStatus='A' 
and pfiChangeDate=(select MAX(pfiChangeDate) from sy_PersonFamilyInsurance where pfiPfGuid=pfGuid and pfiStatus='A')
and pfiCreateDate=(select MAX(pfiCreateDate) from sy_PersonFamilyInsurance where pfiPfGuid=pfGuid and pfiStatus='A')
order by perIDNumber,fID

drop table #tmp
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable H_3in1_out(string itemGv)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,
comLaborProtection1,comLaborProtection2,comHealthInsuranceCode,
piChangeDate,
piDropOutReason,
a.code_desc DORStr1,
b.code_desc DORStr2,
plChangeDate
from sy_PersonInsurance 
left join sy_Person on perGuid=piPerGuid
left join sy_PersonLabor on (plChange='02' or plChange='04') and plStatus='A' and plPerGuid=perGuid
	and plCreateDate=(select MAX(plCreateDate) from sy_PersonLabor where (plChange='02' or plChange='04') and plStatus='A' and plPerGuid=perGuid)
	and plChangeDate=(select MAX(plChangeDate) from sy_PersonLabor where (plChange='02' or plChange='04') and plStatus='A' and plPerGuid=perGuid)
left join sy_Company on comGuid=perComGuid
left join sy_codetable a on a.code_group='20' and a.code_value=piDropOutReason
left join sy_codetable b on b.code_group='21' and b.code_value=piDropOutReason
where piGuid in (" + itemGv + @")
order by piChangeDate desc,piCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable L_3in1_out(string itemGv)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,
comLaborProtection1,comLaborProtection2,comHealthInsuranceCode,
piChangeDate,
piDropOutReason,
a.code_desc DORStr1,
b.code_desc DORStr2,
plChangeDate
from sy_PersonLabor 
left join sy_Person on perGuid=plPerGuid
left join sy_PersonInsurance on (piChange='02' or piChange='04' or piChange='06' or piChange='07') and piStatus='A' and piPerGuid=perGuid
	and piCreateDate=(select MAX(piCreateDate) from sy_PersonInsurance where (piChange='02' or piChange='04' or piChange='06' or piChange='07') and piStatus='A' and piPerGuid=perGuid)
	and piChangeDate=(select MAX(piChangeDate) from sy_PersonInsurance where (piChange='02' or piChange='04' or piChange='06' or piChange='07') and piStatus='A' and piPerGuid=perGuid)
left join sy_Company on comGuid=perComGuid
left join sy_codetable a on a.code_group='20' and a.code_value=piDropOutReason
left join sy_codetable b on b.code_group='21' and b.code_value=piDropOutReason
where plGuid in (" + itemGv + @")
order by plChangeDate desc,plCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable L_2in1_add(string itemGv)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,perPensionIdentity,
comLaborProtection1,comLaborProtection2,ppEmployerRatio,ppLarboRatio,ppChangeDate,iiIdentityCode,plLaborPayroll,plChangeDate
from sy_PersonLabor
left  join sy_Person on perGuid=plPerGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonPension on ppChange='01' and ppStatus='A' and ppPerGuid=perGuid
	and ppCreateDate=(select MAX(ppCreateDate) from sy_PersonPension where ppChange='01' and ppStatus='A' and ppPerGuid=perGuid)
	and ppChangeDate=(select MAX(ppChangeDate) from sy_PersonPension where ppChange='01' and ppStatus='A' and ppPerGuid=perGuid)
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where plGuid in (" + itemGv + ") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }
    
    public DataTable L_2in1_out(string itemGv)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,comLaborProtection1,comLaborProtection2
from sy_PersonLabor 
left join sy_Person on perGuid=plPerGuid
left join sy_Company on perComGuid=comGuid
where plGuid in (" + itemGv + ") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }
    
    public DataSet LH_3in1_mod(string itemGv,string category)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        if (category == "L")
        {
            sb.Append(@"select plPerGuid into #tmp_ItemPerGuid
            from 
            (
            select plPerGuid from sy_PersonLabor where plGuid in (" + itemGv + @") 
            )#tmp ");
        }
        else
        {
            sb.Append(@"select piPerGuid into #tmp_ItemPerGuid
            from 
            (
            select piPerGuid from sy_PersonInsurance where piGuid in (" + itemGv + @") 
            )#tmp ");
        }
        sb.Append(@"
--Top 3 計薪週期
select psmGuid 
into #tmp_psmguid
from 
(
	select psmGuid from sy_PaySalaryMain where 
	psmSalaryRange in (select top 3 sr_Guid from sy_SalaryRange where sr_Status='A' order by sr_BeginDate desc)
)#tmp2

--撈出連續三個月都有資料的人類guid
select perGuid 
into #tmp_perguid
from 
(
	select perGuid,COUNT(perName) as row_count from sy_PaySalaryDetail
	left join sy_PaySalaryMain on psmGuid=pPsmGuid
	left join sy_Person on perGuid=pPerGuid
	where pPsmGuid in (select * from #tmp_psmguid) and pStatus='A'
	group by perGuid
)#tmp3
where row_count>=3

--撈出主檔guid
select perGuid,sum(pPay)/3 PayAvg,perName,perIDNumber,perBirthday,comHealthInsuranceCode GanborID,comLaborProtection1 LaborID1,comLaborProtection2 LaborID2 
from sy_PaySalaryDetail
left join sy_PaySalaryMain on psmGuid=pPsmGuid
left join sy_Person on perGuid=pPerGuid
left join sy_Company on comGuid=perComGuid
where pPsmGuid in (select * from #tmp_psmguid) and perGuid in (select perGuid from #tmp_perguid) and pStatus='A'

        and perGuid in (select * from #tmp_ItemPerGuid)

group by perGuid,perName,perIDNumber,perBirthday,comHealthInsuranceCode,comLaborProtection1,comLaborProtection2

select piPerGuid,piInsurancePayroll,piChange,piChangeDate,piCreateDate from sy_PersonInsurance 
where piPerGuid in (select * from #tmp_ItemPerGuid) and (piChange='01' or piChange='03')  and piStatus='A'
order by piChangeDate desc,piCreateDate desc

drop table #tmp_psmguid 
drop table #tmp_perguid 
drop table #tmp_ItemPerGuid   ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }


    public DataTable checkLaborLastStatus(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonLabor where plStatus='A' and plPerGuid=@perGuid 
and plChangeDate=(select MAX(plChangeDate) from sy_PersonLabor where plStatus='A' and plPerGuid=@perGuid) 
and plCreateDate=(select MAX(plCreateDate) from sy_PersonLabor where plStatus='A' and plPerGuid=@perGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkInsLastStatus(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select * from sy_PersonInsurance where piStatus='A' and piPerGuid=@perGuid 
and piChangeDate=(select MAX(piChangeDate) from sy_PersonInsurance where piStatus='A' and piPerGuid=@perGuid) 
and piCreateDate=(select MAX(piCreateDate) from sy_PersonInsurance where piStatus='A' and piPerGuid=@perGuid) ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable getDelInsSalary(string changedate,string sortName, string sortMethod)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select plGuid gv,perGuid,perNo,perName,
(select cbName from sy_CodeBranches where cbGuid=perDep) perDep,
plLaborPayroll Pay,plChangeDate ChangeDate,'L' TypeName,'勞保' cnName
from sy_PersonLabor
left join sy_Person on plPerGuid=perGuid
where perGuid=plPerGuid and plChange='03' and plChangeDate=@changedate 
	and (select MAX(plCreateDate) from sy_PersonLabor where perGuid=plPerGuid)=plCreateDate and plStatus='A'
union
select piGuid gv,perGuid,perNo,perName,
(select cbName from sy_CodeBranches where cbGuid=perDep) perDep,
piInsurancePayroll Pay,piChangeDate ChangeDate,'H' TypeName,'健保' cnName
from sy_PersonInsurance
left join sy_Person on piPerGuid=perGuid
where perGuid=piPerGuid and piChange='03' and piChangeDate=@changedate 
	and (select MAX(piCreateDate) from sy_PersonInsurance where perGuid=piPerGuid)=piCreateDate and piStatus='A'
union
select ppGuid gv,perGuid,perNo,perName,
(select cbName from sy_CodeBranches where cbGuid=perDep) perDep,
ppPayPayroll Pay,ppChangeDate ChangeDate,'P' TypeName,'勞退' cnName
from sy_PersonPension
left join sy_Person on ppPerGuid=perGuid
where perGuid=ppPerGuid and ppChange='02' and ppChangeDate=@changedate 
	and (select MAX(ppCreateDate) from sy_PersonPension where perGuid=ppPerGuid)=ppCreateDate and ppStatus='A' ");
        sb.Append(@"order by " + sortName + " " + sortMethod + " ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@changedate", changedate);
        oda.Fill(ds);
        return ds;
    }
}