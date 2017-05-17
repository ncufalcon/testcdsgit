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
                string FileName = string.Empty;
                string fileSpec = string.Empty;
                try
                {
                    string mod_guid = string.Empty;
                    string[] split_str = str_perguid.Split(',');
                    for (int i=0;i<split_str.Length;i++) {
                        if (mod_guid != "") {
                            mod_guid += ",";    
                        }
                        mod_guid += "'"+split_str[i]+"'";
                    }
                    // 建立檔案串流（@ 可取消跳脫字元 escape sequence）
                    //fileSpec = context.Server.MapPath("~/Template/"+str_filename+".txt");
                    string UpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"];
                    if (!Directory.Exists(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\"))))//如果上傳路徑中沒有該目錄，則自動新增
                    {
                        Directory.CreateDirectory(UpLoadPath.Substring(0, UpLoadPath.LastIndexOf("\\")));
                    }
                    fileSpec = UpLoadPath + str_filename+".txt";
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
                                text += dt_a.Rows[i]["PAY"].ToString().Trim();
                                text += "@";
                                text += "TW";
                                text += "@";
                                text += dt_a.Rows[i]["comno"].ToString().Trim();
                                text += "@@";
                                text += dt_a.Rows[i]["comAccountNumber"].ToString().Trim();
                                text += "@@";
                                text += dt_a.Rows[i]["SalaryDate"].ToString().Trim();
                                text += "@";
                                text += dt_a.Rows[i]["perNo"].ToString().Trim();
                                text += "@@@@@";
                                text += dt_a.Rows[i]["Paymoney"].ToString().Trim();
                                text += "@@@@@@@";
                                text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();
                                text += "@";
                                text += "AIP";
                                text += "@@@@";
                                text += dt_a.Rows[i]["syNumber"].ToString().Trim();
                                text += "@@@@@@@";
                                text += dt_a.Rows[i]["perSyAccountName"].ToString().Trim();
                                text += "@@@@";
                                text += "AIP";
                                text += "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@";
                                writer.WriteLine(text);
                            }
                            writer.Write(writer.NewLine);
                            context.Response.Write(str_filename+".txt");
                        }
                        else
                        {
                            context.Response.Write("nodata");
                        }

                    }
                }
                catch (Exception ex){
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