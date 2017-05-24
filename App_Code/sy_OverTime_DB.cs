using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
/// <summary>
/// sy_OverTime_DB 的摘要描述
/// </summary>
public class sy_OverTime_DB
{
    public sy_OverTime_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region sy_OverTime 私用
    string oGuid = string.Empty;
    Int32 oMale;
    Int32 oFemale;
    Int32 oFixed;
    Int32 oOverTime1;
    Int32 oOverTime2Start;
    Int32 oOverTime2End;
    Int32 oOverTime3;
    Decimal oOverTimePay1;
    Decimal oOverTimePay2;
    Decimal oOverTimePay3;
    Int32 oOffDay1;
    Int32 oOffDay2Start;
    Int32 oOffDay2End;
    Int32 oOffDay3Start;
    Int32 oOffDay3End;
    Decimal oOffDayPay1;
    Decimal oOffDayPay2;
    Decimal oOffDayPay3;
    Int32 oPublickHoliday1 ;
    Int32 oPublickHoliday2Start ;
    Int32 oPublickHoliday2End ;
    Int32 oPublickHoliday3Start ;
    Int32 oPublickHoliday3End ;
    Int32 oPublickHoliday4 ;
    Decimal oPublickHolidayPay1 ;
    Decimal oPublickHolidayPay2 ;
    Decimal oPublickHolidayPay3 ;
    Decimal oPublickHolidayPay4 ;
    Int32 oNationalHolidays1 ;
    Int32 oNationalHolidays2Start ;
    Int32 oNationalHolidays2End ;
    Int32 oNationalHolidays3Start ;
    Int32 oNationalHolidays3End ;
    Int32 oNationalHolidays4 ;
    Decimal oNationalHolidaysPay1 ;
    Decimal oNationalHolidaysPay2 ;
    Decimal oNationalHolidaysPay3 ;
    Decimal oNationalHolidaysPay4 ;
    Int32 oSpecialHolidays1 ;
    Int32 oSpecialHolidays2Start ;
    Int32 oSpecialHolidays2End ;
    Int32 oSpecialHolidays3Start ;
    Int32 oSpecialHolidays3End ;
    Int32 oSpecialHolidays4 ;
    Decimal oSpecialHolidaysPay1 ;
    Decimal oSpecialHolidaysPay2 ;
    Decimal oSpecialHolidaysPay3 ;
    Decimal oSpecialHolidaysPay4;
    #endregion
    #region sy_OverTime 公用
    public string _oGuid
    {
        set { oGuid = value; }
    }
    public Int32 _oMale
    {
        set { oMale = value; }
    }
    public Int32 _oFemale
    {
        set { oFemale = value; }
    }
    public Int32 _oFixed
    {
        set { oFixed = value; }
    }
    public Int32 _oOverTime1
    {
        set { oOverTime1 = value; }
    }
    public Int32 _oOverTime2Start
    {
        set { oOverTime2Start = value; }
    }
    public Int32 _oOverTime2End
    {
        set { oOverTime2End = value; }
    }
    public Int32 _oOverTime3
    {
        set { oOverTime3 = value; }
    }
    public Decimal _oOverTimePay1
    {
        set { oOverTimePay1 = value; }
    }
    public Decimal _oOverTimePay2
    {
        set { oOverTimePay2 = value; }
    }
    public Decimal _oOverTimePay3
    {
        set { oOverTimePay3 = value; }
    }
    public Int32 _oOffDay1
    {
        set { oOffDay1 = value; }
    }
    public Int32 _oOffDay2Start
    {
        set { oOffDay2Start = value; }
    }
    public Int32 _oOffDay2End
    {
        set { oOffDay2End = value; }
    }
    public Int32 _oOffDay3Start
    {
        set { oOffDay3Start = value; }
    }
    public Int32 _oOffDay3End
    {
        set { oOffDay3End = value; }
    }
    public Decimal _oOffDayPay1
    {
        set { oOffDayPay1 = value; }
    }
    public Decimal _oOffDayPay2
    {
        set { oOffDayPay2 = value; }
    }
    public Decimal _oOffDayPay3
    {
        set { oOffDayPay3 = value; }
    }
    public Int32 _oPublickHoliday1
    {
        set { oPublickHoliday1 = value; }
    }
    public Int32 _oPublickHoliday2Start
    {
        set { oPublickHoliday2Start = value; }
    }
    public Int32 _oPublickHoliday2End
    {
        set { oPublickHoliday2End = value; }
    }
    public Int32 _oPublickHoliday3Start
    {
        set { oPublickHoliday3Start = value; }
    }
    public Int32 _oPublickHoliday3End
    {
        set { oPublickHoliday3End = value; }
    }
    public Int32 _oPublickHoliday4
    {
        set { oPublickHoliday4 = value; }
    }
    public Decimal _oPublickHolidayPay1
    {
        set { oPublickHolidayPay1 = value; }
    }
    public Decimal _oPublickHolidayPay2
    {
        set { oPublickHolidayPay2 = value; }
    }
    public Decimal _oPublickHolidayPay3
    {
        set { oPublickHolidayPay3 = value; }
    }
    public Decimal _oPublickHolidayPay4
    {
        set { oPublickHolidayPay4 = value; }
    }
    public Int32 _oNationalHolidays1
    {
        set { oNationalHolidays1 = value; }
    }
    public Int32 _oNationalHolidays2Start
    {
        set { oNationalHolidays2Start = value; }
    }
    public Int32 _oNationalHolidays2End
    {
        set { oNationalHolidays2End = value; }
    }
    public Int32 _oNationalHolidays3Start
    {
        set { oNationalHolidays3Start = value; }
    }
    public Int32 _oNationalHolidays3End
    {
        set { oNationalHolidays3End = value; }
    }
    public Int32 _oNationalHolidays4
    {
        set { oNationalHolidays4 = value; }
    }
    public Decimal _oNationalHolidaysPay1
    {
        set { oNationalHolidaysPay1 = value; }
    }
    public Decimal _oNationalHolidaysPay2
    {
        set { oNationalHolidaysPay2 = value; }
    }
    public Decimal _oNationalHolidaysPay3
    {
        set { oNationalHolidaysPay3 = value; }
    }
    public Decimal _oNationalHolidaysPay4
    {
        set { oNationalHolidaysPay4 = value; }
    }
    public Int32 _oSpecialHolidays1
    {
        set { oSpecialHolidays1 = value; }
    }
    public Int32 _oSpecialHolidays2Start
    {
        set { oSpecialHolidays2Start = value; }
    }
    public Int32 _oSpecialHolidays2End
    {
        set { oSpecialHolidays2End = value; }
    }
    public Int32 _oSpecialHolidays3Start
    {
        set { oSpecialHolidays3Start = value; }
    }
    public Int32 _oSpecialHolidays3End
    {
        set { oSpecialHolidays3End = value; }
    }
    public Int32 _oSpecialHolidays4
    {
        set { oSpecialHolidays4 = value; }
    }
    public Decimal _oSpecialHolidaysPay1
    {
        set { oSpecialHolidaysPay1 = value; }
    }
    public Decimal _oSpecialHolidaysPay2
    {
        set { oSpecialHolidaysPay2 = value; }
    }
    public Decimal _oSpecialHolidaysPay3
    {
        set { oSpecialHolidaysPay3 = value; }
    }
    public Decimal _oSpecialHolidaysPay4
    {
        set { oSpecialHolidaysPay4 = value; }
    }
    #endregion

