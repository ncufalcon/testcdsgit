using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_BasicSalary_DB 的摘要描述
/// </summary>
public class sy_BasicSalary_DB
{
    public sy_BasicSalary_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    #region sy_BasicSalary 私用
    string bsGuid = string.Empty;
    string bsSalary = string.Empty;
    string bsOther = string.Empty;
    #endregion
    #region sy_BasicSalary 公用
    public string _bsGuid
    {
        set { bsGuid = value; }
    }
    public string _bsSalary
    {
        set { bsSalary = value; }
    }
    public string _bsOther
    {
        set { bsOther = value; }
    }
    #endregion

    #region 撈 sy_BasicSalary 
    public DataTable SelectBasicSalary()
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
                select * from sy_BasicSalary
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

    #region 新增 sy_BasicSalary
    public void InsertBasicSalary()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                 insert into sy_BasicSalary(bsGuid,bsSalary,bsOther)
                 values (@bsGuid,@bsSalary,@bsOther )     
            ");

            thisCommand.Parameters.AddWithValue("@bsGuid", bsGuid);
            thisCommand.Parameters.AddWithValue("@bsSalary", bsSalary);
            thisCommand.Parameters.AddWithValue("@bsOther", bsOther);

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

    #region 修改 sy_BasicSalary
    public void UpdateBasicSalary()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                 update sy_BasicSalary set bsSalary=@bsSalary,bsOther= @bsOther  where bsGuid=@bsGuid     
            ");

            thisCommand.Parameters.AddWithValue("@bsGuid", bsGuid);
            thisCommand.Parameters.AddWithValue("@bsSalary", bsSalary);
            thisCommand.Parameters.AddWithValue("@bsOther", bsOther);

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