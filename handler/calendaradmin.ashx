<%@ WebHandler Language="C#" Class="calendaradmin" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;

public class calendaradmin : IHttpHandler
{
    //Holiday 欄位
    public class TooL
    {
        public string dayGuid { get; set; }//GUID
        public string dayName { get; set; }//假日名稱
        public string dayDate { get; set; }//假日日期
        public string dayPs { get; set; }//備註
        //建立者、修改者、狀態、建立跟修改時間目前不需要顯示在畫面上
        //public string dayCreatId { get; set; }//建立者
        //public string dayModifyId { get; set; }//修改者
        //public string dayStatus { get; set; }//狀態 A:正常 D:刪除
        //public string dayCreatDate { get; set; }//建立時間
        //public string dayModifyDate { get; set; }//修改時間 
    }

    //sy_SalaryRange 欄位 計薪週期
    public class srTooL
    {
        public string sr_Guid { get; set; }//GUID
        public string sr_Year { get; set; }//年度
        public string sr_BeginDate { get; set; }//週期起
        public string sr_Enddate { get; set; }//週期迄
        public string sr_SalaryDate { get; set; }//發薪日
        public string sr_Ps { get; set; }//備註
        //狀態目前不需要顯示在畫面上
        //public string sr_Status { get; set; }//狀態
    }

