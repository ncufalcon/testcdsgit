using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_SalaryItem_DB 的摘要描述
/// </summary>
public class sy_SalaryItem_DB
{
    public sy_SalaryItem_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 全私用
    string str_keyword = string.Empty;
    string str_perguid = string.Empty;
    #endregion
    #region 全公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    public string _str_perguid
    {
        set { str_perguid = value; }
    }
    #endregion

    #region sy_SalaryItem 私用
    string siGuid = string.Empty;
    string siItemCode = string.Empty;
    string siItemName = string.Empty;
    string siAdd = string.Empty;
    string siInsurance = string.Empty;
    string siBenefit = string.Empty;
    string siSupplementaryPremium = string.Empty;
    string siIncomeTax = string.Empty;
    string siCreatId = string.Empty;
    string siModifyId = string.Empty;
    string siStatus = string.Empty;
    string siRef = string.Empty;
    string siRefcom = string.Empty;
    DateTime siCreatDate;
    DateTime siModifyDate;
    #endregion
    #region sy_SalaryFormula 公用
    public string _siGuid
    {
        set { siGuid = value; }
    }
    public string _siItemCode
    {
        set { siItemCode = value; }
    }
    public string _siItemName
    {
        set { siItemName = value; }
    }
    public string _siAdd
    {
        set { siAdd = value; }
    }
    public string _siInsurance
    {
        set { siInsurance = value; }
    }
    public string _siBenefit
    {
        set { siBenefit = value; }
    }
    public string _siSupplementaryPremium
    {
        set { siSupplementaryPremium = value; }
    }
    public string _siIncomeTax
    {
        set { siIncomeTax = value; }
    }
    public string _siCreatId
    {
        set { siCreatId = value; }
    }
    public string _siModifyId
    {
        set { siModifyId = value; }
    }
    public string _siStatus
    {
        set { siStatus = value; }
    }
    public string _siRef
    {
        set { siRef = value; }
    }
    public string _siRefcom
    {
        set { siRefcom = value; }
    }
    public DateTime _siCreatDate
    {
        set { siCreatDate = value; }
    }
    public DateTime _siModifyDate
    {
        set { siModifyDate = value; }
    }
    #endregion

