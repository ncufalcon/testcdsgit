<%@ WebHandler Language="C#" Class="page_WorkHours" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.SessionState;

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
    sy_Attendance_DB at_db = new sy_Attendance_DB();
    public void ProcessRequest(HttpContext context)
    {
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
            //刪除
            case "del_hours":
                string del_guid = string.IsNullOrEmpty(context.Request.Form["del_guid"]) ? "" : context.Request.Form["del_guid"].ToString().Trim();
                try
                {
                    at_db._aGuid = del_guid;
                    at_db.DeleteAttendance();
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
                string mod_aDays = string.IsNullOrEmpty(context.Request.Form["mod_aDays"]) ? "0" : context.Request.Form["mod_aDays"].ToString().Trim();
                string mod_aTimes = string.IsNullOrEmpty(context.Request.Form["mod_aTimes"]) ? "0" : context.Request.Form["mod_aTimes"].ToString().Trim();
                string mod_aLeave = string.IsNullOrEmpty(context.Request.Form["mod_aLeave"]) ? "0" : context.Request.Form["mod_aLeave"].ToString().Trim();
                string mod_aGeneralOverTime1 = string.IsNullOrEmpty(context.Request.Form["mod_aGeneralOverTime1"]) ? "0" : context.Request.Form["mod_aGeneralOverTime1"].ToString().Trim();
                string mod_aGeneralOverTime2 = string.IsNullOrEmpty(context.Request.Form["mod_aGeneralOverTime2"]) ? "0" : context.Request.Form["mod_aGeneralOverTime2"].ToString().Trim();
                string mod_aGeneralOverTime3 = string.IsNullOrEmpty(context.Request.Form["mod_aGeneralOverTime3"]) ? "0" : context.Request.Form["mod_aGeneralOverTime3"].ToString().Trim();
                string mod_aOffDayOverTime1 = string.IsNullOrEmpty(context.Request.Form["mod_aOffDayOverTime1"]) ? "0" : context.Request.Form["mod_aOffDayOverTime1"].ToString().Trim();
                string mod_aOffDayOverTime2 = string.IsNullOrEmpty(context.Request.Form["mod_aOffDayOverTime2"]) ? "0" : context.Request.Form["mod_aOffDayOverTime2"].ToString().Trim();
                string mod_aOffDayOverTime3 = string.IsNullOrEmpty(context.Request.Form["mod_aOffDayOverTime3"]) ? "0" : context.Request.Form["mod_aOffDayOverTime3"].ToString().Trim();
                string mod_aHolidayOverTimes = string.IsNullOrEmpty(context.Request.Form["mod_aHolidayOverTimes"]) ? "0" : context.Request.Form["mod_aHolidayOverTimes"].ToString().Trim();
                string mod_aHolidayOverTime1 = string.IsNullOrEmpty(context.Request.Form["mod_aHolidayOverTime1"]) ? "0" : context.Request.Form["mod_aHolidayOverTime1"].ToString().Trim();
                string mod_aHolidayOverTime2 = string.IsNullOrEmpty(context.Request.Form["mod_aHolidayOverTime2"]) ? "0" : context.Request.Form["mod_aHolidayOverTime2"].ToString().Trim();
                string mod_aHolidayOverTime3 = string.IsNullOrEmpty(context.Request.Form["mod_aHolidayOverTime3"]) ? "0" : context.Request.Form["mod_aHolidayOverTime3"].ToString().Trim();
                string mod_aNationalholidays = string.IsNullOrEmpty(context.Request.Form["mod_aNationalholidays"]) ? "0" : context.Request.Form["mod_aNationalholidays"].ToString().Trim();
                string mod_aNationalholidays1 = string.IsNullOrEmpty(context.Request.Form["mod_aNationalholidays1"]) ? "0" : context.Request.Form["mod_aNationalholidays1"].ToString().Trim();
                string mod_aNationalholidays2 = string.IsNullOrEmpty(context.Request.Form["mod_aNationalholidays2"]) ? "0" : context.Request.Form["mod_aNationalholidays2"].ToString().Trim();
                string mod_aNationalholidays3 = string.IsNullOrEmpty(context.Request.Form["mod_aNationalholidays3"]) ? "0" : context.Request.Form["mod_aNationalholidays3"].ToString().Trim();
                string mod_aSpecialholiday = string.IsNullOrEmpty(context.Request.Form["mod_aSpecialholiday"]) ? "0" : context.Request.Form["mod_aSpecialholiday"].ToString().Trim();
                string mod_aSpecialholiday1 = string.IsNullOrEmpty(context.Request.Form["mod_aSpecialholiday1"]) ? "0" : context.Request.Form["mod_aSpecialholiday1"].ToString().Trim();
                string mod_aSpecialholiday2 = string.IsNullOrEmpty(context.Request.Form["mod_aSpecialholiday2"]) ? "0" : context.Request.Form["mod_aSpecialholiday2"].ToString().Trim();
                string mod_aSpecialholiday3 = string.IsNullOrEmpty(context.Request.Form["mod_aSpecialholiday3"]) ? "0" : context.Request.Form["mod_aSpecialholiday3"].ToString().Trim();
                string mod_aRemark = string.IsNullOrEmpty(context.Request.Form["mod_aRemark"]) ? "" : context.Request.Form["mod_aRemark"].ToString().Trim();
                string mod_aItme = string.IsNullOrEmpty(context.Request.Form["mod_aItme"]) ? "" : context.Request.Form["mod_aItme"].ToString().Trim();
                string mod_type = string.IsNullOrEmpty(context.Request.Form["mod_type"]) ? "" : context.Request.Form["mod_type"].ToString().Trim();

                try
                {
                    at_db._aperGuid = mod_aperGuid;
                    at_db._aAttendanceDate = mod_aAttendanceDate;
                    at_db._aDays = Convert.ToInt32(mod_aDays);
                    at_db._aTimes = Convert.ToDecimal(mod_aTimes);
                    at_db._aLeave = Convert.ToDecimal(mod_aLeave);
                    at_db._aGeneralOverTime1 = Convert.ToDecimal(mod_aGeneralOverTime1);
                    at_db._aGeneralOverTime2 = Convert.ToDecimal(mod_aGeneralOverTime2);
                    at_db._aGeneralOverTime3 = Convert.ToDecimal(mod_aGeneralOverTime3);
                    at_db._aOffDayOverTime1 = Convert.ToDecimal(mod_aOffDayOverTime1);
                    at_db._aOffDayOverTime2 = Convert.ToDecimal(mod_aOffDayOverTime2);
                    at_db._aOffDayOverTime3 = Convert.ToDecimal(mod_aOffDayOverTime3);
                    at_db._aHolidayOverTimes = Convert.ToDecimal(mod_aHolidayOverTimes);
                    at_db._aHolidayOverTime1 = Convert.ToDecimal(mod_aHolidayOverTime1);
                    at_db._aHolidayOverTime2 = Convert.ToDecimal(mod_aHolidayOverTime2);
                    at_db._aHolidayOverTime3 = Convert.ToDecimal(mod_aHolidayOverTime3);
                    at_db._aNationalholidays = Convert.ToDecimal(mod_aNationalholidays);
                    at_db._aNationalholidays1 = Convert.ToDecimal(mod_aNationalholidays1);
                    at_db._aNationalholidays2 = Convert.ToDecimal(mod_aNationalholidays2);
                    at_db._aNationalholidays3 = Convert.ToDecimal(mod_aNationalholidays3);
                    at_db._aSpecialholiday = Convert.ToDecimal(mod_aSpecialholiday);
                    at_db._aSpecialholiday1 = Convert.ToDecimal(mod_aSpecialholiday1);
                    at_db._aSpecialholiday2 = Convert.ToDecimal(mod_aSpecialholiday2);
                    at_db._aSpecialholiday3 = Convert.ToDecimal(mod_aSpecialholiday3);
                    at_db._aRemark = mod_aRemark;
                    at_db._aItme = mod_aItme;
                    at_db._aModdifyId = "王胖爺";
                    if (mod_type=="新增") {
                        at_db._aGuid = Guid.NewGuid().ToString();
                        at_db._aCreateId = "王胖爺";
                        at_db.InsertAttendance();
                    }
                    if (mod_type=="修改") {
                        at_db._aGuid = mod_aGuid;
                        at_db.UpdateAttendance();
                    }
                    context.Response.Write("OK");
                }
                catch (Exception ex){
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