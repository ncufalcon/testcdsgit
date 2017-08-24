using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_AnnualLeave_DB 的摘要描述
/// </summary>
public class sy_AnnualLeave_DB
{
    #region sy_AnnualLeave 私用
    string alGuid = string.Empty;
    Decimal alYears;
    Decimal alDays;
    string alCreateId = string.Empty;
    string alModifyId = string.Empty;
    DateTime alCreateDate;
    DateTime alModifyDate;
    #endregion
    #region sy_AnnualLeave 公用
    public string _alGuid
    {
        set { alGuid = value; }
    }
    public Decimal _alYears
    {
        set { alYears = value; }
    }
    public Decimal _alDays
    {
        set { alDays = value; }
    }
    public string _alCreateId
    {
        set { alCreateId = value; }
    }
    public string _alModifyId
    {
        set { alModifyId = value; }
    }
    public DateTime _alCreateDate
    {
        set { alCreateDate = value; }
    }
    public DateTime _alModifyDate
    {
        set { alModifyDate = value; }
    }
    #endregion
    public sy_AnnualLeave_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 撈 sy_AnnualLeave 
    public DataTable SelectAnnualLeave()
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
                select * from sy_AnnualLeave where 1=1 
            ");
            if (alGuid!="") {
                show_value.Append(@" and alGuid=@alGuid ");
                thisCommand.Parameters.AddWithValue("@alGuid", alGuid);
            }
            show_value.Append(@"  order by alYears ASC ");
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

    #region 撈 sy_AnnualLeave  BY years or guid
    public DataTable SelectAnnualLeaveByYears()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            show_value.Append(@"  select * from sy_AnnualLeave where alYears=@alYears ");
            thisCommand.Parameters.AddWithValue("@alYears", alYears);
            if (alGuid!="") {
                show_value.Append(@"  and alGuid<>@alGuid ");
                thisCommand.Parameters.AddWithValue("@alGuid", alGuid);
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


    #region 刪除sy_AnnualLeave資料 BY guid
    public void DeleteAnnualLeave()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            if (alGuid != "")
            {
                show_value.Append(@" 
                    delete from  sy_AnnualLeave where alGuid=@alGuid
                ");
                thisCommand.Parameters.AddWithValue("@alGuid", alGuid);
            }
            
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

    #region 新增 sy_AnnualLeave
    public void InsertAnnualLeave()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_AnnualLeave(alGuid,alYears,alDays,alCreateId,alCreateDate,alModifyId,alModifyDate) 
                values(@alGuid,@alYears,@alDays,@alCreateId,@alCreateDate,@alModifyId,@alModifyDate) 
            ");

            thisCommand.Parameters.AddWithValue("@alGuid", alGuid);
            thisCommand.Parameters.AddWithValue("@alYears", alYears);
            thisCommand.Parameters.AddWithValue("@alDays", alDays);
            thisCommand.Parameters.AddWithValue("@alCreateId", alCreateId);
            thisCommand.Parameters.AddWithValue("@alCreateDate", alCreateDate);
            thisCommand.Parameters.AddWithValue("@alModifyId", alModifyId);
            thisCommand.Parameters.AddWithValue("@alModifyDate", alModifyDate);

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

    #region 修改 sy_AnnualLeave資料 BY guid
    public void UpdateAnnualLeave()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            if (alGuid != "")
            {
                show_value.Append(@" 
                    update sy_AnnualLeave set alYears=@alYears,alDays=@alDays,alModifyId=@alModifyId,alModifyDate=@alModifyDate where alGuid=@alGuid
                ");
                thisCommand.Parameters.AddWithValue("@alGuid", alGuid);
                thisCommand.Parameters.AddWithValue("@alYears", alYears);
                thisCommand.Parameters.AddWithValue("@alDays", alDays);
                thisCommand.Parameters.AddWithValue("@alModifyId", alModifyId);
                thisCommand.Parameters.AddWithValue("@alModifyDate", alModifyDate);
            }

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
}