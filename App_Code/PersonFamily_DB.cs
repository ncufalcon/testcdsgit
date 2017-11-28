using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// PersonFamily_DB 的摘要描述
/// </summary>
public class PersonFamily_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string pfGuid = string.Empty;
    string pfPerGuid = string.Empty;
    string pfName = string.Empty;
    string pfTitle = string.Empty;
    string pfBirthday = string.Empty;
    string pfIDNumber = string.Empty;
    string pfHealthInsurance = string.Empty;
    string pfCode = string.Empty;
    string pfGroupInsurance = string.Empty;
    string pfCreateId = string.Empty;
    string pfModifyId = string.Empty;
    string pfStatus = string.Empty;

    DateTime pfCreateDate;
    DateTime pfModifyDate;
    #endregion
    #region 公用
    public string _pfGuid
    {
        set { pfGuid = value; }
    }
    public string _pfPerGuid
    {
        set { pfPerGuid = value; }
    }
    public string _pfName
    {
        set { pfName = value; }
    }
    public string _pfTitle
    {
        set { pfTitle = value; }
    }
    public string _pfBirthday
    {
        set { pfBirthday = value; }
    }
    public string _pfIDNumber
    {
        set { pfIDNumber = value; }
    }
    public string _pfHealthInsurance
    {
        set { pfHealthInsurance = value; }
    }
    public string _pfCode
    {
        set { pfCode = value; }
    }
    public string _pfGroupInsurance
    {
        set { pfGroupInsurance = value; }
    }
    public string _pfCreateId
    {
        set { pfCreateId = value; }
    }
    public string _pfModifyId
    {
        set { pfModifyId = value; }
    }
    public string _pfStatus
    {
        set { pfStatus = value; }
    }
    public DateTime _pfCreateDate
    {
        set { pfCreateDate = value; }
    }
    public DateTime _pfModifyDate
    {
        set { pfModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonFamily
left join sy_SubsidyLevel on slGuid=pfCode
left join sy_codetable on code_group='17' and code_value=pfTitle
where pfStatus<>'D' and pfPerGuid=@pfPerGuid ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(pfName) LIKE '%' + upper(@KeyWord) + '%') or (upper(pfIDNumber) LIKE '%' + upper(@KeyWord) + '%')) ");
        }
        sb.Append(@"order by pfCreateDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pfPerGuid", pfPerGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable getPFByID()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonFamily
left join sy_SubsidyLevel on slGuid=pfCode
where pfGuid=@pfGuid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pfGuid", pfGuid);
        oda.Fill(ds);
        return ds;
    }

    public void addPersonFamily()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonFamily (
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
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pfGuid", pfGuid);
        oCmd.Parameters.AddWithValue("@pfPerGuid", pfPerGuid);
        oCmd.Parameters.AddWithValue("@pfName", pfName);
        oCmd.Parameters.AddWithValue("@pfTitle", pfTitle);
        oCmd.Parameters.AddWithValue("@pfBirthday", pfBirthday);
        oCmd.Parameters.AddWithValue("@pfIDNumber", pfIDNumber);
        oCmd.Parameters.AddWithValue("@pfHealthInsurance", pfHealthInsurance);
        oCmd.Parameters.AddWithValue("@pfCode", pfCode);
        oCmd.Parameters.AddWithValue("@pfGroupInsurance", pfGroupInsurance);
        oCmd.Parameters.AddWithValue("@pfCreateId", pfCreateId);
        oCmd.Parameters.AddWithValue("@pfModifyId", pfModifyId);
        oCmd.Parameters.AddWithValue("@pfModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@pfStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modPersonFamily()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonFamily set
pfName=@pfName,
pfTitle=@pfTitle,
pfBirthday=@pfBirthday,
pfIDNumber=@pfIDNumber,
pfHealthInsurance=@pfHealthInsurance,
pfCode=@pfCode,
pfGroupInsurance=@pfGroupInsurance,
pfModifyId=@pfModifyId,
pfModifyDate=@pfModifyDate
where pfGuid=@pfGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pfGuid", pfGuid);
        oCmd.Parameters.AddWithValue("@pfName", pfName);
        oCmd.Parameters.AddWithValue("@pfTitle", pfTitle);
        oCmd.Parameters.AddWithValue("@pfBirthday", pfBirthday);
        oCmd.Parameters.AddWithValue("@pfIDNumber", pfIDNumber);
        oCmd.Parameters.AddWithValue("@pfHealthInsurance", pfHealthInsurance);
        oCmd.Parameters.AddWithValue("@pfCode", pfCode);
        oCmd.Parameters.AddWithValue("@pfGroupInsurance", pfGroupInsurance);
        oCmd.Parameters.AddWithValue("@pfModifyId", pfModifyId);
        oCmd.Parameters.AddWithValue("@pfModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void deletePersonFamily()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonFamily set pfStatus='D' where pfGuid=@pfGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pfGuid", pfGuid);
        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable checkPFbyIDNum()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonFamily with (nolock) where pfIDNumber=@pfIDNumber and pfStatus='A' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pfIDNumber", pfIDNumber);
        oda.Fill(ds);
        return ds;
    }
}