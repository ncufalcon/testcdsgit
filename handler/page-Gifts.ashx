<%@ WebHandler Language="C#" Class="page_Gifts" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

public class page_Gifts : IHttpHandler, IRequiresSessionState
{
    //sy_Attendance 欄位 代碼檔
    public class codeTooL
    {
        public string code_value { get; set; }//value
        public string code_desc { get; set; }//中文名稱
        public string siGuid { get; set; }//對應Item GUID
    }
    //sy_Attendance 欄位
    public class aTooL
    {
        //public string aperGuid { get; set; }//人員GUID
        public string cbName { get; set; }//部門名稱
        public string perNo { get; set; }//人員代號
        public string perName { get; set; }//人員名稱
        public string sum_normal { get; set; }//正常時數
        public string sum_other { get; set; }//加班時數
        public string sum_all { get; set; }//總時數
    }
    page_Gifts_DB a_db = new page_Gifts_DB();
    public void ProcessRequest (HttpContext context) {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            case "load_data":
                string str_dates = string.IsNullOrEmpty(context.Request.Form["str_dates"]) ? "" : context.Request.Form["str_dates"].ToString().Trim();
                string str_datee = string.IsNullOrEmpty(context.Request.Form["str_datee"]) ? "" : context.Request.Form["str_datee"].ToString().Trim();
                string str_hours = string.IsNullOrEmpty(context.Request.Form["str_hours"]) ? "" : context.Request.Form["str_hours"].ToString().Trim();
                try
                {
                    SqlCommand oCmd = new SqlCommand();
                    oCmd.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                    StringBuilder sb = new StringBuilder();

                    sb.Append(@"sp_GigtHoursData");
                    oCmd.CommandTimeout = 120;
                    oCmd.CommandText = sb.ToString();
                    oCmd.CommandType = CommandType.StoredProcedure;
                    oCmd.Connection.Open();

                    SqlDataAdapter oda = new SqlDataAdapter(oCmd);
                    oCmd.Parameters.AddWithValue("@str_dates", str_dates);
                    oCmd.Parameters.AddWithValue("@str_datee", str_datee);
                    oCmd.Parameters.AddWithValue("@str_hours", str_hours);

                    DataTable dt_a = new DataTable();
                    oda.Fill(dt_a);
                    oCmd.Connection.Close();
                    oCmd.Connection.Dispose();
                    oCmd.Dispose();
                    //a_db._str_dates = str_dates;
                    //a_db._str_datee = str_datee;
                    //a_db._str_hours = Convert.ToInt32(str_hours);
                    //DataTable dt_a = a_db.SelectAttendance();
                    if (dt_a.Rows.Count > 0)
                    {
                        List<aTooL> aList = new List<aTooL>();
                        for (int i = 0; i < dt_a.Rows.Count; i++)
                        {
                            aTooL e = new aTooL();
                            //e.aperGuid  = dt_a.Rows[i]["aperGuid "].ToString().Trim();
                            e.cbName = dt_a.Rows[i]["cbName"].ToString().Trim();
                            e.perNo = dt_a.Rows[i]["perNo"].ToString().Trim();
                            e.perName = dt_a.Rows[i]["perName"].ToString().Trim();
                            e.sum_normal = dt_a.Rows[i]["sum_normal"].ToString().Trim();
                            e.sum_other = dt_a.Rows[i]["sum_other"].ToString().Trim();
                            e.sum_all = dt_a.Rows[i]["sum_all"].ToString().Trim();
                            aList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        string ans = objSerializer.Serialize(aList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
                    }
                    else
                    {
                        context.Response.Write("nodata");
                    }
                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;

            //撈禮金名稱 下拉選單選項
            case "load_group16":
                try {
                    DataTable dt_codegroup16 = a_db.SelectCodeRefItem();
                    if (dt_codegroup16.Rows.Count > 0)
                    {
                        List<codeTooL> codeList = new List<codeTooL>();
                        for (int i = 0; i < dt_codegroup16.Rows.Count; i++)
                        {
                            if (dt_codegroup16.Rows[i]["code_value"].ToString().Trim()!="03" && dt_codegroup16.Rows[i]["code_value"].ToString().Trim()!="04" && dt_codegroup16.Rows[i]["code_value"].ToString().Trim()!="05") {
                                codeTooL e = new codeTooL();
                                //e.aperGuid  = dt_a.Rows[i]["aperGuid "].ToString().Trim();
                                e.code_value = dt_codegroup16.Rows[i]["code_value"].ToString().Trim();
                                e.code_desc = dt_codegroup16.Rows[i]["code_desc"].ToString().Trim();
                                e.siGuid = dt_codegroup16.Rows[i]["siGuid"].ToString().Trim();
                                codeList.Add(e);
                            }
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        string ans = objSerializer.Serialize(codeList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
                    }
                    else
                    {
                        context.Response.Write("nodata");
                    }
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }

                break;
            //insert data
            case "add_data":
                string add_dates = string.IsNullOrEmpty(context.Request.Form["add_dates"]) ? "" : context.Request.Form["add_dates"].ToString().Trim();
                string add_datee = string.IsNullOrEmpty(context.Request.Form["add_datee"]) ? "" : context.Request.Form["add_datee"].ToString().Trim();
                string add_hours = string.IsNullOrEmpty(context.Request.Form["add_hours"]) ? "0" : context.Request.Form["add_hours"].ToString().Trim();
                string add_money = string.IsNullOrEmpty(context.Request.Form["add_money"]) ? "0" : context.Request.Form["add_money"].ToString().Trim();
                string add_moneytype = string.IsNullOrEmpty(context.Request.Form["add_moneytype"]) ? "" : context.Request.Form["add_moneytype"].ToString().Trim();
                string add_paydate = string.IsNullOrEmpty(context.Request.Form["add_paydate"]) ? "" : context.Request.Form["add_paydate"].ToString().Trim();
                try {
                    a_db._str_dates = add_dates;
                    a_db._str_datee = add_datee;
                    a_db._str_hours = Convert.ToInt32(add_hours);
                    a_db._paCost = Convert.ToDecimal(add_money);
                    a_db._paPrice = Convert.ToDecimal(add_money);
                    a_db._paAllowanceCode = add_moneytype;
                    a_db._paDate = add_paydate;
                    a_db._paCreateId = "王胖爺";
                    a_db._paModifyId = "王胖爺";
                    a_db.InsertPersonSingleAllowance();
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