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
    string str_dates = string.Empty;
    string str_datee = string.Empty;
    int str_after;
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
    public int _str_after
    {
        set { str_after = value; }
    }
    public string _str_dates
    {
        set { str_dates = value; }
    }
    public string _str_datee
    {
        set { str_datee = value; }
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
                        pacModifyId,pacModifyDate,pacStatus_d,a.perNo,a.perName,pacChange,siItemName,siRef,mbName
                from sy_PersonAllowanceChang1e
                left join sy_Person a on pacPerGuid = a.perGuid
                left join sy_SalaryItem on pacChange = siGuid
                left join sy_Member on pacVenify=mbGuid
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
            if (pacChange!="") {
                show_value.Append(@" and pacChange=@pacChange  ");
                thisCommand.Parameters.AddWithValue("@pacChange", pacChange);
            }
            if (str_dates != ""&& str_datee != "")
            {
                show_value.Append(@" and pacChangeDate between @str_dates and @str_datee  ");
                thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            }
            show_value.Append(@" order by pacStatus, pacCreateDate ASC   ");
            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception ex)
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
                set pacStatus='1',pacModifyId=@pacModifyId,pacModifyDate=@pacModifyDate,pacVenify=@pacVenify,pacVenifyDate=@pacVenifyDate
                where pacGuid=@pacGuid
            ");
            
            thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);
            thisCommand.Parameters.AddWithValue("@pacModifyId", pacModifyId);
            thisCommand.Parameters.AddWithValue("@pacModifyDate", pacModifyDate);
            thisCommand.Parameters.AddWithValue("@pacVenify", pacVenify);
            thisCommand.Parameters.AddWithValue("@pacVenifyDate", pacVenifyDate);

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

    #region 底薪 已確認要更新 sy_Person.perBasicSalary 異動後金額
    public void UpdatePersonBasicSalary()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Person 
                set perBasicSalary=@str_after,perModifyId=@perModifyId,perModifyDate=@perModifyDate
                where perGuid=@perGuid
            ");
            
            thisCommand.Parameters.AddWithValue("@perGuid", pacPerGuid);
            thisCommand.Parameters.AddWithValue("@str_after", str_after);
            thisCommand.Parameters.AddWithValue("@perModifyId", pacModifyId);
            thisCommand.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

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

    #region 職能加給 已確認要更新 sy_Person.perAllowance 異動後金額
    public void UpdatePersonAllowance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Person 
                set perAllowance=@str_after,perModifyId=@perModifyId,perModifyDate=@perModifyDate
                where perGuid=@perGuid
            ");

            thisCommand.Parameters.AddWithValue("@perGuid", pacPerGuid);
            thisCommand.Parameters.AddWithValue("@str_after", str_after);
            thisCommand.Parameters.AddWithValue("@perModifyId", pacModifyId);
            thisCommand.Parameters.AddWithValue("@perModifyDate", DateTime.Now);

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

    #region 個人津貼 已確認要更新 sy_Person.perBasicSalary 異動後金額
    public void UpdatePersonAllowancepaCost()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sv_PersonAllowance 
                set paCost=@str_after,paModifyId=@paModifyId,paModifyDate=@paModifyDate
                where paPerGuid=@pacPerGuid and paAllowanceCode=@pacGuid
            ");

            thisCommand.Parameters.AddWithValue("@pacPerGuid", pacPerGuid);
            thisCommand.Parameters.AddWithValue("@str_after", str_after);
            thisCommand.Parameters.AddWithValue("@pacGuid", pacGuid);
            thisCommand.Parameters.AddWithValue("@paModifyId", pacModifyId);
            thisCommand.Parameters.AddWithValue("@paModifyDate", DateTime.Now);

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

    #region 撈 薪資異動的所有異動項目
    public DataTable SelectPersonAllowanceChangItem()
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
                select siGuid,siItemCode,siItemName,siRef from sy_SalaryItem where siStatus='A' and (siRef='01' or siRef='02')
                union 
                select paAllowanceCode,
                (select siItemCode from sy_SalaryItem where siGuid=paAllowanceCode) siItemCode,
                (select siItemName from sy_SalaryItem where siGuid=paAllowanceCode) siItemName,
                (select siRef from sy_SalaryItem where siGuid=paAllowanceCode) siRef
                from sv_PersonAllowance where paStatus='A'
            ");
            thisCommand.CommandType = CommandType.Text;
            thisCommand.CommandText = show_value.ToString();
            oda.SelectCommand = thisCommand;
            oda.Fill(dt);
        }
        catch (Exception ex)
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