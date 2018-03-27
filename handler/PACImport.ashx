<%@ WebHandler Language="C#" Class="PACImport" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Configuration;
using System.Web.SessionState;

public class PACImport : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        bool status = true;
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
                string fileSpec = context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName));
                Xls.Open(fileSpec);
                Xls.ActiveSheet = 1;

                string textdate = string.IsNullOrEmpty(context.Request.Form["textdate"]) ? "" : context.Request.Form["textdate"].ToString().Trim();
                string textsiref = string.IsNullOrEmpty(context.Request.Form["textsiref"]) ? "" : context.Request.Form["textsiref"].ToString().Trim();
                oCmd.Parameters.Add("@pacChangeDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pacCreateId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@pacChangeEnd", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@perNo", SqlDbType.NVarChar);
                if (textsiref == "01")
                {//底薪
                    for (int j = 2; j <= Xls.GetRowCount(1); j++)
                    {
                        string perno = (Xls.GetCellValue(j, 1) != null) ? Xls.GetCellValue(j, 1).ToString() : "";
                        string aftermoney = (Xls.GetCellValue(j, 2) != null) ? Xls.GetCellValue(j, 2).ToString() : "";

                        oCmd.CommandText = @"
                            insert into sy_PersonAllowanceChang1e(pacGuid,pacPerGuid,pacChangeDate,pacChangeBegin,pacChangeEnd,pacStatus,pacCreateId,pacCreateDate,pacStatus_d,pacChange)
                            select 
                            NEWID(),
                            perGuid,
                            @pacChangeDate,
                            perBasicSalary,
                            @pacChangeEnd,
                            '0',
                            @pacCreateId,
                            GETDATE(),
                            'A',
                            (select siGuid from sy_SalaryItem where siRef='01')
                            from sy_Person
                            where perNo=@perNo and perStatus='A'
                        ";
                        oCmd.Parameters["@pacChangeDate"].Value = textdate;
                        oCmd.Parameters["@pacCreateId"].Value = USERINFO.MemberGuid.ToString().Trim();
                        oCmd.Parameters["@pacChangeEnd"].Value = aftermoney;
                        oCmd.Parameters["@perNo"].Value = perno;
                        oCmd.ExecuteNonQuery();
                    }
                }
                if (textsiref == "02")
                {//職能加給
                    for (int j = 2; j <= Xls.GetRowCount(1); j++)
                    {
                        string perno = (Xls.GetCellValue(j, 1) != null) ? Xls.GetCellValue(j, 1).ToString() : "";
                        string aftermoney = (Xls.GetCellValue(j, 2) != null) ? Xls.GetCellValue(j, 2).ToString() : "";
                        oCmd.CommandText = @"
                            insert into sy_PersonAllowanceChang1e(pacGuid,pacPerGuid,pacChangeDate,pacChangeBegin,pacChangeEnd,pacStatus,pacCreateId,pacCreateDate,pacStatus_d,pacChange)
                            select 
                            NEWID(),
                            perGuid,
                            @pacChangeDate,
                            perAllowance,
                            @pacChangeEnd,
                            '0',
                            @pacCreateId,
                            GETDATE(),
                            'A',
                            (select siGuid from sy_SalaryItem where siRef='02')
                            from sy_Person
                            where perNo=@perNo and perStatus='A'
                        ";
                        oCmd.Parameters["@pacChangeDate"].Value = textdate;
                        oCmd.Parameters["@pacCreateId"].Value = USERINFO.MemberGuid.ToString().Trim();
                        oCmd.Parameters["@pacChangeEnd"].Value = aftermoney;
                        oCmd.Parameters["@perNo"].Value = perno;
                        oCmd.ExecuteNonQuery();
                    }
                }
                myTrans.Commit();

                File.Delete(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(aFile.FileName)));
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
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('匯入失敗，請聯絡系統管理員');</script>");
            else
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('資料匯入完成');</script>");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}