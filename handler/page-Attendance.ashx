<%@ WebHandler Language="C#" Class="page_Attendance" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.SessionState;
using System.Configuration;
using System.Data.SqlClient;
using System.Text;

public class page_Attendance : IHttpHandler, IRequiresSessionState
{
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
    //sy_Leave 欄位 計薪週期
    public class leaTooL
    {
        public string leaGuid { get; set; }//GUID
        public string leaAppilcantId { get; set; }//請假人員編
        public string perName { get; set; }//請假人姓名
        public string leaStratFrom { get; set; }//日期起
        public string leaEndAt { get; set; }//日期迄
        public string leaDuration { get; set; }//天數
        public string leaLeaveType { get; set; }//假別
        public string leaRemark { get; set; }//事由
        public string leaImportStatus { get; set; }//匯入狀態 Y/從sqlite傳過來的
        public string leaLeaveTypeId { get; set; }//假別1
        public string leaLeaveType2 { get; set; }//假別2
        public string leaDuration2 { get; set; }//假別2天數
        public string leaID { get; set; }//id
        //狀態目前不需要顯示在畫面上
        //public string sr_Status { get; set; }//狀態
    }
    SalaryRange_DB s_db = new SalaryRange_DB();
    sy_Leave_DB lea_db = new sy_Leave_DB();
    sy_LeaveDetail_DB ld_db = new sy_LeaveDetail_DB();
    SalaryRange_DB sr_db = new SalaryRange_DB();
    public void ProcessRequest (HttpContext context)
    {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch(str_func){
            //撈計薪週期
            case "load_payrange":
                s_db._sr_Year = "";
                s_db._sr_SalaryDate = "";
                s_db._sr_BeginDate = "";
                s_db._sr_Enddate = "";
                s_db._sr_Guid = "";
                DataTable dt_sr = s_db.SelectSR();
                if (dt_sr.Rows.Count > 0)
                {
                    List<srTooL> eList = new List<srTooL>();
                    for (int i = 0; i < dt_sr.Rows.Count; i++)
                    {
                        if (dt_sr.Rows[i]["sr_importStatus"].ToString().Trim()!="Y") {
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
            //撈假單資料
            case "load_data":
                string str_dates = string.IsNullOrEmpty(context.Request.Form["str_dates"]) ? "" : context.Request.Form["str_dates"].ToString().Trim();
                string str_datee = string.IsNullOrEmpty(context.Request.Form["str_datee"]) ? "" : context.Request.Form["str_datee"].ToString().Trim();
                string str_type = string.IsNullOrEmpty(context.Request.Form["str_type"]) ? "" : context.Request.Form["str_type"].ToString().Trim();
                string str_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();

                try {
                    lea_db._str_dates = str_dates;
                    lea_db._str_datee = str_datee;
                    lea_db._str_type = str_type;
                    lea_db._leaGuid = str_guid;
                    //lea_db._leaID = Convert.ToInt32(str_id);
                    DataTable dt_data = lea_db.SelectLeave();
                    if (dt_data.Rows.Count > 0)
                    {
                        List<leaTooL> leaList = new List<leaTooL>();
                        for (int i = 0; i < dt_data.Rows.Count; i++)
                        {
                            leaTooL e = new leaTooL();
                            e.leaGuid = dt_data.Rows[i]["leaGuid"].ToString().Trim();//
                            e.leaAppilcantId = dt_data.Rows[i]["leaAppilcantId"].ToString().Trim();//
                            e.perName = dt_data.Rows[i]["perName"].ToString().Trim();//
                            e.leaStratFrom = DateTime.Parse(dt_data.Rows[i]["leaStratFrom"].ToString()).ToString("yyyy/MM/dd HH:mm:ss");//
                            e.leaEndAt = DateTime.Parse(dt_data.Rows[i]["leaEndAt"].ToString()).ToString("yyyy/MM/dd HH:mm:ss");//
                            //e.leaDuration = dt_data.Rows[i]["leaDuration"].ToString().Trim();//
                            //如果假別二不為空 天數就相加 假別也湊起來
                            if (dt_data.Rows[i]["leaDuration2"].ToString().Trim()!="0.0") {
                                e.leaDuration = (Convert.ToDecimal(dt_data.Rows[i]["leaDuration"].ToString().Trim())+Convert.ToDecimal(dt_data.Rows[i]["leaDuration2"].ToString().Trim())).ToString();//
                                e.leaLeaveType = dt_data.Rows[i]["phName1"].ToString().Trim()+","+dt_data.Rows[i]["phName2"].ToString().Trim();//
                            } else
                            {
                                e.leaDuration = dt_data.Rows[i]["leaDuration"].ToString().Trim();
                                e.leaLeaveType = dt_data.Rows[i]["phName1"].ToString().Trim();//
                            }
                            e.leaRemark = dt_data.Rows[i]["leaRemark"].ToString().Trim();//
                            e.leaImportStatus = dt_data.Rows[i]["leaImportStatus"].ToString().Trim();//
                            e.leaLeaveTypeId = dt_data.Rows[i]["leaLeaveTypeId"].ToString().Trim();//
                            e.leaLeaveType2 = dt_data.Rows[i]["leaLeaveType2"].ToString().Trim();//
                            e.leaDuration2 = dt_data.Rows[i]["leaDuration2"].ToString().Trim();//
                            e.leaID = dt_data.Rows[i]["leaID"].ToString().Trim();//
                            leaList.Add(e);
                        }
                        System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                        string ans = objSerializer.Serialize(leaList);  //new
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
            //copy sqlite的資料到我們的資料表 先刪我們資料表的資料再轉進資料
            case "copy_and_del_data":
                string copy_dates = string.IsNullOrEmpty(context.Request.Form["copy_dates"]) ? "" : context.Request.Form["copy_dates"].ToString().Trim();
                string copy_datee = string.IsNullOrEmpty(context.Request.Form["copy_datee"]) ? "" : context.Request.Form["copy_datee"].ToString().Trim();
                string copy_srguid = string.IsNullOrEmpty(context.Request.Form["copy_srguid"]) ? "" : context.Request.Form["copy_srguid"].ToString().Trim();
                try {
                    lea_db._str_dates = copy_dates;
                    lea_db._str_datee = copy_datee;
                    ld_db._str_dates = copy_dates;
                    ld_db._str_datee = copy_datee;
                    //lea_db.DeleteLeave();//先刪除時間區間內sy_Leave的資料(因為不能重複匯資料 所以不需要先刪了)
                    lea_db.ImportSqliteToLeave();//1.再將時間區間內的資料轉到sy_Leave
                    ld_db.ImportSqliteToLeaveDetail();//2.將SQLite的資料複製到
                    sr_db._sr_Guid = copy_srguid;
                    sr_db.UpdateSRImportStatus();//3.update 計薪週期的 sy_importStatus='Y' 表示該計薪周期已經匯入完請假資料
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //新增/修改假單資料
            case "mod_data":
                string mod_dates = string.IsNullOrEmpty(context.Request.Form["mod_dates"]) ? "" : context.Request.Form["mod_dates"].ToString().Trim();
                string mod_datee = string.IsNullOrEmpty(context.Request.Form["mod_datee"]) ? "" : context.Request.Form["mod_datee"].ToString().Trim();
                string mod_date = string.IsNullOrEmpty(context.Request.Form["mod_date"]) ? "" : context.Request.Form["mod_date"].ToString().Trim();
                string mod_empno = string.IsNullOrEmpty(context.Request.Form["mod_empno"]) ? "" : context.Request.Form["mod_empno"].ToString().Trim();
                string mod_leave_type = string.IsNullOrEmpty(context.Request.Form["mod_leave_type"]) ? "" : context.Request.Form["mod_leave_type"].ToString().Trim();
                string mod_leave_type2 = string.IsNullOrEmpty(context.Request.Form["mod_leave_type2"]) ? "" : context.Request.Form["mod_leave_type2"].ToString().Trim();
                string mod_leave_type_date = string.IsNullOrEmpty(context.Request.Form["mod_leave_type_date"]) ? "" : context.Request.Form["mod_leave_type_date"].ToString().Trim();
                string mod_leave_type2_date = string.IsNullOrEmpty(context.Request.Form["mod_leave_type2_date"]) ? "" : context.Request.Form["mod_leave_type2_date"].ToString().Trim();
                string mod_ps = string.IsNullOrEmpty(context.Request.Form["mod_ps"]) ? "" : context.Request.Form["mod_ps"].ToString().Trim();
                string mod_type = string.IsNullOrEmpty(context.Request.Form["mod_type"]) ? "" : context.Request.Form["mod_type"].ToString().Trim();
                string mod_id = string.IsNullOrEmpty(context.Request.Form["mod_id"]) ? "0" : context.Request.Form["mod_id"].ToString().Trim();
                string mod_guid = string.IsNullOrEmpty(context.Request.Form["mod_guid"]) ? "" : context.Request.Form["mod_guid"].ToString().Trim();
                try {
                    lea_db._str_username = "Lynn.Lin";
                    //DataTable dt_authuser = lea_db.SelectSqliteAuthUser();
                    //if (dt_authuser.Rows.Count > 0)
                    //{
                    if (mod_type == "新增")
                    {
                        mod_guid = Guid.NewGuid().ToString();
                        lea_db._leaGuid = mod_guid;
                        lea_db._leaStratFrom = DateTime.Parse(mod_dates);
                        lea_db._leaEndAt = DateTime.Parse(mod_datee);
                        lea_db._leaDuration = Convert.ToDecimal(mod_leave_type_date);
                        lea_db._leaRemark = mod_ps;
                        //lea_db._leaAskerName = dt_authuser.Rows[0]["first_name"].ToString().Trim();
                        lea_db._leaAskerName = "王胖爺";
                        lea_db._leaLeaveTypeId = Convert.ToInt32(mod_leave_type);
                        lea_db._leaAppilcantId = mod_empno;
                        if (mod_leave_type2 == "")
                            lea_db._leaLeaveType2 = Convert.ToInt32("0");
                        else
                            lea_db._leaLeaveType2 = Convert.ToInt32(mod_leave_type2);
                        if (mod_leave_type2_date == "")
                            lea_db._leaDuration2 = Convert.ToDecimal("0");
                        else
                            lea_db._leaDuration2 = Convert.ToDecimal(mod_leave_type2_date);
                        lea_db._leaModdifyId = "";
                        lea_db._str_type_date = mod_leave_type_date;
                        lea_db._str_type2_date = mod_leave_type2_date;
                        lea_db._str_days = mod_date;
                        lea_db.InsertLeaveAndDetail();
                        context.Response.Write("ok");
                    }//新增結束
                    if (mod_type == "修改")
                    {
                        lea_db._leaGuid = mod_guid;
                        lea_db._leaGuid = mod_guid;
                        lea_db._leaID = Convert.ToInt32(mod_id);
                        lea_db._leaStratFrom = DateTime.Parse(mod_dates);
                        lea_db._leaEndAt = DateTime.Parse(mod_datee);
                        lea_db._leaDuration = Convert.ToDecimal(mod_leave_type_date);
                        lea_db._leaRemark = mod_ps;
                        //lea_db._leaAskerName = dt_authuser.Rows[0]["first_name"].ToString().Trim();
                        lea_db._leaAskerName = "王胖爺";
                        lea_db._leaLeaveTypeId = Convert.ToInt32(mod_leave_type);
                        lea_db._leaAppilcantId = mod_empno;
                        if (mod_leave_type2 == "")
                            lea_db._leaLeaveType2 = Convert.ToInt32("0");
                        else
                            lea_db._leaLeaveType2 = Convert.ToInt32(mod_leave_type2);
                        if (mod_leave_type2_date == "")
                            lea_db._leaDuration2 = Convert.ToDecimal("0");
                        else
                            lea_db._leaDuration2 = Convert.ToDecimal(mod_leave_type2_date);
                        lea_db._leaModdifyId = "";
                        lea_db._str_type_date = mod_leave_type_date;
                        lea_db._str_type2_date = mod_leave_type2_date;
                        lea_db._str_days = mod_date;
                        lea_db.UpdateLeaveAndDetail();
                        context.Response.Write("ok");
                    }


                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }

                break;
            //刪除
            case "del_data":
                string del_guid = string.IsNullOrEmpty(context.Request.Form["del_guid"]) ? "" : context.Request.Form["del_guid"].ToString().Trim();
                try {
                    lea_db._leaGuid = del_guid;
                    lea_db.DeleteLeaveAndDetail();
                    context.Response.Write("ok");
                } catch (Exception ex) {
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