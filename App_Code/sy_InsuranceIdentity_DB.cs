using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_InsuranceIdentity_DB 的摘要描述
/// </summary>
public class sy_InsuranceIdentity_DB
{
    public sy_InsuranceIdentity_DB()
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

    #region sy_InsuranceIdentity 私用
    string iiGuid = string.Empty;
    string iiIdentityCode = string.Empty;
    string iiIdentity = string.Empty;
    string iiInsurance1 = string.Empty;
    string iiInsurance2 = string.Empty;
    string iiInsurance3 = string.Empty;
    string iiInsurance4 = string.Empty;
    string iiInsurance5 = string.Empty;
    string iiRetirement = string.Empty;
    string iiCreatId = string.Empty;
    string iiModifyId = string.Empty;
    string iiStatus = string.Empty;
    DateTime iiCreatDate;
    DateTime iiModifyDate;
    #endregion
    #region sy_InsuranceIdentity 公用
    public string _iiGuid
    {
        set { iiGuid = value; }
    }
    public string _iiIdentityCode
    {
        set { iiIdentityCode = value; }
    }
    public string _iiIdentity
    {
        set { iiIdentity = value; }
    }
    public string _iiInsurance1
    {
        set { iiInsurance1 = value; }
    }
    public string _iiInsurance2
    {
        set { iiInsurance2 = value; }
    }
    public string _iiInsurance3
    {
        set { iiInsurance3 = value; }
    }
    public string _iiInsurance4
    {
        set { iiInsurance4 = value; }
    }
    public string _iiInsurance5
    {
        set { iiInsurance5 = value; }
    }
    public string _iiCreatId
    {
        set { iiCreatId = value; }
    }
    public string _iiModifyId
    {
        set { iiModifyId = value; }
    }
    public string _iiStatus
    {
        set { iiStatus = value; }
    }
    public string _iiRetirement
    {
        set { iiRetirement = value; }
    }
    public DateTime _iiCreatDate
    {
        set { iiCreatDate = value; }
    }
    public DateTime _iiModifyDate
    {
        set { iiModifyDate = value; }
    }
    #endregion

    #region 撈 sy_InsuranceIdentity  全/BY GUID/BY KEYWORD
    public DataTable SelectInsuranceIdentity()
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
                select * from sy_InsuranceIdentity where iiStatus='A'
            ");
            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(iiIdentityCode) LIKE '%' + upper(@str_keyword) + '%' or upper(iiIdentity) LIKE '%' + upper(@str_keyword) + '%'or upper(iiRetirement) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (iiGuid != "")
            {
                show_value.Append(@" and iiGuid=@iiGuid  ");
                thisCommand.Parameters.AddWithValue("@iiGuid", iiGuid);
            }
            show_value.Append(@" order by iiIdentityCode ASC  ");
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

    #region 新增 sy_InsuranceIdentity
    public void InsertInsuranceIdentity()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_InsuranceIdentity(iiGuid,iiIdentityCode,iiIdentity,iiInsurance1,iiInsurance2,iiInsurance3,iiInsurance4,iiInsurance5,iiRetirement,iiCreatId,iiModifyId,iiModifyDate,iiStatus) 
                values(@iiGuid,@iiIdentityCode,@iiIdentity,@iiInsurance1,@iiInsurance2,@iiInsurance3,@iiInsurance4,@iiInsurance5,@iiRetirement,@iiCreatId,@iiModifyId,@iiModifyDate,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@iiGuid", iiGuid);
            thisCommand.Parameters.AddWithValue("@iiIdentityCode", iiIdentityCode);
            thisCommand.Parameters.AddWithValue("@iiIdentity", iiIdentity);
            thisCommand.Parameters.AddWithValue("@iiInsurance1", iiInsurance1);
            thisCommand.Parameters.AddWithValue("@iiInsurance2", iiInsurance2);
            thisCommand.Parameters.AddWithValue("@iiInsurance3", iiInsurance3);
            thisCommand.Parameters.AddWithValue("@iiInsurance4", iiInsurance4);
            thisCommand.Parameters.AddWithValue("@iiInsurance5", iiInsurance5);
            thisCommand.Parameters.AddWithValue("@iiRetirement", iiRetirement);
            thisCommand.Parameters.AddWithValue("@iiCreatId", iiCreatId);
            thisCommand.Parameters.AddWithValue("@iiModifyId", iiModifyId);
            thisCommand.Parameters.AddWithValue("@iiModifyDate", DateTime.Now);

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

    #region 修改 sy_InsuranceIdentity
    public void UpdateInsuranceIdentity()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_InsuranceIdentity 
                set iiIdentityCode=@iiIdentityCode,iiIdentity=@iiIdentity,
                    iiInsurance1=@iiInsurance1,iiInsurance2=@iiInsurance2,iiInsurance3=@iiInsurance3,iiInsurance4=@iiInsurance4,
                    iiInsurance5=@iiInsurance5,iiRetirement=@iiRetirement,iiModifyId=@iiModifyId,iiModifyDate=@iiModifyDate
                where iiGuid=@iiGuid
            ");

            thisCommand.Parameters.AddWithValue("@iiGuid", iiGuid);
            thisCommand.Parameters.AddWithValue("@iiIdentityCode", iiIdentityCode);
            thisCommand.Parameters.AddWithValue("@iiIdentity", iiIdentity);
            thisCommand.Parameters.AddWithValue("@iiInsurance1", iiInsurance1);
            thisCommand.Parameters.AddWithValue("@iiInsurance2", iiInsurance2);
            thisCommand.Parameters.AddWithValue("@iiInsurance3", iiInsurance3);
            thisCommand.Parameters.AddWithValue("@iiInsurance4", iiInsurance4);
            thisCommand.Parameters.AddWithValue("@iiInsurance5", iiInsurance5);
            thisCommand.Parameters.AddWithValue("@iiRetirement", iiRetirement);
            thisCommand.Parameters.AddWithValue("@iiModifyId", iiModifyId);
            thisCommand.Parameters.AddWithValue("@iiModifyDate", DateTime.Now);

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

    #region 刪除 sy_InsuranceIdentity update giStatus="D"
    public void DeleteInsuranceIdentity()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_InsuranceIdentity set iiStatus='D',iiModifyId=@iiModifyId,iiModifyDate=@iiModifyDate
                where iiGuid=@iiGuid
            ");

            thisCommand.Parameters.AddWithValue("@iiGuid", iiGuid);
            thisCommand.Parameters.AddWithValue("@iiModifyId", iiModifyId);
            thisCommand.Parameters.AddWithValue("@iiModifyDate", DateTime.Now);

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

    #region 檢查 sy_InsuranceIdentity  iiIdentityCode是否重複
    public DataTable SelectInsuranceIdentityCode()
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
                select * from sy_InsuranceIdentity where iiStatus='A' 
            ");
            if (iiIdentityCode != "")
            {
                show_value.Append(@" and iiIdentityCode=@iiIdentityCode ");
                thisCommand.Parameters.AddWithValue("@iiIdentityCode", iiIdentityCode);
            }
            if (iiGuid != "")
            {
                show_value.Append(@" and iiGuid=@iiGuid  ");
                thisCommand.Parameters.AddWithValue("@iiGuid", iiGuid);
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