﻿<%@ WebHandler Language="C#" Class="page_Seniority" %>

using System;
using System.Web;
using System.IO;
using System.Text;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.SessionState;

public class page_Seniority : IHttpHandler, IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        string session_no = string.IsNullOrEmpty(USERINFO.MemberGuid) ? "" : USERINFO.MemberGuid.ToString().Trim();
        string session_name = string.IsNullOrEmpty(USERINFO.MemberName) ? "" : USERINFO.MemberName.ToString().Trim();
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            case "update":
                //string str_year = string.IsNullOrEmpty(context.Request.Form["str_year"]) ? "" : context.Request.Form["str_year"].ToString().Trim();
                string str_date = string.IsNullOrEmpty(context.Request.Form["str_date"]) ? "" : context.Request.Form["str_date"].ToString().Trim();
                string str_perguid = string.IsNullOrEmpty(context.Request.Form["str_perguid"]) ? "" : context.Request.Form["str_perguid"].ToString().Trim();
                string str_updatetype = string.IsNullOrEmpty(context.Request.Form["str_updatetype"]) ? "" : context.Request.Form["str_updatetype"].ToString().Trim();
                string str_outtype = string.IsNullOrEmpty(context.Request.Form["str_outtype"]) ? "" : context.Request.Form["str_outtype"].ToString().Trim();

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
                else {
                    mod_guid = "";
                }


                SqlCommand oCmd = new SqlCommand();
                oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                StringBuilder sb = new StringBuilder();
                try
                {


                    sb.Append(@"sp_yearandspecial_new");
                    oCmd.CommandTimeout = 120;
                    oCmd.CommandText = sb.ToString();
                    oCmd.CommandType = CommandType.StoredProcedure;
                    oCmd.Connection.Open();

                    SqlDataAdapter oda = new SqlDataAdapter(oCmd);
                    oCmd.Parameters.AddWithValue("@end_date", str_date);
                    oCmd.Parameters.AddWithValue("@mod_type", str_updatetype);
                    oCmd.Parameters.AddWithValue("@perguid", mod_guid);
                    oCmd.Parameters.AddWithValue("@reg_type", str_outtype);
                    oCmd.ExecuteNonQuery();
                    DataTable dt = new DataTable();
                    oda.Fill(dt);
                    oCmd.Connection.Close();
                    oCmd.Connection.Dispose();
                    oCmd.Dispose();

                    context.Response.Write("ok");
                }
                catch (Exception ex)
                {
                    context.Response.Write("error");
                }
                finally {
                    oCmd.Connection.Close();
                    oCmd.Connection.Dispose();
                    oCmd.Dispose();
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