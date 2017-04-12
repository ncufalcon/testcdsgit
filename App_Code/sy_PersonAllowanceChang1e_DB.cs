using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_PersonAllowanceChang1e_DB 的摘要描述
/// </summary>
public class sy_PersonAllowanceChang1e_DB
{
    public sy_PersonAllowanceChang1e_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

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

    #region sy_PersonAllowanceChang1e 私用
    string pacGuid = string.Empty;
    string pacPerGuid = string.Empty;
    string pacChangeDate = string.Empty;
    string pacChangeBegin = string.Empty;
    string pacChangeEnd = string.Empty;
    string pacVenifyDate = string.Empty;
    string pacVenify = string.Empty;
    string pacStatus = string.Empty;
    string pacPs = string.Empty;
    string pacCreateId = string.Empty;
    string pacModifyId = string.Empty;
    string pacStatus_d = string.Empty;
    string pacChange = string.Empty;
    DateTime pacCreateDate;
    DateTime pacModifyDate;
    #endregion
    #region sy_PersonAllowanceChang1e 公用
    public string _pacGuid
    {
        set { pacGuid = value; }
    }
    public string _pacPerGuid
    {
        set { pacPerGuid = value; }
    }
    public string _pacChangeDate
    {
        set { pacChangeDate = value; }
    }
    public string _pacChangeBegin
    {
        set { pacChangeBegin = value; }
    }
    public string _pacChangeEnd
    {
        set { pacChangeEnd = value; }
    }
    public string _pacVenifyDate
    {
        set { pacVenifyDate = value; }
    }
    public string _pacVenify
    {
        set { pacVenify = value; }
    }
    public string _pacStatus
    {
        set { pacStatus = value; }
    }
    public string _pacPs
    {
        set { pacPs = value; }
    }
    public string _pacCreateId
    {
        set { pacCreateId = value; }
    }
    public string _pacModifyId
    {
        set { pacModifyId = value; }
    }
    public string _pacStatus_d
    {
        set { pacStatus_d = value; }
    }
    public string _pacChange
    {
        set { pacChange = value; }
    }
    public DateTime _pacCreateDate
    {
        set { pacCreateDate = value; }
    }
    public DateTime _pacModifyDate
    {
        set { pacModifyDate = value; }
    }
    #endregion

    #region 撈 sy_PersonAllowanceChang1e 條件 keyword or date(yyyy/mm/dd) or GUID or 異動項目名稱 or 狀態(已未/確認)
    public DataTable SelectPersonAllowanceChang1e()
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
                select pacGuid,pacPerGuid,pacChangeDate,pacChangeBegin,pacChangeEnd,pacVenifyDate,pacVenify,pacStatus,pacPs,pacCreateId,pacCreateDate,
                        pacModifyId,pacModifyDate,pacStatus_d,perNo,perName,pacChange,siItemName
                from sy_PersonAllowanceChang1e
                left join sy_Person on pacPerGuid = perGuid
                left join sy_SalaryItem on pacChange = siGuid
                where pacStatus_d='A'
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(perNo) LIKE '%' + upper(@str_keyword) + '%' or upper(perName) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (str_date != "")
            {
                show_value.Append(@" and pacChangeDate=@pacChangeDate  ");
                thisCommand.Parameters.AddWithValue("@pacChangeDate", str_date);
            }
            if (pacGuid != "")
            {
                show_value.Append(@" and pacGuid=@pacGuid  ");
                thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);
            }
            if (str_status != "")
            {
                show_value.Append(@" and pacStatus=@pacStatus  ");
                thisCommand.Parameters.AddWithValue("@pacStatus", str_status);
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

    #region 新增 sy_PersonAllowanceChang1e
    public void InsertPersonAllowanceChang1e()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_PersonAllowanceChang1e(pacGuid,pacPerGuid,pacChangeDate,pacChangeBegin,pacChangeEnd,pacVenifyDate,pacVenify,pacStatus,pacPs,pacCreateId,pacChange,pacCreateDate,pacStatus_d) 
                values(@pacGuid,@pacPerGuid,@pacChangeDate,@pacChangeBegin,@pacChangeEnd,@pacVenifyDate,@pacVenify,@pacStatus,@pacPs,@pacCreateId,@pacChange,@pacCreateDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);
            thisCommand.Parameters.AddWithValue("@pacPerGuid", pacPerGuid);
            thisCommand.Parameters.AddWithValue("@pacChangeDate", pacChangeDate);
            thisCommand.Parameters.AddWithValue("@pacChangeBegin", pacChangeBegin);
            thisCommand.Parameters.AddWithValue("@pacChangeEnd", pacChangeEnd);
            thisCommand.Parameters.AddWithValue("@pacVenifyDate", pacVenifyDate);
            thisCommand.Parameters.AddWithValue("@pacVenify", pacVenify);
            thisCommand.Parameters.AddWithValue("@pacStatus", pacStatus);
            thisCommand.Parameters.AddWithValue("@pacPs", pacPs);
            thisCommand.Parameters.AddWithValue("@pacCreateId", pacCreateId);
            thisCommand.Parameters.AddWithValue("@pacChange", pacChange);
            thisCommand.Parameters.AddWithValue("@pacCreateDate", DateTime.Now);

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

    #region 修改 sy_PersonAllowanceChang1e
    public void UpdatePersonAllowanceChang1e()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonAllowanceChang1e 
                set pacPerGuid=@pacPerGuid,pacChangeDate=@pacChangeDate,pacChangeBegin=@pacChangeBegin,pacChangeEnd=@pacChangeEnd
                    ,pacVenifyDate=@pacVenifyDate,pacVenify=@pacVenify,pacStatus=@pacStatus,pacPs=@pacPs
                    ,pacModifyId=@pacModifyId,pacModifyDate=@pacModifyDate,pacChange=@pacChange
                where pacGuid=@pacGuid
            ");

            thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);
            thisCommand.Parameters.AddWithValue("@pacPerGuid", pacPerGuid);
            thisCommand.Parameters.AddWithValue("@pacChangeDate", pacChangeDate);
            thisCommand.Parameters.AddWithValue("@pacChangeBegin", pacChangeBegin);
            thisCommand.Parameters.AddWithValue("@pacChangeEnd", pacChangeEnd);
            thisCommand.Parameters.AddWithValue("@pacVenifyDate", pacVenifyDate);
            thisCommand.Parameters.AddWithValue("@pacVenify", pacVenify);
            thisCommand.Parameters.AddWithValue("@pacStatus", pacStatus);
            thisCommand.Parameters.AddWithValue("@pacPs", pacPs);
            thisCommand.Parameters.AddWithValue("@pacModifyId", pacModifyId);
            thisCommand.Parameters.AddWithValue("@pacChange", pacChange);
            thisCommand.Parameters.AddWithValue("@pacModifyDate", DateTime.Now);

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

    #region 刪除 sy_PersonAllowanceChang1e update status_d
    public void DeletePersonAllowanceChang1e()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonAllowanceChang1e 
                set pacStatus_d='D',pacModifyId=@pacModifyId,pacModifyDate=@pacModifyDate
                where pacGuid=@pacGuid
            ");

            thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);
            thisCommand.Parameters.AddWithValue("@pacModifyId", pacModifyId);
            thisCommand.Parameters.AddWithValue("@pacModifyDate", DateTime.Now);

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

    #region 批次審核 sy_PersonAllowanceChang1e
    public void UpdateStatus()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PersonAllowanceChang1e 
                set pacStatus='1'
                where pacGuid=@pacGuid
            ");

            thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);

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