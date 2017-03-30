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
    string str_status = string.Empty;
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
    public string _str_status
    {
        set { str_status = value; }
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
                select pcGuid,pcPerGuid,pcChangeDate,pcChangeName,pcChangeBegin,pcChangeEnd,pcVenifyDate,pcVenify,pcStatus,pcPs,perNo,perName,e.code_desc ChangeCName
                        ,a.code_desc begin_jobname,b.code_desc after_jobname,c.cbName begin_storename,d.cbName after_storename
                from sy_PersonChange
                left join sy_Person on pcPerGuid = perGuid
                left join sy_codetable a on a.code_group='02' and pcChangeBegin = a.code_value
                left join sy_codetable b on b.code_group='02' and pcChangeEnd = b.code_value
                left join sy_codetable e on e.code_group='10' and pcChangeName = e.code_value
                left join sy_CodeBranches c on pcChangeBegin = c.cbGuid
                left join sy_CodeBranches d on pcChangeEnd = d.cbGuid
                where pcStatus_d='A'
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(perNo) LIKE '%' + upper(@str_keyword) + '%' or upper(perName) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (pcChangeDate != "")
            {
                show_value.Append(@" and pcChangeDate=@pcChangeDate  ");
                thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
            }
            if (pcGuid != "")
            {
                show_value.Append(@" and pcGuid=@pcGuid  ");
                thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            }
            if (pcStatus != "")
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
                select perGuid,perNo,perName,perPosition,code_desc as PositionName,perDep,cbName,perFirstDate
                from sy_Person
                left join sy_codetable on code_group = '02' and  perPosition = code_value
                left join sy_CodeBranches on perDep = cbGuid
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

    #region 新增 sy_PersonChange
    public void InsertPersonChange()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_PersonChange(pcGuid,pcPerGuid,pcChangeDate,pcChangeName,pcChangeBegin,pcChangeEnd,pcVenifyDate,pcVenify,pcStatus,pcPs,pcCreateId,pcCreateDate,pcStatus_d) 
                values(@pcGuid,@pcPerGuid,@pcChangeDate,@pcChangeName,@pcChangeBegin,@pcChangeEnd,@pcVenifyDate,@pcVenify,@pcStatus,@pcPs,@pcCreateId,@pcCreateDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            thisCommand.Parameters.AddWithValue("@pcPerGuid", pcPerGuid);
            thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
            thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            thisCommand.Parameters.AddWithValue("@pcChangeBegin", pcChangeBegin);
            thisCommand.Parameters.AddWithValue("@pcChangeEnd", pcChangeEnd);
            thisCommand.Parameters.AddWithValue("@pcVenifyDate", pcVenifyDate);
            thisCommand.Parameters.AddWithValue("@pcVenify", pcVenify);
            thisCommand.Parameters.AddWithValue("@pcStatus", pcStatus);
            thisCommand.Parameters.AddWithValue("@pcPs", pcPs);
            thisCommand.Parameters.AddWithValue("@pcCreateId", pcCreateId);
            thisCommand.Parameters.AddWithValue("@pcCreateDate", DateTime.Now);

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

    #region 修改 sy_PersonChange
    public void UpdatePersonChange()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonChange set pcPerGuid=@pcPerGuid,pcChangeDate=@pcChangeDate,pcChangeName=@pcChangeName,pcChangeBegin=@pcChangeBegin,pcChangeEnd=@pcChangeEnd,pcVenifyDate=@pcVenifyDate,pcVenify=@pcVenify,pcStatus=@pcStatus,pcPs=@pcPs,pcModifyId=@pcModifyId,pcModifyDate=@pcModifyDate
                where  pcGuid=@pcGuid               
            ");

            thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            thisCommand.Parameters.AddWithValue("@pcPerGuid", pcPerGuid);
            thisCommand.Parameters.AddWithValue("@pcChangeDate", pcChangeDate);
            thisCommand.Parameters.AddWithValue("@pcChangeName", pcChangeName);
            thisCommand.Parameters.AddWithValue("@pcChangeBegin", pcChangeBegin);
            thisCommand.Parameters.AddWithValue("@pcChangeEnd", pcChangeEnd);
            thisCommand.Parameters.AddWithValue("@pcVenifyDate", pcVenifyDate);
            thisCommand.Parameters.AddWithValue("@pcVenify", pcVenify);
            thisCommand.Parameters.AddWithValue("@pcStatus", pcStatus);
            thisCommand.Parameters.AddWithValue("@pcPs", pcPs);
            thisCommand.Parameters.AddWithValue("@pcModifyId", pcModifyId);
            thisCommand.Parameters.AddWithValue("@pcModifyDate", DateTime.Now);

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

    #region 刪除 sy_PersonChange 不是真的刪除 update set 
    public void DeletePersonChange()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonChange set pcStatus_d='D' where  pcGuid=@pcGuid               
            ");

            thisCommand.Parameters.AddWithValue("@pcGuid", pcGuid);
            thisCommand.Parameters.AddWithValue("@pcModifyId", pcModifyId);
            thisCommand.Parameters.AddWithValue("@pcModifyDate", DateTime.Now);

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