<%@ WebHandler Language="C#" Class="page_Saveto" %>

using System;
using System.Web;
using System.IO;
using System.Text;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.SessionState;

public class page_Saveto : IHttpHandler, IRequiresSessionState {
    ErrorLog err = new ErrorLog();
    public void ProcessRequest(HttpContext context)
    {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func)
        {
            case "downloadtxt":
                string str_filename = string.IsNullOrEmpty(context.Request.Form["str_filename"]) ? "" : context.Request.Form["str_filename"].ToString().Trim();
                string str_paydate = string.IsNullOrEmpty(context.Request.Form["str_paydate"]) ? "" : context.Request.Form["str_paydate"].ToString().Trim();
                string str_perguid = string.IsNullOrEmpty(context.Request.Form["str_perguid"]) ? "" : context.Request.Form["str_perguid"].ToString().Trim();
                string str_comno = string.IsNullOrEmpty(context.Request.Form["str_comno"]) ? "" : context.Request.Form["str_comno"].ToString().Trim();
                string str_exporttype = string.IsNullOrEmpty(context.Request.Form["str_exporttype"]) ? "" : context.Request.Form["str_exporttype"].ToString().Trim();
                string str_rangeGuid = string.IsNullOrEmpty(context.Request.Form["str_rangeGuid"]) ? "" : context.Request.Form["str_rangeGuid"].ToString().Trim();
                string FileName = string.Empty;
                string fileSpec = string.Empty;
                try
                {
                    string mod_guid = string.Empty;
                    if (str_perguid != "")
                    {

                        string[] split_str = str_perguid.Split(',');
                        for (int i = 0; i < split_str.Length; i++)
                        {
                            if (mod_guid != "")
                            {
                                mod_guid += ",";
                            }
                            mod_guid += "'" + split_str[i] + "'";
                        }
                    }
                    else
                    {
                        mod_guid = "";
                    }

                    // 建立檔案串流（@ 可取消跳脫字元 escape sequence）
                    //fileSpec = context.Server.MapPath("~/Template/"+str_filename+".txt");
                    string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
                    if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
                    {
                        Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                    }
                    fileSpec = UpLoadPath + str_filename + ".txt";
                    //fileSpec = context.Server.MapPath("~/Template/"+str_filename+".txt");

                    using (TextWriter writer = File.CreateText(fileSpec))
                    {
                        SqlCommand oCmd = new SqlCommand();
                        oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                        StringBuilder sb = new StringBuilder();

                        sb.Append(@"sp_citybank");
                        oCmd.CommandTimeout = 120;
                        oCmd.CommandText = sb.ToString();
                        oCmd.CommandType = CommandType.StoredProcedure;
                        oCmd.Connection.Open();

                        SqlDataAdapter oda = new SqlDataAdapter(oCmd);
                        //oCmd.Parameters.AddWithValue("@comGuid", "");
                        //oCmd.Parameters.AddWithValue("@depGuid", "");
                        oCmd.Parameters.AddWithValue("@perGuid", mod_guid);
                        oCmd.Parameters.AddWithValue("@paydate", str_paydate);
                        oCmd.Parameters.AddWithValue("@exporttype", str_exporttype);
                        oCmd.Parameters.AddWithValue("@comno", str_comno);
                        oCmd.Parameters.AddWithValue("@rangeGuid", str_rangeGuid);

                        DataTable dt_a = new DataTable();
                        oda.Fill(dt_a);
                        oCmd.Connection.Close();
                        oCmd.Connection.Dispose();
                        oCmd.Dispose();
                        if (dt_a.Rows.Count > 0)
                        {
                            for (int i = 0; i < dt_a.Rows.Count; i++)
                            {
                                string text = "";
                                text += dt_a.Rows[i]["PAY"].ToString().Trim();//付款方式
                                text += "@";
                                text += "TW";
                                text += "@";
                                text += dt_a.Rows[i]["comAccountNumber"].ToString().Trim();//扣款帳號 
                                text += "@@";
                                //負數不需要帶值
                                if (dt_a.Rows[i]["Paymoney"] != null && dt_a.Rows[i]["Paymoney"].ToString().Trim() != "")
                                {
                                    if (Convert.ToInt32(dt_a.Rows[i]["Paymoney"].ToString().Trim()) > 0)
                                    {
                                        text += dt_a.Rows[i]["Paymoney"].ToString().Trim();//付款金額 
                                    }
                                    else
                                    {
                                        text += "";//付款金額
                                    }
                                }
                                else
                                {
                                    text += "";//付款金額
                                }
                                text += "@@";
                                text += dt_a.Rows[i]["SalaryDate"].ToString().Trim().Replace("/", "");//交易日
                                text += "@";
                                text += dt_a.Rows[i]["perNo"].ToString().Trim();//交易序號
                                text += "@@@@@";
                                //text += dt_a.Rows[i]["comno"].ToString().Trim();//公司代碼
                                text += str_comno;//公司代碼
                                text += "@@@@@@@";
                                text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();//受款人
                                                                                           //text += "@";
                                                                                           //text += "AIP";
                                text += "@@@@@";
                                text += dt_a.Rows[i]["perSyAccount"].ToString().Trim();//受款人帳號
                                text += "@@@@@@@";
                                text += dt_a.Rows[i]["syNumber"].ToString().Trim();//銀行代碼
                                                                                   //text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();
                                text += "@@@@";
                                //if (str_exporttype == "0")
                                //{
                                //    //薪資
                                //    text += "";
                                //}
                                //else {
                                //法扣
                                //text += dt_a.Rows[i]["perName"].ToString().Trim() + dt_a.Rows[i]["perIDNumber"].ToString().Trim()+"";
                                //}
                                text += "ID:" + dt_a.Rows[i]["perIDNumber"].ToString().Trim() + "#, ";
                                //text += "AIP";
                                text += "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
                                writer.WriteLine(text);
                            }
                            writer.Write(writer.NewLine);
                            context.Response.Write(str_filename + ".txt");
                        }
                        else
                        {
                            context.Response.Write("nodata");
                        }

                    }
                }
                catch (Exception ex)
                {
                    err.InsErrorLog("page_Saveto.ashx", ex.Message, USERINFO.MemberName);
                    context.Response.Write("error");
                }

                break;
        }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}