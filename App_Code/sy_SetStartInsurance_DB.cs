using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_SetStartInsurance_DB 的摘要描述
/// </summary>
public class sy_SetStartInsurance_DB
{
    #region sy_InsuranceBasic 私用
    Decimal ssi_labor;
    Decimal ssi_ganbor;
    Decimal ssi_tahui;
    string ssi_CreateId = string.Empty;
    string ssi_ModifyId = string.Empty;
    DateTime ssi_CreateDate;
    DateTime ssi_ModifyDate;
    #endregion
    #region sy_InsuranceBasic 公用
    public Decimal _ssi_labor
    {
        set { ssi_labor = value; }
    }
    public Decimal _ssi_ganbor
    {
        set { ssi_ganbor = value; }
    }
    public Decimal _ssi_tahui
    {
        set { ssi_tahui = value; }
    }
    public string _ssi_CreateId
    {
        set { ssi_CreateId = value; }
    }
    public string _ssi_ModifyId
    {
        set { ssi_ModifyId = value; }
    }
    public DateTime _ssi_CreateDate
    {
        set { ssi_CreateDate = value; }
    }
    public DateTime _ssi_ModifyDate
    {
        set { ssi_ModifyDate = value; }
    }
    #endregion

    public sy_SetStartInsurance_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    #region 撈 sy_SetStartInsurance 
    public DataTable SelectSetStartInsurance()
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
                select * from sy_SetStartInsurance
            ");
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

    #region 修改 sy_SetStartInsurance
    public void UpdateSetStartInsurance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@"  
                update sy_SetStartInsurance set ssi_labor=@ssi_labor,ssi_ganbor=@ssi_ganbor,ssi_tahui=@ssi_tahui,ssi_ModifyId=@ssi_ModifyId,ssi_ModifyDate=@ssi_ModifyDate
            ");
            thisCommand.Parameters.AddWithValue("@ssi_labor", ssi_labor);
            thisCommand.Parameters.AddWithValue("@ssi_ganbor", ssi_ganbor);
            thisCommand.Parameters.AddWithValue("@ssi_tahui", ssi_tahui);
            thisCommand.Parameters.AddWithValue("@ssi_ModifyId", ssi_ModifyId);
            thisCommand.Parameters.AddWithValue("@ssi_ModifyDate", ssi_ModifyDate);
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

    #region 新增 sy_SetStartInsurance
    public void InsertSetStartInsurance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@"  
                insert into sy_SetStartInsurance(ssi_labor,ssi_ganbor,ssi_tahui,ssi_CreateId,ssi_CreateDate,ssi_ModifyId,ssi_ModifyDate) 
                values(@ssi_labor,@ssi_ganbor,@ssi_tahui,@ssi_CreateId,@ssi_CreateDate,@ssi_ModifyId,@ssi_ModifyDate)
            ");
            thisCommand.Parameters.AddWithValue("@ssi_labor", ssi_labor);
            thisCommand.Parameters.AddWithValue("@ssi_ganbor", ssi_ganbor);
            thisCommand.Parameters.AddWithValue("@ssi_tahui", ssi_tahui);
            thisCommand.Parameters.AddWithValue("@ssi_CreateId", ssi_CreateId);
            thisCommand.Parameters.AddWithValue("@ssi_CreateDate", ssi_CreateDate);
            thisCommand.Parameters.AddWithValue("@ssi_ModifyId", ssi_ModifyId);
            thisCommand.Parameters.AddWithValue("@ssi_ModifyDate", ssi_ModifyDate);
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