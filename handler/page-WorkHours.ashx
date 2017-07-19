<%@ WebHandler Language="C#" Class="page_WorkHours" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;


public class page_WorkHours : IHttpHandler, IRequiresSessionState
{
    //sy_Attendance 欄位 代碼檔
    public class TooL
    {
        public string aGuid { get; set; }//
        public string aperGuid { get; set; }//
        public string aAttendanceDate { get; set; }//
        public string aDays { get; set; }//
        public string aTimes { get; set; }//
        public string aLeave { get; set; }//
        public string aGeneralOverTime1 { get; set; }//
        public string aGeneralOverTime2 { get; set; }//
        public string aGeneralOverTime3 { get; set; }//
        public string aOffDayOverTime1 { get; set; }//
        public string aOffDayOverTime2 { get; set; }//
        public string aOffDayOverTime3 { get; set; }//
        public string aHolidayOverTimes { get; set; }//
        public string aHolidayOverTime1 { get; set; }//
        public string aHolidayOverTime2 { get; set; }//
        public string aHolidayOverTime3 { get; set; }//
        public string aNationalholidays { get; set; }//
        public string aNationalholidays1 { get; set; }//
        public string aNationalholidays2 { get; set; }//
        public string aNationalholidays3 { get; set; }//
        public string aSpecialholiday { get; set; }//
        public string aSpecialholiday1 { get; set; }//
        public string aSpecialholiday2 { get; set; }//
        public string aSpecialholiday3 { get; set; }//
        public string aRemark { get; set; }//
        public string aItme { get; set; }//
        public string aStatus { get; set; }//
        public string perNo { get; set; }//
        public string perName { get; set; }//
        public string cbName { get; set; }//
    }
    //人員資料
    public class perTooL
    {
        public string cbName { get; set; }//
        public string perNo { get; set; }//
        public string perName { get; set; }//
    }
    //人員資料
    public class leaveTooL
    {
        public string leaAppilcantId { get; set; }//
        public string perName { get; set; }//
        public string leaStratFrom { get; set; }//
        public string leaEndAt { get; set; }//
        public string ldDate { get; set; }//
        public string leaDuration { get; set; }//
        public string phName { get; set; }//
        public string leaRemark { get; set; }//
    }

