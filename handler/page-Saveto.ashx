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

    public void ProcessRequest (HttpContext context) {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            case "downloadtxt":
                string str_filename = string.IsNullOrEmpty(context.Request.Form["str_filename"]) ? "" : context.Request.Form["str_filename"].ToString().Trim();
                string str_paydate = string.IsNullOrEmpty(context.Request.Form["str_paydate"]) ? "" : context.Request.Form["str_paydate"].ToString().Trim();
                string str_perguid = string.IsNullOrEmpty(context.Request.Form["str_perguid"]) ? "" : context.Request.Form["str_perguid"].ToString().Trim();
                string str_comno = string.IsNullOrEmpty(context.Request.Form["str_comno"]) ? "" : context.Request.Form["str_comno"].ToString().Trim();
                string str_exporttype = string.IsNullOrEmpty(context.Request.Form["str_exporttype"]) ? "" : context.Request.Form["str_exporttype"].ToString().Trim();
                string str_rangeGuid = string.IsNullOrEmpty(context.Request.Form["str_rangeGuid"]) ? "" : context.Request.Form["str_rangeGuid"].ToString().Trim();
                string FileName = string.Empty;
                string fileSpec = string.Empty;

                // 建立檔案串流（@ 可取消跳脫字元 escape sequence）
                //fileSpec = context.Server.MapPath("~/Template/"+str_filename+".txt");
                string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
                if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
                {
                    Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                }
                fileSpec = UpLoadPath + str_filename + ".txt";
                //fileSpec = context.Server.MapPath("~/Template/"+str_filename+".txt");

                FileStream fs = new FileStream(fileSpec, FileMode.Create);
                StreamWriter sw = new StreamWriter(fs, Encoding.GetEncoding("big5"));

                SqlCommand oCmd = new SqlCommand();
                oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                StringBuilder sb = new StringBuilder();
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


                    //開始寫入
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
                        if (str_exporttype == "0")//薪資
                        {
                            for (int i = 0; i < dt_a.Rows.Count; i++)
                            {
                                string chkstr = "";
                                if (dt_a.Rows[i]["comAccountNumber"] == null)
                                {
                                    chkstr = "";
                                }
                                else
                                {
                                    chkstr = dt_a.Rows[i]["comAccountNumber"].ToString().Trim();
                                }
                                if (chkstr == "")
                                {
                                    continue;
                                }
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
                                //受款人 法扣撈""==>廣哥會給欄位 
                                text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();//受款人
                                text += "@@@@@";
                                text += dt_a.Rows[i]["perSyAccount"].ToString().Trim();//受款人帳號
                                text += "@@@@@@@";
                                text += dt_a.Rows[i]["syNumber"].ToString().Trim();//銀行代碼
                                text += "@@@@";
                                text += "ID:" + dt_a.Rows[i]["perIDNumber"].ToString().Trim() + "#, ";
                                //text += "AIP";
                                text += "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";

                                sw.WriteLine(text);
                            }
                        }
                        if (str_exporttype == "1") {//法扣
                            for (int i = 0; i < dt_a.Rows.Count; i++)
                            {
                                string chkstr = "";
                                if (dt_a.Rows[i]["comAccountNumber"] == null)
                                {
                                    chkstr = "";
                                }
                                else
                                {
                                    chkstr = dt_a.Rows[i]["comAccountNumber"].ToString().Trim();
                                }
                                if (chkstr == "")
                                {
                                    continue;
                                }
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
                                text += dt_a.Rows[i]["psbNo"].ToString().Trim().Replace("/", "");//交易序號
                                text += "@@@@@";
                                text += str_comno;//公司代碼
                                text += "@@@@@@@";
                                //受款人 法扣撈""==>廣哥會給欄位 
                                //text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();//
                                text += dt_a.Rows[i]["psbCreditor"].ToString().Trim();//受款人
                                text += "@";
                                text += dt_a.Rows[i]["strOther"].ToString();
                                text += "@@@@";
                                //text += dt_a.Rows[i]["perSyAccount"].ToString().Trim();//受款人帳號
                                text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();//受款人帳號
                                text += "@@@@@@@";
                                text += dt_a.Rows[i]["syNumber"].ToString().Trim();//銀行代碼
                                text += "@@@@";
                                text += dt_a.Rows[i]["strOther"].ToString();
                                text += "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
                                sw.WriteLine(text);
                            }
                        }

                        context.Response.Write(str_filename + ".txt");
                    }
                    else
                    {
                        context.Response.Write("nodata");
                    }

                }
                catch (Exception ex)
                {
                    context.Response.Write("error");
                }
                finally {
                    //清空緩衝區
                    sw.Flush();
                    //關閉流
                    sw.Close();
                    fs.Close();
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