    #region 撈 sy_OverTime
    public DataTable SelectOverTime()
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
                select * from sy_OverTime
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

    #region 新增 sy_OverTime
    public void InsertOverTime()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                insert into sy_OverTime (oGuid,oMale,oFemale,oFixed,oOverTime1,oOverTime2Start,oOverTime2End,oOverTime3,oOverTimePay1,oOverTimePay2,oOverTimePay3,
                oOffDay1,oOffDay2Start,oOffDay2End,oOffDay3Start,oOffDay3End,oOffDayPay1,oOffDayPay2,oOffDayPay3,
                oPublickHoliday1,oPublickHoliday2Start,oPublickHoliday2End,oPublickHoliday3Start,oPublickHoliday3End,oPublickHoliday4,
                oPublickHolidayPay1,oPublickHolidayPay2,oPublickHolidayPay3,oPublickHolidayPay4,
                oNationalHolidays1,oNationalHolidays2Start,oNationalHolidays2End,oNationalHolidays3Start,oNationalHolidays3End,oNationalHolidays4,
                oNationalHolidaysPay1,oNationalHolidaysPay2,oNationalHolidaysPay3,oNationalHolidaysPay4,
                oSpecialHolidays1,oSpecialHolidays2Start,oSpecialHolidays2End,oSpecialHolidays3Start,oSpecialHolidays3End,oSpecialHolidays4,
                oSpecialHolidaysPay1,oSpecialHolidaysPay2,oSpecialHolidaysPay3,oSpecialHolidaysPay4
                ) 
                values(@oGuid,@oMale,@oFemale,@oFixed,@oOverTime1,@oOverTime2Start,@oOverTime2End,@oOverTime3,@oOverTimePay1,@oOverTimePay2,@oOverTimePay3,
                @oOffDay1,@oOffDay2Start,@oOffDay2End,@oOffDay3Start,@oOffDay3End,@oOffDayPay1,@oOffDayPay2,@oOffDayPay3,
                @oPublickHoliday1,@oPublickHoliday2Start,@oPublickHoliday2End,@oPublickHoliday3Start,@oPublickHoliday3End,@oPublickHoliday4,
                @oPublickHolidayPay1,@oPublickHolidayPay2,@oPublickHolidayPay3,@oPublickHolidayPay4,
                @oNationalHolidays1,@oNationalHolidays2Start,@oNationalHolidays2End,@oNationalHolidays3Start,@oNationalHolidays3End,@oNationalHolidays4,
                @oNationalHolidaysPay1,@oNationalHolidaysPay2,@oNationalHolidaysPay3,@oNationalHolidaysPay4,
                @oSpecialHolidays1,@oSpecialHolidays2Start,@oSpecialHolidays2End,@oSpecialHolidays3Start,@oSpecialHolidays3End,@oSpecialHolidays4,
                @oSpecialHolidaysPay1,@oSpecialHolidaysPay2,@oSpecialHolidaysPay3,@oSpecialHolidaysPay4
                ) 
            ");
            
