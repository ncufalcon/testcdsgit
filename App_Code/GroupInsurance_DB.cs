using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// GroupInsurance_DB 的摘要描述
/// </summary>
public class GroupInsurance_DB
{
    string KeyWord = string.Empty;
    public string _KeyWord
    {
        set { KeyWord = value; }
    }
    #region 私用
    string pgiGuid = string.Empty;
    string pgiPerGuid = string.Empty;
    string pgiPfGuid = string.Empty;
    string pgiType = string.Empty;
    string pgiChange = string.Empty;
    string pgiChangeDate = string.Empty;
    string pgiInsuranceCode = string.Empty;
    string pgiPs = string.Empty;
    string pgiCreateId = string.Empty;
    string pgiModifyId = string.Empty;
    string pgiStatus = string.Empty;

    DateTime pgiCreateDate;
    DateTime pgiModifyDate;
    #endregion
    #region 公用
    public string _pgiGuid
    {
        set { pgiGuid = value; }
    }
    public string _pgiPerGuid
    {
        set { pgiPerGuid = value; }
    }
    public string _pgiPfGuid
    {
        set { pgiPfGuid = value; }
    }
    public string _pgiType
    {
        set { pgiType = value; }
    }
    public string _pgiChange
    {
        set { pgiChange = value; }
    }
    public string _pgiChangeDate
    {
        set { pgiChangeDate = value; }
    }
    public string _pgiInsuranceCode
    {
        set { pgiInsuranceCode = value; }
    }
    public string _pgiPs
    {
        set { pgiPs = value; }
    }
    public string _pgiCreateId
    {
        set { pgiCreateId = value; }
    }
    public string _pgiModifyId
    {
        set { pgiModifyId = value; }
    }
    public string _pgiStatus
    {
        set { pgiStatus = value; }
    }
    public DateTime _pgiCreateDate
    {
        set { pgiCreateDate = value; }
    }
    public DateTime _pgiModifyDate
    {
        set { pgiModifyDate = value; }
    }
    #endregion

    public DataTable SelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT top 200 pgiGuid,pgiPerGuid,pgiPfGuid,perNo,perName,pfName,pfTitle
,pgiInsuranceCode,pgiType,pgiChangeDate,code_desc
from sy_PersonGroupInsurance
left join sy_Person on perGuid=pgiPerGuid
left join sy_PersonFamily on pfGuid=pgiPfGuid
left join sy_GroupInsurance on giGuid=pgiInsuranceCode
left join sy_codetable on code_group='14' and code_value=pgiChange
where pgiStatus<>'D' order by sy_PersonGroupInsurance.pgiChangeDate desc ");
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

    public void addGroupInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"insert into sy_PersonGroupInsurance (
pgiGuid,
pgiPerGuid,
pgiPfGuid,
pgiType,
pgiChange,
pgiChangeDate,
pgiInsuranceCode,
pgiPs,
pgiCreateId,
pgiModifyDate,
pgiModifyId,
pgiStatus
) values (
@pgiGuid,
@pgiPerGuid,
@pgiPfGuid,
@pgiType,
@pgiChange,
@pgiChangeDate,
@pgiInsuranceCode,
@pgiPs,
@pgiCreateId,
@pgiModifyDate,
@pgiModifyId,
@pgiStatus
) ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oCmd.Parameters.AddWithValue("@pgiPerGuid", pgiPerGuid);
        oCmd.Parameters.AddWithValue("@pgiPfGuid", pgiPfGuid);
        oCmd.Parameters.AddWithValue("@pgiType", pgiType);
        oCmd.Parameters.AddWithValue("@pgiChange", pgiChange);
        oCmd.Parameters.AddWithValue("@pgiChangeDate", pgiChangeDate);
        oCmd.Parameters.AddWithValue("@pgiInsuranceCode", pgiInsuranceCode);
        oCmd.Parameters.AddWithValue("@pgiPs", pgiPs);
        oCmd.Parameters.AddWithValue("@pgiCreateId", pgiCreateId);
        oCmd.Parameters.AddWithValue("@pgiModifyId", pgiModifyId);
        oCmd.Parameters.AddWithValue("@pgiModifyDate", DateTime.Now);
        oCmd.Parameters.AddWithValue("@pgiStatus", "A");

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public void modGroupInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonGroupInsurance set
pgiPerGuid=@pgiPerGuid,
pgiPfGuid=@pgiPfGuid,
pgiType=@pgiType,
pgiChange=@pgiChange,
pgiChangeDate=@pgiChangeDate,
pgiInsuranceCode=@pgiInsuranceCode,
pgiPs=@pgiPs,
pgiModifyId=@pgiModifyId,
pgiModifyDate=@pgiModifyDate
where pgiGuid=@pgiGuid
";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oCmd.Parameters.AddWithValue("@pgiPerGuid", pgiPerGuid);
        oCmd.Parameters.AddWithValue("@pgiPfGuid", pgiPfGuid);
        oCmd.Parameters.AddWithValue("@pgiType", pgiType);
        oCmd.Parameters.AddWithValue("@pgiChange", pgiChange);
        oCmd.Parameters.AddWithValue("@pgiChangeDate", pgiChangeDate);
        oCmd.Parameters.AddWithValue("@pgiInsuranceCode", pgiInsuranceCode);
        oCmd.Parameters.AddWithValue("@pgiPs", pgiPs);
        oCmd.Parameters.AddWithValue("@pgiModifyId", pgiModifyId);
        oCmd.Parameters.AddWithValue("@pgiModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }
    public void deleteGroupInsurance()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oCmd.CommandText = @"update sy_PersonGroupInsurance set 
pgiStatus='D',
pgiModifyId=@pgiModifyId,
pgiModifyDate=@pgiModifyDate
where pgiGuid=@pgiGuid ";
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oCmd.Parameters.AddWithValue("@pgiModifyId", pgiModifyId);
        oCmd.Parameters.AddWithValue("@pgiModifyDate", DateTime.Now);

        oCmd.Connection.Open();
        oCmd.ExecuteNonQuery();
        oCmd.Connection.Close();
    }

    public DataTable getGroupInsByGuid()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonGroupInsurance 
left join sy_Person on perGuid=pgiPerGuid
left join sy_PersonFamily on pfGuid=pgiPfGuid
left join sy_GroupInsurance on giGuid=pgiInsuranceCode
left join sy_CodeBranches on cbGuid=perDep
where  pgiStatus<>'D' and pgiGuid=@pgiGuid ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pgiGuid", pgiGuid);
        oda.Fill(ds);
        return ds;
    }

    public DataTable checkPerGroupIns()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_PersonGroupInsurance where pgiPerGuid=@pgiPerGuid and pgiStatus<>'D' ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oCmd.Parameters.AddWithValue("@pgiPerGuid", pgiPerGuid);
        oda.Fill(ds);
        return ds;
    }
}