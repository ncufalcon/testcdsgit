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

    public DataTable LH_3in1_add(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,comLaborProtection1 LaborID1,comLaborProtection2 LaborID2,comHealthInsuranceCode GanBorID
,'' fID,'' fName,'' fBirth,'' fTitle,piChangeDate ChangeDate,ppEmployerRatio,ppLarboRatio,ppChangeDate,
(select min(ilItem2) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem2<>0) minLaborLv,
(select min(ilItem4) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem4<>0) minInsLv,
iiIdentityCode,perPensionIdentity
from sy_Person 
left join sy_Company on perComGuid=comGuid
left join sy_PersonInsurance on piChange='01' and piStatus='A' and piPerGuid=perGuid
left join sy_PersonPension on ppChange='01' and ppStatus='A' and ppPerGuid=perGuid
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where perGuid in (" + perGuid + @")
union
select perIDNumber,perName,perBirthday,perSex,comLaborProtection1,comLaborProtection2,comHealthInsuranceCode,pfIDNumber,pfName,pfBirthday,pfTitle,pfiChangeDate ChangeDate,0,0,'',0,0,'',''
from sy_PersonFamily 
left join sy_Person on pfPerGuid=perGuid
left join sy_Company on perComGuid=comGuid
left join sy_PersonFamilyInsurance on pfiChange='01' and pfiPfGuid=pfGuid and pfiStatus='A'
where pfPerGuid in (" + perGuid + @") and pfStatus='A'
order by perIDNumber,fID ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable LH_3in1_out(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,
comLaborProtection1,comLaborProtection2,comHealthInsuranceCode,
piChangeDate,
piDropOutReason,
code_desc DORStr,
plChangeDate
from sy_Person 
left join sy_PersonLabor on plChange='02' and plStatus='A' and plPerGuid=perGuid
left join sy_PersonInsurance on piChange='02' and piStatus='A' and piPerGuid=perGuid
left join sy_Company on comGuid=perComGuid
left join sy_codetable on code_group='20' and code_value=piDropOutReason
where perGuid in (" + perGuid + @")
order by plChangeDate desc,plCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable LH_2in1_add(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,perSex,perPensionIdentity,
comLaborProtection1,comLaborProtection2,ppEmployerRatio,ppLarboRatio,ppChangeDate,iiIdentityCode,
(select min(ilItem2) from sy_InsuranceLevel where ilEffectiveDate=(select MAX(ilEffectiveDate) from sy_InsuranceLevel) and ilItem2<>0) minLaborLv
from sy_Person 
left join sy_Company on perComGuid=comGuid
left join sy_PersonLabor on plChange='01' and plStatus='A' and plPerGuid=perGuid
left join sy_PersonPension on ppChange='01' and ppStatus='A' and ppPerGuid=perGuid
left join sy_InsuranceIdentity on perInsuranceDes=iiGuid
where perGuid in (" + perGuid + ") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable LH_2in1_out(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"select perIDNumber,perName,perBirthday,comLaborProtection1,comLaborProtection2
from sy_Person 
left join sy_PersonLabor on plChange='02' and plStatus='A' and plPerGuid=perGuid
left join sy_Company on perComGuid=comGuid
where perGuid in (" + perGuid + ") ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataSet LH_3in1_mod(string perGuid)
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"
declare @day_1 nvarchar(6);
declare @day_2 nvarchar(6);
declare @day_3 nvarchar(6);
select @day_1=(select CONVERT(varchar(6),DATEADD(MONTH, -1,GETDATE()),112));
select @day_2=(select CONVERT(varchar(6),DATEADD(MONTH, -2,GETDATE()),112));
select @day_3=(select CONVERT(varchar(6),DATEADD(MONTH, -3,GETDATE()),112));
--撈出連續三個月都有資料的人類guid
select perGuid 
into #tmp_perguid
from 
(
	select perGuid,COUNT(perName) as row_count from sy_PaySalaryDetail
	left join sy_PaySalaryMain on psmGuid=pPsmGuid
	left join sy_Person on perGuid=pPerGuid
	where psmYear in (@day_1,@day_2,@day_3) and pStatus='A'
	group by perGuid
)#tmp
where row_count=3

--撈出主檔guid
select perGuid,sum(pPay)/3 PayAvg,perName,perIDNumber,perBirthday,comHealthInsuranceCode GanborID,comLaborProtection1 LaborID1,comLaborProtection2 LaborID2 
from sy_PaySalaryDetail
left join sy_PaySalaryMain on psmGuid=pPsmGuid
left join sy_Person on perGuid=pPerGuid
left join sy_Company on comGuid=perComGuid
where psmYear in (@day_1,@day_2,@day_3) and perGuid in (select perGuid from #tmp_perguid) and pStatus='A' ");

        if (perGuid != "")
            sb.Append(@"and perGuid in (" + perGuid + ")");

        sb.Append(@"group by perGuid,perName,perIDNumber,perBirthday,comHealthInsuranceCode,comLaborProtection1,comLaborProtection2

select piPerGuid,piInsurancePayroll,piChange,piChangeDate,piCreateDate from sy_PersonInsurance 
where piPerGuid in (select perGuid from #tmp_perguid) and (piChange='01' or piChange='03')  and piStatus='A'
order by piChangeDate desc,piCreateDate desc

drop table #tmp_perguid 
");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataSet ds = new DataSet();
        //oCmd.Parameters.AddWithValue("@perGuid", perGuid);
        oda.Fill(ds);
        return ds;
    }

}