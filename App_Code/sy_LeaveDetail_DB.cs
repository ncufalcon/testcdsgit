using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Data.SQLite;

/// <summary>
/// sy_LeaveDetail_DB 的摘要描述
/// </summary>
public class sy_LeaveDetail_DB
{
    public sy_LeaveDetail_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 全私用
    string str_dates = string.Empty;
    string str_datee = string.Empty;
    string str_type = string.Empty;
    DataTable dtld = null;
    #endregion
    #region 全公用
    public string _str_dates
    {
        set { str_dates = value; }
    }
    public string _str_datee
    {
        set { str_datee = value; }
    }
    public string _str_type
    {
        set { str_type = value; }
    }
    public DataTable _dtld
    {
        set { dtld = value; }
    }
    #endregion

    #region sy_LeaveDetail 私用
    string ldLeaGuid = string.Empty;
    Int32 ldId;
    string ldDate = string.Empty;
    string ldApplicantId = string.Empty;
    Int32 ldLeaveid;
    Int32 ldTypeId;
    Decimal ldDuration;
    #endregion
    #region  sy_LeaveDetail 公用
    public string _ldLeaGuid
    {
        set { ldLeaGuid = value; }
    }
    public Int32 _ldId
    {
        set { ldId = value; }
    }
    public string _ldDate
    {
        set { ldDate = value; }
    }
    public string _ldApplicantId
    {
        set { ldApplicantId = value; }
    }
    public Int32 _ldLeaveid
    {
        set { ldLeaveid = value; }
    }
    public Int32 _ldTypeId
    {
        set { ldTypeId = value; }
    }
    public Decimal _ldDuration
    {
        set { ldDuration = value; }
    }
    #endregion

    private SQLiteConnection sqlite_connect;
    private SQLiteCommand sqlite_cmd;
    sy_Leave_DB l_db = new sy_Leave_DB();
    #region 從 SQLite 轉資料到 sy_LeaveDetail 
    public void ImportSqliteToLeaveDetail()
    {
        DataTable dt = new DataTable();
        //相對路徑一定意這樣用HttpContext.Current.Server.MapPath()
        sqlite_connect = new SQLiteConnection("Data source=" + HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["sqliteString"].ToString()) + "");
        #region 第一段 先撈sy_Leave資料
        //建立資料庫連線
        sqlite_connect.Open();// Open
        sqlite_cmd = sqlite_connect.CreateCommand();//create command
        //sqlite_cmd.CommandText = "SELECT * FROM leave_leave where start_from between 20161101 and 20161131"; //select table
        string sql = @" select * from leave_leaverecord where leave_id in ( ";
        sql += @" SELECT id FROM leave_leave where status='A' ";
        if (str_dates != "" && str_datee != "")
        {
            sql += " and  ( (start_from<'" + str_dates + "' and (end_at between '" + str_dates + "' and '" + str_datee + "')) or ((start_from between '" + str_dates + "' and '" + str_datee + "') and end_at>'" + str_dates + "') or (start_from between '" + str_dates + "' and '" + str_datee + "' and end_at between '" + str_dates + "' and '" + str_datee + "') or  ('" + str_dates + "'>start_from and '" + str_datee + "'<end_at)   )  ";
        }
        sql += @" ) ";
        
        //SQLiteDataReader sqlite_datareader = sqlite_cmd.ExecuteReader();
        SQLiteDataAdapter da = new SQLiteDataAdapter(sql, sqlite_connect);
        da.Fill(dt);
        sqlite_connect.Close();
        #endregion

