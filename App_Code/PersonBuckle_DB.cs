using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// PersonBuckle_DB 的摘要描述
/// </summary>
public class PersonBuckle_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string pbGuid = string.Empty;
    string pbPerGuid = string.Empty;
    string pbCreditorNumber = string.Empty;
    string pbCreditor = string.Empty;
    decimal pbCreditorCost;
    string pbRatio = string.Empty;
    string pbIssued = string.Empty;
    string pbPayment = string.Empty;
    string pbIntoName = string.Empty;
    string pbIntoNumber = string.Empty;
    string pbIntoAccount = string.Empty;
    string pbContractor = string.Empty;
    string pbTel = string.Empty;
    decimal pbFee;
    string pbCreateId = string.Empty;
    string pbModifyId = string.Empty;
    string pbStatus = string.Empty;

    DateTime pbCreateDate;
    DateTime pbModifyDate;
    #endregion
    #region 公用
    public string _pbGuid
    {
        set { pbGuid = value; }
    }
    public string _pbPerGuid
    {
        set { pbPerGuid = value; }
    }
    public string _pbCreditorNumber
    {
        set { pbCreditorNumber = value; }
    }
    public string _pbCreditor
    {
        set { pbCreditor = value; }
    }
    public decimal _pbCreditorCost
    {
        set { pbCreditorCost = value; }
    }
    public string _pbRatio
    {
        set { pbRatio = value; }
    }
    public string _pbIssued
    {
        set { pbIssued = value; }
    }
    public string _pbPayment
    {
        set { pbPayment = value; }
    }
    public string _pbIntoName
    {
        set { pbIntoName = value; }
    }
    public string _pbIntoNumber
    {
        set { pbIntoNumber = value; }
    }
    public string _pbIntoAccount
    {
        set { pbIntoAccount = value; }
    }
    public string _pbContractor
    {
        set { pbContractor = value; }
    }
    public string _pbTel
    {
        set { pbTel = value; }
    }
    public decimal _pbFee
    {
        set { pbFee = value; }
    }
    public string _pbCreateId
    {
        set { pbCreateId = value; }
    }
    public string _pbModifyId
    {
        set { pbModifyId = value; }
    }
    public string _pbStatus
    {
        set { pbStatus = value; }
    }
    public DateTime _pbCreateDate
    {
        set { pbCreateDate = value; }
    }
    public DateTime _pbModifyDate
    {
        set { pbModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonBuckle where pbStatus<>'D' and pbPerGuid=@pbPerGuid ");
        if (KeyWord != "")
        {
            sb.Append(@"and ((upper(pbCreditor) LIKE '%' + upper(@KeyWord) + '%')) ");
        }

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@KeyWord", KeyWord);
        oCmd.Parameters.AddWithValue("@pbPerGuid", pbPerGuid);
        oda.Fill(ds);
        return ds;
    }

    public void addPersonBuckle()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonBuckle (
pbGuid,
pbPerGuid,
pbCreditor,
pbCreditorCost,
pbRatio,
pbIssued,
pbPayment,
pbIntoName,
pbIntoNumber,
pbIntoAccount,
pbContractor,
pbTel,
pbFee,
pbCreateId,
pbModifyId,
pbModifyDate,  
pbStatus
) values (
@pbGuid,
@pbPerGuid,
@pbCreditor,
@pbCreditorCost,
@pbRatio,
@pbIssued,
@pbPayment,
@pbIntoName,
@pbIntoNumber,
@pbIntoAccount,
@pbContractor,
@pbTel,
@pbFee,
@pbCreateId,
@pbModifyId,
@pbModifyDate,  
@pbStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pbGuid", pbGuid);
        oCmd.Parameters.AddWithValue("@pbPerGuid", pbPerGuid);
        oCmd.Parameters.AddWithValue("@pbCreditor", pbCreditor);
        oCmd.Parameters.AddWithValue("@pbCreditorCost", pbCreditorCost);
        oCmd.Parameters.AddWithValue("@pbRatio", pbRatio);
        oCmd.Parameters.AddWithValue("@pbIssued", pbIssued);
        oCmd.Parameters.AddWithValue("@pbPayment", pbPayment);
        oCmd.Parameters.AddWithValue("@pbIntoName", pbIntoName);
        oCmd.Parameters.AddWithValue("@pbIntoNumber", pbIntoNumber);
        oCmd.Parameters.AddWithValue("@pbIntoAccount", pbIntoAccount);
        oCmd.Parameters.AddWithValue("@pbContractor", pbContractor);
        oCmd.Parameters.AddWithValue("@pbTel", pbTel);
        oCmd.Parameters.AddWithValue("@pbFee", pbFee);
        oCmd.Parameters.AddWithValue("@pbCreateId", pbCreateId);
        oCmd.Parameters.AddWithValue("@pbModifyId", pbModifyId);
        oCmd.Parameters.AddWithValue("@pbModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@pbStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modPersonBuckle()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonBuckle set
pbCreditor=@pbCreditor,
pbCreditorCost=@pbCreditorCost,
pbRatio=@pbRatio,
pbIssued=@pbIssued,
pbPayment=@pbPayment,
pbIntoName=@pbIntoName,
pbIntoNumber=@pbIntoNumber,
pbIntoAccount=@pbIntoAccount,
pbContractor=@pbContractor,
pbTel=@pbTel,
pbFee=@pbFee,
pbModifyId=@pbModifyId,
pbModifyDate=@pbModifyDate
where pbGuid=@pbGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pbGuid", pbGuid);
        oCmd.Parameters.AddWithValue("@pbCreditor", pbCreditor);
        oCmd.Parameters.AddWithValue("@pbCreditorCost", pbCreditorCost);
        oCmd.Parameters.AddWithValue("@pbRatio", pbRatio);
        oCmd.Parameters.AddWithValue("@pbIssued", pbIssued);
        oCmd.Parameters.AddWithValue("@pbPayment", pbPayment);
        oCmd.Parameters.AddWithValue("@pbIntoName", pbIntoName);
        oCmd.Parameters.AddWithValue("@pbIntoNumber", pbIntoNumber);
        oCmd.Parameters.AddWithValue("@pbIntoAccount", pbIntoAccount);
        oCmd.Parameters.AddWithValue("@pbContractor", pbContractor);
        oCmd.Parameters.AddWithValue("@pbTel", pbTel);
        oCmd.Parameters.AddWithValue("@pbFee", pbFee);
        oCmd.Parameters.AddWithValue("@pbModifyId", pbModifyId);
        oCmd.Parameters.AddWithValue("@pbModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void deletePersonBuckle()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonBuckle set pbStatus='D' where pbGuid=@pbGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pbGuid", pbGuid);
        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getPbByID()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonBuckle where pbGuid=@pbGuid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pbGuid", pbGuid);
        oda.Fill(ds);
        return ds;
    }
}