using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;

/// <summary>
/// SalaryRange_DB 的摘要描述 
/// </summary>
public class SalaryRange_DB
{
    public SalaryRange_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    #region SalaryRange 私用
    string sr_Guid = string.Empty;
    string sr_Year = string.Empty;
    string sr_BeginDate = string.Empty;
    string sr_Enddate = string.Empty;
    string sr_SalaryDate = string.Empty;
    string sr_Ps = string.Empty;
    string sr_Status = string.Empty;
    #endregion
    #region SalaryRange 公用
    public string _sr_Guid
    {
        set { sr_Guid = value; }
    }
    public string _sr_Year
    {
        set { sr_Year = value; }
    }
    public string _sr_BeginDate
    {
        set { sr_BeginDate = value; }
    }
    public string _sr_Enddate
    {
        set { sr_Enddate = value; }
    }
    public string _sr_SalaryDate
    {
        set { sr_SalaryDate = value; }
    }
    public string _sr_Ps
    {
        set { sr_Ps = value; }
    }
    public string _sr_Status
    {
        set { sr_Status = value; }
    }
    #endregion

    #region 撈 計薪週期 條件 keyword or date(yyyy/mm/dd) or GUID
    public DataTable SelectSR()
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
                select * from sy_SalaryRange where sr_Status='A'
            ");

            if (sr_Year != "")
            {
                show_value.Append(@" and sr_Year=@sr_Year  ");
                thisCommand.Parameters.AddWithValue("@sr_Year", sr_Year);
            }
            if (sr_Guid != "")
            {
                show_value.Append(@" and sr_Guid=@sr_Guid  ");
                thisCommand.Parameters.AddWithValue("@sr_Guid", sr_Guid);
            }
            if (sr_SalaryDate != "")
            {
                show_value.Append(@" and sr_SalaryDate=@sr_SalaryDate  ");
                thisCommand.Parameters.AddWithValue("@sr_SalaryDate", sr_SalaryDate);
            }
            if (sr_BeginDate!="" && sr_Enddate!="") {
                show_value.Append(@" and (sr_BeginDate=@sr_BeginDate and sr_Enddate=@sr_Enddate ) ");
                thisCommand.Parameters.AddWithValue("@sr_BeginDate", sr_BeginDate);
                thisCommand.Parameters.AddWithValue("@sr_Enddate", sr_Enddate);
            }
            if (sr_BeginDate != "" && sr_Enddate == "")
            {
                show_value.Append(@" and sr_BeginDate>=@sr_BeginDate ");
                thisCommand.Parameters.AddWithValue("@sr_BeginDate", sr_BeginDate);
            }
            if (sr_BeginDate == "" && sr_Enddate != "")
            {
                show_value.Append(@" and sr_Enddate<=@sr_Enddate ");
                thisCommand.Parameters.AddWithValue("@sr_Enddate", sr_Enddate);
            }

            show_value.Append(@" order by sr_SalaryDate DESC ");
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

    #region 修改 計薪週期
    public void UpdateSR()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SalaryRange set sr_Year=@sr_Year,sr_BeginDate=@sr_BeginDate,sr_Enddate=@sr_Enddate,sr_SalaryDate=@sr_SalaryDate,sr_Ps=@sr_Ps,sr_Status='A' where sr_Guid=@sr_Guid
            ");

            thisCommand.Parameters.AddWithValue("@sr_Guid", sr_Guid);
            thisCommand.Parameters.AddWithValue("@sr_Year", sr_Year);
            thisCommand.Parameters.AddWithValue("@sr_BeginDate", sr_BeginDate);
            thisCommand.Parameters.AddWithValue("@sr_Enddate", sr_Enddate);
            thisCommand.Parameters.AddWithValue("@sr_SalaryDate", sr_SalaryDate);
            thisCommand.Parameters.AddWithValue("@sr_Ps", sr_Ps);

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

    #region 新增 sr
    public void InsertSR()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_SalaryRange(sr_Guid,sr_Year,sr_BeginDate,sr_Enddate,sr_SalaryDate,sr_Ps,sr_Status) 
                values(@sr_Guid,@sr_Year,@sr_BeginDate,@sr_Enddate,@sr_SalaryDate,@sr_Ps,'A') 
            ");

            thisCommand.Parameters.AddWithValue("@sr_Guid", sr_Guid);
            thisCommand.Parameters.AddWithValue("@sr_Year", sr_Year);
            thisCommand.Parameters.AddWithValue("@sr_BeginDate", sr_BeginDate);
            thisCommand.Parameters.AddWithValue("@sr_Enddate", sr_Enddate);
            thisCommand.Parameters.AddWithValue("@sr_SalaryDate", sr_SalaryDate);
            thisCommand.Parameters.AddWithValue("@sr_Ps", sr_Ps);

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

    #region 刪除 計薪週期
    public void DeleteSR()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SalaryRange set sr_Status='D' where sr_Guid=@sr_Guid
            ");
            thisCommand.Parameters.AddWithValue("@sr_Guid", sr_Guid);

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

    #region update 計薪週期匯入註記
    public void UpdateSRImportStatus()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_SalaryRange set sr_importStatus='Y' where sr_Guid=@sr_Guid
            ");

            thisCommand.Parameters.AddWithValue("@sr_Guid", sr_Guid);

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

    public DataTable ddlSelectList()
    {
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        StringBuilder sb = new StringBuilder();

        sb.Append(@"SELECT * from sy_SalaryRange where sr_Status='A' order by sr_BeginDate desc ");

        oCmd.CommandText = sb.ToString();
        oCmd.CommandType = CommandType.Text;
        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
        DataTable ds = new DataTable();
        oda.Fill(ds);
        return ds;
    }
}