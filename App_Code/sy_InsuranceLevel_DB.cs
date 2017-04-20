using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_InsuranceLevel_DB 的摘要描述
/// </summary>
public class sy_InsuranceLevel_DB
{
    public sy_InsuranceLevel_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 全 私用
    string str_keyword = string.Empty;
    #endregion
    # region 全 公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    #endregion

    #region sy_InsuranceLevel 私用
    string ilGuid = string.Empty;
    decimal ilItem1;
    decimal ilItem2;
    decimal ilItem3;
    decimal ilItem4;
    string ilEffectiveDate = string.Empty;
    string ilCreatId = string.Empty;
    string ilModifyId = string.Empty;
    string ilStatus = string.Empty;
    DateTime ilCreatDate;
    DateTime ilModifyDate;
    #endregion
    #region sy_InsuranceLevel 公用
    public string _ilGuid
    {
        set { ilGuid = value; }
    }
    
    public Decimal _ilItem1
    {
        set { ilItem1 = value; }
    }
    public Decimal _ilItem2
    {
        set { ilItem2 = value; }
    }
    public Decimal _ilItem3
    {
        set { ilItem3 = value; }
    }
    public Decimal _ilItem4
    {
        set { ilItem4 = value; }
    }
    public string _ilEffectiveDate
    {
        set { ilEffectiveDate = value; }
    }
    public string _ilCreatId
    {
        set { ilCreatId = value; }
    }
    public string _ilModifyId
    {
        set { ilModifyId = value; }
    }
    public string _ilStatus
    {
        set { ilStatus = value; }
    }
    public DateTime _ilCreatDate
    {
        set { ilCreatDate = value; }
    }
    public DateTime _ilModifyDate
    {
        set { ilModifyDate = value; }
    }
    #endregion

    #region 撈 sy_InsuranceLevel  全/BY GUID/BY KEYWORD
    public DataTable SelectInsuranceLevel()
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
                select * from sy_InsuranceLevel where ilStatus='A'
            ");
            if (ilEffectiveDate != "")
            {
                show_value.Append(@" and ilEffectiveDate=@ilEffectiveDate  ");
                thisCommand.Parameters.AddWithValue("@ilEffectiveDate", ilEffectiveDate);
            }
            else {

            }
            //if (ilGuid != "")
            //{
            //    show_value.Append(@" and ilGuid=@ilGuid  ");
            //    thisCommand.Parameters.AddWithValue("@ilGuid", ilGuid);
            //}
            show_value.Append(@" order by ilItem1 ASC  ");
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

    #region 新增 sy_InsuranceLevel
    public void InsertInsuranceLevel()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_InsuranceLevel(ilGuid,ilItem1,ilItem2,ilItem3,ilItem4,ilEffectiveDate,ilCreatId,ilModifyId,ilModifyDate,slStatus) 
                values(@ilGuid,@ilItem1,@ilItem2,@ilItem3,@ilItem4,@ilEffectiveDate,@ilCreatId,@ilModifyId,@ilModifyDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@ilGuid", ilGuid);
            thisCommand.Parameters.AddWithValue("@ilItem1", ilItem1);
            thisCommand.Parameters.AddWithValue("@ilItem2", ilItem2);
            thisCommand.Parameters.AddWithValue("@ilItem3", ilItem3);
            thisCommand.Parameters.AddWithValue("@ilItem4", ilItem4);
            thisCommand.Parameters.AddWithValue("@ilEffectiveDate", ilEffectiveDate);
            thisCommand.Parameters.AddWithValue("@ilCreatId", ilCreatId);
            thisCommand.Parameters.AddWithValue("@ilModifyId", ilModifyDate);
            thisCommand.Parameters.AddWithValue("@slModifyDate", DateTime.Now);

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

    #region 修改 sy_InsuranceLevel
    public void UpdateInsuranceLevel()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_InsuranceLevel 
                set ilItem1=@ilItem1,ilItem2=@ilItem2,ilItem3=@ilItem3,ilItem4=@ilItem4,
                    ilEffectiveDate=@ilEffectiveDate,ilModifyId=@ilModifyId,slModifyDate=@slModifyDate
                where ilGuid=@ilGuid
            ");

            thisCommand.Parameters.AddWithValue("@ilGuid", ilGuid);
            thisCommand.Parameters.AddWithValue("@ilItem1", ilItem1);
            thisCommand.Parameters.AddWithValue("@ilItem2", ilItem2);
            thisCommand.Parameters.AddWithValue("@ilItem3", ilItem3);
            thisCommand.Parameters.AddWithValue("@ilItem4", ilItem4);
            thisCommand.Parameters.AddWithValue("@ilEffectiveDate", ilEffectiveDate);
            thisCommand.Parameters.AddWithValue("@ilModifyId", ilModifyDate);
            thisCommand.Parameters.AddWithValue("@slModifyDate", DateTime.Now);

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

    #region 刪除 sy_InsuranceLevel update giiStatus="D"
    public void DeleteInsuranceLevel()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_InsuranceLevel set ilStatus='D',ilModifyId=@ilModifyId,slModifyDate=@slModifyDate where ilGuid=@ilGuid
            ");

            thisCommand.Parameters.AddWithValue("@ilGuid", ilGuid);
            thisCommand.Parameters.AddWithValue("@ilModifyId", ilModifyDate);
            thisCommand.Parameters.AddWithValue("@slModifyDate", DateTime.Now);

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


    #region 檢查 sy_InsuranceLevel  ilItem1 月投保薪資是否重複
    public DataTable SelectInsuranceLevelItem1()
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
                select * from sy_InsuranceLevel where ilStatus='A'
            ");
            if (ilItem1.ToString().Trim() != "")
            {
                show_value.Append(@" and ilItem1=@ilItem1  ");
                thisCommand.Parameters.AddWithValue("@ilItem1", ilItem1);
            }
            if (ilGuid != "")
            {
                show_value.Append(@" and ilGuid=@ilGuid  ");
                thisCommand.Parameters.AddWithValue("@ilGuid", ilGuid);
            }
            if (ilGuid != "")
            {
                show_value.Append(@" and ilEffectiveDate=@ilEffectiveDate  ");
                thisCommand.Parameters.AddWithValue("@ilEffectiveDate", ilEffectiveDate);
            }
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

    #region 撈 sy_InsuranceLevel  生效日期
    public DataTable SelectInsuranceLevelDate()
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
                select ilEffectiveDate from sy_InsuranceLevel group by ilEffectiveDate order by ilEffectiveDate DESC
            ");
            //if (ilGuid != "")
            //{
            //    show_value.Append(@" and ilGuid=@ilGuid  ");
            //    thisCommand.Parameters.AddWithValue("@ilGuid", ilGuid);
            //}
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