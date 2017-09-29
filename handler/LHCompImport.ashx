<%@ WebHandler Language="C#" Class="LHCompImport" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Configuration;
using System.Text;

public class LHCompImport : IHttpHandler,IRequiresSessionState {
    ErrorLog err = new ErrorLog();
    public void ProcessRequest(HttpContext context) {
        if (string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LoginFailed');</script>");
            return;
        }

        bool status = true;
        string YearMonth = string.Empty;
        string result = string.Empty;
        HttpFileCollection uploadFiles = context.Request.Files;//檔案集合

        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            string ddl_SalaryRange = (context.Request["ddl_SalaryRange"] != null) ? context.Request["ddl_SalaryRange"].ToString() : "";
            string[] DayAry = ddl_SalaryRange.Split(',');

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

                //勞退
                Xls.ActiveSheet = 4;

                oCmd.CommandText = @"delete from tmp_cPension ";
                oCmd.ExecuteNonQuery();

                oCmd.Parameters.Add("@P_ID", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@P_Salary", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@P_PersonPay", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@P_Date", SqlDbType.NVarChar);

                for (int j = 13; j <= Xls.GetRowCount(4); j++)
                {
                    string P_Date = (Xls.GetCellValue(j, 8) != null) ? Xls.GetCellValue(j, 8).ToString().Trim() : "";
                    string P_ID = (Xls.GetCellValue(j, 4) != null) ? Xls.GetCellValue(j, 4).ToString().Trim() : "";
                    //if (P_ID == "")
                    //    continue;
                    string P_Salary = (Xls.GetCellValue(j, 5) != null) ? Xls.GetCellValue(j, 5).ToString() : "0";
                    P_Salary = (P_Salary.ToString().Trim() != "") ? P_Salary.ToString() : "0";
                    string P_PersonPay = (Xls.GetCellValue(j, 7) != null) ? Xls.GetCellValue(j, 7).ToString() : "0";
                    P_PersonPay = (P_PersonPay.ToString().Trim() != "") ? P_PersonPay.ToString() : "0";
                    YearMonth = P_Date;

                    oCmd.Parameters["@P_ID"].Value = P_ID;
                    oCmd.Parameters["@P_Salary"].Value = decimal.Parse(P_Salary);
                    oCmd.Parameters["@P_PersonPay"].Value = decimal.Parse(P_PersonPay);
                    oCmd.Parameters["@P_Date"].Value = P_Date;

                    oCmd.CommandText = @"insert into tmp_cPension (
P_ID,
P_Salary,
P_PersonPay,
P_Date
) values (
@P_ID,
@P_Salary,
@P_PersonPay,
@P_Date
) ";

                    oCmd.ExecuteNonQuery();
                }

                //勞保
                oCmd.Parameters.Clear();
                Xls.ActiveSheet = 1;

                oCmd.CommandText = @"delete from tmp_cLabor ";
                oCmd.ExecuteNonQuery();

                oCmd.Parameters.Add("@L_ID", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@L_Salary", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@L_PersonPay", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@L_Date", SqlDbType.NVarChar);

                for (int j = 6; j <= Xls.GetRowCount(1); j++)
                {
                    string rownum = (Xls.GetCellValue(j, 1) != null) ? Xls.GetCellValue(j, 1).ToString() : "";
                    if (rownum == "")
                        continue;

                    string L_ID = (Xls.GetCellValue(j, 3) != null) ? Xls.GetCellValue(j, 3).ToString().Trim() : "";
                    string L_Salary = (Xls.GetCellValue(j, 5) != null) ? Xls.GetCellValue(j, 5).ToString() : "0";
                    L_Salary = (L_Salary.ToString().Trim() != "") ? L_Salary.ToString() : "0";
                    string L_PersonPay = (Xls.GetCellValue(j, 9) != null) ? Xls.GetCellValue(j, 9).ToString() : "0";
                    L_PersonPay = (L_PersonPay.ToString().Trim() != "") ? L_PersonPay.ToString() : "0";
                    //string L_Date = (Xls.GetCellValue(2, 1) != null) ? Xls.GetCellValue(2, 1).ToString() : "";
                    string L_Date = YearMonth;


                    oCmd.Parameters["@L_ID"].Value = L_ID;
                    oCmd.Parameters["@L_Salary"].Value = decimal.Parse(L_Salary);
                    oCmd.Parameters["@L_PersonPay"].Value = decimal.Parse(L_PersonPay);
                    oCmd.Parameters["@L_Date"].Value = L_Date;

                    oCmd.CommandText = @"insert into tmp_cLabor (
L_ID,
L_Salary,
L_PersonPay,
L_Date
) values (
@L_ID,
@L_Salary,
@L_PersonPay,
@L_Date
) ";

                    oCmd.ExecuteNonQuery();
                }

                //健保
                oCmd.Parameters.Clear();
                Xls.ActiveSheet = 2;

                oCmd.CommandText = @"delete from tmp_cHeal ";
                oCmd.ExecuteNonQuery();

                oCmd.Parameters.Add("@H_ID", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@H_Salary", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@H_PersonPay", SqlDbType.NVarChar);
                oCmd.Parameters.Add("@H_Date", SqlDbType.NVarChar);

                for (int j = 2; j <= Xls.GetRowCount(2) - 2; j++)
                {
                    string H_Date = (Xls.GetCellValue(j, 1) != null) ? Xls.GetCellValue(j, 1).ToString().Trim() : "";
                    string H_ID = (Xls.GetCellValue(j, 5) != null) ? Xls.GetCellValue(j, 5).ToString().Trim() : "";
                    if (H_ID == "")
                        continue;
                    string H_Salary = (Xls.GetCellValue(j, 4) != null) ? Xls.GetCellValue(j, 4).ToString() : "0";
                    H_Salary = (H_Salary.ToString().Trim() != "") ? H_Salary.ToString() : "0";
                    string H_PersonPay = (Xls.GetCellValue(j, 19) != null) ? Xls.GetCellValue(j, 19).ToString() : "0";
                    H_PersonPay = (H_PersonPay.ToString().Trim() != "") ? H_PersonPay.ToString() : "0";

                    oCmd.Parameters["@H_ID"].Value = H_ID;
                    oCmd.Parameters["@H_Salary"].Value = decimal.Parse(H_Salary);
                    oCmd.Parameters["@H_PersonPay"].Value = decimal.Parse(H_PersonPay);
                    oCmd.Parameters["@H_Date"].Value = H_Date;

                    oCmd.CommandText = @"insert into tmp_cHeal (
H_ID,
H_Salary,
H_PersonPay,
H_Date
) values (
@H_ID,
@H_Salary,
@H_PersonPay,
@H_Date
) ";

                    oCmd.ExecuteNonQuery();
                }



