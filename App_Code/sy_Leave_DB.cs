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
/// sy_Leave_DB 的摘要描述
/// </summary>
public class sy_Leave_DB
{
    public sy_Leave_DB()
    {
        //
        // TODO: 在這裡新增建構函式邏輯
        //
    }

    #region 全私用
    string str_dates = string.Empty;
    string str_datee = string.Empty;
    string str_type = string.Empty;
    string str_username = string.Empty;
    string str_type_date = string.Empty;
    string str_type2_date = string.Empty;
    string str_days = string.Empty;
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
    public string _str_username
    {
        set { str_username = value; }
    }
    public string _str_type_date
    {
        set { str_type_date = value; }
    }
    public string _str_type2_date
    {
        set { str_type2_date = value; }
    }
    public string _str_days
    {
        set { str_days = value; }
    }
    #endregion

    #region sy_Leave 私用
    string leaGuid = string.Empty;
    Int32 leaID;
    DateTime leaCreatedDate;
    DateTime leaStratFrom;
    DateTime leaEndAt;
    Decimal leaDuration;
    string leaRemark = string.Empty;
    string leaAskerName = string.Empty;
    Int32 leaLeaveTypeId;
    string leaAppilcantId = string.Empty;
    string leaStatus = string.Empty;
    Int32 leaLeaveType2;
    Decimal leaDuration2;
    string leaModdifyId = string.Empty;
    DateTime leaModdifyDate;
    string leaImportStatus = string.Empty;
    string leaDataStatus = string.Empty;
    string leaAttach_file_1 = string.Empty;
    string leaAttach_file_2 = string.Empty;
    string leaScenario = string.Empty;
    Int32 leaPrint_count;
    string leaAccountStatus;
    #endregion
    #region sy_Leave 公用
    public string _leaGuid
    {
        set { leaGuid = value; }
    }
    public Int32 _leaID
    {
        set { leaID = value; }
    }
    public DateTime _leaCreatedDate
    {
        set { leaCreatedDate = value; }
    }
    public DateTime _leaStratFrom
    {
        set { leaStratFrom = value; }
    }
    public DateTime _leaEndAt
    {
        set { leaEndAt = value; }
    }
    public Decimal _leaDuration
    {
        set { leaDuration = value; }
    }
    public string _leaRemark
    {
        set { leaRemark = value; }
    }
    public string _leaAskerName
    {
        set { leaAskerName = value; }
    }
    public Int32 _leaLeaveTypeId
    {
        set { leaLeaveTypeId = value; }
    }
    public string _leaAppilcantId
    {
        set { leaAppilcantId = value; }
    }
    public string _leaStatus
    {
        set { leaStatus = value; }
    }
    public Int32 _leaLeaveType2
    {
        set { leaLeaveType2 = value; }
    }
    public Decimal _leaDuration2
    {
        set { leaDuration2 = value; }
    }
    public string _leaModdifyId
    {
        set { leaModdifyId = value; }
    }
    public DateTime _leaModdifyDate
    {
        set { leaModdifyDate = value; }
    }
    public string _leaImportStatus
    {
        set { leaImportStatus = value; }
    }
    public string _leaDataStatus
    {
        set { leaDataStatus = value; }
    }
    public string _leaAttach_file_1
    {
        set { leaAttach_file_1 = value; }
    }
    public string _leaAttach_file_2
    {
        set { leaAttach_file_2 = value; }
    }
    public string _leaScenario
    {
        set { leaScenario = value; }
    }
    public Int32 _leaPrint_count
    {
        set { leaPrint_count = value; }
    }
    public string _leaAccountStatus
    {
        set { leaAccountStatus = value; }
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

    #region 撈 sy_Leave BY 起訖日期 匯入狀態 GUID
    public DataTable SelectLeave()
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
                select leaID,leaGuid,leaStratFrom,leaEndAt,leaDuration,leaRemark,leaLeaveTypeId,leaAppilcantId,perGuid,perName,leaLeaveType2,leaDuration2,a.phName phName1,b.phName phName2 ,leaImportStatus
                from sy_Leave 
                left join sy_PayHoliday a on leaLeaveTypeId = a.phCode
                left join sy_PayHoliday b on leaLeaveType2 = b.phCode
                left join sy_Person on leaAppilcantId = perNo
                where leaDataStatus='A'
            ");
            if (str_type!="all" && leaGuid=="" && leaID==0) {
                show_value.Append(@" and  leaImportStatus=@str_type ");
                thisCommand.Parameters.AddWithValue("@str_type", str_type);
            }
            if (str_dates!="" && str_datee!="") {
                show_value.Append(@" and  ( (leaStratFrom<@str_dates and (leaEndAt between @str_dates and @str_datee)) or ((leaStratFrom between @str_dates and @str_datee) and leaEndAt>@str_datee) or (leaStratFrom between @str_dates and @str_datee and leaEndAt between @str_dates and @str_datee) or  (@str_dates>leaStratFrom and @str_datee<leaEndAt)   )  ");
                thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            }
            if (str_dates != "" && str_datee == "") {
                show_value.Append(@" and  leaStratFrom>=@str_dates  ");
                thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
            }
            if (str_dates == "" && str_datee != "")
            {
                show_value.Append(@" and leaEndAt<= @str_datee  ");
                thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            }
            if (leaGuid != "")
            {
                show_value.Append(@" and leaGuid = @leaGuid  ");
                thisCommand.Parameters.AddWithValue("@leaGuid", leaGuid);
            }
            show_value.Append(@" order by leaAppilcantId ASC,leaEndAt ASC  ");
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

    private SQLiteConnection sqlite_connect;
    private SQLiteCommand sqlite_cmd;

    #region 從SQLite轉資料到sy_Leave
    public void ImportSqliteToLeave()
    {
        DataTable dt = new DataTable();
        //相對路徑一定意這樣用HttpContext.Current.Server.MapPath()
        sqlite_connect = new SQLiteConnection("Data source=" + HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["sqliteString"].ToString()) + "");
        //建立資料庫連線
        sqlite_connect.Open();// Open
        sqlite_cmd = sqlite_connect.CreateCommand();//create command

        //sqlite_cmd.CommandText = "SELECT * FROM leave_leave where start_from between 20161101 and 20161131"; //select table
        string sql = @"SELECT * FROM leave_leave left join auth_user on auth_user.id=leave_leave.asker_id where status='A'";
        if (str_dates != "" && str_datee != "")
        {
            sql+= " and  ( (start_from<'"+ str_dates + "' and (end_at between '" + str_dates + "' and '" + str_datee + "')) or ((start_from between '" + str_dates + "' and '" + str_datee + "') and end_at>'" + str_dates + "') or (start_from between '" + str_dates + "' and '" + str_datee + "' and end_at between '" + str_dates + "' and '" + str_datee + "') or  ('" + str_dates + "'>start_from and '" + str_datee + "'<end_at)   )  ";
        }
        //SQLiteDataReader sqlite_datareader = sqlite_cmd.ExecuteReader();
        SQLiteDataAdapter da = new SQLiteDataAdapter(sql, sqlite_connect);
        da.Fill(dt);

        sqlite_connect.Close();

        DataView dv = dt.DefaultView;
        string sql1 = "";
        //DateTime dtime = DateTime.Parse(DateTime.Parse(dv[0]["created_date"].ToString().Trim()).ToString("yyyy-MM-dd mm:hh:ss"));
        //DateTime dtime1 = DateTime.Parse(dv[1]["created_date"].ToString().Trim());
        for (int i = 0; i < dv.Count; i++)
        {
            //在匯入時盼判斷該ID的資料是不是已經存在sy_Leave  沒有才新增
            sql1 = @"
                declare @count_rows int;
                select @count_rows=count(*) from sy_Leave where leaID=@leaID;
                if @count_rows=0
                    begin
                        insert into sy_Leave(leaGuid,leaCreatedDate,leaID,leaStratFrom,leaEndAt,leaDuration,leaRemark,leaAskerName,leaLeaveTypeId,leaAppilcantId,leaLeaveType2,leaDuration2,leaDataStatus,leaStatus,leaModdifyId,leaModdifyDate,leaImportStatus,leaAttach_file_1,leaAttach_file_2,leaScenario,leaPrint_count,leaAccountStatus)
                        values(NEWID(),@leaCreatedDate,@leaID,@leaStratFrom,@leaEndAt,@leaDuration,@leaRemark,@leaAskerName,@leaLeaveTypeId,@leaAppilcantId,@leaLeaveType2,@leaDuration2,'A',@leaStatus,@leaModdifyId,@leaModdifyDate,'Y',@leaAttach_file_1,@leaAttach_file_2,@leaScenario,@leaPrint_count,@leaAccountStatus)
                    end
            ";

            SqlConnection Sqlconn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
            SqlCommand cmd = new SqlCommand(sql1, Sqlconn);
            cmd.Parameters.AddWithValue("@leaCreatedDate", DateTime.Parse(dv[i]["created_date"].ToString()));
            cmd.Parameters.AddWithValue("@leaID", dv[i]["id"].ToString().Trim());
            cmd.Parameters.AddWithValue("@leaStratFrom", DateTime.Parse(dv[i]["start_from"].ToString()));
            cmd.Parameters.AddWithValue("@leaEndAt", DateTime.Parse(dv[i]["end_at"].ToString()));
            cmd.Parameters.AddWithValue("@leaDuration", Convert.ToDecimal(dv[i]["duration"].ToString()));
            cmd.Parameters.AddWithValue("@leaRemark", dv[i]["remark"].ToString());
            cmd.Parameters.AddWithValue("@leaAskerName", dv[i]["first_name"].ToString().Trim());
            cmd.Parameters.AddWithValue("@leaLeaveTypeId", Convert.ToInt32(dv[i]["leave_type_id"].ToString()));
            cmd.Parameters.AddWithValue("@leaAppilcantId", dv[i]["applicant_id"].ToString());
            cmd.Parameters.AddWithValue("@leaLeaveType2", ((dv[i]["leave_type_2_id"].ToString() == "") ? 0 : Convert.ToInt32(dv[i]["leave_type_2_id"].ToString())));
            cmd.Parameters.AddWithValue("@leaDuration2", ((dv[i]["duration_2"].ToString() == "") ? 0 : decimal.Parse(dv[i]["duration_2"].ToString())));
            cmd.Parameters.AddWithValue("@leaModdifyId", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaModdifyDate", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaAttach_file_1", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaAttach_file_2", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaScenario", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaPrint_count", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaAccountStatus", DBNull.Value);
            cmd.Parameters.AddWithValue("@leaStatus", dv[i]["status"].ToString().Trim());
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

    #region 刪除sy_Leave資料 BY dates-datee
    public void DeleteLeave()
    {
        SqlConnection thisConnection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        SqlCommand thisCommand = thisConnection.CreateCommand();
        SqlDataAdapter oda = new SqlDataAdapter();
        StringBuilder show_value = new StringBuilder();
        try
        {
            if (str_dates != "" && str_datee != "")
            {
                show_value.Append(@" 
                    delete from  sy_Leave 
                    where leaImportStatus='Y' and ( (leaStratFrom<@str_dates and (leaEndAt between @str_dates and @str_datee)) or ((leaStratFrom between @str_dates and @str_datee) and leaEndAt>@str_datee) or (leaStratFrom between @str_dates and @str_datee and leaEndAt between @str_dates and @str_datee) or  (@str_dates>leaStratFrom and @str_datee<leaEndAt)   )            
                ");
                thisCommand.Parameters.AddWithValue("@str_dates", str_dates);
                thisCommand.Parameters.AddWithValue("@str_datee", str_datee);
            }
            

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

    #region 新增 sy_Leave and sy_LeaveDetail 資料
    public void InsertLeaveAndDetail()
    {
        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            string mod_guid = Guid.NewGuid().ToString();
            oCmd.CommandText = @"
                insert into sy_Leave(leaGuid,leaID,leaCreatedDate,leaStratFrom,leaEndAt,leaDuration,leaRemark,leaAskerName,leaLeaveTypeId,leaAppilcantId,leaStatus,leaLeaveType2,leaDuration2,leaModdifyId,leaModdifyDate,leaImportStatus,leaDataStatus,leaAttach_file_1,leaAttach_file_2,leaScenario,leaPrint_count,leaAccountStatus)
                values(@leaGuid,@leaID,@leaCreatedDate,@leaStratFrom,@leaEndAt,@leaDuration,@leaRemark,@leaAskerName,@leaLeaveTypeId,@leaAppilcantId,@leaStatus,@leaLeaveType2,@leaDuration2,@leaModdifyId,@leaModdifyDate,@leaImportStatus,@leaDataStatus,@leaAttach_file_1,@leaAttach_file_2,@leaScenario,@leaPrint_count,@leaAccountStatus)
            ";
            oCmd.Parameters.AddWithValue("@leaGuid", mod_guid);
            oCmd.Parameters.AddWithValue("@leaID", DBNull.Value);
            oCmd.Parameters.AddWithValue("@leaCreatedDate", DateTime.Now);
            oCmd.Parameters.AddWithValue("@leaStratFrom", leaStratFrom);
            oCmd.Parameters.AddWithValue("@leaEndAt", leaEndAt);
            oCmd.Parameters.AddWithValue("@leaDuration", leaDuration);
            oCmd.Parameters.AddWithValue("@leaRemark", leaRemark);
            oCmd.Parameters.AddWithValue("@leaAskerName", leaAskerName);
            oCmd.Parameters.AddWithValue("@leaLeaveTypeId", leaLeaveTypeId);
            oCmd.Parameters.AddWithValue("@leaAppilcantId", leaAppilcantId);
            oCmd.Parameters.AddWithValue("@leaStatus", "A");
            oCmd.Parameters.AddWithValue("@leaLeaveType2", leaLeaveType2);
            oCmd.Parameters.AddWithValue("@leaDuration2", leaDuration2);
            oCmd.Parameters.AddWithValue("@leaModdifyId", leaModdifyId);
            oCmd.Parameters.AddWithValue("@leaModdifyDate", DateTime.Now);
            oCmd.Parameters.AddWithValue("@leaImportStatus", "");
            oCmd.Parameters.AddWithValue("@leaDataStatus", "A");
            oCmd.Parameters.AddWithValue("@leaAttach_file_1", DBNull.Value);
            oCmd.Parameters.AddWithValue("@leaAttach_file_2", DBNull.Value);
            oCmd.Parameters.AddWithValue("@leaScenario", DBNull.Value);
            oCmd.Parameters.AddWithValue("@leaPrint_count", DBNull.Value);
            oCmd.Parameters.AddWithValue("@leaAccountStatus", DBNull.Value);
            oCmd.ExecuteNonQuery();

            //新增到Detail
            oCmd.Parameters.Add("@ldLeaGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ldId", SqlDbType.Int);
            oCmd.Parameters.Add("@ldDate", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ldApplicantId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ldLeaveid", SqlDbType.Int);
            oCmd.Parameters.Add("@ldTypeId", SqlDbType.Int);
            oCmd.Parameters.Add("@ldDuration", SqlDbType.Decimal);
            oCmd.CommandText = @"
                insert into sy_LeaveDetail(ldLeaGuid,ldId,ldDate,ldApplicantId,ldLeaveid,ldTypeId,ldDuration)
                values(@ldLeaGuid,@ldId,@ldDate,@ldApplicantId,@ldLeaveid,@ldTypeId,@ldDuration)
            ";

            //只有假別1
            if (leaLeaveType2 == 0 && str_type2_date == "")
            {
                //判斷0.5天 如果總天數有.5 假別一也有.5  表示前半天在假別1
                //1.只有半天
                if (str_days.Substring(str_days.Length - 2) == ".5" && str_type_date.Substring(str_type_date.Length - 2) == ".5" && str_days == "0.5")
                {
                    oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(str_days);
                    oCmd.ExecuteNonQuery();
                }
                else
                {//超過半天
                 //只有假別1
                 //先insert 半天的進去
                    oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(0.5);
                    oCmd.ExecuteNonQuery();
                    
                    double days = Convert.ToDouble(str_days) - 0.5;
                    DateTime dtime_this = Convert.ToDateTime(leaStratFrom);//.ToShortDateString()
                    //再insert 後面整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_days) - 0.5); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                }
            }
            else
            {//假別1.2混搭
             //半天在假別1 假別2都整天
                if (Convert.ToDouble(str_days).ToString("#0.0").Substring(Convert.ToDouble(str_days).ToString("#0.0").Length - 2) == ".5" && Convert.ToDouble(str_type_date).ToString("#0.0").Substring(Convert.ToDouble(str_type_date).ToString("#0.0").Length - 2) == ".5")
                {
                    //1.先insert 假別1 半天的進去
                    oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(0.5);
                    oCmd.ExecuteNonQuery();

                    double days = Convert.ToDouble(str_days) - 0.5;
                    DateTime dtime_this = Convert.ToDateTime(leaStratFrom);//.ToShortDateString()
                    //2.再insert 假別1 後面整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type_date) - 0.5); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //3.insert 假別2整天得進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type2_date)); i++)
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                }//半天在假別1 假別2都整天 END
                 //假別1都整天 半天在假別2
                else if (Convert.ToDouble(str_days).ToString("#0.0").Substring(Convert.ToDouble(str_days).ToString("#0.0").Length - 2) == ".5" && Convert.ToDouble(str_type2_date).ToString("#0.0").Substring(Convert.ToDouble(str_type2_date).ToString("#0.0").Length - 2) == ".5")
                {
                    double days = Convert.ToDouble(str_days);
                    DateTime dtime_this = Convert.ToDateTime(str_days);//.ToShortDateString()
                    //1.先insert 假別1 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //2.再insert 假別2 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type2_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //3.insert 假別2 後面半天的進去
                    oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(0.5);
                    oCmd.ExecuteNonQuery();
                }//假別1都整天 半天在假別2 END
                 //兩種假別都整天
                else
                {
                    double days = Convert.ToDouble(str_days);
                    DateTime dtime_this = Convert.ToDateTime(leaStratFrom);//.ToShortDateString()
                                                                        //1.先insert 假別1 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //2.再insert 假別2 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type2_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                }//兩種假別都整天 END

            }

            myTrans.Commit();
        }
        catch (Exception ex)
        {
            myTrans.Rollback();
            throw ex;
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
        }

    }
    #endregion

    #region 刪除 sy_Leave and sy_LeaveDetail 資料
    public void DeleteLeaveAndDetail()
    {
        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            oCmd.CommandText = @"
                update sy_Leave set leaDataStatus='D' where leaGuid=@leaGuid 
            ";
            oCmd.Parameters.AddWithValue("@leaGuid", leaGuid);
            oCmd.ExecuteNonQuery();

            //delete Detail
            oCmd.CommandText = @"
                delete from sy_LeaveDetail where ldLeaGuid=@ldLeaGuid
            ";
            oCmd.Parameters.AddWithValue("@ldLeaGuid", leaGuid);
            oCmd.ExecuteNonQuery();

            myTrans.Commit();
        }
        catch (Exception ex)
        {
            myTrans.Rollback();
            throw ex;
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
        }

    }
    #endregion

    #region 修改 sy_Leave and sy_LeaveDetail 資料
    public void UpdateLeaveAndDetail()
    {
        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            string mod_guid = leaGuid;
            if (leaID != 0)
            {
                oCmd.CommandText = @"
                    update sy_Leave set 
                    leaStratFrom=@leaStratFrom,leaEndAt=@leaEndAt,leaDuration=@leaDuration,leaRemark=@leaRemark,leaAskerName=@leaAskerName,
                    leaLeaveTypeId=@leaLeaveTypeId,leaAppilcantId=@leaAppilcantId,leaStatus=@leaStatus,
                    leaLeaveType2=@leaLeaveType2,leaDuration2=@leaDuration2,
                    leaModdifyId=@leaModdifyId,leaModdifyDate=@leaModdifyDate
                    where leaID=@leaID
                ";
                oCmd.Parameters.AddWithValue("@leaID", leaID);
            }//leaGuid=@leaGuid 
            else {
                oCmd.CommandText = @"
                    update sy_Leave set 
                    leaStratFrom=@leaStratFrom,leaEndAt=@leaEndAt,leaDuration=@leaDuration,leaRemark=@leaRemark,leaAskerName=@leaAskerName,
                    leaLeaveTypeId=@leaLeaveTypeId,leaAppilcantId=@leaAppilcantId,leaStatus=@leaStatus,
                    leaLeaveType2=@leaLeaveType2,leaDuration2=@leaDuration2,
                    leaModdifyId=@leaModdifyId,leaModdifyDate=@leaModdifyDate
                    where leaGuid=@leaGuid
                ";
                oCmd.Parameters.AddWithValue("@leaGuid", leaGuid);
            }
            oCmd.Parameters.AddWithValue("@leaStratFrom", leaStratFrom);
            oCmd.Parameters.AddWithValue("@leaEndAt", leaEndAt);
            oCmd.Parameters.AddWithValue("@leaDuration", leaDuration);
            oCmd.Parameters.AddWithValue("@leaRemark", leaRemark);
            oCmd.Parameters.AddWithValue("@leaAskerName", leaAskerName);
            oCmd.Parameters.AddWithValue("@leaLeaveTypeId", leaLeaveTypeId);
            oCmd.Parameters.AddWithValue("@leaAppilcantId", leaAppilcantId);
            oCmd.Parameters.AddWithValue("@leaStatus", "A");
            oCmd.Parameters.AddWithValue("@leaLeaveType2", leaLeaveType2);
            oCmd.Parameters.AddWithValue("@leaDuration2", leaDuration2);
            oCmd.Parameters.AddWithValue("@leaModdifyId", leaModdifyId);
            oCmd.Parameters.AddWithValue("@leaModdifyDate", DateTime.Now);
            oCmd.ExecuteNonQuery();

            //新增到Detail 先砍掉舊的再新增
            oCmd.Parameters.Add("@ldLeaGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ldLeaveid", SqlDbType.Int);
            
            if (leaID != 0) {
                oCmd.CommandText = @"
                    delete from sy_LeaveDetail where ldLeaveid=@ldLeaveid
                ";
                oCmd.Parameters["@ldLeaveid"].Value = leaID;
                oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
            }
            else
            {
                oCmd.CommandText = @"
                    delete from sy_LeaveDetail where ldLeaGuid=@ldLeaGuid
                ";
                oCmd.Parameters["@ldLeaGuid"].Value = leaGuid;
                oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
            }
            oCmd.ExecuteNonQuery();

            //新增到Detail
            oCmd.Parameters.Add("@ldId", SqlDbType.Int);
            oCmd.Parameters.Add("@ldDate", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ldApplicantId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ldTypeId", SqlDbType.Int);
            oCmd.Parameters.Add("@ldDuration", SqlDbType.Decimal);
            oCmd.CommandText = @"
                insert into sy_LeaveDetail(ldLeaGuid,ldId,ldDate,ldApplicantId,ldLeaveid,ldTypeId,ldDuration)
                values(@ldLeaGuid,@ldId,@ldDate,@ldApplicantId,@ldLeaveid,@ldTypeId,@ldDuration)
            ";
            //只有假別1
            if (leaLeaveType2 == 0 && str_type2_date == "")
            {
                //判斷0.5天 如果總天數有.5 假別一也有.5  表示前半天在假別1
                //1.只有半天
                if (str_days.Substring(str_days.Length - 2) == ".5" && str_type_date.Substring(str_type_date.Length - 2) == ".5" && str_days == "0.5")
                {
                    if (leaID != 0)
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldLeaveid"].Value = leaID;
                    }
                    else {
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    }
                   
                    oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(str_days);
                    oCmd.ExecuteNonQuery();
                }
                else
                {//超過半天
                 //只有假別1
                 //先insert 半天的進去
                    if (leaID != 0)
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldLeaveid"].Value = leaID;
                    }
                    else
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    }
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(0.5);
                    oCmd.ExecuteNonQuery();

                    double days = Convert.ToDouble(str_days) - 0.5;
                    DateTime dtime_this = Convert.ToDateTime(leaStratFrom);//.ToShortDateString()
                    //再insert 後面整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_days) - 0.5); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                }
            }
            else
            {//假別1.2混搭
             //半天在假別1 假別2都整天
                if (Convert.ToDouble(str_days).ToString("#0.0").Substring(Convert.ToDouble(str_days).ToString("#0.0").Length - 2) == ".5" && Convert.ToDouble(str_type_date).ToString("#0.0").Substring(Convert.ToDouble(str_type_date).ToString("#0.0").Length - 2) == ".5")
                {
                    //1.先insert 假別1 半天的進去
                    if (leaID != 0)
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldLeaveid"].Value = leaID;
                    }
                    else
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    }
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(0.5);
                    oCmd.ExecuteNonQuery();

                    double days = Convert.ToDouble(str_days) - 0.5;
                    DateTime dtime_this = Convert.ToDateTime(leaStratFrom);//.ToShortDateString()
                    //2.再insert 假別1 後面整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type_date) - 0.5); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //3.insert 假別2整天得進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type2_date)); i++)
                    {
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                }//半天在假別1 假別2都整天 END
                 //假別1都整天 半天在假別2
                else if (Convert.ToDouble(str_days).ToString("#0.0").Substring(Convert.ToDouble(str_days).ToString("#0.0").Length - 2) == ".5" && Convert.ToDouble(str_type2_date).ToString("#0.0").Substring(Convert.ToDouble(str_type2_date).ToString("#0.0").Length - 2) == ".5")
                {
                    double days = Convert.ToDouble(str_days);
                    DateTime dtime_this = Convert.ToDateTime(str_days);//.ToShortDateString()
                    //1.先insert 假別1 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //2.再insert 假別2 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type2_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //3.insert 假別2 後面半天的進去
                    if (leaID != 0)
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                        oCmd.Parameters["@ldLeaveid"].Value = leaID;
                    }
                    else
                    {
                        oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                        oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                    }
                    oCmd.Parameters["@ldId"].Value = DBNull.Value;
                    oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                    oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                    oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                    oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(0.5);
                    oCmd.ExecuteNonQuery();
                }//假別1都整天 半天在假別2 END
                 //兩種假別都整天
                else
                {
                    double days = Convert.ToDouble(str_days);
                    DateTime dtime_this = Convert.ToDateTime(str_days);//.ToShortDateString()
                                                                       //1.先insert 假別1 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = Convert.ToDateTime(leaStratFrom).ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveTypeId;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                    //2.再insert 假別2 整天的進去
                    for (int i = 1; i <= (Convert.ToDouble(str_type2_date)); i++)
                    {
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        dtime_this = dtime_this.AddDays(1);//.ToShortDateString()
                        if (leaID != 0)
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = DBNull.Value;
                            oCmd.Parameters["@ldLeaveid"].Value = leaID;
                        }
                        else
                        {
                            oCmd.Parameters["@ldLeaGuid"].Value = mod_guid;
                            oCmd.Parameters["@ldLeaveid"].Value = DBNull.Value;
                        }
                        oCmd.Parameters["@ldId"].Value = DBNull.Value;
                        oCmd.Parameters["@ldDate"].Value = dtime_this.ToString("yyyy/MM/dd");
                        oCmd.Parameters["@ldApplicantId"].Value = leaAppilcantId;
                        oCmd.Parameters["@ldTypeId"].Value = leaLeaveType2;
                        oCmd.Parameters["@ldDuration"].Value = Convert.ToDecimal(1);
                        oCmd.ExecuteNonQuery();
                    }
                }//兩種假別都整天 END

            }

            myTrans.Commit();
        }
        catch (Exception ex)
        {
            myTrans.Rollback();
            throw ex;
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
        }

    }
    #endregion

    #region 撈 SQLite auth_user.first_name BY name
    public DataTable SelectSqliteAuthUser()
    {
        DataTable dt = new DataTable();
        //相對路徑一定意這樣用HttpContext.Current.Server.MapPath()
        sqlite_connect = new SQLiteConnection("Data source=" + HttpContext.Current.Server.MapPath(ConfigurationManager.AppSettings["sqliteString"].ToString()) + "");
        
        try
        {
            //建立資料庫連線
            sqlite_connect.Open();// Open
            sqlite_cmd = sqlite_connect.CreateCommand();//create command
            //sqlite_cmd.CommandText = "SELECT * FROM leave_leave where start_from between 20161101 and 20161131"; //select table
            string sql = @"select first_name from auth_user where username='" + str_username + "' ";
            //SQLiteDataReader sqlite_datareader = sqlite_cmd.ExecuteReader();
            SQLiteDataAdapter da = new SQLiteDataAdapter(sql, sqlite_connect);
            da.Fill(dt);
            return dt;
        }
        catch (Exception ex) { throw ex; }
        finally {
            sqlite_connect.Close();
        }
        

    }
    #endregion
}