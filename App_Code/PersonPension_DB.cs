using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// PersonPension 的摘要描述
/// </summary>
public class PersonPension_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string ppGuid = string.Empty;
    string ppPerGuid = string.Empty;
    string ppChange = string.Empty;
    string ppChangeDate = string.Empty;
    decimal ppLarboRatio;
    decimal ppEmployerRatio;
    decimal ppPayPayroll;
    string ppPs = string.Empty;
    string ppCreateId = string.Empty;
    string ppModifyId = string.Empty;
    string ppStatus = string.Empty;

    DateTime ppCreateDate;
    DateTime ppModifyDate;
    #endregion
    #region 公用
    public string _ppGuid
    {
        set { ppGuid = value; }
    }
    public string _ppPerGuid
    {
        set { ppPerGuid = value; }
    }
    public string _ppChange
    {
        set { ppChange = value; }
    }
    public string _ppChangeDate
    {
        set { ppChangeDate = value; }
    }
    public decimal _ppLarboRatio
    {
        set { ppLarboRatio = value; }
    }
    public decimal _ppEmployerRatio
    {
        set { ppEmployerRatio = value; }
    }
    public decimal _ppPayPayroll
    {
        set { ppPayPayroll = value; }
    }
    public string _ppPs
    {
        set { ppPs = value; }
    }
    public string _ppCreateId
    {
        set { ppCreateId = value; }
    }
    public string _ppModifyId
    {
        set { ppModifyId = value; }
    }
    public string _ppStatus
    {
        set { ppStatus = value; }
    }
    public DateTime _ppCreateDate
    {
        set { ppCreateDate = value; }
    }
    public DateTime _ppModifyDate
    {
        set { ppModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT top 200 ppGuid,ppPerGuid,perNo,perName,ppChangeDate,ppChange,code_desc,
ppLarboRatio,ppEmployerRatio,ppPayPayroll
from sy_PersonPension
left join sy_Person on perGuid=ppPerGuid
left join sy_codetable on code_group='13' and code_value=ppChange
where ppStatus<>'D' ");
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

    public void addPension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonPension (
ppGuid,
ppPerGuid,
ppChange,
ppChangeDate,
ppLarboRatio,
ppEmployerRatio,
ppPayPayroll,
ppPs,
ppCreateId,
ppModifyDate,
ppModifyId,
ppStatus
) values (
@ppGuid,
@ppPerGuid,
@ppChange,
@ppChangeDate,
@ppLarboRatio,
@ppEmployerRatio,
@ppPayPayroll,
@ppPs,
@ppCreateId,
@ppModifyDate,
@ppModifyId,
@ppStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oCmd.Parameters.AddWithValue("@ppPerGuid", ppPerGuid);
        oCmd.Parameters.AddWithValue("@ppChange", ppChange);
        oCmd.Parameters.AddWithValue("@ppChangeDate", ppChangeDate);
        oCmd.Parameters.AddWithValue("@ppLarboRatio", ppLarboRatio);
        oCmd.Parameters.AddWithValue("@ppEmployerRatio", ppEmployerRatio);
        oCmd.Parameters.AddWithValue("@ppPayPayroll", ppPayPayroll);
        oCmd.Parameters.AddWithValue("@ppPs", ppPs);
        oCmd.Parameters.AddWithValue("@ppCreateId", ppCreateId);
        oCmd.Parameters.AddWithValue("@ppModifyId", ppModifyId);
        oCmd.Parameters.AddWithValue("@ppModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@ppStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modPension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonPension set
ppPerGuid=@ppPerGuid,
ppChange=@ppChange,
ppChangeDate=@ppChangeDate,
ppLarboRatio=@ppLarboRatio,
ppEmployerRatio=@ppEmployerRatio,
ppPayPayroll=@ppPayPayroll,
ppPs=@ppPs,
ppModifyId=@ppModifyId,
ppModifyDate=@ppModifyDate
where ppGuid=@ppGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oCmd.Parameters.AddWithValue("@ppPerGuid", ppPerGuid);
        oCmd.Parameters.AddWithValue("@ppChange", ppChange);
        oCmd.Parameters.AddWithValue("@ppChangeDate", ppChangeDate);
        oCmd.Parameters.AddWithValue("@ppLarboRatio", ppLarboRatio);
        oCmd.Parameters.AddWithValue("@ppEmployerRatio", ppEmployerRatio);
        oCmd.Parameters.AddWithValue("@ppPayPayroll", ppPayPayroll);
        oCmd.Parameters.AddWithValue("@ppPs", ppPs);
        oCmd.Parameters.AddWithValue("@ppModifyId", ppModifyId);
        oCmd.Parameters.AddWithValue("@ppModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deletePension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonPension set 
ppStatus='D',
ppModifyId=@ppModifyId,
ppModifyDate=@ppModifyDate
where ppGuid=@ppGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oCmd.Parameters.AddWithValue("@ppModifyId", ppModifyId);
        oCmd.Parameters.AddWithValue("@ppModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getPensionByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonPension 
left join sy_Person on perGuid=ppPerGuid
where  ppStatus<>'D' and ppGuid=@ppGuid  ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@ppGuid", ppGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerPension()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonPension where ppPerGuid=@ppPerGuid and ppStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@ppPerGuid", ppPerGuid);
        oda.Fill(ds);
        return ds;
    }
}