                myTrans.Commit();

                File.Delete(context.Server.MapPath("~/Template/" + System.IO.Path.GetFileName(uploadFiles[0].FileName)));

                SqlCommand oCmd2 = new SqlCommand();
                oCmd2.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                StringBuilder sb = new StringBuilder();

                sb.Append(@"sp_LH_Compare");
                oCmd2.CommandTimeout = 120;
                oCmd2.CommandText = sb.ToString();
                oCmd2.CommandType = CommandType.StoredProcedure;
                oCmd2.Connection.Open();

                SqlDataAdapter oda = new SqlDataAdapter(oCmd2);
                oCmd2.Parameters.AddWithValue("@modifyID", USERINFO.MemberGuid);
                oCmd2.Parameters.AddWithValue("@sdate", DayAry[0]);
                oCmd2.Parameters.AddWithValue("@edate", DayAry[1]);
                //oCmd2.ExecuteNonQuery();

                DataTable ds = new DataTable();
                oda.Fill(ds);
                oCmd2.Connection.Close();
                oCmd2.Connection.Dispose();
                oCmd2.Dispose();

                if (ds.Rows.Count > 0)
                    result = ds.Rows[0]["Column1"].ToString();
            }
        }
        catch (Exception ex)
        {
            status = false;
            err.InsErrorLog("LHCompImport.ashx", ex.Message, USERINFO.MemberName);
            myTrans.Rollback();
        }
        finally
        {
            context.Server.ClearError();
            oCmd.Connection.Close();
            oConn.Close();
            context.Response.ContentType = "text/html";
            if (status == false)
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('Error：比對失敗，請聯絡系統管理員');</script>");
            else
            {
                if (result == "succeed")
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('比對完成');</script>");
                else
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('" + result + "');</script>");
            }
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}