    //原始時數資料
    public class ahTooL
    {
        public string ah_guid { get; set; }//
        public string ah_perGuid { get; set; }//
        public string ah_perNo { get; set; }//
        public string ah_AttendanceDate { get; set; }//
        public string ah_Times { get; set; }//
        public string ah_Remark { get; set; }//
        public string ah_Itme { get; set; }//
        public string perGuid { get; set; }//
        public string perName { get; set; }//
    }
    //sy_SalaryRange 欄位 計薪週期
    public class srTooL
    {
        public string sr_Guid { get; set; }//GUID
        public string sr_Year { get; set; }//年度
        public string sr_BeginDate { get; set; }//週期起
        public string sr_Enddate { get; set; }//週期迄
        public string sr_BeginDate_c { get; set; }//週期起 yyyy-mm-dd 因為在SQL日期between 一定要yyyy-mm-dd
        public string sr_Enddate_c { get; set; }//週期迄 yyyy-mm-dd yyyy-mm-dd 因為在SQL日期between 一定要yyyy-mm-dd
        public string sr_SalaryDate { get; set; }//發薪日
        public string sr_Ps { get; set; }//備註
        //狀態目前不需要顯示在畫面上
        //public string sr_Status { get; set; }//狀態
    }
    sy_Attendance_DB at_db = new sy_Attendance_DB();
    SalaryRange_DB sr_db = new SalaryRange_DB();
    public void ProcessRequest(HttpContext context)
    {
        string session_no = string.IsNullOrEmpty(USERINFO.MemberGuid) ? "" : USERINFO.MemberGuid.ToString().Trim();
        string session_name = string.IsNullOrEmpty(USERINFO.MemberName) ? "" : USERINFO.MemberName.ToString().Trim();
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            case "load_hoursdata":
                string str_keywords = string.IsNullOrEmpty(context.Request.Form["str_keywords"]) ? "" : context.Request.Form["str_keywords"].ToString().Trim();
                string str_dates = string.IsNullOrEmpty(context.Request.Form["str_dates"]) ? "" : context.Request.Form["str_dates"].ToString().Trim();
                string str_datee = string.IsNullOrEmpty(context.Request.Form["str_datee"]) ? "" : context.Request.Form["str_datee"].ToString().Trim();
                string str_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                try {
                    at_db._str_keyword = str_keywords;
                    at_db._str_dates = str_dates;
                    at_db._str_datee = str_datee;
                    at_db._aGuid = str_guid;
                    DataTable dt = at_db.SelectAttendance();
                    if (dt.Rows.Count > 0)
                    {
                        List<TooL> eList = new List<TooL>();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            TooL e = new TooL();
                            e.aGuid = dt.Rows[i]["aGuid"].ToString().Trim();//
                            e.aperGuid = dt.Rows[i]["aperGuid"].ToString().Trim();//
                            e.aAttendanceDate = dt.Rows[i]["aAttendanceDate"].ToString().Trim();//
                            e.aDays = dt.Rows[i]["aDays"].ToString().Trim();//
                            e.aTimes = dt.Rows[i]["aTimes"].ToString().Trim();//
                            e.aLeave = dt.Rows[i]["aLeave"].ToString().Trim();//
                            e.aGeneralOverTime1 = dt.Rows[i]["aGeneralOverTime1"].ToString().Trim();//
                            e.aGeneralOverTime2 = dt.Rows[i]["aGeneralOverTime2"].ToString().Trim();//
                            e.aGeneralOverTime3 = dt.Rows[i]["aGeneralOverTime3"].ToString().Trim();//
                            e.aOffDayOverTime1 = dt.Rows[i]["aOffDayOverTime1"].ToString().Trim();//
                            e.aOffDayOverTime2 = dt.Rows[i]["aOffDayOverTime2"].ToString().Trim();//
                            e.aOffDayOverTime3 = dt.Rows[i]["aOffDayOverTime3"].ToString().Trim();//
                            e.aHolidayOverTimes = dt.Rows[i]["aHolidayOverTimes"].ToString().Trim();//
                            e.aHolidayOverTime1 = dt.Rows[i]["aHolidayOverTime1"].ToString().Trim();//
                            e.aHolidayOverTime2 = dt.Rows[i]["aHolidayOverTime2"].ToString().Trim();//
                            e.aHolidayOverTime3 = dt.Rows[i]["aHolidayOverTime3"].ToString().Trim();//
                            e.aNationalholidays = dt.Rows[i]["aNationalholidays"].ToString().Trim();//
                            e.aNationalholidays1 = dt.Rows[i]["aNationalholidays1"].ToString().Trim();//
                            e.aNationalholidays2 = dt.Rows[i]["aNationalholidays2"].ToString().Trim();//
                            e.aNationalholidays3 = dt.Rows[i]["aNationalholidays3"].ToString().Trim();//
                            e.aSpecialholiday = dt.Rows[i]["aSpecialholiday"].ToString().Trim();//
                            e.aSpecialholiday1 = dt.Rows[i]["aSpecialholiday1"].ToString().Trim();//
                            e.aSpecialholiday2 = dt.Rows[i]["aSpecialholiday2"].ToString().Trim();//
                            e.aSpecialholiday3 = dt.Rows[i]["aSpecialholiday3"].ToString().Trim();//
                            e.aRemark = dt.Rows[i]["aRemark"].ToString().Trim();//
                            e.aItme = dt.Rows[i]["aItme"].ToString().Trim();//
                            e.aStatus = dt.Rows[i]["aStatus"].ToString().Trim();//
                            e.perNo = dt.Rows[i]["perNo"].ToString().Trim();//
                            e.perName = dt.Rows[i]["perName"].ToString().Trim();//
                            e.cbName = dt.Rows[i]["cbName"].ToString().Trim();//
                            eList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        //加了下面這行才不會超過預設json的最大長度
                        objSerializer.MaxJsonLength = 2147483644;
                        string ans = objSerializer.Serialize(eList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
                    }
                    else {
                        context.Response.Write("nodata");
                    }
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;


            //撈人員資料
            case "load_person":
                string dept_perguid = string.IsNullOrEmpty(context.Request.Form["dept_perguid"]) ? "" : context.Request.Form["dept_perguid"].ToString().Trim();
                try
                {
                    at_db._aperGuid = dept_perguid;
                    DataTable dt_dept = at_db.SelectDept();
                    if (dt_dept.Rows.Count > 0)
                    {
                        List<perTooL> perList = new List<perTooL>();
                        for (int i = 0; i < dt_dept.Rows.Count; i++)
                        {
                            perTooL e = new perTooL();
                            e.cbName = dt_dept.Rows[i]["cbName"].ToString().Trim();//
                            e.perNo = dt_dept.Rows[i]["perNo"].ToString().Trim();//
                            e.perName = dt_dept.Rows[i]["perName"].ToString().Trim();//
                            perList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        string ans = objSerializer.Serialize(perList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
                    }
                    else {
                        context.Response.Write("nodata");
                    }
                }
                catch {
                    context.Response.Write("error");
                }
                break;

            //撈請假資料
            case "load_leave":
                string leave_perguid = string.IsNullOrEmpty(context.Request.Form["leave_perguid"]) ? "" : context.Request.Form["leave_perguid"].ToString().Trim();
                string leave_date = string.IsNullOrEmpty(context.Request.Form["leave_date"]) ? "" : context.Request.Form["leave_date"].ToString().Trim();
                try
                {
                    at_db._aperGuid =leave_perguid;
                    at_db._aAttendanceDate = leave_date;
                    DataTable dt_leave = at_db.Selectleave();
                    if (dt_leave.Rows.Count > 0)
                    {
                        List<leaveTooL> leaveList = new List<leaveTooL>();
                        for (int i = 0; i < dt_leave.Rows.Count; i++)
                        {
                            leaveTooL e = new leaveTooL();
                            e.leaAppilcantId = dt_leave.Rows[i]["leaAppilcantId"].ToString().Trim();//
                            e.perName = dt_leave.Rows[i]["perName"].ToString().Trim();//
                            e.leaStratFrom = dt_leave.Rows[i]["leaStratFrom"].ToString().Trim();//
                            e.leaEndAt = dt_leave.Rows[i]["leaEndAt"].ToString().Trim();//
                            e.ldDate = dt_leave.Rows[i]["ldDate"].ToString().Trim();//
                            e.leaDuration = dt_leave.Rows[i]["leaDuration"].ToString().Trim();//
                            e.phName = dt_leave.Rows[i]["phName"].ToString().Trim();//
                            e.leaRemark = dt_leave.Rows[i]["leaRemark"].ToString().Trim();//
                            leaveList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        string ans = objSerializer.Serialize(leaveList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
                    }
                    else {
                        context.Response.Write("nodata");
                    }
                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //工號change
            case "load_thispeopledata":
                string p_no = string.IsNullOrEmpty(context.Request.Form["str_thisno"]) ? "" : context.Request.Form["str_thisno"].ToString().Trim();
                try
                {
                    at_db._str_perno = p_no;
                    DataTable dt_p = at_db.SelectPerson();
                    if (dt_p.Rows.Count > 0)
                    {
                        context.Response.Write(dt_p.Rows[0]["perGuid"].ToString().Trim() + "," + dt_p.Rows[0]["perName"].ToString().Trim());
                    }
                    else {
                        context.Response.Write("nodata");
                    }
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;

            //撈原始時數資料
            case "load_oldhours":
                string old_dates = string.IsNullOrEmpty(context.Request.Form["str_dates"]) ? "" : context.Request.Form["str_dates"].ToString().Trim();
                string old_datee = string.IsNullOrEmpty(context.Request.Form["str_datee"]) ? "" : context.Request.Form["str_datee"].ToString().Trim();
                string old_keyword = string.IsNullOrEmpty(context.Request.Form["str_keywords"]) ? "" : context.Request.Form["str_keywords"].ToString().Trim();
                string old_ahguid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                string old_order_column = string.IsNullOrEmpty(context.Request.Form["str_order_column"]) ? "" : context.Request.Form["str_order_column"].ToString().Trim();
                string old_order_status = string.IsNullOrEmpty(context.Request.Form["str_order_status"]) ? "" : context.Request.Form["str_order_status"].ToString().Trim();
                try
                {
                    at_db._str_keyword = old_keyword;
                    at_db._str_dates = old_dates;
                    at_db._str_datee = old_datee;
                    at_db._ah_guid = old_ahguid;
                    if (old_order_column=="cno") {
                        at_db._str_order_column = "ah_perNo";
                    }
                    if (old_order_column=="cname") {
                        at_db._str_order_column = "perName";
                    }
                    if (old_order_column=="cdate") {
                        at_db._str_order_column = "ah_AttendanceDate";
                    }
                    at_db._str_order_status = old_order_status;
                    DataTable dt = at_db.SelectAttendanceHours();
                    if (dt.Rows.Count > 0)
                    {
                        List<ahTooL> eList = new List<ahTooL>();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            ahTooL e = new ahTooL();
                            e.ah_guid = dt.Rows[i]["ah_guid"].ToString().Trim();//
                            e.ah_perGuid = dt.Rows[i]["ah_perGuid"].ToString().Trim();//
                            e.ah_perNo = dt.Rows[i]["ah_perNo"].ToString().Trim();//
                            e.ah_AttendanceDate = dt.Rows[i]["ah_AttendanceDate"].ToString().Trim();//
                            e.ah_Times = dt.Rows[i]["ah_Times"].ToString().Trim();//
                            e.ah_Remark = dt.Rows[i]["ah_Remark"].ToString().Trim();//
                            e.ah_Itme = dt.Rows[i]["ah_Itme"].ToString().Trim();//
                            e.perGuid = dt.Rows[i]["perGuid"].ToString().Trim();//
                            e.perName = dt.Rows[i]["perName"].ToString().Trim();//
                            eList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        //加了下面這行才不會超過預設json的最大長度
                        objSerializer.MaxJsonLength = 2147483644;
                        string ans = objSerializer.Serialize(eList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
                    }
                    else {
                        context.Response.Write("nodata");
                    }
                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //刪除 原始時數資料
            case "del_hours":
                string del_guid = string.IsNullOrEmpty(context.Request.Form["del_guid"]) ? "" : context.Request.Form["del_guid"].ToString().Trim();
                try
                {
                    at_db._ah_guid = del_guid;
                    at_db.DeleteAttendanceHours();
                    context.Response.Write("OK");
                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;

            //新增/修改
            case "mod_hours":
                string mod_aGuid = string.IsNullOrEmpty(context.Request.Form["mod_aGuid"]) ? "" : context.Request.Form["mod_aGuid"].ToString().Trim();
                string mod_aperGuid = string.IsNullOrEmpty(context.Request.Form["mod_aperGuid"]) ? "" : context.Request.Form["mod_aperGuid"].ToString().Trim();
                string mod_aAttendanceDate = string.IsNullOrEmpty(context.Request.Form["mod_aAttendanceDate"]) ? "" : context.Request.Form["mod_aAttendanceDate"].ToString().Trim();
                string mod_aTimes = string.IsNullOrEmpty(context.Request.Form["mod_aTimes"]) ? "0" : context.Request.Form["mod_aTimes"].ToString().Trim();
                string mod_aRemark = string.IsNullOrEmpty(context.Request.Form["mod_aRemark"]) ? "" : context.Request.Form["mod_aRemark"].ToString().Trim();
                string mod_aItme = string.IsNullOrEmpty(context.Request.Form["mod_aItme"]) ? "" : context.Request.Form["mod_aItme"].ToString().Trim();
                string mod_type = string.IsNullOrEmpty(context.Request.Form["mod_type"]) ? "" : context.Request.Form["mod_type"].ToString().Trim();

                try
                {
                    at_db._ah_perGuid = mod_aperGuid;
                    at_db._ah_AttendanceDate = mod_aAttendanceDate;
                    at_db._ah_Times = Convert.ToDecimal(mod_aTimes);
                    at_db._ah_Remark = mod_aRemark;
                    at_db._ah_Itme = mod_aItme;
                    at_db._ah_ModdifyId = session_no;
                    if (mod_type=="新增") {
                        at_db._ah_guid = Guid.NewGuid().ToString();
                        at_db._ah_CreateId = session_no;
                        at_db.InsertAttendanceHours();
                    }
                    if (mod_type=="修改") {
                        at_db._ah_guid = mod_aGuid;
                        at_db.UpdateAttendanceHours();
                    }
                    context.Response.Write("OK");
                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //計算工時
            case "hours_go":
                string go_ranges = string.IsNullOrEmpty(context.Request.Form["str_ranges"]) ? "" : context.Request.Form["str_ranges"].ToString().Trim();
                string go_rangee = string.IsNullOrEmpty(context.Request.Form["str_rangee"]) ? "" : context.Request.Form["str_rangee"].ToString().Trim();
                string str_userid = session_no;
                try {
                    //跑工時計算SP
                    SqlCommand oCmd2 = new SqlCommand();
                    oCmd2.Connection = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
                    StringBuilder sb = new StringBuilder();
                    sb.Append(@"sp_workhours");
                    oCmd2.CommandTimeout = 120;
                    oCmd2.CommandText = sb.ToString();
                    oCmd2.CommandType = CommandType.StoredProcedure;
                    oCmd2.Connection.Open();
                    SqlDataAdapter oda = new SqlDataAdapter(oCmd2);
                    oCmd2.Parameters.AddWithValue("@create_id", str_userid);
                    oCmd2.Parameters.AddWithValue("@ranges", go_ranges);
                    oCmd2.Parameters.AddWithValue("@rangee", go_rangee);
                    oCmd2.ExecuteNonQuery();
                    oCmd2.Connection.Close();
                    oCmd2.Connection.Dispose();
                    oCmd2.Dispose();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //撈原始工時資料 by  perGuid date
            case "load_historyhours":
                string history_pguid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                string history_date = string.IsNullOrEmpty(context.Request.Form["str_date"]) ? "" : context.Request.Form["str_date"].ToString().Trim();
                try
                {
                    at_db._ah_perGuid = history_pguid;
                    at_db._ah_AttendanceDate = history_date;
                    DataTable dt = at_db.SelectAttendanceHours();
                    if (dt.Rows.Count > 0)
                    {
                        List<ahTooL> eList = new List<ahTooL>();
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            ahTooL e = new ahTooL();
                            e.ah_guid = dt.Rows[i]["ah_guid"].ToString().Trim();//
                            e.ah_perGuid = dt.Rows[i]["ah_perGuid"].ToString().Trim();//
                            e.ah_perNo = dt.Rows[i]["ah_perNo"].ToString().Trim();//
                            e.ah_AttendanceDate = dt.Rows[i]["ah_AttendanceDate"].ToString().Trim();//
                            e.ah_Times = dt.Rows[i]["ah_Times"].ToString().Trim();//
                            e.ah_Remark = dt.Rows[i]["ah_Remark"].ToString().Trim();//
                            e.ah_Itme = dt.Rows[i]["ah_Itme"].ToString().Trim();//
                            e.perGuid = dt.Rows[i]["perGuid"].ToString().Trim();//
                            e.perName = dt.Rows[i]["perName"].ToString().Trim();//
                            eList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        //加了下面這行才不會超過預設json的最大長度
                        objSerializer.MaxJsonLength = 2147483644;
                        string ans = objSerializer.Serialize(eList);  //new
                        context.Response.ContentType = "application/json";
                        context.Response.Write(ans);
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
                break;
            //撈計薪週期 for 工時計算
            case "load_payrange_workinghours":
                sr_db._sr_Year = "";
                sr_db._sr_SalaryDate = "";
                sr_db._sr_BeginDate = "";
                sr_db._sr_Enddate = "";
                sr_db._sr_Guid = "";
                DataTable dt_sr = sr_db.SelectSR();
                if (dt_sr.Rows.Count > 0)
                {
                    List<srTooL> eList = new List<srTooL>();
                    for (int i = 0; i < dt_sr.Rows.Count; i++)
                    {
                        srTooL e = new srTooL();
                        e.sr_Guid = dt_sr.Rows[i]["sr_Guid"].ToString().Trim();//Guid
                        e.sr_Year = dt_sr.Rows[i]["sr_Year"].ToString().Trim();//年度
                        e.sr_BeginDate = dt_sr.Rows[i]["sr_BeginDate"].ToString().Trim();//週期起
                        e.sr_Enddate = dt_sr.Rows[i]["sr_Enddate"].ToString().Trim();//週期迄
                        e.sr_BeginDate_c = dt_sr.Rows[i]["sr_BeginDate"].ToString().Trim().Replace("/", "-");//週期起 yyyy-mm-dd 因為在SQL日期between 一定要yyyy-mm-dd
                        e.sr_Enddate_c = dt_sr.Rows[i]["sr_Enddate"].ToString().Trim().Replace("/", "-");//週期迄 yyyy-mm-dd 因為在SQL日期between 一定要yyyy-mm-dd
                        e.sr_SalaryDate = dt_sr.Rows[i]["sr_SalaryDate"].ToString().Trim();//發薪日
                        e.sr_Ps = dt_sr.Rows[i]["sr_Ps"].ToString().Trim();//備註
                        eList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(eList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else
                {
                    context.Response.Write("nodata");
                }
                break;
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}