using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_GroupInsuranceIdentity_DB 的摘要描述
/// </summary>
public class sy_GroupInsuranceIdentity_DB
{
    public sy_GroupInsuranceIdentity_DB()
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

    #region sy_GroupInsuranceIdentity 私用
    string giiGuid = string.Empty;
    string giidentityCode = string.Empty;
    string giiIdentity = string.Empty;
    string giiItem1 = string.Empty;
    string giiItem2 = string.Empty;
    string giiItem3 = string.Empty;
    string giiCreatId = string.Empty;
    string giiModifyId = string.Empty;
    string giiStatus = string.Empty;
    DateTime giiCreatDate;
    DateTime giiModifyDate;
    #endregion
    #region sy_GroupInsuranceIdentity 公用
    public string _giiGuid
    {
        set { giiGuid = value; }
    }
    public string _giidentityCode
    {
        set { giidentityCode = value; }
    }
    public string _giiIdentity
    {
        set { giiIdentity = value; }
    }
    public string _giiItem1
    {
        set { giiItem1 = value; }
    }
    public string _giiItem2
    {
        set { giiItem2 = value; }
    }
    public string _giiItem3
    {
        set { giiItem3 = value; }
    }
    public string _giiCreatId
    {
        set { giiCreatId = value; }
    }
    public string _giiModifyId
    {
        set { giiModifyId = value; }
    }
    public string _giiStatus
    {
        set { giiStatus = value; }
    }
    public DateTime _giiCreatDate
    {
        set { giiCreatDate = value; }
    }
    public DateTime _giiModifyDate
    {
        set { giiModifyDate = value; }
    }
    #endregion

    #region 撈 sy_GroupInsuranceIdentity  全/BY GUID/BY KEYWORD
    public DataTable SelectGroupInsuranceIdentity()
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
                select * from sy_GroupInsuranceIdentity where giiStatus='A'
            ");
            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(giidentityCode) LIKE '%' + upper(@str_keyword) + '%' or upper(giiIdentity) LIKE '%' + upper(@str_keyword) + '%' or upper(giiItem1) LIKE '%' + upper(@str_keyword) + '%' or upper(giiItem2) LIKE '%' + upper(@str_keyword) + '%' or upper(giiItem3) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (giiGuid != "")
            {
                show_value.Append(@" and giiGuid=@giiGuid  ");
                thisCommand.Parameters.AddWithValue("@giiGuid", giiGuid);
            }
            show_value.Append(@" order by giidentityCode ASC  ");
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

    #region 新增 sy_GroupInsuranceIdentity
    public void InsertGroupInsuranceIdentity()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_GroupInsuranceIdentity(giiGuid,giidentityCode,giiIdentity,giiItem1,giiItem2,giiItem3,giiCreatId,giiModifyId,giiModifyDate,giiStatus) 
                values(@giiGuid,@giidentityCode,@giiIdentity,@giiItem1,@giiItem2,@giiItem3,@giiCreatId,@giiModifyId,@giiModifyDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@giiGuid", giiGuid);
            thisCommand.Parameters.AddWithValue("@giidentityCode", giidentityCode);
            thisCommand.Parameters.AddWithValue("@giiIdentity", giiIdentity);
            thisCommand.Parameters.AddWithValue("@giiItem1", giiItem1);
            thisCommand.Parameters.AddWithValue("@giiItem2", giiItem2);
            thisCommand.Parameters.AddWithValue("@giiItem3", giiItem3);
            thisCommand.Parameters.AddWithValue("@giiCreatId", giiCreatId);
            thisCommand.Parameters.AddWithValue("@giiModifyId", giiModifyId);
            thisCommand.Parameters.AddWithValue("@giiStatus", giiStatus);
            thisCommand.Parameters.AddWithValue("@giiModifyDate", DateTime.Now);

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

    #region 修改 sy_GroupInsuranceIdentity
    public void UpdateGroupInsuranceIdentity()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_GroupInsuranceIdentity 
                set giidentityCode=@giidentityCode,giiIdentity=@giiIdentity,
                    giiItem1=@giiItem1,giiItem2=@giiItem2,giiItem3=@giiItem3,giiModifyId=@giiModifyId,giiModifyDate=@giiModifyDate
                where giiGuid=@giiGuid
            ");

            thisCommand.Parameters.AddWithValue("@giiGuid", giiGuid);
            thisCommand.Parameters.AddWithValue("@giidentityCode", giidentityCode);
            thisCommand.Parameters.AddWithValue("@giiIdentity", giiIdentity);
            thisCommand.Parameters.AddWithValue("@giiItem1", giiItem1);
            thisCommand.Parameters.AddWithValue("@giiItem2", giiItem2);
            thisCommand.Parameters.AddWithValue("@giiItem3", giiItem3);
            thisCommand.Parameters.AddWithValue("@giiModifyId", giiModifyId);
            thisCommand.Parameters.AddWithValue("@giiModifyDate", DateTime.Now);

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

    #region 刪除 sy_GroupInsuranceIdentity update giiStatus="D"
    public void DeleteGroupInsuranceIdentity()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_GroupInsuranceIdentity set giiStatus='D',giiModifyId=@giiModifyId,giiModifyDate=@giiModifyDate where giiGuid=@giiGuid
            ");

            thisCommand.Parameters.AddWithValue("@giiGuid", giiGuid);
            thisCommand.Parameters.AddWithValue("@giiModifyId", giiModifyId);
            thisCommand.Parameters.AddWithValue("@giiModifyDate", DateTime.Now);

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


    #region 檢查 sy_GroupInsuranceIdentity  giidentityCode 身分代碼是否重複
    public DataTable SelectGroupInsuranceIdentityCode()
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
                select * from sy_GroupInsuranceIdentity where giiStatus='A' 
            ");
            if (giidentityCode != "")
            {
                show_value.Append(@" and giidentityCode=@giidentityCode  ");
                thisCommand.Parameters.AddWithValue("@giidentityCode", giidentityCode);
            }
            if (giiGuid != "")
            {
                show_value.Append(@" and giiGuid=@giiGuid  ");
                thisCommand.Parameters.AddWithValue("@giiGuid", giiGuid);
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