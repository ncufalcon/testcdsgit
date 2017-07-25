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
    string dates = string.Empty;
    string datee = string.Empty;
    string str_order_column = string.Empty;
    string str_order_status = string.Empty;
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
    public string _dates
    {
        set { dates = value; }
    }
    public string _datee
    {
        set { datee = value; }
    }
    public string _str_order_column
    {
        set { str_order_column = value; }
    }
    public string _str_order_status
    {
        set { str_order_status = value; }
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

    #region sy_Attendance_hours 私用
    string ah_guid = string.Empty;
    string ah_perGuid = string.Empty;
    string ah_perNo = string.Empty;
    string ah_AttendanceDate = string.Empty;
    decimal ah_Times;
    string ah_Remark = string.Empty;
    string ah_Itme = string.Empty;
    string ah_Status = string.Empty;
    string ah_CreateId = string.Empty;
    string ah_ModdifyId = string.Empty;
    DateTime ah_CreateDate;
    DateTime ah_ModdifyDate;
    #endregion
    #region sy_Attendance_hours 公用
    public string _ah_guid
    {
        set
        { ah_guid = value; }
    }
    public string _ah_perGuid
    {
        set
        { ah_perGuid = value; }
    }
    public string _ah_perNo
    {
        set
        { ah_perNo = value; }
    }
    public string _ah_AttendanceDate
    {
        set
        { ah_AttendanceDate = value; }
    }
    public decimal _ah_Times
    {
        set
        { ah_Times = value; }
    }
    public string _ah_Remark
    {
        set
        { ah_Remark = value; }
    }
    public string _ah_Itme
    {
        set
        { ah_Itme = value; }
    }
    public string _ah_Status
    {
        set
        { ah_Status = value; }
    }
    public string _ah_CreateId
    {
        set
        { ah_CreateId = value; }
    }
    public string _ah_ModdifyId
    {
        set
        { ah_ModdifyId = value; }
    }
    public DateTime _ah_CreateDate
    {
        set
        { ah_CreateDate = value; }
    }
    public DateTime _ah_ModdifyDate
    {
        set
        { ah_ModdifyDate = value; }
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
                        ,aSpecialholiday,aSpecialholiday1,aSpecialholiday2,aSpecialholiday3,aRemark,aItme,aStatus,aCreateId,aCreateDate,aModdifyId,aModdifyDate,perNo,perName,cbName
                    from sy_Attendance left join sy_Person on aperGuid=perGuid
                    left join sy_CodeBranches on perDep=cbGuid
                    where aStatus='A'
                ");
            }
            else {
                show_value.Append(@"  
                    select aGuid,aperGuid,aAttendanceDate,aDays,aTimes,aLeave,aGeneralOverTime1,aGeneralOverTime2,aGeneralOverTime3,aOffDayOverTime1,aOffDayOverTime2,aOffDayOverTime3
                        ,aHolidayOverTimes,aHolidayOverTime1,aHolidayOverTime2,aHolidayOverTime3,aNationalholidays,aNationalholidays1,aNationalholidays2,aNationalholidays3,aNationalholidays
                        ,aSpecialholiday,aSpecialholiday1,aSpecialholiday2,aSpecialholiday3,aRemark,aItme,aStatus,aCreateId,aCreateDate,aModdifyId,aModdifyDate,perNo,perName,cbName
                    from sy_Attendance left join sy_Person on aperGuid=perGuid
                    left join sy_CodeBranches on perDep=cbGuid
                    where aStatus='A'
                ");
                if (str_keyword != "")
                {
                    show_value.Append(@" and ( upper(perNo) LIKE '%' + upper(@str_keyword) + '%' or upper(perName) LIKE '%' + upper(@str_keyword) + '%' )  ");
                    thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
                }
                if (aGuid != "")
                {
                    show_value.Append(@" and aGuid=@aGuid  ");
                    thisCommand.Parameters.AddWithValue("@aGuid", aGuid);
                }
                if (str_dates != "" && str_datee != "")
                {
                    show_value.Append(@" and (aAttendanceDate between @str_dates and @str_datee)  ");
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

    #region 撈 sy_Attendance_hours 條件 keyword or GUID or dates datee
    public DataTable SelectAttendanceHours()
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
            if (str_keyword == "" && str_dates == "" && str_datee == "" && ah_guid == "" && (ah_perGuid=="" || ah_AttendanceDate==""))
            {
                show_value.Append(@"  
                    select top 100 ah_guid,ah_perGuid,ah_perNo,ah_AttendanceDate,ah_Times,ah_Remark,ah_Itme,perGuid,perName
                    from sy_Attendance_hours left join sy_Person on ah_perNo=perNO
                    where ah_Status='A'
                ");
            }
            else
            {
                show_value.Append(@"  
                    select ah_guid,ah_perGuid,ah_perNo,ah_AttendanceDate,ah_Times,ah_Remark,ah_Itme,perGuid,perName
                    from sy_Attendance_hours left join sy_Person on ah_perNo=perNO
                    where ah_Status='A'
                ");
                if (str_keyword != "")
                {
                    show_value.Append(@" and (  upper(perNo) LIKE '%' + upper(@str_keyword) + '%' or upper(perName) LIKE '%' + upper(@str_keyword) + '%' )  ");
                    thisCommand.Parameters.AddWithValue("@str_keyword", str_keyword);
                }
                if (ah_guid != "")
                {
                    show_value.Append(@" and ah_guid=@ah_guid  ");
                    thisCommand.Parameters.AddWithValue("@ah_guid", ah_guid);
                }
                if (ah_perGuid != "" && ah_AttendanceDate != "")
                {
                    show_value.Append(@" and ah_perGuid=@ah_perGuid and  ah_AttendanceDate=@ah_AttendanceDate ");
                    thisCommand.Parameters.AddWithValue("@ah_perGuid", ah_perGuid);
                    thisCommand.Parameters.AddWithValue("@ah_AttendanceDate", ah_AttendanceDate);
                }
                if (str_dates != "" && str_datee != "")
                {
                    show_value.Append(@" and (ah_AttendanceDate between @str_dates and @str_datee)  ");
                    thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                    thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
                }
                if (str_dates != "" && str_datee == "")
                {
                    show_value.Append(@" and ah_AttendanceDate>=@str_dates  ");
                    thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                }
                if (str_dates == "" && str_datee != "")
                {
                    show_value.Append(@" and ah_AttendanceDate<=@str_datee  ");
                    thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
                }

            }
            if (str_order_column != "" && str_order_status!="")
            {
                string str_order = " order by "+ str_order_column + " "+ str_order_status + " ";
                show_value.Append(@""+ str_order + "");
            }
            else {
                show_value.Append(@"  
                    order by ah_AttendanceDate DESC,perNo ASC
                ");
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

    #region 刪除 sy_Attendance_hours update status="D"
    public void DeleteAttendanceHours()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_Attendance_hours set ah_Status='D',ah_ModdifyId=@ah_ModdifyId,ah_ModdifyDate=@ah_ModdifyDate  where ah_guid=@ah_guid               
            ");

            thisCommand.Parameters.AddWithValue("@ah_guid", ah_guid);
            thisCommand.Parameters.AddWithValue("@ah_ModdifyId", ah_ModdifyId);
            thisCommand.Parameters.AddWithValue("@ah_ModdifyDate", DateTime.Now);

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

    #region 新增 sy_Attendance_hours
    public void InsertAttendanceHours()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                declare @perno nvarchar(20);
                select @perno = perNo from sy_Person where perGuid=@ah_perGuid;
                insert into sy_Attendance_hours 
                (
                    ah_guid,ah_perGuid,ah_perNo,ah_AttendanceDate,ah_Times,ah_Remark,ah_Itme,ah_Status,ah_CreateId,ah_CreateDate,ah_ModdifyId,ah_ModdifyDate,ah_flag
                ) 
                values
                (
                    @ah_guid,@ah_perGuid,@perno,@ah_AttendanceDate,@ah_Times,@ah_Remark,@ah_Itme,'A',@ah_CreateId,@ah_CreateDate,@ah_ModdifyId,@ah_ModdifyDate,'N'
                ) 
            ");
            thisCommand.Parameters.AddWithValue("@ah_guid", ah_guid);
            thisCommand.Parameters.AddWithValue("@ah_perGuid", ah_perGuid);
            thisCommand.Parameters.AddWithValue("@ah_AttendanceDate", ah_AttendanceDate);
            thisCommand.Parameters.AddWithValue("@ah_Times", ah_Times);
            thisCommand.Parameters.AddWithValue("@ah_Remark", ah_Remark);
            thisCommand.Parameters.AddWithValue("@ah_Itme", ah_Itme);
            thisCommand.Parameters.AddWithValue("@ah_CreateId", ah_CreateId);
            thisCommand.Parameters.AddWithValue("@ah_ModdifyId", ah_ModdifyId);
            thisCommand.Parameters.AddWithValue("@ah_CreateDate", DateTime.Now);
            thisCommand.Parameters.AddWithValue("@ah_ModdifyDate", DateTime.Now);

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

    #region 修改 sy_Attendance_hours
    public void UpdateAttendanceHours()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                declare @perno nvarchar(20);
                select @perno = perNo from sy_Person where perGuid=@ah_perGuid;
                update sy_Attendance_hours set 
                ah_perGuid=@ah_perGuid,ah_perNo=@perno,ah_AttendanceDate=@ah_AttendanceDate,ah_Times=@ah_Times,ah_Remark=@ah_Remark,ah_Itme=@ah_Itme,ah_ModdifyId=@ah_ModdifyId,ah_ModdifyDate=@ah_ModdifyDate
                where ah_guid=@ah_guid
            ");
            thisCommand.Parameters.AddWithValue("@ah_guid", ah_guid);
            thisCommand.Parameters.AddWithValue("@ah_perGuid", ah_perGuid);
            thisCommand.Parameters.AddWithValue("@ah_AttendanceDate", ah_AttendanceDate);
            thisCommand.Parameters.AddWithValue("@ah_Times", ah_Times);
            thisCommand.Parameters.AddWithValue("@ah_Remark", ah_Remark);
            thisCommand.Parameters.AddWithValue("@ah_Itme", ah_Itme);
            thisCommand.Parameters.AddWithValue("@ah_ModdifyId", ah_ModdifyId);
            thisCommand.Parameters.AddWithValue("@ah_ModdifyDate", DateTime.Now);

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

    #region 匯入刪除時間區間的資料 sy_Attendance_hours
    public void deleteAttendanceHoursForImport()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                delete from sy_Attendance_hours  where ah_flag='Y' and ah_AttendanceDate between @dates and @datee
            ");
            thisCommand.Parameters.AddWithValue("@dates", dates);
            thisCommand.Parameters.AddWithValue("@datee", datee);

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