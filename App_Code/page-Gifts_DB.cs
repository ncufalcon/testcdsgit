using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_Attendance_DB 的摘要描述
/// </summary>
public class page_Gifts_DB
{
    public page_Gifts_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 全私用
    string str_keyword = string.Empty;
    string str_dates = string.Empty;
    string str_datee = string.Empty;
    Int32 str_hours;
    #endregion
    #region 全公用
    public string _str_keyword
    {
        set { str_keyword = value; }
    }
    public string _str_dates
    {
        set { str_dates = value; }
    }
    public string _str_datee
    {
        set { str_datee = value; }
    }
    public Int32 _str_hours
    {
        set { str_hours = value; }
    }
    #endregion

    #region sy_Attendance 私用
    string aGuid = string.Empty;
    string aAttendanceDate = string.Empty;
    Decimal aDays;
    Decimal aTimes;
    Decimal aLeave;
    Decimal aGeneralOverTime1;
    Decimal aGeneralOverTime2;
    Decimal aGeneralOverTime3;
    Decimal aHolidayOverTime1;
    Decimal aHolidayOverTime2;
    Decimal aHolidayOverTime3;
    Decimal aHolidayOverTimes;
    Decimal aOffDayOverTime1;
    Decimal aOffDayOverTime2;
    Decimal aOffDayOverTime3;
    Decimal aOffDayOverTimes;
    string aRemark = string.Empty;
    string aItme = string.Empty;
    string aStatus = string.Empty;
    string aCreateId = string.Empty;
    string aModdifyId = string.Empty;
    DateTime aCreateDate;
    DateTime aModdifyDate;
    #endregion
    #region sy_Attendance 公用
    public string _aGuid
    {
        set { aGuid = value; }
    }
    public string _aAttendanceDate
    {
        set { aAttendanceDate = value; }
    }
    public decimal _aDays
    {
        set { aDays = value; }
    }
    public decimal _aTimes
    {
        set { aTimes = value; }
    }
    public decimal _aLeave
    {
        set { aLeave = value; }
    }
    public decimal _aGeneralOverTime1
    {
        set { aGeneralOverTime1 = value; }
    }
    public decimal _aGeneralOverTime2
    {
        set { aGeneralOverTime2 = value; }
    }
    public decimal _aGeneralOverTime3
    {
        set { aGeneralOverTime3 = value; }
    }
    public decimal _aHolidayOverTime1
    {
        set { aHolidayOverTime1 = value; }
    }
    public decimal _aHolidayOverTime2
    {
        set { aHolidayOverTime2 = value; }
    }
    public decimal _aHolidayOverTime3
    {
        set { aHolidayOverTime3 = value; }
    }
    public decimal _aHolidayOverTimes
    {
        set { aHolidayOverTimes = value; }
    }
    public decimal _aOffDayOverTime1
    {
        set { aOffDayOverTime1 = value; }
    }
    public decimal _aOffDayOverTime2
    {
        set { aOffDayOverTime2 = value; }
    }
    public decimal _aOffDayOverTime3
    {
        set { aOffDayOverTime3 = value; }
    }
    public decimal _aOffDayOverTimes
    {
        set { aOffDayOverTimes = value; }
    }
    public string _aRemark
    {
        set { aRemark = value; }
    }
    public string _aItme
    {
        set { aItme = value; }
    }
    public string _aStatus
    {
        set { aStatus = value; }
    }
    public string _aCreateId
    {
        set { aCreateId = value; }
    }
    public string _aModdifyId
    {
        set { aModdifyId = value; }
    }
    public DateTime _aCreateDate
    {
        set { aCreateDate = value; }
    }
    public DateTime _aModdifyDate
    {
        set { aModdifyDate = value; }
    }
    #endregion

    #region sy_PersonSingleAllowance 私用
    string paGuid = string.Empty;
    string paPerGuid = string.Empty;
    string paAllowanceCode = string.Empty;
    Decimal paPrice;
    Decimal paQuantity;
    Decimal paCost;
    string paDate = string.Empty;
    string paPs = string.Empty;
    string paCreateId = string.Empty;
    string paModifyId = string.Empty;
    string paStatus = string.Empty;
    DateTime paCreateDate;
    DateTime paModifyDate;
    #endregion
    #region sy_PersonSingleAllowance 公用
    public string _paGuid
    {
        set { paGuid = value; }
    }
    public string _paPerGuid
    {
        set { paPerGuid = value; }
    }
    public string _paAllowanceCode
    {
        set { paAllowanceCode = value; }
    }
    public decimal _paPrice
    {
        set { paPrice = value; }
    }
    public decimal _paQuantity
    {
        set { paQuantity = value; }
    }
    public decimal _paCost
    {
        set { paCost = value; }
    }
    public string _paDate
    {
        set { paDate = value; }
    }
    public string _paPs
    {
        set { paPs = value; }
    }
    public string _paCreateId
    {
        set { paCreateId = value; }
    }
    public string _paModifyId
    {
        set { paModifyId = value; }
    }
    public string _paStatus
    {
        set { paStatus = value; }
    }
    public DateTime _paCreateDate
    {
        set { paCreateDate = value; }
    }
    public DateTime _paModifyDate
    {
        set { paModifyDate = value; }
    }
    #endregion

