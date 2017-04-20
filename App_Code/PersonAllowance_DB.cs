using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// PersonAllowance_DB 的摘要描述
/// </summary>
public class PersonAllowance_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string paGuid = string.Empty;
    string paPerGuid = string.Empty;
    string paAllowanceCode = string.Empty;
    decimal paCost;
    string paCreateId = string.Empty;
    string paModifyId = string.Empty;
    string paStatus = string.Empty;

    DateTime paCreateDate;
    DateTime paModifyDate;
    #endregion
    #region 公用
    public string _paGuid
    {
        set { paGuid = value; }
    }
    public string _paPerGuid
    {
        set { paPerGuid = value; }
    }
    public string _paAllowanceCode
    {
        set { paAllowanceCode = value; }
    }
    public decimal _paCost
    {
        set { paCost = value; }
    }
    public string _paCreateId
    {
        set { paCreateId = value; }
    }
    public string _paModifyId
    {
        set { paModifyId = value; }
    }
    public string _paStatus
    {
        set { paStatus = value; }
    }
    public DateTime _paCreateDate
    {
        set { paCreateDate = value; }
    }
    public DateTime _paModifyDate
    {
        set { paModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sv_PersonAllowance 
left join sy_SalaryItem on siGuid=paAllowanceCode
where paStatus<>'D' and paPerGuid=@paPerGuid ");

        sb.Append(@"order by paCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@paPerGuid", paPerGuid);
        oda.Fill(ds);
        return ds;
    }

    public void addPersonAllowance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sv_PersonAllowance (
paGuid,
paPerGuid,
paAllowanceCode,
paCost,
paCreateId,
paModifyId,
paModifyDate,
paStatus
) values (
@paGuid,
@paPerGuid,
@paAllowanceCode,
@paCost,
@paCreateId,
@paModifyId,
@paModifyDate,
@paStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@paGuid", paGuid);
        oCmd.Parameters.AddWithValue("@paPerGuid", paPerGuid);
        oCmd.Parameters.AddWithValue("@paAllowanceCode", paAllowanceCode);
        oCmd.Parameters.AddWithValue("@paCost", paCost);
        oCmd.Parameters.AddWithValue("@paCreateId", paCreateId);
        oCmd.Parameters.AddWithValue("@paModifyId", paModifyId);
        oCmd.Parameters.AddWithValue("@paModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@paStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modPersonAllowance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sv_PersonAllowance set
paAllowanceCode=@paAllowanceCode,
paCost=@paCost,
paModifyId=@paModifyId,
paModifyDate=@paModifyDate
where paGuid=@paGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@paGuid", paGuid);
        oCmd.Parameters.AddWithValue("@paAllowanceCode", paAllowanceCode);
        oCmd.Parameters.AddWithValue("@paCost", paCost);
        oCmd.Parameters.AddWithValue("@paModifyId", paModifyId);
        oCmd.Parameters.AddWithValue("@paModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void deletePersonAllowance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sv_PersonAllowance set paStatus='D' where paGuid=@paGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@paGuid", paGuid);
        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getPaByID()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sv_PersonAllowance where paGuid=@paGuid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@paGuid", paGuid);
        oda.Fill(ds);
        return ds;
    }
}