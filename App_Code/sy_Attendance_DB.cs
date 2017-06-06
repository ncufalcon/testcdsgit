using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

/// <summary>
/// sy_Attendance 的摘要描述
/// </summary>
public class sy_Attendance_DB
{
    #region 全私用
    string str_keyword = string.Empty;
    string str_dates = string.Empty;
    string str_datee = string.Empty;
    string str_perno = string.Empty;
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
    public string _str_perno
    {
        set { str_perno = value; }
    }
    #endregion

    #region sy_Attendance 私用
    string aGuid = string.Empty;
    string aperGuid = string.Empty;
    string aAttendanceDate = string.Empty;
    Int32 aDays;
    Decimal aTimes;
    Decimal aLeave;
    Decimal aGeneralOverTime1;
    Decimal aGeneralOverTime2;
    Decimal aGeneralOverTime3;
    Decimal aOffDayOverTime1;
    Decimal aOffDayOverTime2;
    Decimal aOffDayOverTime3;
    Decimal aHolidayOverTimes;
    Decimal aHolidayOverTime1;
    Decimal aHolidayOverTime2;
    Decimal aHolidayOverTime3;
    Decimal aNationalholidays;
    Decimal aNationalholidays1;
    Decimal aNationalholidays2;
    Decimal aNationalholidays3;
    Decimal aSpecialholiday;
    Decimal aSpecialholiday1;
    Decimal aSpecialholiday2;
    Decimal aSpecialholiday3;
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
    { set
        { aGuid = value; }
    }
    public string _aperGuid
    {
        set { aperGuid = value; }
    }
    public string _aAttendanceDate
    {
        set { aAttendanceDate = value; }
    }
    public Int32 _aDays
    {
        set { aDays = value; }
    }
    public Decimal _aTimes
    {
        set { aTimes = value; }
    }
    public Decimal _aLeave
    {
        set { aLeave = value; }
    }
    public Decimal _aGeneralOverTime1
    {
        set { aGeneralOverTime1 = value; }
    }
    public Decimal _aGeneralOverTime2
    {
        set { aGeneralOverTime2 = value; }
    }
    public Decimal _aGeneralOverTime3
    {
        set { aGeneralOverTime3 = value; }
    }
    public Decimal _aOffDayOverTime1
    {
        set { aOffDayOverTime1 = value; }
    }
    public Decimal _aOffDayOverTime2
    {
        set { aOffDayOverTime2 = value; }
    }
    public Decimal _aOffDayOverTime3
    {
        set { aOffDayOverTime3 = value; }
    }
    public Decimal _aHolidayOverTimes
    {
        set { aHolidayOverTimes = value; }
    }
    public Decimal _aHolidayOverTime1
    {
        set { aHolidayOverTime1 = value; }
    }
    public Decimal _aHolidayOverTime2
    {
        set { aHolidayOverTime2 = value; }
    }
    public Decimal _aHolidayOverTime3
    {
        set { aHolidayOverTime3 = value; }
    }
    public Decimal _aNationalholidays
    {
        set { aNationalholidays = value; }
    }
    public Decimal _aNationalholidays1
    {
        set { aNationalholidays1 = value; }
    }
    public Decimal _aNationalholidays2
    {
        set { aNationalholidays2 = value; }
    }
    public Decimal _aNationalholidays3
    {
        set { aNationalholidays3 = value; }
    }
    public Decimal _aSpecialholiday
    {
        set { aSpecialholiday = value; }
    }
    public Decimal _aSpecialholiday1
    {
        set { aSpecialholiday1 = value; }
    }
    public Decimal _aSpecialholiday2
    {
        set { aSpecialholiday2 = value; }
    }
    public Decimal _aSpecialholiday3
    {
        set { aSpecialholiday3 = value; }
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
    public sy_Attendance_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }
    #region 撈 sy_Attendance 條件 keyword or GUID or dates datee
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
            //如果都沒有查詢條件 只顯示最新100
            if (str_keyword == "" && str_dates == "" && str_datee == "" && aGuid == "")
            {
                show_value.Append(@"  
                    select top 100 aGuid,aperGuid,aAttendanceDate,aDays,aTimes,aLeave,aGeneralOverTime1,aGeneralOverTime2,aGeneralOverTime3,aOffDayOverTime1,aOffDayOverTime2,aOffDayOverTime3
                        ,aHolidayOverTimes,aHolidayOverTime1,aHolidayOverTime2,aHolidayOverTime3,aNationalholidays,aNationalholidays1,aNationalholidays2,aNationalholidays3,aNationalholidays
                        ,aSpecialholiday,aSpecialholiday1,aSpecialholiday2,aSpecialholiday3,aRemark,aItme,aStatus,aCreateId,aCreateDate,aModdifyId,aModdifyDate,perNo,perName
                    from sy_Attendance left join sy_Person on aperGuid=perGuid
                    where aStatus='A'
                ");
            }
            else {
                show_value.Append(@"  
                    select aGuid,aperGuid,aAttendanceDate,aDays,aTimes,aLeave,aGeneralOverTime1,aGeneralOverTime2,aGeneralOverTime3,aOffDayOverTime1,aOffDayOverTime2,aOffDayOverTime3
                        ,aHolidayOverTimes,aHolidayOverTime1,aHolidayOverTime2,aHolidayOverTime3,aNationalholidays,aNationalholidays1,aNationalholidays2,aNationalholidays3,aNationalholidays
                        ,aSpecialholiday,aSpecialholiday1,aSpecialholiday2,aSpecialholiday3,aRemark,aItme,aStatus,aCreateId,aCreateDate,aModdifyId,aModdifyDate,perNo,perName
                    from sy_Attendance left join sy_Person on aperGuid=perGuid
                    where aStatus='A'
                ");
                if (str_keyword != "")
                {
                    show_value.Append(@" and (upper(aAttendanceDate) LIKE '%' + upper(@str_keyword) + '%' or upper(perNo) LIKE '%' + upper(@str_keyword) + '%' or upper(perName) LIKE '%' + upper(@str_keyword) + '%' )  ");
                    thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
                }
                if (aGuid != "")
                {
                    show_value.Append(@" and aGuid=@aGuid  ");
                    thisCommand.Parameters.AddWithValue("@aGuid", aGuid);
                }
                if (str_dates != "" && str_datee != "")
                {
                    show_value.Append(@" and (aAttendanceDate between str_dates andd str_datee)  ");
                    thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                    thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
                }
                if (str_dates != "" && str_datee == "")
                {
                    show_value.Append(@" and aAttendanceDate>@str_dates  ");
                    thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                }
                if (str_dates == "" && str_datee != "")
                {
                    show_value.Append(@" and aAttendanceDate<@str_datee  ");
                    thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
                }
                
            }
            show_value.Append(@"  
                order by aAttendanceDate DESC,perNo ASC
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

    #region 刪除 sy_Attendance update status="D"
    public void DeleteAttendance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Attendance set aStatus='D'  where aGuid=@aGuid               
            ");

            thisCommand.Parameters.AddWithValue("@aGuid", aGuid);

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

    #region 新增 sy_Attendance
    public void InsertAttendance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_Attendance 
                (
                    aGuid,aperGuid,aAttendanceDate,aDays,aTimes,aLeave,aGeneralOverTime1,aGeneralOverTime2,aGeneralOverTime3,aOffDayOverTime1,aOffDayOverTime2,aOffDayOverTime3
                    ,aHolidayOverTimes,aHolidayOverTime1,aHolidayOverTime2,aHolidayOverTime3,aNationalholidays,aNationalholidays1,aNationalholidays2,aNationalholidays3
                    ,aSpecialholiday,aSpecialholiday1,aSpecialholiday2,aSpecialholiday3,aRemark,aItme,aStatus,aCreateId,aCreateDate,aModdifyId,aModdifyDate
                ) 
                values
                (
                    @aGuid,@aperGuid,@aAttendanceDate,@aDays,@aTimes,@aLeave,@aGeneralOverTime1,@aGeneralOverTime2,@aGeneralOverTime3,@aOffDayOverTime1,@aOffDayOverTime2,@aOffDayOverTime3
                    ,@aHolidayOverTimes,@aHolidayOverTime1,@aHolidayOverTime2,@aHolidayOverTime3,@aNationalholidays,@aNationalholidays1,@aNationalholidays2,@aNationalholidays3
                    ,@aSpecialholiday,@aSpecialholiday1,@aSpecialholiday2,@aSpecialholiday3,@aRemark,@aItme,'A',@aCreateId,@aCreateDate,@aModdifyId,@aModdifyDate
                ) 
            ");
            thisCommand.Parameters.AddWithValue("@aGuid", aGuid);
            thisCommand.Parameters.AddWithValue("@aperGuid", aperGuid );
            thisCommand.Parameters.AddWithValue("@aAttendanceDate",aAttendanceDate );
            thisCommand.Parameters.AddWithValue("@aDays",aDays );
            thisCommand.Parameters.AddWithValue("@aTimes",aTimes );
            thisCommand.Parameters.AddWithValue("@aLeave",aLeave );
            thisCommand.Parameters.AddWithValue("@aGeneralOverTime1",aGeneralOverTime1 );
            thisCommand.Parameters.AddWithValue("@aGeneralOverTime2",aGeneralOverTime2 );
            thisCommand.Parameters.AddWithValue("@aGeneralOverTime3",aGeneralOverTime3 );
            thisCommand.Parameters.AddWithValue("@aOffDayOverTime1",aOffDayOverTime1 );
            thisCommand.Parameters.AddWithValue("@aOffDayOverTime2",aOffDayOverTime2 );
            thisCommand.Parameters.AddWithValue("@aOffDayOverTime3",aOffDayOverTime3 );
            thisCommand.Parameters.AddWithValue("@aHolidayOverTimes",aHolidayOverTimes );
            thisCommand.Parameters.AddWithValue("@aHolidayOverTime1",aHolidayOverTime1 );
            thisCommand.Parameters.AddWithValue("@aHolidayOverTime2",aHolidayOverTime2 );
            thisCommand.Parameters.AddWithValue("@aHolidayOverTime3",aHolidayOverTime3 );
            thisCommand.Parameters.AddWithValue("@aNationalholidays",aNationalholidays );
            thisCommand.Parameters.AddWithValue("@aNationalholidays1",aNationalholidays1 );
            thisCommand.Parameters.AddWithValue("@aNationalholidays2",aNationalholidays2 );
            thisCommand.Parameters.AddWithValue("@aNationalholidays3",aNationalholidays3 );
            thisCommand.Parameters.AddWithValue("@aSpecialholiday",aSpecialholiday );
            thisCommand.Parameters.AddWithValue("@aSpecialholiday1",aSpecialholiday1 );
            thisCommand.Parameters.AddWithValue("@aSpecialholiday2",aSpecialholiday2 );
            thisCommand.Parameters.AddWithValue("@aSpecialholiday3",aSpecialholiday3 );
            thisCommand.Parameters.AddWithValue("@aRemark",aRemark );
            thisCommand.Parameters.AddWithValue("@aItme",aItme );
            thisCommand.Parameters.AddWithValue("@aCreateId", aCreateId);
            thisCommand.Parameters.AddWithValue("@aModdifyId", aModdifyId);
            thisCommand.Parameters.AddWithValue("@aCreateDate", DateTime.Now);
            thisCommand.Parameters.AddWithValue("@aModdifyDate", DateTime.Now);

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

    #region 修改 sy_Attendance
    public void UpdateAttendance()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Attendance set
                    aperGuid=@aperGuid,aAttendanceDate=@aAttendanceDate,aDays=@aDays,aTimes=@aTimes,aLeave=@aLeave
                    ,aGeneralOverTime1=@aGeneralOverTime1,aGeneralOverTime2=@aGeneralOverTime2,aGeneralOverTime3=@aGeneralOverTime3
                    ,aOffDayOverTime1=@aOffDayOverTime1,aOffDayOverTime2=@aOffDayOverTime2,aOffDayOverTime3=@aOffDayOverTime3
                    ,aHolidayOverTimes=@aHolidayOverTimes,aHolidayOverTime1=@aHolidayOverTime1
                    ,aHolidayOverTime2=@aHolidayOverTime2,aHolidayOverTime3=@aHolidayOverTime3
                    ,aNationalholidays=@aNationalholidays,aNationalholidays1=@aNationalholidays1
                    ,aNationalholidays2=@aNationalholidays2,aNationalholidays3=@aNationalholidays3
                    ,aSpecialholiday=@aSpecialholiday,aSpecialholiday1=@aSpecialholiday1
                    ,aSpecialholiday2=@aSpecialholiday2,aSpecialholiday3=@aSpecialholiday3
                    ,aRemark=@aRemark,aItme=@aItme,aModdifyId=@aModdifyId,aModdifyDate=@aModdifyDate
                where aGuid=@aGuid
            ");
            thisCommand.Parameters.AddWithValue("@aGuid", aGuid);
            thisCommand.Parameters.AddWithValue("@aperGuid", aperGuid);
            thisCommand.Parameters.AddWithValue("@aAttendanceDate", aAttendanceDate);
            thisCommand.Parameters.AddWithValue("@aDays", aDays);
            thisCommand.Parameters.AddWithValue("@aTimes", aTimes);
            thisCommand.Parameters.AddWithValue("@aLeave", aLeave);
            thisCommand.Parameters.AddWithValue("@aGeneralOverTime1", aGeneralOverTime1);
            thisCommand.Parameters.AddWithValue("@aGeneralOverTime2", aGeneralOverTime2);
            thisCommand.Parameters.AddWithValue("@aGeneralOverTime3", aGeneralOverTime3);
            thisCommand.Parameters.AddWithValue("@aOffDayOverTime1", aOffDayOverTime1);
            thisCommand.Parameters.AddWithValue("@aOffDayOverTime2", aOffDayOverTime2);
            thisCommand.Parameters.AddWithValue("@aOffDayOverTime3", aOffDayOverTime3);
            thisCommand.Parameters.AddWithValue("@aHolidayOverTimes", aHolidayOverTimes);
            thisCommand.Parameters.AddWithValue("@aHolidayOverTime1", aHolidayOverTime1);
            thisCommand.Parameters.AddWithValue("@aHolidayOverTime2", aHolidayOverTime2);
            thisCommand.Parameters.AddWithValue("@aHolidayOverTime3", aHolidayOverTime3);
            thisCommand.Parameters.AddWithValue("@aNationalholidays", aNationalholidays);
            thisCommand.Parameters.AddWithValue("@aNationalholidays1", aNationalholidays1);
            thisCommand.Parameters.AddWithValue("@aNationalholidays2", aNationalholidays2);
            thisCommand.Parameters.AddWithValue("@aNationalholidays3", aNationalholidays3);
            thisCommand.Parameters.AddWithValue("@aSpecialholiday", aSpecialholiday);
            thisCommand.Parameters.AddWithValue("@aSpecialholiday1", aSpecialholiday1);
            thisCommand.Parameters.AddWithValue("@aSpecialholiday2", aSpecialholiday2);
            thisCommand.Parameters.AddWithValue("@aSpecialholiday3", aSpecialholiday3);
            thisCommand.Parameters.AddWithValue("@aRemark", aRemark);
            thisCommand.Parameters.AddWithValue("@aItme", aItme);
            thisCommand.Parameters.AddWithValue("@aModdifyId", aModdifyId);
            thisCommand.Parameters.AddWithValue("@aModdifyDate", DateTime.Now);

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

    #region 撈 人員資料 條件 人員GUID
    public DataTable SelectDept()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            

            if (aperGuid != "")
            {
                show_value.Append(@"  
                    select top 1 cbName,perNo,perName from sy_Person left join sy_CodeBranches on perDep=cbGuid where 1=1 
                ");
                show_value.Append(@" and perGuid=@aperGuid ");
                thisCommand.Parameters.AddWithValue("@aperGuid", aperGuid);
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

    #region 撈 人員資料 條件 人員工號 perNo
    public DataTable SelectPerson()
    {
        DataTable dt = new DataTable();
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            thisConnection.Open();
            if (str_perno != "")
            {
                show_value.Append(@"  
                    select top 1 perGuid,perName from sy_Person left join sy_CodeBranches on perDep=cbGuid where 1=1 
                ");
                show_value.Append(@" and perNo=@perNo ");
                thisCommand.Parameters.AddWithValue("@perNo", str_perno);
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

    #region 撈 人員請假資料 條件 人員GUID&date
    public DataTable Selectleave()
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
                select leaAppilcantId,perName,leaStratFrom,leaEndAt,ldDate,leaDuration,phName,leaRemark
                from sy_Leave
                left join sy_Person on leaAppilcantId=perNo
                left join sy_LeaveDetail on (leaGuid = ldLeaGuid or leaID = ldLeaveId)
                left join sy_PayHoliday on leaLeaveTypeId = phCode
                where perGuid=@aperGuid and ldDate = @aAttendanceDate
            ");
            
            thisCommand.Parameters.AddWithValue("@aperGuid", aperGuid);
            thisCommand.Parameters.AddWithValue("@aAttendanceDate", aAttendanceDate);
            

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