        DataView dv = dt.DefaultView;
        string sql1 = "";
        //DateTime dtime = DateTime.Parse(DateTime.Parse(dv[0]["created_date"].ToString().Trim()).ToString("yyyy-MM-dd mm:hh:ss"));
        //DateTime dtime1 = DateTime.Parse(dv[1]["created_date"].ToString().Trim());
        for (int i = 0; i < dv.Count; i++)
        {
            //在匯入時盼判斷該資料是不是已經存在sy_LeaveDetail  沒有才新增
            sql1 = @"
                declare @count_rows int;
                select @count_rows=count(*) from sy_LeaveDetail where ldId=@ldId
                if @count_rows=0
                    begin
                        insert into sy_LeaveDetail(ldLeaGuid,ldId,ldDate,ldApplicantId,ldLeaveid,ldTypeId,ldDuration)
                        values(@ldLeaGuid,@ldId,@ldDate,@ldApplicantId,@ldLeaveid,@ldTypeId,@ldDuration)
                    end
            ";

            SqlConnection Sqlconn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
            SqlCommand cmd = new SqlCommand(sql1, Sqlconn);
            cmd.Parameters.AddWithValue("@ldLeaGuid", DBNull.Value);
            cmd.Parameters.AddWithValue("@ldId", Convert.ToInt32(dv[i]["id"].ToString()));
            cmd.Parameters.AddWithValue("@ldDate", Convert.ToDateTime(dv[i]["date"].ToString()).ToString("yyyy/MM/dd"));
            cmd.Parameters.AddWithValue("@ldApplicantId", dv[i]["applicant_id"].ToString().Trim());
            cmd.Parameters.AddWithValue("@ldLeaveid", Convert.ToInt32(dv[i]["leave_id"].ToString()));
            cmd.Parameters.AddWithValue("@ldTypeId", Convert.ToInt32(dv[i]["leave_type_id"].ToString()));
            cmd.Parameters.AddWithValue("@ldDuration", ((dv[i]["duration"].ToString() == "") ? 0 : decimal.Parse(dv[i]["duration"].ToString())));
            try
            {
                cmd.Connection.Open();
                cmd.ExecuteNonQuery();

            }
            catch (Exception ex) { throw ex; }
            finally { cmd.Connection.Close(); cmd.Dispose(); }
        }
    }
    #endregion

    #region 新增sy_LeaveDetail資料 (目前沒用到先註解掉)
    //public void InsertLeaveDetail()
    //{
    //    SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
    //    SqlCommand thisCommand = thisConnection.CreateCommand();
    //    SqlDataAdapter oda = new SqlDataAdapter();
    //    StringBuilder show_value = new StringBuilder();
    //    try
    //    {

    //        show_value.Append(@" 
    //            insert into sy_LeaveDetail(ldLeaGuid,ldId,ldDate,ldApplicantId,ldLeaveid,ldTypeId,ldDuration)
    //            values(@ldLeaGuid,@ldId,@ldDate,@ldApplicantId,@ldLeaveid,@ldTypeId,@ldDuration)
    //        ");
    //        thisCommand.Parameters.AddWithValue("@ldLeaGuid", ldLeaGuid);
    //        thisCommand.Parameters.AddWithValue("@ldId", DBNull.Value);
    //        thisCommand.Parameters.AddWithValue("@ldDate", ldDate);
    //        thisCommand.Parameters.AddWithValue("@ldApplicantId", ldApplicantId);
    //        thisCommand.Parameters.AddWithValue("@ldLeaveid", DBNull.Value);
    //        thisCommand.Parameters.AddWithValue("@ldTypeId", ldTypeId);
    //        thisCommand.Parameters.AddWithValue("@ldDuration", ldDuration);

    //        thisCommand.CommandText = show_value.ToString();
    //        thisCommand.CommandType = CommandType.Text;

    //        thisCommand.Connection.Open();
    //        thisCommand.ExecuteNonQuery();
    //        thisCommand.Connection.Close();
    //    }
    //    catch (Exception ex)
    //    {
    //        throw ex;
    //    }
    //    finally
    //    {
    //        oda.Dispose();
    //        thisConnection.Close();
    //        thisConnection.Dispose();
    //        thisCommand.Dispose();
    //    }

    //}
    #endregion
}