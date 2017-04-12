using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_SalaryFormula 的摘要描述
/// </summary>
public class sy_SalaryFormula
{
    public sy_SalaryFormula()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region sy_SalaryFormula 私用
    string sfGuid = string.Empty;
    string sfupdatetype = string.Empty;
    Int32 sfBasicSalary ;
    Decimal sfWelfare ;
    #endregion
    #region sy_SalaryFormula 公用
    public string _sfGuid
    {
        set { sfGuid = value; }
    }
    public string _sfupdatetype
    {
        set { sfupdatetype = value; }
    }
    public Int32 _sfBasicSalary
    {
        set { sfBasicSalary = value; }
    }
    public Decimal _sfWelfare
    {
        set { sfWelfare = value; }
    }
    #endregion

    #region 撈 sy_SalaryFormula 
    public DataTable SelectSalaryFormula()
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
                select * from sy_SalaryFormula
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

    #region 新增 sy_SalaryFormula
    public void InsertSalaryFormula()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            if (sfupdatetype == "1")
            {
                show_value.Append(@" 
                    insert into sy_SalaryFormula(sfGuid,sfBasicSalary,sfWelfare)
                 values (@sfGuid,@sfBasicSalary,null )    
                ");
                thisCommand.Parameters.AddWithValue("@sfBasicSalary", sfBasicSalary);
            }
            if (sfupdatetype == "2")
            {
                show_value.Append(@" 
                    insert into sy_SalaryFormula(sfGuid,sfBasicSalary,sfWelfare)
                    values (@sfGuid,null,@sfWelfare )   
                ");
                thisCommand.Parameters.AddWithValue("@sfWelfare", sfWelfare);
            }

            thisCommand.Parameters.AddWithValue("@sfGuid", sfGuid);

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

    #region 修改 sy_SalaryFormula
    public void UpdateSalaryFormula()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            if (sfupdatetype == "1") {
                show_value.Append(@" 
                    update sy_SalaryFormula set sfBasicSalary=@sfBasicSalary    
                ");
                thisCommand.Parameters.AddWithValue("@sfBasicSalary", sfBasicSalary);
            }
            if (sfupdatetype == "2")
            {
                show_value.Append(@" 
                    update sy_SalaryFormula set sfWelfare=@sfWelfare    
                ");
                thisCommand.Parameters.AddWithValue("@sfWelfare", sfWelfare);
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