    #region 撈 sy_Attendance
    public DataTable SelectAttendance()
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
                select 
                aperGuid
                ,sum_aTimes
                ,sum_aGeneralOverTime1+sum_aGeneralOverTime2+sum_aGeneralOverTime3+sum_aHolidayOverTimes+sum_aOffDayOverTimes as sum_other
                ,sum_aTimes+sum_aGeneralOverTime1+sum_aGeneralOverTime2+sum_aGeneralOverTime3+sum_aHolidayOverTimes+sum_aOffDayOverTimes as sum_all
                into #tmp_all
                from 
                (
	                select 
	                aperGuid,
	                SUM(aTimes) as sum_aTimes
	                ,SUM(aGeneralOverTime1)as sum_aGeneralOverTime1
	                ,SUM(aGeneralOverTime2)as sum_aGeneralOverTime2
	                ,SUM(aGeneralOverTime3)as sum_aGeneralOverTime3
	                ,SUM(aHolidayOverTimes)as sum_aHolidayOverTimes
	                ,SUM(aOffDayOverTimes)as sum_aOffDayOverTimes
	                from
	                (
		                select aperGuid,aItme
		                ,case aItme when '02' then (0-aTimes) else aTimes end as aTimes
		                ,case aItme when '02' then (0-aGeneralOverTime1) else aGeneralOverTime1 end as aGeneralOverTime1
		                ,case aItme when '02' then (0-aGeneralOverTime2) else aGeneralOverTime2 end as aGeneralOverTime2
		                ,case aItme when '02' then (0-aGeneralOverTime3) else aGeneralOverTime1 end as aGeneralOverTime3
		                ,case aItme when '02' then (0-aHolidayOverTimes) else aHolidayOverTimes end as aHolidayOverTimes
		                ,case aItme when '02' then (0-aOffDayOverTimes) else aGeneralOverTime1 end as aOffDayOverTimes
		                from sy_Attendance where 1=1
            ");
            if (str_dates != "" && str_datee != "")
            {
                show_value.Append(@" and aAttendanceDate between @str_dates and @str_datee  ");
                thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            }
            //where aAttendanceDate between '2017/04/01' and '2017/04/12'
            show_value.Append(@"          
                    )#tmp
	                group by aperGuid
                )#tmp2
                select aperGuid,cbName,perNo,perName,sum_aTimes,sum_other,sum_all,(sum_aTimes-sum_other) as sum_normal
                from #tmp_all left join sy_Person on aperGuid=perGuid
                left join sy_CodeBranches on perDep=cbGuid where 1=1
            ");
            if (str_hours != 0)
            {
                show_value.Append(@" and sum_all>@str_hours ");
                thisCommand.Parameters.AddWithValue("@str_hours", str_hours);
            }
            show_value.Append(@" order by aperGuid ");

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

    #region 撈 codetable join sy_SalaryItem 撈GUID
    public DataTable SelectCodeRefItem()
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
                select code_desc,code_value,siGuid
                from sy_codetable
                left join sy_SalaryItem on code_value=siRef
                where code_group='16' and code_value<>'01' and code_value<>'02'
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

    #region 新增 sy_PersonSingleAllowance
    public void InsertPersonSingleAllowance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            //用insert into select 做
            show_value.Append(@" 
            CREATE TABLE #tmp
            (
              aperGuid nvarchar(50)
              ,cbName nvarchar(20)
              ,perNo  nvarchar(20)
              ,perName nvarchar(20)
              ,sum_aTimes decimal(10, 1)
              ,sum_other decimal(10, 1)
              ,sum_all decimal(10, 1)
              ,sum_normal decimal(10, 1)
            )

            insert into #tmp exec sp_GigtHoursData @str_dates,@str_datee,@str_hours

            insert into sy_PersonSingleAllowance (paGuid,paPerGuid,paAllowanceCode,paPrice,paQuantity,paCost,paDate,paPs,paCreateId,paCreateDate,paModifyId,paModifyDate,paStatus,paImport,paImportDate) 
            select NEWID(),#tmp.aperGuid,@paAllowanceCode,@paPrice,1,@paCost,@paDate,'',@paCreateId,@paCreateDate,@paModifyId,@paModifyDate,'A',@paImport,@paImportDate
            from #tmp
                       
            ");

            thisCommand.Parameters.AddWithValue("@paGuid", paGuid);
            thisCommand.Parameters.AddWithValue("@paPerGuid", paPerGuid);
            thisCommand.Parameters.AddWithValue("@paAllowanceCode", paAllowanceCode);
            thisCommand.Parameters.AddWithValue("@paPrice", paPrice);
            thisCommand.Parameters.AddWithValue("@paCost", paCost);
            thisCommand.Parameters.AddWithValue("@paDate", paDate);
            thisCommand.Parameters.AddWithValue("@paCreateId", paCreateId);
            thisCommand.Parameters.AddWithValue("@paCreateDate", DateTime.Now);
            thisCommand.Parameters.AddWithValue("@paModifyId", paModifyId);
            thisCommand.Parameters.AddWithValue("@paModifyDate", DateTime.Now);
            thisCommand.Parameters.AddWithValue("@paImport", DBNull.Value);
            thisCommand.Parameters.AddWithValue("@paImportDate", DBNull.Value);
            thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
            thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            thisCommand.Parameters.AddWithValue("@str_hours", str_hours);

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