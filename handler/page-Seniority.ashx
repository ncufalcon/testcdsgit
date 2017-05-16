<%@ WebHandler Language="C#" Class="page_Seniority" %>

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
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            case "update":
                string str_year = string.IsNullOrEmpty(context.Request.Form["str_year"]) ? "" : context.Request.Form["str_year"].ToString().Trim();
                string str_date = string.IsNullOrEmpty(context.Request.Form["str_date"]) ? "" : context.Request.Form["str_date"].ToString().Trim();
                string str_perguid = string.IsNullOrEmpty(context.Request.Form["str_perguid"]) ? "" : context.Request.Form["str_perguid"].ToString().Trim();
                string str_updatetype = string.IsNullOrEmpty(context.Request.Form["str_updatetype"]) ? "" : context.Request.Form["str_updatetype"].ToString().Trim();

                string mod_guid = string.Empty;
                string[] split_str = str_perguid.Split(',');
                for (int i=0;i<split_str.Length;i++) {
                    if (mod_guid != "") {
                        mod_guid += ",";    
                    }
                    mod_guid += "'"+split_str[i]+"'";
                }
                try {
                    SqlCommand oCmd = new SqlCommand();
                    oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                    StringBuilder sb = new StringBuilder();

                    sb.Append(@"sp_yearandspecial");
                    oCmd.CommandTimeout = 120;
                    oCmd.CommandText = sb.ToString();
                    oCmd.CommandType = CommandType.StoredProcedure;
                    oCmd.Connection.Open();

                    SqlDataAdapter oda = new SqlDataAdapter(oCmd);
                    //oCmd.Parameters.AddWithValue("@comGuid", "");
                    //oCmd.Parameters.AddWithValue("@depGuid", "");
                    //oCmd.Parameters.AddWithValue("@paydate", str_paydate);
                    oCmd.Parameters.AddWithValue("@year", str_year);
                    oCmd.Parameters.AddWithValue("@end_date", str_date);
                    oCmd.Parameters.AddWithValue("@mod_type", str_updatetype);
                    oCmd.Parameters.AddWithValue("@perguid", mod_guid);
                    oCmd.ExecuteNonQuery();
                    DataTable dt = new DataTable();
                    oda.Fill(dt);
                    oCmd.Connection.Close();
                    oCmd.Connection.Dispose();
                    oCmd.Dispose();

                    context.Response.Write("ok");
                }
                catch (Exception ex) {
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