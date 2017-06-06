using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_PayHoliday_DB 的摘要描述
/// </summary>
public class sy_PayHoliday_DB
{
    public sy_PayHoliday_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 全私用
    string str_keyword = string.Empty;
    #endregion
    #region 全公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    #endregion

    #region sy_PayHoliday 私用
    string phGuid = string.Empty;
    string phCode = string.Empty;
    string phName = string.Empty;
    string phBasic = string.Empty;
    string phPs = string.Empty;
    string phCreatId = string.Empty;
    string phModifyId = string.Empty;
    string phStatus = string.Empty;
    Decimal phDays;
    DateTime phCreatDate;
    DateTime phModifyDate;
    #endregion
    #region sy_PayHoliday 公用
    public string _phGuid
    {
        set { phGuid = value; }
    }
    public string _phCode
    {
        set { phCode = value; }
    }
    public string _phName
    {
        set { phName = value; }
    }
    public string _phBasic
    {
        set { phBasic = value; }
    }
    public string _phPs
    {
        set { phPs = value; }
    }
    public string _phCreatId
    {
        set { phCreatId = value; }
    }
    public string _phModifyId
    {
        set { phModifyId = value; }
    }
    public string _phStatus
    {
        set { phStatus = value; }
    }
    public Decimal _phDays
    {
        set { phDays = value; }
    }
    public DateTime _phCreatDate
    {
        set { phCreatDate = value; }
    }
    public DateTime _phModifyDate
    {
        set { phModifyDate = value; }
    }
    #endregion

    #region 撈 sy_PayHoliday 條件 keyword 
    public DataTable SelectPayHoliday()
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
                select * from sy_PayHoliday where phStatus='A'                
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(phName) LIKE '%' + upper(@str_keyword) + '%' or upper(phPs) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (phGuid != "")
            {
                show_value.Append(@" and phGuid=@phGuid  ");
                thisCommand.Parameters.AddWithValue("@phGuid", phGuid);
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

    #region 修改 sy_PayHoliday
    public void UpdatePayHoliday()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PayHoliday 
                set phName=@phName,phBasic=@phBasic,phPs=@phPs,phModifyId=@phModifyId,phModifyDate=@phModifyDate,phDays=@phDays
                where  phGuid=@phGuid               
            ");

            thisCommand.Parameters.AddWithValue("@phGuid", phGuid);
            thisCommand.Parameters.AddWithValue("@phName", phName);
            thisCommand.Parameters.AddWithValue("@phBasic", phBasic);
            thisCommand.Parameters.AddWithValue("@phPs", phPs);
            thisCommand.Parameters.AddWithValue("@phDays", phDays);
            thisCommand.Parameters.AddWithValue("@phModifyId", phModifyId);
            thisCommand.Parameters.AddWithValue("@phModifyDate", DateTime.Now);

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

    #region 刪除 sy_PayHoliday update status='D'
    public void DeletePayHoliday()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_PayHoliday set phStatus='D',phModifyId=@phModifyId,phModifyDate=@phModifyDate
                where  pcGuid=@pcGuid               
            ");

            thisCommand.Parameters.AddWithValue("@phGuid", phGuid);
            thisCommand.Parameters.AddWithValue("@phModifyId", phModifyId);
            thisCommand.Parameters.AddWithValue("@phModifyDate", DateTime.Now);

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

    #region 撈 sy_PayHoliday 檢查phName是否重複
    public DataTable SelectPayHolidayNAme()
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
                select * from sy_PayHoliday where phStatus='A' and  phName=@phName             
            ");
            
            thisCommand.Parameters.AddWithValue("@phName", phName);
            

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