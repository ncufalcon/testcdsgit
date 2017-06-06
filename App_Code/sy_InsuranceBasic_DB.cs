using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_InsuranceBasic_DB 的摘要描述
/// </summary>
public class sy_InsuranceBasic_DB
{
    public sy_InsuranceBasic_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    

    #region sy_InsuranceBasic 私用
    string ibGuid = string.Empty;
    Decimal ibLaborProtection1;
    Decimal ibLaborProtection2;
    Decimal ibLaborProtection3;
    Decimal ibLaborProtection4;
    Decimal ibLaborProtection5;
    Decimal ibLaborProtection6;
    string ibLaborProtection7 = string.Empty;
    Decimal ibHealthcare1;
    Decimal ibHealthcare2;
    Decimal ibHealthcare3;
    Decimal ibHealthcare4;
    Decimal ibHealthcare5;
    Decimal ibHealthcare6;
    Decimal ibHealthcare6_up;
    Decimal ibHealthcare6_down;
    string ibHealthcare7 = string.Empty;
    string ibModifyId = string.Empty;
    DateTime ibModifyDate;
    #endregion
    #region sy_InsuranceBasic 公用
    public string _ibGuid
    {
        set { ibGuid = value; }
    }
    public Decimal _ibLaborProtection1
    {
        set { ibLaborProtection1 = value; }
    }
    public Decimal _ibLaborProtection2
    {
        set { ibLaborProtection2 = value; }
    }
    public Decimal _ibLaborProtection3
    {
        set { ibLaborProtection3 = value; }
    }
    public Decimal _ibLaborProtection4
    {
        set { ibLaborProtection4 = value; }
    }
    public Decimal _ibLaborProtection5
    {
        set { ibLaborProtection5 = value; }
    }
    public Decimal _ibLaborProtection6
    {
        set { ibLaborProtection6 = value; }
    }
    public string _ibLaborProtection7
    {
        set { ibLaborProtection7 = value; }
    }
    public Decimal _ibHealthcare1
    {
        set { ibHealthcare1 = value; }
    }
    public Decimal _ibHealthcare2
    {
        set { ibHealthcare2 = value; }
    }
    public Decimal _ibHealthcare3
    {
        set { ibHealthcare3 = value; }
    }
    public Decimal _ibHealthcare4
    {
        set { ibHealthcare4 = value; }
    }
    public Decimal _ibHealthcare5
    {
        set { ibHealthcare5 = value; }
    }
    public Decimal _ibHealthcare6
    {
        set { ibHealthcare6 = value; }
    }
    public Decimal _ibHealthcare6_up
    {
        set { ibHealthcare6_up = value; }
    }
    public Decimal _ibHealthcare6_down
    {
        set { ibHealthcare6_down = value; }
    }
    public string _ibHealthcare7
    {
        set { ibHealthcare7 = value; }
    }
    public string _ibModifyId
    {
        set { ibModifyId = value; }
    }
    public DateTime _ibModifyDate
    {
        set { ibModifyDate = value; }
    }
    #endregion

    

    #region 撈 sy_InsuranceBasic 
    public DataTable SelectInsuranceBasic()
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
                select * from sy_InsuranceBasic
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