    #region 撈 sy_SalaryItem 條件 keyword or GUID
    public DataTable SelectSalaryItem()
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
                select *
                from sy_SalaryItem
                where siStatus='A'
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(siItemCode) LIKE '%' + upper(@str_keyword) + '%' or upper(siItemName) LIKE '%' + upper(@str_keyword) + '%' or upper(siAdd) LIKE '%' + upper(@str_keyword) + '%' or upper(siIncomeTax) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            if (siGuid != "")
            {
                show_value.Append(@" and siGuid=@siGuid  ");
                thisCommand.Parameters.AddWithValue("@siGuid", siGuid);
            }
            show_value.Append(@"  
                order by siCreatDate DESC
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

    #region 新增 sy_SalaryItem
    public void InsertSalaryItem()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_SalaryItem (siGuid,siItemCode,siItemName,siAdd,siInsurance,siBenefit,siSupplementaryPremium,siIncomeTax,siCreatId,siCreatDate,siStatus,siRef,siRefcom) 
                values(@siGuid,@siItemCode,@siItemName,@siAdd,@siInsurance,@siBenefit,@siSupplementaryPremium,@siIncomeTax,@siCreatId,@siCreatDate,'A',@siRef,@siRefcom) 
            ");

            thisCommand.Parameters.AddWithValue("@siGuid", siGuid);
            thisCommand.Parameters.AddWithValue("@siItemCode", siItemCode);
            thisCommand.Parameters.AddWithValue("@siItemName", siItemName);
            thisCommand.Parameters.AddWithValue("@siAdd", siAdd);
            thisCommand.Parameters.AddWithValue("@siInsurance", siInsurance);
            thisCommand.Parameters.AddWithValue("@siBenefit", siBenefit);
            thisCommand.Parameters.AddWithValue("@siSupplementaryPremium", siSupplementaryPremium);
            thisCommand.Parameters.AddWithValue("@siIncomeTax", siIncomeTax);
            thisCommand.Parameters.AddWithValue("@siCreatId", siCreatId);
            thisCommand.Parameters.AddWithValue("@siRef", siRef);
            thisCommand.Parameters.AddWithValue("@siRefcom", siRefcom);
            thisCommand.Parameters.AddWithValue("@siCreatDate", DateTime.Now);

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

    #region 修改 sy_PersonChange
    public void UpdateSalaryItem()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SalaryItem set siItemCode=@siItemCode,siItemName=@siItemName,siAdd=@siAdd,siInsurance=@siInsurance,siBenefit=@siBenefit,siSupplementaryPremium=@siSupplementaryPremium,siIncomeTax=@siIncomeTax,siModifyId=@siModifyId,siRef=@siRef,siModifyDate=@siModifyDate,siRefcom=@siRefcom
                where  siGuid=@siGuid               
            ");

            thisCommand.Parameters.AddWithValue("@siGuid", siGuid);
            thisCommand.Parameters.AddWithValue("@siItemCode", siItemCode);
            thisCommand.Parameters.AddWithValue("@siItemName", siItemName);
            thisCommand.Parameters.AddWithValue("@siAdd", siAdd);
            thisCommand.Parameters.AddWithValue("@siInsurance", siInsurance);
            thisCommand.Parameters.AddWithValue("@siBenefit", siBenefit);
            thisCommand.Parameters.AddWithValue("@siSupplementaryPremium", siSupplementaryPremium);
            thisCommand.Parameters.AddWithValue("@siIncomeTax", siIncomeTax);
            thisCommand.Parameters.AddWithValue("@siModifyId", siModifyId);
            thisCommand.Parameters.AddWithValue("@siRef", siRef);
            thisCommand.Parameters.AddWithValue("@siRefcom", siRefcom);
            thisCommand.Parameters.AddWithValue("@siModifyDate", DateTime.Now);

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

    #region 撈 sy_SalaryItem 檢查siItemCode有沒有重複
    public DataTable ChksiItemCode()
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
                select siItemCode
                from sy_SalaryItem
                where siStatus='A'
            ");
            if (siItemCode != "")
            {
                show_value.Append(@" and siItemCode=@siItemCode  ");
                thisCommand.Parameters.AddWithValue("@siItemCode", siItemCode);
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

    #region 刪除 sy_PersonChange
    public void DeleteSalaryItem()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SalaryItem set siStatus='D'  where siGuid=@siGuid               
            ");

            thisCommand.Parameters.AddWithValue("@siGuid", siGuid);

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

    #region 撈 sy_SalaryItem 檢查 siRefcom 對應欄位(在勞健保比對使用) 加項&扣項在這張表一種只能存在一個
    public DataTable ChksiItemCodeRefcom()
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
                select * from sy_SalaryItem where siStatus='A' and siRefcom=@siRefcom
            ");
            thisCommand.Parameters.AddWithValue("@siRefcom", siRefcom);
            if (siGuid != "")
            {
                show_value.Append(@" and siGuid=@siGuid  ");
                thisCommand.Parameters.AddWithValue("@siGuid", siGuid);
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

    #region 撈 sy_SalaryItem for 開窗用
    public DataTable SelectSalaryItemForWindow()
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
                select siGuid,siItemCode,siItemName from sy_SalaryItem where siStatus='A' and (siRef='底薪' or siRef='職能加給')
                union 
                select paAllowanceCode,
                (select siItemCode from sy_SalaryItem where siGuid=paAllowanceCode) siItemCode,
                (select siItemName from sy_SalaryItem where siGuid=paAllowanceCode) siItemName
                from sv_PersonAllowance where paStatus='A' and paPerGuid=@str_perguid
            ");

            if (str_keyword != "")
            {
                show_value.Append(@" and (upper(siItemCode) LIKE '%' + upper(@str_keyword) + '%' or upper(siItemName) LIKE '%' + upper(@str_keyword) + '%' or upper(siAdd) LIKE '%' + upper(@str_keyword) + '%' or upper(siIncomeTax) LIKE '%' + upper(@str_keyword) + '%' )  ");
                thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
            }
            thisCommand.Parameters.AddWithValue("@str_perguid", str_perguid);

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