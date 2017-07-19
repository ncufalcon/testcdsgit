<%@ WebHandler Language="C#" Class="InsuranceLevelImport" %>

using System;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Configuration;
using System.Web.SessionState;

public class InsuranceLevelImport : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        string session_no = string.IsNullOrEmpty(USERINFO.MemberGuid) ? "" : USERINFO.MemberGuid.ToString().Trim();
        string session_name = string.IsNullOrEmpty(USERINFO.MemberName) ? "" : USERINFO.MemberName.ToString().Trim();
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
        string now_rows = "";

        //生效日期 201705改為手動輸入
        string textdate = string.IsNullOrEmpty(context.Request.Form["textdate"]) ? "" : context.Request.Form["textdate"].ToString().Trim();

        try
        {
            //如果日期是空或不是日期格式 就catch掉
            str_response = "請輸入正確生效日期";
            DateTime dtnow = DateTime.Parse(textdate);
            str_response = "";

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
                int error_samdate = 0;
                int int_ilItem1 = 0;
                sy_InsuranceLevel_DB il_db = new sy_InsuranceLevel_DB();
                DataTable dt_chk_date = il_db.SelectInsuranceLevelDate();
                //寫入資料庫
                for (int j = 2; j <= Xls.GetRowCount(1); j++)
                {
                    now_rows = j.ToString();
                    string cl1 = (Xls.GetCellValue(j, 1) != null) ? Xls.GetCellValue(j, 1).ToString().Trim() : "";
                    string cl2 = (Xls.GetCellValue(j, 2) != null) ? Xls.GetCellValue(j, 2).ToString().Trim() : "";
                    string cl3 = (Xls.GetCellValue(j, 3) != null) ? Xls.GetCellValue(j, 3).ToString().Trim() : "";
                    //如果輸入的值不是空 但不是數字就catch掉
                    if (cl1!="") {
                        int int_cl1 = int.Parse(cl1);
                    }
                    if (cl2!="") {
                        int int_cl2 = int.Parse(cl2);
                    }
                    if (cl3!="") {
                        int int_cl3 = int.Parse(cl3);
                    }
                    
                    //判斷日期格式
                    if (!DateTime.TryParse(textdate, out dtDate) || textdate.ToString().Trim().Length != 10)
                    {
                        //不是日期格式 或 日期格式有誤
                        error_date++;
                        continue;
                    } else {
                        //重複匯入
                        DataRow[] rows = dt_chk_date.Select("ilEffectiveDate = '" + textdate + "' ");
                        if (rows.Length>0) {
                            error_samdate++;
                            continue;
                        }
                    }
                    if (cl1 == "" && cl2 == "" && cl3 == "")
                    {
                        continue;
                    }
                    else {
                        int_ilItem1 = int_ilItem1 + 1;
                    }
                    //if (cl1 != "")
                    //{
                    //    if (!int.TryParse(cl1.Trim(), out n))
                    //    {
                    //        //不是數字格式
                    //        error_num++;
                    //        continue;
                    //    }

                    if (str_date == "")
                    {
                        str_date = textdate;
                    }


                    oCmd.CommandText = @"
                        insert into sy_InsuranceLevel(ilGuid,ilItem1,ilItem2,ilItem3,ilItem4,ilEffectiveDate,ilCreatId,ilModifyId,ilModifyDate,ilStatus)
                        values(@ilGuid,@ilItem1,@ilItem2,@ilItem3,@ilItem4,@ilEffectiveDate,@ilCreatId,@ilModifyId,@ilModifyDate,'A')
                    ";

                    oCmd.Parameters["@ilGuid"].Value = Guid.NewGuid().ToString();
                    oCmd.Parameters["@ilItem1"].Value = int_ilItem1;//201705 決定不新增
                    oCmd.Parameters["@ilItem2"].Value = (cl1.Trim() == "") ? 0 : Convert.ToDecimal(cl1.Trim());
                    oCmd.Parameters["@ilItem3"].Value = (cl3.Trim() == "") ? 0 : Convert.ToDecimal(cl3.Trim());
                    oCmd.Parameters["@ilItem4"].Value = (cl2.Trim() == "") ? 0 : Convert.ToDecimal(cl2.Trim());
                    oCmd.Parameters["@ilEffectiveDate"].Value = textdate;
                    oCmd.Parameters["@ilCreatId"].Value = session_no;
                    oCmd.Parameters["@ilModifyId"].Value = session_no;
                    oCmd.Parameters["@ilModifyDate"].Value = DateTime.Now;
                    oCmd.ExecuteNonQuery();

                }

                if (error_samdate > 0)
                {
                    str_response += "重複匯入資料";
                    myTrans.Rollback();
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
            if (status == false) {
                //context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('匯入失敗請聯絡系統管理員,nodate');</script>");
                if (str_response != "")
                {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('資料匯入失敗，" + str_response + ",nodate');</script>");
                }
                else
                {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('資料匯入失敗，第" + now_rows + "筆資料錯誤,nodate');</script>");
                }

            }
            else{
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('資料匯入完成,"+str_date+"');</script>");
            }

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}