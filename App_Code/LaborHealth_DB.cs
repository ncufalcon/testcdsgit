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
plLaborPayroll,plChangeDate,comLaborProtectionCode
from sy_PersonLabor
left join sy_Person on perGuid=plPerGuid
left join sy_SubsidyLevel on slGuid=plSubsidyLevel
left join sy_codetable on code_group='11' and code_value=plChange
left join sy_Company on comGuid=perComGuid
where plStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
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

    public DataTable SelectHealList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT top 200 piGuid,piPerGuid,perNo,perName,piSubsidyLevel,slSubsidyCode,piCardNo,piChangeDate,piChange,code_desc,piInsurancePayroll,
piChangeDate,comHealthInsuranceCode
from sy_PersonInsurance 
left join sy_Person on perGuid=piPerGuid
left join sy_SubsidyLevel on slGuid=piSubsidyLevel
left join sy_codetable on code_group='12' and code_value=piChange
left join sy_Company on comGuid=perComGuid
where piStatus<>'D' ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(perNo) LIKE '%' + upper(@KeyWord) + '%') or (upper(perName) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
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

}