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
    Int32 oOverTimePay1;
    Int32 oOverTimePay2;
    Int32 oOverTimePay3;
    Int32 oOffDay1;
    Int32 oOffDay2Start;
    Int32 oOffDay2End;
    Int32 oOffDay3Start;
    Int32 oOffDay3End;
    Int32 oOffDayPay1;
    Int32 oOffDayPay2;
    Int32 oOffDayPay3;
    Int32 oPublickHoliday;
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
    public Int32 _oOverTimePay1
    {
        set { oOverTimePay1 = value; }
    }
    public Int32 _oOverTimePay2
    {
        set { oOverTimePay2 = value; }
    }
    public Int32 _oOverTimePay3
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
    public Int32 _oOffDayPay1
    {
        set { oOffDayPay1 = value; }
    }
    public Int32 _oOffDayPay2
    {
        set { oOffDayPay2 = value; }
    }
    public Int32 _oOffDayPay3
    {
        set { oOffDayPay3 = value; }
    }
    public Int32 _oPublickHoliday
    {
        set { oPublickHoliday = value; }
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
                insert into sy_OverTime (oGuid,oMale,oFemale,oFixed,oOverTime1,oOverTime2Start,oOverTime2End,oOverTime3,oOverTimePay1,oOverTimePay2,oOverTimePay3,oOffDay1,oOffDay2Start,oOffDay2End,oOffDay3Start,oOffDay3End,oOffDayPay1,oOffDayPay2,oOffDayPay3,oPublickHoliday) 
                values(@oGuid,@oMale,@oFemale,@oFixed,@oOverTime1,@oOverTime2Start,@oOverTime2End,@oOverTime3,@oOverTimePay1,@oOverTimePay2,@oOverTimePay3,@oOffDay1,@oOffDay2Start,@oOffDay2End,@oOffDay3Start,@oOffDay3End,@oOffDayPay1,@oOffDayPay2,@oOffDayPay3,@oPublickHoliday) 
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
            thisCommand.Parameters.AddWithValue("@oPublickHoliday", oPublickHoliday);

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
                ,oOffDayPay1=@oOffDayPay1,oOffDayPay2=@oOffDayPay2,oOffDayPay3=@oOffDayPay3,oPublickHoliday=@oPublickHoliday
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
            thisCommand.Parameters.AddWithValue("@oPublickHoliday", oPublickHoliday);

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