<%@ WebHandler Language="C#" Class="WorkHoursImport" %>

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
    public void ProcessRequest (HttpContext context) {
        bool status = true;
        string YearMonth = string.Empty;
        string now_rows = string.Empty;
        HttpFileCollection uploadFiles = context.Request.Files;//檔案集合

        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            
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

                oCmd.Parameters.Add("@aperNo", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@aAttendanceDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@aTimes", SqlDbType.Decimal);
                string perno = string.Empty;
                string str_date = string.Empty;
                Decimal str_times;
                //第三個row開始是資料
                //for (int j = 3; j <= 20; j++)
                for (int j = 3; j <= Xls.GetRowCount(1); j++)
                {
                    now_rows = j.ToString();
                    perno = (Xls.GetCellValue(j, 2) != null) ? Xls.GetCellValue(j, 2).ToString() : "";
                    for (int k = 4; k <= col_count; k++) {
                        //因為excel的日期格式是d-mmm，這邊抓到會是5位數的數字 
                        //所以要這樣先轉成我們要的日期格式 DateTime.FromOADate(Double.Parse(str)).ToString("yyyy/MM/dd")
                        str_date = (Xls.GetCellValue(1, k) != null) ? DateTime.FromOADate(Double.Parse(Xls.GetCellValue(1, k).ToString())).ToString("yyyy/MM/dd"): "";
                        str_times = (Xls.GetCellValue(1, k) != null) ? Convert.ToDecimal(Xls.GetCellValue(j, k).ToString().Trim()) : 0;
                        oCmd.CommandText = @"
                            declare @aperGuid nvarchar(50)
                            select @aperGuid=perGuid from sy_Person where perNo=@aperNo
                            insert into sy_Attendance_tmp(aperGuid,aperNo,aAttendanceDate,aTimes)
                            values(@aperGuid,@aperNo,@aAttendanceDate,@aTimes)
                        ";
                        oCmd.Parameters["@aperNo"].Value = perno;
                        oCmd.Parameters["@aAttendanceDate"].Value = str_date;
                        oCmd.Parameters["@aTimes"].Value = str_times;
                        oCmd.ExecuteNonQuery();
                    }
                }
                myTrans.Commit();

                SqlCommand oCmd2 = new SqlCommand();
                oCmd2.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                StringBuilder sb = new StringBuilder();

                sb.Append(@"sp_workhours");
                oCmd2.CommandTimeout = 120;
                oCmd2.CommandText = sb.ToString();
                oCmd2.CommandType = CommandType.StoredProcedure;
                oCmd2.Connection.Open();

                SqlDataAdapter oda = new SqlDataAdapter(oCmd2);
                oCmd2.Parameters.AddWithValue("@create_id", "Wang");
                //oCmd.Parameters.AddWithValue("@Year", Year);
                oCmd2.ExecuteNonQuery();

                oCmd2.Connection.Close();
                oCmd2.Connection.Dispose();
                oCmd2.Dispose();
                File.Delete(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(uploadFiles[0].FileName)));
            }
        }
        catch (Exception ex)
        {
            status = false;
            myTrans.Rollback();
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
            context.Response.ContentType = "text/html";
            if (status == false)
                //context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('工時匯入失敗，請聯絡系統管理員');</script>");
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('第"+now_rows+"筆資料有誤');</script>");
            else
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('工時匯入完成');</script>");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}