﻿<%@ WebHandler Language="C#" Class="WorkHoursImport" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Text;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using FlexCel.Core;
using FlexCel.XlsAdapter;

public class WorkHoursImport : IHttpHandler, IRequiresSessionState
{
    ErrorLog err = new ErrorLog();
    sy_Attendance_DB a_db = new sy_Attendance_DB();
    public void ProcessRequest (HttpContext context) {
        string session_no = string.IsNullOrEmpty(USERINFO.MemberGuid) ? "" : USERINFO.MemberGuid.ToString().Trim();
        string session_name = string.IsNullOrEmpty(USERINFO.MemberName) ? "" : USERINFO.MemberName.ToString().Trim();
        bool status = true;
        string YearMonth = string.Empty;
        string now_rows = string.Empty;
        string error_msg = "Error Massage = ";
        HttpFileCollection uploadFiles = context.Request.Files;//檔案集合

        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;

        try
        {
            DateTime Start1 = DateTime.Now; /// 記錄時間
            string str_userid = session_no;
            DateTime dtnow = DateTime.Now;
            //將EXCEL資料先放到dt裡面再做insert
            DataTable dt = new DataTable();
            dt.Columns.Add("str_perno");
            dt.Columns.Add("str_date");
            dt.Columns.Add("str_times");
            dt.Columns.Add("str_dtnow");
            dt.Columns.Add("str_userid");
            //dt.Columns.Add("str_createdate");
            //dt.Columns.Add("str_userid");

            int str_nowrow = 0;
            string str_no_rowdata = "";


            for (int i = 0; i < uploadFiles.Count; i++)
            {
                HttpPostedFile aFile = uploadFiles[i];
                //if (aFile.ContentLength == 0 || String.IsNullOrEmpty(System.IO.Path.GetFileName(aFile.FileName)))
                //{
                //    continue;
                //}
                ExcelFile Xls = new XlsFile(true);
                string UpLoadPath = context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName));
                if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
                {
                    Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                }
                aFile.SaveAs(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName)));

                Xls.Open(UpLoadPath);

                Xls.ActiveSheet = 1;
                //Xls.ColCount 取得欄位數
                int col_count = 0;//總共有幾個工作天的欄位
                col_count = (Xls.ColCount);

                oCmd.Parameters.Add("@ah_guid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ah_perNo", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ah_AttendanceDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ah_Times", SqlDbType.Decimal);
                //oCmd.Parameters.Add("@ah_Remark", SqlDbType.NVarChar);
                //oCmd.Parameters.Add("@ah_Itme", SqlDbType.NVarChar);
                //oCmd.Parameters.Add("@ah_Status", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ah_CreateId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ah_CreateDate", SqlDbType.DateTime);
                oCmd.Parameters.Add("@ah_ModdifyId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ah_ModdifyDate", SqlDbType.DateTime);
                string perno = string.Empty;
                string str_date = string.Empty;
                string dates = string.Empty;//該次匯入最小日期
                string datee = string.Empty;//該次匯入最大日期
                Decimal str_times;
                //第三個row開始是資料
                for (int j = 3; j <= Xls.GetRowCount(1); j++)
                {
                    now_rows = j.ToString();
                    for (int k = 4; k <= col_count; k++) {
                        //因為excel的日期格式是d-mmm，這邊抓到會是5位數的數字 
                        //所以要這樣先轉成我們要的日期格式 DateTime.FromOADate(Double.Parse(str)).ToString("yyyy/MM/dd")
                        //抓最大最小日期只要在抓第一筆有資料的row做就好
                        //防止user右邊的column都沒有刪除 所以判斷(1, k)到底有沒有值再跑回圈
                        if (Xls.GetCellValue(1, k)==null || Xls.GetCellValue(1, k).ToString()=="") {
                            continue;
                        }
                        str_date = (Xls.GetCellValue(1, k) != null) ? DateTime.FromOADate(Double.Parse(Xls.GetCellValue(1, k).ToString())).ToString("yyyy/MM/dd"): "";
                        str_times = (Xls.GetCellValue(j, k) != null) ? Convert.ToDecimal(Xls.GetCellValue(j, k).ToString().Trim()) : 0;
                        perno = (Xls.GetCellValue(j, 2) != null) ? Xls.GetCellValue(j, 2).ToString().Trim() : "";
                        if (j==3) {
                            if (k == 4)
                            {
                                if (str_date != "")
                                {
                                    dates = (Xls.GetCellValue(1, k) != null) ? DateTime.FromOADate(Double.Parse(Xls.GetCellValue(1, k).ToString())).ToString("yyyy/MM/dd") : "";
                                }
                            }
                            else {
                                if (str_date!="") {
                                    datee = (Xls.GetCellValue(1, k) != null) ? DateTime.FromOADate(Double.Parse(Xls.GetCellValue(1, k).ToString())).ToString("yyyy/MM/dd") : "";
                                }
                            }

                        }
                        DataRow row = dt.NewRow();
                        row["str_perno"] = perno;
                        row["str_date"] = str_date;
                        row["str_times"] = str_times;
                        row["str_dtnow"] = dtnow;
                        row["str_userid"] = str_userid;
                        dt.Rows.Add(row);
                    }
                }
                now_rows = "";//資料都進datatable了 沒有錯誤的資料把now_rows=""
                DateTime END1 = DateTime.Now; /// 記錄時間
                if (dt.Rows.Count>0) {
                    //先刪除這批匯入的時間區間內所有匯入的資料 ah_flag = 'Y' 不刪除手動匯入資料
                    deleteAttendanceHoursForImport(myTrans,dates,datee,error_msg);

                    // 建立 temp table
                    CreateTempTable( myTrans,error_msg );
                    // 利用 SqlBulkCopy 新增資料到temp table
                    DoBulkCopy( myTrans, dt,error_msg );
                    //insert 資料
                    DoDataJoinAndInsert(myTrans,error_msg);
                    DateTime END2 = DateTime.Now; /// 記錄時間
                    string dtime1 = (END1 - Start1).TotalMilliseconds.ToString( "#,###" );
                    string dtime2 = (END2 - END1).TotalMilliseconds.ToString( "#,###" );
                }
            }
            //再commit insert
            myTrans.Commit();

            File.Delete(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(uploadFiles[0].FileName)));
        }
        catch (Exception ex)
        {
            err.InsErrorLog("WorkHoursImport.ashx", ex.Message, USERINFO.MemberName);
            status = false;
            if (error_msg=="Error Massage = ") {
                error_msg += ex.Message.ToString();
            }
            myTrans.Rollback();
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
            context.Response.ContentType = "text/html";
            if (status == false)
            {
                //context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('工時匯入失敗，請聯絡系統管理員');</script>");
                if (now_rows != "")
                {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('工時匯入失敗，第" + now_rows + "筆資料有誤。" + error_msg + "');</script>");
                }
                else {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('工時匯入失敗。" + error_msg + "');</script>");
                }

            }
            else {
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('工時匯入完成');</script>");
            }

        }
    }

    //匯入前先刪掉時間區間內的資料
    void deleteAttendanceHoursForImport(SqlTransaction oTran, string dates, string datee, string error_msg)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"
                delete from sy_Attendance_hours  where ah_flag='Y' and ah_AttendanceDate between @dates and @datee
            ");

            SqlCommand oCmd = oTran.Connection.CreateCommand();
            oCmd.Parameters.AddWithValue("@dates", dates);
            oCmd.Parameters.AddWithValue("@datee", datee);
            oCmd.Transaction = oTran;
            oCmd.CommandText = sb.ToString();
            oCmd.ExecuteNonQuery();
        }
        catch (Exception ex){
            error_msg = "deleteAttendanceHoursForImport：" + ex.Message.ToString();
        }

    }
    //tmp table 拿來做join
    void CreateTempTable(SqlTransaction oTran,string error_msg)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"
                CREATE TABLE #temp (
                  str_perno  nvarchar(50),
                  str_date nvarchar(10),
                  str_times decimal(10,2),
                  str_dtnow datetime,
                  str_userid nvarchar(50)
                );
            ");
            SqlCommand oCmd = oTran.Connection.CreateCommand();
            oCmd.Transaction = oTran;
            oCmd.CommandText = sb.ToString();
            oCmd.ExecuteNonQuery();
        }
        catch (Exception ex){
            error_msg += ",CreateTempTable：" + ex.Message.ToString();
        }

    }

    //執行 BulkCopy
    void DoBulkCopy( SqlTransaction oTran, DataTable srcData,string error_msg )
    {
        try
        {
            SqlBulkCopyOptions setting = SqlBulkCopyOptions.CheckConstraints | SqlBulkCopyOptions.TableLock;
            using (SqlBulkCopy sqlBC = new SqlBulkCopy(oTran.Connection, setting, oTran))
            {
                sqlBC.BulkCopyTimeout = 600; ///設定逾時的秒數
                //sqlBC.BatchSize = 1000; ///設定一個批次量寫入多少筆資料, 設定值太小會影響效能 
                ////設定 NotifyAfter 屬性，以便在每複製 10000 個資料列至資料表後，呼叫事件處理常式。
                //sqlBC.NotifyAfter = 10000;
                ///設定要寫入的資料庫
                sqlBC.DestinationTableName = "#temp";

                /// 對應來源與目標資料欄位
                sqlBC.ColumnMappings.Add("str_perno", "str_perno");
                sqlBC.ColumnMappings.Add("str_date", "str_date");
                sqlBC.ColumnMappings.Add("str_times", "str_times");
                sqlBC.ColumnMappings.Add("str_dtnow", "str_dtnow");
                sqlBC.ColumnMappings.Add("str_userid", "str_userid");

                /// 開始寫入資料
                sqlBC.WriteToServer(srcData);
            }
        }
        catch (Exception ex){
            error_msg += ",DoBulkCopy error：" + ex.Message.ToString();
        }

    }

    //將tmp table 資料join 出GUID insert 回sy_Attendance_hours
    void DoDataJoinAndInsert(SqlTransaction oTran, string error_msg)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"
                insert into sy_Attendance_hours(ah_guid,ah_perGuid,ah_perNo,ah_AttendanceDate,ah_Times,ah_Remark,ah_Itme,ah_Status,ah_CreateId,ah_CreateDate,ah_ModdifyId,ah_ModdifyDate,ah_flag)
                select NEWID(),perGuid,str_perno,str_date,str_times,'','01','A',str_userid,str_dtnow,str_userid,str_dtnow,'Y' from #temp  WITH (NOLOCK) left join sy_Person  WITH (NOLOCK) on perNo=str_perno
            ");
            SqlCommand oCmd = oTran.Connection.CreateCommand();
            oCmd.Transaction = oTran;
            oCmd.CommandText = sb.ToString();
            oCmd.ExecuteNonQuery();
        }
        catch(Exception ex){
            error_msg += ",DoDataJoinAndInsert Error：" + ex.Message.ToString();
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}