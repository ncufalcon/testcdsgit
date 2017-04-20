<%@ WebHandler Language="C#" Class="InsuranceLevelImport" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Configuration;

public class InsuranceLevelImport : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        bool status = true;
        HttpFileCollection uploadFiles = context.Request.Files;//檔案集合

        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        string str_response = "";
        string str_date = "";
        try
        {
            for (int i = 0; i < uploadFiles.Count; i++)
            {
                HttpPostedFile aFile = uploadFiles[i];
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
                oCmd.Parameters.Add("@ilGuid", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ilItem1", SqlDbType.Decimal);
                oCmd.Parameters.Add("@ilItem2", SqlDbType.Decimal);
                oCmd.Parameters.Add("@ilItem3", SqlDbType.Decimal);
                oCmd.Parameters.Add("@ilItem4", SqlDbType.Decimal);
                oCmd.Parameters.Add("@ilEffectiveDate", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ilCreatId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ilModifyId", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@ilModifyDate", SqlDbType.DateTime);

                DateTime dtDate;
                int n;
                int error_date = 0;
                int error_num = 0;

                //寫入資料庫
                for (int j = 2; j <= Xls.GetRowCount(1); j++)
                {
                    if (!DateTime.TryParse(Xls.GetCellValue(j, 5).ToString().Trim(), out dtDate ) || Xls.GetCellValue(j, 5).ToString().Trim().Length != 10)
                    {
                        //不是日期格式 或 日期格式有誤
                        error_date++;
                    }
                    else if(!int.TryParse(Xls.GetCellValue(j, 1).ToString().Trim(), out n) || !int.TryParse(Xls.GetCellValue(j, 2).ToString().Trim(), out n) || !int.TryParse(Xls.GetCellValue(j, 3).ToString().Trim(), out n) || !int.TryParse(Xls.GetCellValue(j, 4).ToString().Trim(), out n))
                    {
                        //不是數字格式
                        error_num++;
                    }
                    else {
                        if (str_date == "")
                            str_date = Xls.GetCellValue(j, 5).ToString().Trim();

                        oCmd.CommandText = @"
                            insert into sy_InsuranceLevel(ilGuid,ilItem1,ilItem2,ilItem3,ilItem4,ilEffectiveDate,ilCreatId,ilModifyId,ilModifyDate,ilStatus)
                            values(@ilGuid,@ilItem1,@ilItem2,@ilItem3,@ilItem4,@ilEffectiveDate,@ilCreatId,@ilModifyId,@ilModifyDate,'A')
                        ";

                        oCmd.Parameters["@ilGuid"].Value = Guid.NewGuid().ToString();
                        oCmd.Parameters["@ilItem1"].Value = Convert.ToDecimal(Xls.GetCellValue(j, 1).ToString().Trim());
                        oCmd.Parameters["@ilItem2"].Value = Convert.ToDecimal(Xls.GetCellValue(j, 2).ToString().Trim());
                        oCmd.Parameters["@ilItem3"].Value = Convert.ToDecimal(Xls.GetCellValue(j, 3).ToString().Trim());
                        oCmd.Parameters["@ilItem4"].Value = Convert.ToDecimal(Xls.GetCellValue(j, 4).ToString().Trim());
                        oCmd.Parameters["@ilEffectiveDate"].Value = Xls.GetCellValue(j, 5).ToString().Trim();
                        oCmd.Parameters["@ilCreatId"].Value = "王胖爺";
                        oCmd.Parameters["@ilModifyId"].Value = "王胖爺";
                        oCmd.Parameters["@ilModifyDate"].Value = DateTime.Now;
                        oCmd.ExecuteNonQuery();
                    }
                }


                if (error_date != 0 || error_num != 0)
                {
                    if (error_date!=0) {
                        str_response += "\\n請檢查日期格式是否為yyyy/mm/dd";
                    }
                    if (error_num!=0) {
                        str_response += "\\n請檢查級距是否皆為數字";
                    }

                    myTrans.Rollback();
                }
                else {
                    myTrans.Commit();
                }

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
            if (status == false) {
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('匯入失敗，請聯絡系統管理員');</script>");
            }
            else{
                if (str_response != "")
                {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('資料匯入失敗"+str_response+",nodate');</script>");
                }
                else {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('資料匯入完成,"+str_date+"');</script>");
                }
            }

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}