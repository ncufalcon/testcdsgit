using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_GroupInsurance_DB 的摘要描述
/// </summary>
public class sy_GroupInsurance_DB
{
    public sy_GroupInsurance_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    # region 全 私用
    string str_keyword = string.Empty;
    #endregion
    # region 全 公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    #endregion

    #region sy_GroupInsurance私用
    string giGuid = string.Empty;
    string giInsuranceCode = string.Empty;
    Decimal giInsuranceName;
    string giAge = string.Empty;
    string giPs = string.Empty;
    string giCreatId = string.Empty;
    string giModifyId = string.Empty;
    string giStatus = string.Empty;
    DateTime giCreatDate;
    DateTime giModifyDate;
    #endregion
    #region sy_GroupInsurance 公用
    public string _giGuid
    {
        set { giGuid = value; }
    }
    public string _giInsuranceCode
    {
        set { giInsuranceCode = value; }
    }
    public Decimal _giInsuranceName
    {
        set { giInsuranceName = value; }
    }
    public string _giAge
    {
        set { giAge = value; }
    }
    public string _giPs
    {
        set { giPs = value; }
    }
    public string _giCreatId
    {
        set { giCreatId = value; }
    }
    public string _giModifyId
    {
        set { giModifyId = value; }
    }
    public string _giStatus
    {
        set { giStatus = value; }
    }
    public DateTime _giCreatDate
    {
        set { giCreatDate = value; }
    }
    public DateTime _giModifyDate
    {
        set { giModifyDate = value; }
    }
    #endregion

    #region 撈 sy_GroupInsurance  全/BY GUID/BY KEYWORD
    public DataTable SelectGroupInsurance()
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
                select * from sy_GroupInsurance where giStatus='A'
            ");
            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(giInsuranceCode) LIKE '%' + upper(@str_keyword) + '%' or upper(giInsuranceName) LIKE '%' + upper(@str_keyword) + '%'or upper(giAge) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (giGuid != "")
            {
                show_value.Append(@" and giGuid=@giGuid  ");
                thisCommand.Parameters.AddWithValue("@giGuid", giGuid);
            }
            show_value.Append(@" order by giInsuranceCode ASC  ");
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

    #region 新增 sy_GroupInsurance
    public void InsertGroupInsurance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_GroupInsurance(giGuid,giInsuranceCode,giInsuranceName,giAge,giPs,giCreatId,giModifyId,giStatus,giModifyDate) 
                values(@giGuid,@giInsuranceCode,@giInsuranceName,@giAge,@giPs,@giCreatId,@giModifyId,'A',@giModifyDate) 
            ");

            thisCommand.Parameters.AddWithValue("@giGuid", giGuid);
            thisCommand.Parameters.AddWithValue("@giInsuranceCode", giInsuranceCode);
            thisCommand.Parameters.AddWithValue("@giInsuranceName", giInsuranceName);
            thisCommand.Parameters.AddWithValue("@giAge", giAge);
            thisCommand.Parameters.AddWithValue("@giPs", giPs);
            thisCommand.Parameters.AddWithValue("@giCreatId", giCreatId);
            thisCommand.Parameters.AddWithValue("@giModifyId", giModifyId);
            thisCommand.Parameters.AddWithValue("@giStatus", giStatus);
            thisCommand.Parameters.AddWithValue("@giModifyDate", DateTime.Now);

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

    #region 修改 sy_GroupInsurance
    public void UpdateGroupInsurance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_GroupInsurance 
                set giInsuranceCode=@giInsuranceCode,giInsuranceName=@giInsuranceName,
                    giAge=@giAge,giPs=@giPs,giModifyId=@giModifyId,giModifyDate=@giModifyDate
                where giGuid=@giGuid
            ");

            thisCommand.Parameters.AddWithValue("@giGuid", giGuid);
            thisCommand.Parameters.AddWithValue("@giInsuranceCode", giInsuranceCode);
            thisCommand.Parameters.AddWithValue("@giInsuranceName", giInsuranceName);
            thisCommand.Parameters.AddWithValue("@giAge", giAge);
            thisCommand.Parameters.AddWithValue("@giPs", giPs);
            thisCommand.Parameters.AddWithValue("@giModifyId", giModifyId);
            thisCommand.Parameters.AddWithValue("@giModifyDate", DateTime.Now);

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

    #region 刪除 sy_GroupInsurance update giStatus="D"
    public void DeleteGroupInsurance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_GroupInsurance set giStatus='D',giModifyId=@giModifyId,giModifyDate=@giModifyDate where giGuid=@giGuid
            ");

            thisCommand.Parameters.AddWithValue("@giGuid", giGuid);
            thisCommand.Parameters.AddWithValue("@giModifyId", giModifyId);
            thisCommand.Parameters.AddWithValue("@giModifyDate", DateTime.Now);

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


    #region 檢查 sy_GroupInsurance  保險代號是否重複
    public DataTable SelectGroupInsuranceCode()
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
                select * from sy_GroupInsurance where giStatus='A' 
            ");
            if (giInsuranceCode != "")
            {
                show_value.Append(@" and giInsuranceCode=@giInsuranceCode  ");
                thisCommand.Parameters.AddWithValue("@giInsuranceCode", giInsuranceCode);
            }
            if (giGuid != "")
            {
                show_value.Append(@" and giGuid=@giGuid  ");
                thisCommand.Parameters.AddWithValue("@giGuid", giGuid);
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

}