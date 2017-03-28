using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_PersonChange 的摘要描述
/// </summary>
public class sy_PersonChange
{
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

    #region sy_PersonChange 私用
    string pcGuid = string.Empty;
    string pcPerGuid = string.Empty;
    string pcChangeDate = string.Empty;
    string pcChangeName = string.Empty;
    string pcChangeBegin = string.Empty;
    string pcChangeEnd = string.Empty;
    string pcVenifyDate = string.Empty;
    string pcVenify = string.Empty;
    string pcStatus = string.Empty;
    string pcPs = string.Empty;
    string pcCreateId = string.Empty;
    string pcModifyId = string.Empty;
    string pcStatus_d = string.Empty;
    DateTime pcCreateDate;
    DateTime pcModifyDate;
    #endregion
    #region sy_PersonChange 公用
    public string _pcGuid
    {
        set { pcGuid = value; }
    }
    public string _pcPerGuid
    {
        set { pcPerGuid = value; }
    }
    public string _pcChangeDate
    {
        set { pcChangeDate = value; }
    }
    public string _pcChangeName
    {
        set { pcChangeName = value; }
    }
    public string _pcChangeBegin
    {
        set { pcChangeBegin = value; }
    }
    public string _pcChangeEnd
    {
        set { pcChangeEnd = value; }
    }
    public string _pcVenifyDate
    {
        set { pcVenifyDate = value; }
    }
    public string _pcVenify
    {
        set { pcVenify = value; }
    }
    public string _pcStatus
    {
        set { pcStatus = value; }
    }
    public string _pcPs
    {
        set { pcPs = value; }
    }
    public string _pcCreateId
    {
        set { pcCreateId = value; }
    }
    public string _pcModifyId
    {
        set { pcModifyId = value; }
    }
    public string _pcStatus_d
    {
        set { pcStatus_d = value; }
    }
    public DateTime _pcCreateDate
    {
        set { pcCreateDate = value; }
    }
    public DateTime _pcModifyDate
    {
        set { pcModifyDate = value; }
    }
    #endregion

    #region sy_Person 私用
    string perNo = string.Empty;
    #endregion
    #region sy_Person 公用
    public string _perNo
    {
        set { perNo = value; }
    }
    #endregion

    public sy_PersonChange()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 撈 sy_PersonChange 條件 keyword or date(yyyy/mm/dd) or GUID or 異動項目名稱 or 狀態(已未/確認)
    public DataTable SelectPersonChange()
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
                select *
                from sy_PersonChange
                where pcStatus_d='A'
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and upper(dayName) LIKE '%' + upper(@str_keyword) + '%'  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (str_date != "")
            {
                show_value.Append(@" and pcChangeDate=@dayDate  ");
                thisCommand.Parameters.AddWithValue("@dayDate", str_date);
            }
            if (pcGuid != "")
            {
                show_value.Append(@" and pcGuid=@pcGuid  ");
                thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            }
            if (pcGuid != "")
            {
                show_value.Append(@" and pcStatus=@pcStatus  ");
                thisCommand.Parameters.AddWithValue("@pcStatus", pcStatus);
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

    #region 撈 sy_Person 條件 perNo
    public DataTable SelectPersonByperNo()
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
                select perGuid,perNo,perName,perComGuid,perCompName,perDep,perDepName,perPosition
                from sy_Person
                where perNo=@perNo
            ");
            thisCommand.Parameters.AddWithValue("@perNo", perNo);

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