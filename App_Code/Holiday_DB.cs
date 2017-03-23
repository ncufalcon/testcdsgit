using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;

/// <summary>
/// Holiday_DB 的摘要描述
/// </summary>
public class Holiday_DB
{
    public Holiday_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    #region 全私用
    string str_keyword = string.Empty;
    string str_date = string.Empty;
    #endregion
    #region 全公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    public string _str_date
    {
        set { str_date = value; }
    }
    #endregion

    #region labview_cleanlog 私用
    string dayGuid = string.Empty;
    string dayName = string.Empty;
    string dayDate = string.Empty;
    string dayPs = string.Empty;
    string dayCreatId = string.Empty;
    string dayModifyId = string.Empty;
    string dayStatus = string.Empty;
    DateTime dayCreatDate;
    DateTime dayModifyDate;
    #endregion
    #region labview_cleanlog 公用
    public string _dayGuid
    {
        set { dayGuid = value; }
    }
    public string _dayName
    {
        set { dayName = value; }
    }
    public string _dayDate
    {
        set { dayDate = value; }
    }
    public string _dayPs
    {
        set { dayPs = value; }
    }
    public string _dayCreatId
    {
        set { dayCreatId = value; }
    }
    public string _dayModifyId
    {
        set { dayModifyId = value; }
    }
    public string _dayStatus
    {
        set { dayStatus = value; }
    }
    
    public DateTime _dayCreatDate
    {
        set { dayCreatDate = value; }
    }
    public DateTime _dayModifyDate
    {
        set { dayModifyDate = value; }
    }
    #endregion

    #region 撈 holiday 條件 keyword or date(yyyy/mm/dd) or GUID
    public DataTable SelectHoliday()
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
                select * from sy_Holiday where dayStatus='A'
            ");

            if (str_keyword!="") {
                show_value.Append(@" and upper(dayName) LIKE '%' + upper(@str_keyword) + '%'  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (str_date!="") {
                show_value.Append(@" and dayDate=@dayDate  ");
                thisCommand.Parameters.AddWithValue("@dayDate", str_date);
            }
            if (dayGuid != "")
            {
                show_value.Append(@" and dayGuid=@dayGuid  ");
                thisCommand.Parameters.AddWithValue("@dayGuid", dayGuid);
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

    #region 修改 holiday
    public void UpdateHoliday()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Holiday set dayName=@dayName,dayDate=@dayDate,dayPs=@dayPs,dayModifyId=@dayModifyId,dayModifyDate=@dayModifyDate,dayStatus='A' where dayGuid=@dayGuid
            ");

            thisCommand.Parameters.AddWithValue("@dayGuid", dayGuid);
            thisCommand.Parameters.AddWithValue("@dayName", dayName);
            thisCommand.Parameters.AddWithValue("@dayDate", dayDate);
            thisCommand.Parameters.AddWithValue("@dayPs", dayPs);
            thisCommand.Parameters.AddWithValue("@dayModifyId", dayModifyId);
            thisCommand.Parameters.AddWithValue("@dayModifyDate", DateTime.Now);

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

    #region 新增 holiday
    public void InsertHoliday()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_Holiday(dayName,dayDate,dayPs,dayCreatId,dayCreatDate,dayStatus) 
                values(@dayName,@dayDate,@dayPs,@dayCreatId,@dayCreatDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@dayGuid", dayGuid);
            thisCommand.Parameters.AddWithValue("@dayName", dayName);
            thisCommand.Parameters.AddWithValue("@dayDate", dayDate);
            thisCommand.Parameters.AddWithValue("@dayPs", dayPs);
            thisCommand.Parameters.AddWithValue("@dayCreatId", dayCreatId);
            thisCommand.Parameters.AddWithValue("@dayCreatDate", DateTime.Now);

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

    #region 刪除 holiday
    public void DeleteHoliday()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Holiday set dayStatus='D' where dayGuid=@dayGuid
            ");
            thisCommand.Parameters.AddWithValue("@dayGuid", dayGuid);
            thisCommand.Parameters.AddWithValue("@dayModifyId", dayModifyId);
            thisCommand.Parameters.AddWithValue("@dayModifyDate", DateTime.Now);

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