    #region 新增 sy_InsuranceBasic
    public void InsertInsuranceBasic()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            
            show_value.Append(@" 
                insert into sy_InsuranceBasic(ibGuid,ibLaborProtection1,ibLaborProtection2,ibLaborProtection3,ibLaborProtection4,ibLaborProtection5,ibLaborProtection6,
                        ibLaborProtection7,ibHealthcare1,ibHealthcare2,ibHealthcare3,ibHealthcare4,ibHealthcare5,
                        ibHealthcare6,ibHealthcare7,ibModifyId,ibModifyDate,ibHealthcare6_up,ibHealthcare6_down)
                values (@ibGuid,@ibLaborProtection1,@ibLaborProtection2,@ibLaborProtection3,@ibLaborProtection4,@ibLaborProtection5,@ibLaborProtection6,
                        @ibLaborProtection7,@ibHealthcare1,@ibHealthcare2,@ibHealthcare3,@ibHealthcare4,@ibHealthcare5,
                        @ibHealthcare6,@ibHealthcare7,@ibModifyId,@ibModifyDate,@ibHealthcare6_up,@ibHealthcare6_down )   
            ");

            thisCommand.Parameters.AddWithValue("@ibGuid", ibGuid);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection1", ibLaborProtection1);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection2",  ibLaborProtection2);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection3",  ibLaborProtection3);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection4",  ibLaborProtection4);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection5",  ibLaborProtection5);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection6",  ibLaborProtection6);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection7",  ibLaborProtection7);
            thisCommand.Parameters.AddWithValue("@ibHealthcare1", ibHealthcare1);
            thisCommand.Parameters.AddWithValue("@ibHealthcare2", ibHealthcare2);
            thisCommand.Parameters.AddWithValue("@ibHealthcare3", ibHealthcare3);
            thisCommand.Parameters.AddWithValue("@ibHealthcare4", ibHealthcare4);
            thisCommand.Parameters.AddWithValue("@ibHealthcare5", ibHealthcare5);
            thisCommand.Parameters.AddWithValue("@ibHealthcare6", ibHealthcare6);
            thisCommand.Parameters.AddWithValue("@ibHealthcare6_up", ibHealthcare6_up);
            thisCommand.Parameters.AddWithValue("@ibHealthcare6_down", ibHealthcare6_down);
            thisCommand.Parameters.AddWithValue("@ibHealthcare7", ibHealthcare7);
            thisCommand.Parameters.AddWithValue("@ibModifyId", ibModifyId);
            thisCommand.Parameters.AddWithValue("@ibModifyDate", DateTime.Now);
            
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

    #region 修改 sy_InsuranceBasic
    public void UpdateInsuranceBasic()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            
            show_value.Append(@" 
                update sy_InsuranceBasic set ibLaborProtection1=@ibLaborProtection1,ibLaborProtection2=@ibLaborProtection2
                    ,ibLaborProtection3=@ibLaborProtection3,ibLaborProtection4=@ibLaborProtection4,ibLaborProtection5=@ibLaborProtection5
                    ,ibLaborProtection6=@ibLaborProtection6,ibLaborProtection7=@ibLaborProtection7
                    ,ibHealthcare1=@ibHealthcare1,ibHealthcare2=@ibHealthcare2
                    ,ibHealthcare3=@ibHealthcare3,ibHealthcare4=@ibHealthcare4,ibHealthcare5=@ibHealthcare5
                    ,ibHealthcare6=@ibHealthcare6,ibHealthcare7=@ibHealthcare7
                    ,ibHealthcare6_up=@ibHealthcare6_up,ibHealthcare6_down=@ibHealthcare6_down
                    ,ibModifyId=@ibModifyId,ibModifyDate=@ibModifyDate
                    where   ibGuid=@ibGuid
            ");
            thisCommand.Parameters.AddWithValue("@ibGuid", ibGuid);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection1", ibLaborProtection1);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection2", ibLaborProtection2);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection3", ibLaborProtection3);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection4", ibLaborProtection4);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection5", ibLaborProtection5);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection6", ibLaborProtection6);
            thisCommand.Parameters.AddWithValue("@ibLaborProtection7", ibLaborProtection7);
            thisCommand.Parameters.AddWithValue("@ibHealthcare1", ibHealthcare1);
            thisCommand.Parameters.AddWithValue("@ibHealthcare2", ibHealthcare2);
            thisCommand.Parameters.AddWithValue("@ibHealthcare3", ibHealthcare3);
            thisCommand.Parameters.AddWithValue("@ibHealthcare4", ibHealthcare4);
            thisCommand.Parameters.AddWithValue("@ibHealthcare5", ibHealthcare5);
            thisCommand.Parameters.AddWithValue("@ibHealthcare6", ibHealthcare6);
            thisCommand.Parameters.AddWithValue("@ibHealthcare6_up", ibHealthcare6_up);
            thisCommand.Parameters.AddWithValue("@ibHealthcare6_down", ibHealthcare6_down);
            thisCommand.Parameters.AddWithValue("@ibHealthcare7", ibHealthcare7);

            thisCommand.Parameters.AddWithValue("@ibModifyId", ibModifyId);
            thisCommand.Parameters.AddWithValue("@ibModifyDate", DateTime.Now);



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