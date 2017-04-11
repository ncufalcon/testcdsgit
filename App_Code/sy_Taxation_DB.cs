using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_TaxationItem_DB 的摘要描述
/// </summary>
public class sy_Taxation_DB
{
    public sy_Taxation_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region sy_TaxationItem 私用
    string tiGuid = string.Empty;
    string tiItem = string.Empty;
    string sfTaxPay = string.Empty;
    string tiFormula = string.Empty;
    #endregion
    #region sy_TaxationItem 公用
    public string _tiGuid
    {
        set { tiGuid = value; }
    }
    public string _tiItem
    {
        set { tiItem = value; }
    }
    public string _sfTaxPay
    {
        set { sfTaxPay = value; }
    }
    public string _tiFormula
    {
        set { tiFormula = value; }
    }
    #endregion

    #region sy_TaxationFormula 私用
    string tfGuid = string.Empty;
    string tfTiGuid = string.Empty;
    string tfClass = string.Empty;
    string tfItem = string.Empty;
    string tfCalculation = string.Empty;
    string tfOrder = string.Empty;
    string tfCreateID = string.Empty;
    string tfModifyID = string.Empty;
    DateTime tfCreateDate;
    DateTime tfModifyDate;
    #endregion
    #region sy_TaxationFormula 公用
    public string _tfGuid
    {
        set { tfGuid = value; }
    }
    public string _tfTiGuid
    {
        set { tfTiGuid = value; }
    }
    public string _tfClass
    {
        set { tfClass = value; }
    }
    public string _tfItem
    {
        set { tfItem = value; }
    }
    public string _tfCalculation
    {
        set { tfCalculation = value; }
    }
    public string _tfOrder
    {
        set { tfOrder = value; }
    }
    public string _tfCreateID
    {
        set { tfCreateID = value; }
    }
    public string _tfModifyID
    {
        set { tfModifyID = value; }
    }
    public DateTime _tfCreateDate
    {
        set { tfCreateDate = value; }
    }
    public DateTime _tfModifyDate
    {
        set { tfModifyDate = value; }
    }
    #endregion

    #region 撈 sy_TaxationItem
    public DataTable SelectTaxationItem()
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
                select * from sy_TaxationItem 
            ");
            //left join sy_TaxationFormula on tiGuid=tfTiGuid where 1=1
            //if (tiGuid !=null && tiGuid != "") {
            //    show_value.Append(@" and tiGuid=@tiGuid  ");
            //    thisCommand.Parameters.AddWithValue("@tiGuid", tiGuid);
            //}
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

    #region 修改 sy_TaxationItem
    public void UpdateTaxationItem()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            
            show_value.Append(@" 
                update sy_TaxationItem set tiFormula=@tiFormula where tiGuid=@tiGuid   
            ");
            thisCommand.Parameters.AddWithValue("@tiGuid", tiGuid);
            thisCommand.Parameters.AddWithValue("@tiFormula", tiFormula);
            
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