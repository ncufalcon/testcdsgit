using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_SubsidyLevel_DB 的摘要描述
/// </summary>
public class sy_SubsidyLevel_DB
{
    public sy_SubsidyLevel_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    #region 全 私用
    string str_keyword = string.Empty;
    #endregion
    # region 全 公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    #endregion

    #region sy_SubsidyLevel 私用
    string slGuid = string.Empty;
    string slSubsidyCode = string.Empty;
    string slSubsidyIdentity = string.Empty;
    decimal slSubsidyRatio1;
    decimal slSubsidyRatio2;
    decimal slSubsidyRatio3;
    string slCreatId = string.Empty;
    string slModifyId = string.Empty;
    string slStatus = string.Empty;
    DateTime slCreatDate;
    DateTime slModifyDate;
    #endregion
    #region sy_SubsidyLevel 公用
    public string _slGuid
    {
        set { slGuid = value; }
    }
    public string _slSubsidyCode
    {
        set { slSubsidyCode = value; }
    }
    public string _slSubsidyIdentity
    {
        set { slSubsidyIdentity = value; }
    }
    public Decimal _slSubsidyRatio1
    {
        set { slSubsidyRatio1 = value; }
    }
    public Decimal _slSubsidyRatio2
    {
        set { slSubsidyRatio2 = value; }
    }
    public Decimal _slSubsidyRatio3
    {
        set { slSubsidyRatio3 = value; }
    }
    public string _slCreatId
    {
        set { slCreatId = value; }
    }
    public string _slModifyId
    {
        set { slModifyId = value; }
    }
    public string _slStatus
    {
        set { slStatus = value; }
    }
    public DateTime _slCreatDate
    {
        set { slCreatDate = value; }
    }
    public DateTime _slModifyDate
    {
        set { slModifyDate = value; }
    }
    #endregion

    #region 撈 sy_SubsidyLevel  全/BY GUID/BY KEYWORD
    public DataTable SelectSubsidyLevel()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            show_value.Append(@"  
                select * from sy_SubsidyLevel where slStatus='A'
            ");
            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(slSubsidyCode) LIKE '%' + upper(@str_keyword) + '%' or upper(slSubsidyIdentity) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (slGuid != "")
            {
                show_value.Append(@" and slGuid=@slGuid  ");
                thisCommand.Parameters.AddWithValue("@slGuid", slGuid);
            }
            show_value.Append(@" order by slSubsidyCode ASC  ");
            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception)
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        return dt;

    }
    #endregion

    #region 新增 sy_SubsidyLevel
    public void InsertSubsidyLevel()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_SubsidyLevel(slGuid,slSubsidyCode,slSubsidyIdentity,slSubsidyRatio1,slSubsidyRatio2,slSubsidyRatio3,slCreatId,slModifyId,slModifyDate,slStatus) 
                values(@slGuid,@slSubsidyCode,@slSubsidyIdentity,@slSubsidyRatio1,@slSubsidyRatio2,@slSubsidyRatio3,@slCreatId,@slModifyId,@slModifyDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@slGuid", slGuid);
            thisCommand.Parameters.AddWithValue("@slSubsidyCode", slSubsidyCode);
            thisCommand.Parameters.AddWithValue("@slSubsidyIdentity", slSubsidyIdentity);
            thisCommand.Parameters.AddWithValue("@slSubsidyRatio1", slSubsidyRatio1);
            thisCommand.Parameters.AddWithValue("@slSubsidyRatio2", slSubsidyRatio2);
            thisCommand.Parameters.AddWithValue("@slSubsidyRatio3", slSubsidyRatio3);
            thisCommand.Parameters.AddWithValue("@slCreatId", slCreatId);
            thisCommand.Parameters.AddWithValue("@slModifyId", slModifyId);
            thisCommand.Parameters.AddWithValue("@slModifyDate", DateTime.Now);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 修改 sy_SubsidyLevel
    public void UpdateSubsidyLevel()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SubsidyLevel 
                set slSubsidyCode=@slSubsidyCode,slSubsidyIdentity=@slSubsidyIdentity,
                    slSubsidyRatio1=@slSubsidyRatio1,slSubsidyRatio2=@slSubsidyRatio2,slSubsidyRatio3=@slSubsidyRatio3,
                    slModifyId=@slModifyId,slModifyDate=@slModifyDate
                where slGuid=@slGuid
            ");

            thisCommand.Parameters.AddWithValue("@slGuid", slGuid);
            thisCommand.Parameters.AddWithValue("@slSubsidyCode", slSubsidyCode);
            thisCommand.Parameters.AddWithValue("@slSubsidyIdentity", slSubsidyIdentity);
            thisCommand.Parameters.AddWithValue("@slSubsidyRatio1", slSubsidyRatio1);
            thisCommand.Parameters.AddWithValue("@slSubsidyRatio2", slSubsidyRatio2);
            thisCommand.Parameters.AddWithValue("@slSubsidyRatio3", slSubsidyRatio3);
            thisCommand.Parameters.AddWithValue("@slModifyId", slModifyId);
            thisCommand.Parameters.AddWithValue("@slModifyDate", DateTime.Now);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion

    #region 刪除 sy_SubsidyLevel update giiStatus="D"
    public void DeleteSubsidyLevel()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SubsidyLevel set slStatus='D',slModifyId=@slModifyId,slModifyDate=@slModifyDate where slGuid=@slGuid
            ");

            thisCommand.Parameters.AddWithValue("@slGuid", slGuid);
            thisCommand.Parameters.AddWithValue("@slModifyId", slModifyId);
            thisCommand.Parameters.AddWithValue("@slModifyDate", DateTime.Now);

            thisCommand.CommandText = show_value.ToString();
            thisCommand.CommandType = CommandType.Text;

            thisCommand.Connection.Open();
            thisCommand.ExecuteNonQuery();
            thisCommand.Connection.Close();
        }
        catch (Exception ex)
        {
            throw ex;
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }

    }
    #endregion


    #region 檢查 sy_SubsidyLevel  giidentityCode 身分代碼是否重複
    public DataTable SelectGroupInsuranceIdentityCode()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            show_value.Append(@"  
                select * from sy_SubsidyLevel where slStatus='A' 
            ");
            if (slSubsidyCode != "")
            {
                show_value.Append(@" and slSubsidyCode=@slSubsidyCode  ");
                thisCommand.Parameters.AddWithValue("@slSubsidyCode", slSubsidyCode);
            }
            if (slGuid != "")
            {
                show_value.Append(@" and slGuid=@slGuid  ");
                thisCommand.Parameters.AddWithValue("@slGuid", slGuid);
            }
            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception)
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        finally
        {
            oda.Dispose();
            thisConnection.Close();
            thisConnection.Dispose();
            thisCommand.Dispose();
        }
        return dt;

    }
    #endregion

}