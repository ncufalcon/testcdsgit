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

    Holiday_DB h_db = new Holiday_DB();
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
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}