            thisCommand.Parameters.AddWithValue("@oGuid", oGuid);
            thisCommand.Parameters.AddWithValue("@oMale", oMale);
            thisCommand.Parameters.AddWithValue("@oFemale", oFemale);
            thisCommand.Parameters.AddWithValue("@oFixed", oFixed);
            thisCommand.Parameters.AddWithValue("@oOverTime1", oOverTime1);
            thisCommand.Parameters.AddWithValue("@oOverTime2Start", oOverTime2Start);
            thisCommand.Parameters.AddWithValue("@oOverTime2End", oOverTime2End);
            thisCommand.Parameters.AddWithValue("@oOverTime3", oOverTime3);
            thisCommand.Parameters.AddWithValue("@oOverTimePay1", oOverTimePay1);
            thisCommand.Parameters.AddWithValue("@oOverTimePay2", oOverTimePay2);
            thisCommand.Parameters.AddWithValue("@oOverTimePay3", oOverTimePay3);
            thisCommand.Parameters.AddWithValue("@oOffDay1", oOffDay1);
            thisCommand.Parameters.AddWithValue("@oOffDay2Start", oOffDay2Start);
            thisCommand.Parameters.AddWithValue("@oOffDay2End", oOffDay2End);
            thisCommand.Parameters.AddWithValue("@oOffDay3Start", oOffDay3Start);
            thisCommand.Parameters.AddWithValue("@oOffDay3End", oOffDay3End);
            thisCommand.Parameters.AddWithValue("@oOffDayPay1", oOffDayPay1);
            thisCommand.Parameters.AddWithValue("@oOffDayPay2", oOffDayPay2);
            thisCommand.Parameters.AddWithValue("@oOffDayPay3", oOffDayPay3);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday1", oPublickHoliday1);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday2Start", oPublickHoliday2Start);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday2End", oPublickHoliday2End);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday3Start", oPublickHoliday3Start);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday3End", oPublickHoliday3End);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday4", oPublickHoliday4);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay1", oPublickHolidayPay1);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay2", oPublickHolidayPay2);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay3", oPublickHolidayPay3);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay4", oPublickHolidayPay4);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays1", oNationalHolidays1);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays2Start", oNationalHolidays2Start);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays2End", oNationalHolidays2End);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays3Start", oNationalHolidays3Start);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays3End", oNationalHolidays3End);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays4", oNationalHolidays4);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay1", oNationalHolidaysPay1);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay2", oNationalHolidaysPay2);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay3", oNationalHolidaysPay3);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay4", oNationalHolidaysPay4);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays1", oSpecialHolidays1);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays2Start", oSpecialHolidays2Start);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays2End", oSpecialHolidays2End);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays3Start", oSpecialHolidays3Start);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays3End", oSpecialHolidays3End);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays4", oSpecialHolidays4);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay1", oSpecialHolidaysPay1);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay2", oSpecialHolidaysPay2);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay3", oSpecialHolidaysPay3);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay4", oSpecialHolidaysPay4);

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

    #region 修改 sy_OverTime
    public void UpdateOverTime()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            show_value.Append(@" 
                update sy_OverTime set 
                oMale=@oMale,oFemale=@oFemale,oFixed=@oFixed
                ,oOverTime1=@oOverTime1,oOverTime2Start=@oOverTime2Start,oOverTime2End=@oOverTime2End,oOverTime3=@oOverTime3
                ,oOverTimePay1=@oOverTimePay1,oOverTimePay2=@oOverTimePay2,oOverTimePay3=@oOverTimePay3
                ,oOffDay1=@oOffDay1,oOffDay2Start=@oOffDay2Start,oOffDay2End=@oOffDay2End,oOffDay3Start=@oOffDay3Start,oOffDay3End=@oOffDay3End
                ,oOffDayPay1=@oOffDayPay1,oOffDayPay2=@oOffDayPay2,oOffDayPay3=@oOffDayPay3
                ,oPublickHoliday1=@oPublickHoliday1,oPublickHoliday2Start=@oPublickHoliday2Start,oPublickHoliday2End=@oPublickHoliday2End
                ,oPublickHoliday3Start=@oPublickHoliday3Start,oPublickHoliday3End=@oPublickHoliday3End,oPublickHoliday4=@oPublickHoliday4
                ,oPublickHolidayPay1=@oPublickHolidayPay1,oPublickHolidayPay2=@oPublickHolidayPay2
                ,oPublickHolidayPay3=@oPublickHolidayPay3,oPublickHolidayPay4=@oPublickHolidayPay4
                ,oNationalHolidays1=@oNationalHolidays1,oNationalHolidays2Start=@oNationalHolidays2Start,oNationalHolidays2End=@oNationalHolidays2End
                ,oNationalHolidays3Start=@oNationalHolidays3Start,oNationalHolidays3End=@oNationalHolidays3End,oNationalHolidays4=@oNationalHolidays4
                ,oNationalHolidaysPay1=@oNationalHolidaysPay1,oNationalHolidaysPay2=@oNationalHolidaysPay2
                ,oNationalHolidaysPay3=@oNationalHolidaysPay3,oNationalHolidaysPay4=@oNationalHolidaysPay4
                ,oSpecialHolidays1=@oSpecialHolidays1,oSpecialHolidays2Start=@oSpecialHolidays2Start,oSpecialHolidays2End=@oSpecialHolidays2End
                ,oSpecialHolidays3Start=@oSpecialHolidays3Start,oSpecialHolidays3End=@oSpecialHolidays3End,oSpecialHolidays4=@oSpecialHolidays4
                ,oSpecialHolidaysPay1=@oSpecialHolidaysPay1,oSpecialHolidaysPay2=@oSpecialHolidaysPay2
                ,oSpecialHolidaysPay3=@oSpecialHolidaysPay3,oSpecialHolidaysPay4=@oSpecialHolidaysPay4
                where  oGuid=@oGuid               
            ");

            thisCommand.Parameters.AddWithValue("@oGuid", oGuid);
            thisCommand.Parameters.AddWithValue("@oMale", oMale);
            thisCommand.Parameters.AddWithValue("@oFemale", oFemale);
            thisCommand.Parameters.AddWithValue("@oFixed", oFixed);
            thisCommand.Parameters.AddWithValue("@oOverTime1", oOverTime1);
            thisCommand.Parameters.AddWithValue("@oOverTime2Start", oOverTime2Start);
            thisCommand.Parameters.AddWithValue("@oOverTime2End", oOverTime2End);
            thisCommand.Parameters.AddWithValue("@oOverTime3", oOverTime3);
            thisCommand.Parameters.AddWithValue("@oOverTimePay1", oOverTimePay1);
            thisCommand.Parameters.AddWithValue("@oOverTimePay2", oOverTimePay2);
            thisCommand.Parameters.AddWithValue("@oOverTimePay3", oOverTimePay3);
            thisCommand.Parameters.AddWithValue("@oOffDay1", oOffDay1);
            thisCommand.Parameters.AddWithValue("@oOffDay2Start", oOffDay2Start);
            thisCommand.Parameters.AddWithValue("@oOffDay2End", oOffDay2End);
            thisCommand.Parameters.AddWithValue("@oOffDay3Start", oOffDay3Start);
            thisCommand.Parameters.AddWithValue("@oOffDay3End", oOffDay3End);
            thisCommand.Parameters.AddWithValue("@oOffDayPay1", oOffDayPay1);
            thisCommand.Parameters.AddWithValue("@oOffDayPay2", oOffDayPay2);
            thisCommand.Parameters.AddWithValue("@oOffDayPay3", oOffDayPay3);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday1", oPublickHoliday1);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday2Start", oPublickHoliday2Start);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday2End", oPublickHoliday2End);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday3Start", oPublickHoliday3Start);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday3End", oPublickHoliday3End);
            thisCommand.Parameters.AddWithValue("@oPublickHoliday4", oPublickHoliday4);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay1", oPublickHolidayPay1);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay2", oPublickHolidayPay2);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay3", oPublickHolidayPay3);
            thisCommand.Parameters.AddWithValue("@oPublickHolidayPay4", oPublickHolidayPay4);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays1", oNationalHolidays1);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays2Start", oNationalHolidays2Start);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays2End", oNationalHolidays2End);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays3Start", oNationalHolidays3Start);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays3End", oNationalHolidays3End);
            thisCommand.Parameters.AddWithValue("@oNationalHolidays4", oNationalHolidays4);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay1", oNationalHolidaysPay1);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay2", oNationalHolidaysPay2);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay3", oNationalHolidaysPay3);
            thisCommand.Parameters.AddWithValue("@oNationalHolidaysPay4", oNationalHolidaysPay4);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays1", oSpecialHolidays1);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays2Start", oSpecialHolidays2Start);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays2End", oSpecialHolidays2End);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays3Start", oSpecialHolidays3Start);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays3End", oSpecialHolidays3End);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidays4", oSpecialHolidays4);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay1", oSpecialHolidaysPay1);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay2", oSpecialHolidaysPay2);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay3", oSpecialHolidaysPay3);
            thisCommand.Parameters.AddWithValue("@oSpecialHolidaysPay4", oSpecialHolidaysPay4);

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