    Holiday_DB h_db = new Holiday_DB();
    SalaryRange_DB s_db = new SalaryRange_DB();
    public void ProcessRequest (HttpContext context)
    {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            case "call_holidaydata":
                string str_date = string.IsNullOrEmpty(context.Request.Form["str_date"]) ? "" : context.Request.Form["str_date"].ToString().Trim();
                string str_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                h_db._str_keyword = str_keyword;
                h_db._str_date = str_date;
                h_db._dayGuid = str_guid;
                DataTable dt_holiday = h_db.SelectHoliday();
                if (dt_holiday.Rows.Count > 0)
                {
                    List<TooL> eList = new List<TooL>();
                    for (int i = 0; i < dt_holiday.Rows.Count; i++)
                    {
                        TooL e = new TooL();
                        e.dayGuid = dt_holiday.Rows[i]["dayGuid"].ToString().Trim();//Guid
                        e.dayName = dt_holiday.Rows[i]["dayName"].ToString().Trim();//假日名稱
                        e.dayDate = dt_holiday.Rows[i]["dayDate"].ToString().Trim();//假日日期
                        e.dayPs = dt_holiday.Rows[i]["dayPs"].ToString().Trim();//備註
                        //建立者、修改者、狀態、建立跟修改時間目前不需要顯示在畫面上
                        //e.dayCreatId = dt_holiday.Rows[i]["dayCreatId"].ToString().Trim();//建立者
                        //e.dayModifyId = dt_holiday.Rows[i]["dayModifyId"].ToString().Trim();//修改者
                        //e.dayStatus = dt_holiday.Rows[i]["dayStatus"].ToString().Trim();//狀態 A:正常 D:刪除
                        //e.dayCreatDate =  Convert.ToDateTime(dt_holiday.Rows[i]["dayCreatDate"].ToString().Trim()).ToString("yyyy/MM/dd H:mm:ss");//建立時間
                        //e.dayModifyDate =  Convert.ToDateTime(dt_holiday.Rows[i]["dayModifyDate"].ToString().Trim()).ToString("yyyy/MM/dd H:mm:ss");//修改時間
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
            //國定假日新增 or 修改 
            case "mod_holidaydata":
                string str_mod_type = string.IsNullOrEmpty(context.Request.Form["str_mod_type"]) ? "" : context.Request.Form["str_mod_type"].ToString().Trim();
                string str_mod_guid = string.IsNullOrEmpty(context.Request.Form["str_mod_guid"]) ? "" : context.Request.Form["str_mod_guid"].ToString().Trim();
                string str_mod_date = string.IsNullOrEmpty(context.Request.Form["str_mod_date"]) ? "" : context.Request.Form["str_mod_date"].ToString().Trim();
                string str_mod_ps = string.IsNullOrEmpty(context.Request.Form["str_mod_ps"]) ? "" : context.Request.Form["str_mod_ps"].ToString().Trim();
                string str_mod_datename = string.IsNullOrEmpty(context.Request.Form["str_mod_datename"]) ? "" : context.Request.Form["str_mod_datename"].ToString().Trim();

                h_db._dayDate = str_mod_date;
                h_db._dayPs = str_mod_ps;
                h_db._dayName = str_mod_datename;

                if (str_mod_type == "修改")
                {
                    h_db._dayCreatId = "王胖爺";//目前還沒有登入的這塊 先寫死
                    h_db._dayGuid = str_mod_guid;
                    h_db.UpdateHoliday();
                }
                else if (str_mod_type == "新增")
                {
                    h_db._dayModifyId = "王胖爺";//目前還沒有登入的這塊 先寫死
                    h_db._dayGuid=Guid.NewGuid().ToString();
                    h_db.InsertHoliday();
                }
                else {
                    context.Response.Write("error");
                }
                break;
            //刪除 holiday (並不是真的刪除 是updat status欄位)
            case "del_holidaydata":
                string str_holiday_del_guid = string.IsNullOrEmpty(context.Request.Form["str_holiday_del_guid"]) ? "" : context.Request.Form["str_holiday_del_guid"].ToString().Trim();
                h_db._dayGuid = str_holiday_del_guid;
                h_db._dayModifyId = "王胖爺";//目前還沒有登入的這塊 先寫死
                try
                {
                    h_db.DeleteHoliday();
                    context.Response.Write("OK");
                }
                catch {
                    context.Response.Write("error");
                }
                break;

            //撈計薪週期資料
            case "call_srdata":
                string str_sr_year = string.IsNullOrEmpty(context.Request.Form["str_sr_year"]) ? "" : context.Request.Form["str_sr_year"].ToString().Trim();
                string str_sr_paydate = string.IsNullOrEmpty(context.Request.Form["str_sr_paydate"]) ? "" : context.Request.Form["str_sr_paydate"].ToString().Trim();
                string str_sr_dates = string.IsNullOrEmpty(context.Request.Form["str_sr_dates"]) ? "" : context.Request.Form["str_sr_dates"].ToString().Trim();
                string str_sr_datee = string.IsNullOrEmpty(context.Request.Form["str_sr_datee"]) ? "" : context.Request.Form["str_sr_datee"].ToString().Trim();

                s_db._sr_Year = str_sr_year;
                s_db._sr_SalaryDate = str_sr_paydate;
                s_db._sr_BeginDate = str_sr_dates;
                s_db._sr_Enddate = str_sr_datee;
                DataTable dt_sr = s_db.SelectSR();
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
                        e.sr_SalaryDate = dt_sr.Rows[i]["sr_SalaryDate"].ToString().Trim();//發薪日
                        e.sr_Ps = dt_sr.Rows[i]["sr_Ps"].ToString().Trim();//備註
                        //狀態目前不需要顯示在畫面上
                        //e.sr_Status = dt_sr.Rows[i]["sr_Status"].ToString().Trim();//狀態
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
            //新增 or 修改 計薪週期
            case "mod_srdata":
                string str_sr_mod_type = string.IsNullOrEmpty(context.Request.Form["str_mod_type"]) ? "" : context.Request.Form["str_mod_type"].ToString().Trim();
                string str_sr_mod_guid = string.IsNullOrEmpty(context.Request.Form["str_mod_guid"]) ? "" : context.Request.Form["str_mod_guid"].ToString().Trim();
                string str_sr_mod_year = string.IsNullOrEmpty(context.Request.Form["str_mod_year"]) ? "" : context.Request.Form["str_mod_year"].ToString().Trim();
                string str_sr_mod_payday = string.IsNullOrEmpty(context.Request.Form["str_mod_paydate"]) ? "" : context.Request.Form["str_mod_paydate"].ToString().Trim();
                string str_sr_mod_dates = string.IsNullOrEmpty(context.Request.Form["str_mod_dates"]) ? "" : context.Request.Form["str_mod_dates"].ToString().Trim();
                string str_sr_mod_datee = string.IsNullOrEmpty(context.Request.Form["str_mod_datee"]) ? "" : context.Request.Form["str_mod_datee"].ToString().Trim();
                string str_sr_mod_ps = string.IsNullOrEmpty(context.Request.Form["str_mod_ps"]) ? "" : context.Request.Form["str_mod_ps"].ToString().Trim();

                s_db._sr_Year = str_sr_mod_year;
                s_db._sr_SalaryDate = str_sr_mod_payday;
                s_db._sr_BeginDate = str_sr_mod_dates;
                s_db._sr_Enddate = str_sr_mod_datee;
                s_db._sr_Ps = str_sr_mod_ps;

                if (str_sr_mod_type == "修改")
                {
                    s_db._sr_Guid = str_sr_mod_guid;
                    try {
                        s_db.UpdateSR();
                        context.Response.Write("OK");
                    } catch{ }

                }
                else if (str_sr_mod_type == "新增")
                {
                    s_db._sr_Guid=Guid.NewGuid().ToString();
                        try {
                        s_db.InsertSR();
                        context.Response.Write("OK");
                    } catch{ }
                }
                else {
                    context.Response.Write("error");
                }
                break;
            //刪除 sr (並不是真的刪除 是updat status欄位)
            case "del_srdata":
                string str_sr_del_guid = string.IsNullOrEmpty(context.Request.Form["str_sr_del_guid"]) ? "" : context.Request.Form["str_sr_del_guid"].ToString().Trim();
                s_db._sr_Guid = str_sr_del_guid;
                try
                {
                    s_db.DeleteSR();
                    context.Response.Write("OK");
                }
                catch {
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