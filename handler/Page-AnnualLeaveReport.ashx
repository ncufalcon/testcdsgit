<%@ WebHandler Language="C#" Class="Page_AnnualLeaveReport" %>

using System;
using System.Web;
using System.IO;
using System.Text.RegularExpressions;
using FlexCel.Core;
using FlexCel.XlsAdapter;
using System.Data;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Globalization;

public class Page_AnnualLeaveReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    NpoiExcel Npo = new NpoiExcel();
    public void ProcessRequest(HttpContext context)
    {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func)
        {
            case "downloadexcel":
                try
                {
                    if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
                    {
                        string FileName = string.Empty;
                        string fileSpec = string.Empty;
                        ExcelFile Xls = new XlsFile(true);
                        fileSpec = context.Server.MapPath("~/Excel_sample/spacialday_report.xlsx");
                        using (FileStream file = new FileStream(fileSpec, FileMode.Open, FileAccess.Read))
                        {
                            Xls.Open(fileSpec);
                            FileName += "AnnualLeaveReport_" + DateTime.Now.ToString("yyyyMMdd");
                            string str_yyyy = string.IsNullOrEmpty(context.Request.Form["str_yyyy"]) ? "" : context.Request.Form["str_yyyy"].ToString().Trim();
                            string str_empno = string.IsNullOrEmpty(context.Request.Form["str_empno"]) ? "" : context.Request.Form["str_empno"].ToString().Trim();
                            string str_cname = string.IsNullOrEmpty(context.Request.Form["str_cname"]) ? "" : context.Request.Form["str_cname"].ToString().Trim();
                            string str_com = string.IsNullOrEmpty(context.Request.Form["str_com"]) ? "" : context.Request.Form["str_com"].ToString().Trim();
                            string str_dep = string.IsNullOrEmpty(context.Request.Form["str_dep"]) ? "" : context.Request.Form["str_dep"].ToString().Trim();

                            SqlCommand oCmd = new SqlCommand();
                            oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                            StringBuilder sb = new StringBuilder();
                            sb.Append(@"sp_yearandspecial_report");
                            oCmd.CommandTimeout = 120;
                            oCmd.CommandText = sb.ToString();
                            oCmd.CommandType = CommandType.StoredProcedure;
                            oCmd.Connection.Open();

                            SqlDataAdapter oda = new SqlDataAdapter(oCmd);
                            oCmd.Parameters.Add("@yyyy", SqlDbType.NVarChar).Value = str_yyyy;
                            oCmd.Parameters.Add("@empno", SqlDbType.NVarChar).Value = str_empno;
                            oCmd.Parameters.Add("@cname", SqlDbType.NVarChar).Value = str_cname;
                            oCmd.Parameters.Add("@com", SqlDbType.NVarChar).Value = str_com;
                            oCmd.Parameters.Add("@dep", SqlDbType.NVarChar).Value = str_dep;

                            DataSet ds = new DataSet();
                            oda.Fill(ds);

                            if (oCmd.Connection.State != ConnectionState.Closed)
                                oCmd.Connection.Close();

                            //表頭 從第二列開始
                            Xls.SetCellValue(2, 1, "WHS");
                            Xls.SetCellValue(2, 2, "員工代號");
                            Xls.SetCellValue(2, 3, "員工姓名");
                            Xls.SetCellValue(2, 4, "到職日");
                            Xls.SetCellValue(2, 5, "年資(到"+str_yyyy+"/12/31)");
                            Xls.SetCellValue(2, 6, "滿半年");
                            Xls.SetCellValue(2, 7, "給假天數(1)");
                            Xls.SetCellValue(2, 8, "給假天數(2)");
                            Xls.SetCellValue(2, 9, "特休假總天數");
                            Xls.SetCellValue(2, 10, "已請天數");
                            //接下來表頭欄位是動態根據計薪期有幾個 欄位就幾個
                            List<string> arr_sumval = new List<string>();
                            int now_head_col = 10;
                            if (ds.Tables[1].Rows.Count > 0)
                            {
                                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                                {
                                    now_head_col = now_head_col + 1;
                                    Xls.SetCellValue(2, now_head_col, ds.Tables[1].Rows[i]["sr_s"].ToString().Trim()+"-"+ds.Tables[1].Rows[i]["sr_e"].ToString().Trim());
                                    arr_sumval.Add("0");
                                }
                            }
                            Xls.SetCellValue(2, now_head_col+1, "剩餘天數");
                            Xls.SetCellValue(2, now_head_col+2, "離職日");

                            //資料從第3列開始
                            int data_row = 2;
                            //各個總和
                            //int sum_M1, sum_M2, sum_M3, sum_M4, sum_M5, sum_M6, sum_M7, sum_M8, sum_M9, sum_M10;
                            //int sum_M11, sum_M12, sum_M13, sum_M14, sum_M15, sum_M16, sum_M17, sum_M18, sum_M19, sum_M20;
                            //int sum_M21, sum_M22, sum_M23, sum_M24, sum_M25,sum_M26,sum_M27,sum_M28,sum_M29sum_M30;
                            
                            for (int j = 0; j < ds.Tables[0].Rows.Count; j++)
                            {
                                double sum_val = 0;
                                data_row = data_row + 1;
                                Xls.SetCellValue(data_row, 1, ds.Tables[0].Rows[j]["cb_Value"].ToString());
                                Xls.SetCellValue(data_row, 2, ds.Tables[0].Rows[j]["perNo"].ToString());
                                Xls.SetCellValue(data_row, 3, ds.Tables[0].Rows[j]["perName"].ToString());
                                //Xls.SetCellValue(data_row, 4, ds.Tables[0].Rows[j]["perOldFirstDate"].ToString());
                                Xls.SetCellValue(data_row, 4, ROC_Date(ds.Tables[0].Rows[j]["perOldFirstDate"].ToString()));
                                Xls.SetCellValue(data_row, 5, Convert.ToDouble(ds.Tables[0].Rows[j]["perYears"].ToString()));
                                Xls.SetCellValue(data_row, 6, Convert.ToDouble(ds.Tables[0].Rows[j]["full3year"].ToString()));
                                Xls.SetCellValue(data_row, 7, Convert.ToDouble(ds.Tables[0].Rows[j]["now_year_days"].ToString()));
                                Xls.SetCellValue(data_row, 8, Convert.ToDouble(ds.Tables[0].Rows[j]["next_year_days"].ToString()));
                                Xls.SetCellValue(data_row, 9, Convert.ToDouble(ds.Tables[0].Rows[j]["perAnnualLeave"].ToString()));
                                now_head_col = 10;
                                int dsdt1count = ds.Tables[1].Rows.Count;

                                for (int k = 0; k < ds.Tables[1].Rows.Count; k++)
                                {
                                    string str_val = "";
                                    now_head_col = now_head_col + 1;
                                    if (ds.Tables[0].Rows[j]["" + ds.Tables[1].Rows[k]["sr_columnname"].ToString().Trim() + ""] == null)
                                    {
                                        str_val = "0";
                                    }
                                    else {
                                        if (ds.Tables[0].Rows[j]["" + ds.Tables[1].Rows[k]["sr_columnname"].ToString().Trim() + ""].ToString().Trim()=="") {
                                            str_val = "0";
                                        } else {
                                            str_val = ds.Tables[0].Rows[j]["" + ds.Tables[1].Rows[k]["sr_columnname"].ToString().Trim() + ""].ToString().Trim();
                                        }
                                    }
                                    Xls.SetCellValue(data_row, now_head_col, Convert.ToDouble(str_val));
                                    //已請天數
                                    sum_val = sum_val+Convert.ToDouble(str_val);
                                    //if (arr_sumval[k] == "")
                                    //{
                                    //    arr_sumval[k] = "0";
                                    //}
                                    //else
                                    //{
                                    arr_sumval[k] = (Convert.ToDouble(arr_sumval[k].ToString()) + Convert.ToDouble(str_val)).ToString();
                                    //}
                                }
                                Xls.SetCellValue(data_row, 10, sum_val);//已請天數
                                Xls.SetCellValue(data_row, now_head_col+1, (Convert.ToDouble(ds.Tables[0].Rows[j]["perAnnualLeave"].ToString())-sum_val));//剩餘天數
                                Xls.SetCellValue(data_row, now_head_col+2, ds.Tables[0].Rows[j]["perLastDate"].ToString());
                            }
                            now_head_col = 10;
                            if (arr_sumval.Count > 0)
                            {
                                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                                {
                                    now_head_col = now_head_col + 1;
                                    Xls.SetCellValue(1, now_head_col, Convert.ToDouble(arr_sumval[i].ToString()));

                                }
                            }
                        }

                        string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
                        if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
                        {
                            Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                        }
                        Xls.Save(System.IO.Path.Combine(ConfigurationManager.AppSettings["UploadFileRootDir"], FileName + ".xlsx"));
                        context.Response.Write("success," + FileName + ".xlsx");

                        //context.Response.Write("ok");
                    }
                    else
                    {
                        context.Response.Write("error,TimeOut");
                    }
                }
                catch (Exception ex)
                {
                    ErrorLog err = new ErrorLog();
                    err.InsErrorLog("Page_AnnualLeaveReport.ashx", ex.Message, USERINFO.MemberName);
                    context.Response.Write("程式發生錯誤，請聯絡相關管理人員");

                }
                break;
        }

    }
    //西元轉民國
    private string ROC_Date(string dateStr)
    {
        string TaiwanDate = string.Empty;
        if (dateStr == "")
            TaiwanDate = "";
        else
        {
            var ROC_Calendar = new TaiwanCalendar();
            TaiwanDate = ROC_Calendar.GetYear(DateTime.Parse(dateStr)).ToString() +"/"+
                    DateTime.Parse(dateStr).Month.ToString().PadLeft(2, '0') +"/"+
                    DateTime.Parse(dateStr).Day.ToString().PadLeft(2, '0');
        }
        return TaiwanDate;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }
    
}