﻿<%@ WebHandler Language="C#" Class="page_hourlyadmin" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;

public class page_hourlyadmin : IHttpHandler {
    //sy_BasicSalary 欄位 代碼檔
    public class bsTooL
    {
        public string bsGuid { get; set; }//guid
        public string bsSalary { get; set; }//底薪
        public string bsOther { get; set; }//職能加給
    }
    //sy_SalaryFormula 欄位 代碼檔
    public class sfTooL
    {
        public string sfGuid { get; set; }//guid
        public string sfBasicSalary { get; set; }//課稅所得
        public string sfWelfare { get; set; }//代扣福利金%數
    }
    //sy_BasicSalary 欄位
    public class siTooL
    {
        public string siGuid { get; set; }
        public string siItemCode { get; set; }
        public string siItemName { get; set; }
        public string siAdd { get; set; }
        public string siInsurance { get; set; }
        public string siBenefit { get; set; }
        public string siSupplementaryPremium { get; set; }
        public string siIncomeTax { get; set; }
        public string siCreatId { get; set; }
        public string siModifyId { get; set; }
        public string siStatus { get; set; }
        public string siCreatDate { get; set; }
        public string siModifyDate { get; set; }
        public string siRef { get; set; }
        public string siRefcom { get; set; }
    }
    //sy_OverTime 欄位
    public class oTooL
    {
        public string oGuid { get; set; }
        public string oMale { get; set; }
        public string oFemale { get; set; }
        public string oFixed { get; set; }
        public string oOverTime1 { get; set; }
        public string oOverTime2Start { get; set; }
        public string oOverTime2End { get; set; }
        public string oOverTime3 { get; set; }
        public string oOverTimePay1 { get; set; }
        public string oOverTimePay2 { get; set; }
        public string oOverTimePay3 { get; set; }
        public string oOffDay1 { get; set; }
        public string oOffDay2Start { get; set; }
        public string oOffDay2End { get; set; }
        public string oOffDay3Start { get; set; }
        public string oOffDay3End { get; set; }
        public string oOffDayPay1 { get; set; }
        public string oOffDayPay2 { get; set; }
        public string oOffDayPay3 { get; set; }
        public string oPublickHoliday { get; set; }
    }
    //sy_TaxationItem sy_TaxationFormula 欄位
    public class tiTooL
    {
        public string tiGuid { get; set; }
        public string tiItem { get; set; }
        public string tiFormula { get; set; }
        public string sfBasicSalary { get; set; }
        //public string tfGuid { get; set; }
        //public string tfTiGuid { get; set; }
        //public string tfClass { get; set; }
        //public string tfItem { get; set; }
        //public string tfCalculation { get; set; }
        //public string tfOrder { get; set; }
        //public string tfCreateID { get; set; }
        //public string tfCreateDate { get; set; }
        //public string tfModifyID { get; set; }
        //public string tfModifyDate { get; set; }
    }
    //sy_PayHoliday 欄位
    public class phTooL
    {
        public string phGuid { get; set; }
        public string phCode { get; set; }
        public string phName { get; set; }
        public string phBasic { get; set; }
        public string phPs { get; set; }
        public string phStatus { get; set; }
    }
    sy_BasicSalary_DB bs_db = new sy_BasicSalary_DB();
    sy_SalaryFormula sf_db = new sy_SalaryFormula();
    sy_SalaryItem_DB si_db = new sy_SalaryItem_DB();
    sy_OverTime_DB o_db = new sy_OverTime_DB();
    sy_Taxation_DB ti_db = new sy_Taxation_DB();
    CodeTable_DB code_db = new CodeTable_DB();
    sy_PayHoliday_DB ph_db = new sy_PayHoliday_DB();
    public void ProcessRequest (HttpContext context)
    {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            //撈時薪設定資料
            case "load_hourdata":
                DataTable dt_bsdata = bs_db.SelectBasicSalary();
                if (dt_bsdata.Rows.Count > 0)
                {
                    List<bsTooL> bsList = new List<bsTooL>();
                    for (int i = 0; i < dt_bsdata.Rows.Count; i++)
                    {
                        bsTooL e = new bsTooL();
                        e.bsGuid = dt_bsdata.Rows[i]["bsGuid"].ToString().Trim();
                        e.bsSalary = dt_bsdata.Rows[i]["bsSalary"].ToString().Trim();
                        e.bsOther = dt_bsdata.Rows[i]["bsOther"].ToString().Trim();
                        bsList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(bsList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //修改時薪設定資料
            case "mod_hourdata":
                string mod_hour_salary = string.IsNullOrEmpty(context.Request.Form["mod_hour_salary"]) ? "" : context.Request.Form["mod_hour_salary"].ToString().Trim();
                string mod_hour_other = string.IsNullOrEmpty(context.Request.Form["mod_hour_other"]) ? "" : context.Request.Form["mod_hour_other"].ToString().Trim();
                string mod_hour_guid = string.IsNullOrEmpty(context.Request.Form["mod_hour_guid"]) ? "" : context.Request.Form["mod_hour_guid"].ToString().Trim();
                bs_db._bsOther = mod_hour_other;
                bs_db._bsSalary = mod_hour_salary;
                try
                {
                    if (mod_hour_guid == "")
                    {
                        //新增
                        bs_db._bsGuid = Guid.NewGuid().ToString();
                        bs_db.InsertBasicSalary();
                    }
                    else
                    {
                        //修改
                        bs_db._bsGuid = mod_hour_guid;
                        bs_db.UpdateBasicSalary();
                    }
                    context.Response.Write("ok");
                }
                catch (Exception ex){ context.Response.Write("error"); }
                break;
            //撈 薪資計算公式設定 參數設定 資料
            case "load_paysetdata":
                DataTable dt_sfdata = sf_db.SelectSalaryFormula();
                if (dt_sfdata.Rows.Count > 0)
                {
                    List<sfTooL> sfList = new List<sfTooL>();
                    for (int i = 0; i < dt_sfdata.Rows.Count; i++)
                    {
                        sfTooL e = new sfTooL();
                        e.sfGuid = dt_sfdata.Rows[i]["sfGuid"].ToString().Trim();
                        e.sfBasicSalary = dt_sfdata.Rows[i]["sfBasicSalary"].ToString().Trim();
                        e.sfWelfare = dt_sfdata.Rows[i]["sfWelfare"].ToString().Trim();
                        sfList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(sfList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            // 薪資計算公式設定 參數設定 修改 新增
            case "mod_paysetdata":
                string mod_payset_value = string.IsNullOrEmpty(context.Request.Form["mod_payset_value"]) ? "" : context.Request.Form["mod_payset_value"].ToString().Trim();
                string mod_payset_type = string.IsNullOrEmpty(context.Request.Form["mod_payset_type"]) ? "" : context.Request.Form["mod_payset_type"].ToString().Trim();
                DataTable dt_sel_sf = sf_db.SelectSalaryFormula();
                try
                {
                    sf_db._sfupdatetype = mod_payset_type;
                    if (dt_sel_sf.Rows.Count > 0)
                    {
                        if (mod_payset_type == "1")
                        {
                            //修改課稅所得
                            sf_db._sfBasicSalary = Convert.ToInt32(mod_payset_value);
                            sf_db.UpdateSalaryFormula();
                        }
                        else
                        {
                            //修改代扣福利金%數
                            sf_db._sfWelfare = Convert.ToDecimal(mod_payset_value);
                            sf_db.UpdateSalaryFormula();
                        }
                    }
                    else {
                        //新增
                        sf_db._sfGuid = Guid.NewGuid().ToString();
                        if (mod_payset_type == "1") {
                            sf_db._sfBasicSalary = Convert.ToInt32(mod_payset_value);
                        }
                        if (mod_payset_type == "2") {
                            sf_db._sfWelfare = Convert.ToDecimal(mod_payset_value);
                        }
                        sf_db.InsertSalaryFormula();
                    }
                    context.Response.Write("ok");
                }
                catch (Exception ex){ context.Response.Write("error"); }
                break;
            //撈薪資項目設定 資料
            case "load_sidata":
                string str_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_guid= string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                si_db._str_keyword = str_keyword;
                si_db._siGuid = str_guid;
                DataTable dt_si_data = si_db.SelectSalaryItem();
                if (dt_si_data.Rows.Count > 0)
                {
                    List<siTooL> siList = new List<siTooL>();
                    for (int i = 0; i < dt_si_data.Rows.Count; i++)
                    {
                        siTooL e = new siTooL();
                        e.siGuid = dt_si_data.Rows[i]["siGuid"].ToString().Trim();
                        e.siItemCode = dt_si_data.Rows[i]["siItemCode"].ToString().Trim();
                        e.siItemName = dt_si_data.Rows[i]["siItemName"].ToString().Trim();
                        e.siAdd = dt_si_data.Rows[i]["siAdd"].ToString().Trim();
                        e.siInsurance = dt_si_data.Rows[i]["siInsurance"].ToString().Trim();
                        e.siBenefit = dt_si_data.Rows[i]["siBenefit"].ToString().Trim();
                        e.siSupplementaryPremium = dt_si_data.Rows[i]["siSupplementaryPremium"].ToString().Trim();
                        e.siIncomeTax = dt_si_data.Rows[i]["siIncomeTax"].ToString().Trim();
                        e.siIncomeTax = dt_si_data.Rows[i]["siIncomeTax"].ToString().Trim();
                        e.siRef = dt_si_data.Rows[i]["siRef"].ToString().Trim();
                        e.siRefcom = dt_si_data.Rows[i]["siRefcom"].ToString().Trim();
                        siList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(siList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //薪資項目設定資料 新增/修改
            case "mod_sidata":
                string mod_si_code = string.IsNullOrEmpty(context.Request.Form["mod_si_code"]) ? "" : context.Request.Form["mod_si_code"].ToString().Trim();
                string mod_si_name = string.IsNullOrEmpty(context.Request.Form["mod_si_name"]) ? "" : context.Request.Form["mod_si_name"].ToString().Trim();
                string mod_si_Insurance = string.IsNullOrEmpty(context.Request.Form["mod_si_Insurance"]) ? "" : context.Request.Form["mod_si_Insurance"].ToString().Trim();
                string mod_si_itemadd = string.IsNullOrEmpty(context.Request.Form["mod_si_itemadd"]) ? "" : context.Request.Form["mod_si_itemadd"].ToString().Trim();
                string mod_si_itembenefit = string.IsNullOrEmpty(context.Request.Form["mod_si_itembenefit"]) ? "" : context.Request.Form["mod_si_itembenefit"].ToString().Trim();
                string mod_si_itemsup = string.IsNullOrEmpty(context.Request.Form["mod_si_itemsup"]) ? "" : context.Request.Form["mod_si_itemsup"].ToString().Trim();
                string mod_si_itemtax = string.IsNullOrEmpty(context.Request.Form["mod_si_itemtax"]) ? "" : context.Request.Form["mod_si_itemtax"].ToString().Trim();
                string mod_si_itemref = string.IsNullOrEmpty(context.Request.Form["mod_si_itemref"]) ? "" : context.Request.Form["mod_si_itemref"].ToString().Trim();
                string mod_si_itemrefcom = string.IsNullOrEmpty(context.Request.Form["mod_si_itemrefcom"]) ? "" : context.Request.Form["mod_si_itemrefcom"].ToString().Trim();
                string mod_si_itemguid = string.IsNullOrEmpty(context.Request.Form["mod_si_itemguid"]) ? "" : context.Request.Form["mod_si_itemguid"].ToString().Trim();
                string mod_si_type = string.IsNullOrEmpty(context.Request.Form["mod_si_type"]) ? "" : context.Request.Form["mod_si_type"].ToString().Trim();
                try
                {
                    si_db._siItemCode = mod_si_code;
                    si_db._siItemName = mod_si_name;
                    si_db._siAdd = mod_si_itemadd;
                    si_db._siInsurance = mod_si_Insurance;
                    si_db._siBenefit = mod_si_itembenefit;
                    si_db._siSupplementaryPremium = mod_si_itemsup;
                    si_db._siIncomeTax = mod_si_itemtax;
                    si_db._siRef = mod_si_itemref;
                    si_db._siRefcom = mod_si_itemrefcom;

                    DataTable dt_chkcode = si_db.ChksiItemCode();
                    DataTable dt_refcom_add = si_db.ChksiItemCodeRefcom();
                    if (dt_chkcode.Rows.Count > 0 && mod_si_type == "新增")
                    {
                        context.Response.Write("notonly");
                    }
                    else
                    {
                        if (mod_si_type == "新增")
                        {
                            if (dt_refcom_add.Rows.Count > 0)
                            {
                                context.Response.Write("si_refcom_notonly_add");
                            }
                            else {
                                si_db._siGuid = Guid.NewGuid().ToString();
                                si_db._siCreatId = "王胖爺";
                                si_db.InsertSalaryItem();
                                context.Response.Write("ok");
                            }
                        }
                        else
                        {//修改
                            si_db._siGuid = mod_si_itemguid;
                            DataTable dt_refcom_mod = si_db.ChksiItemCodeRefcom();
                            if (dt_refcom_add.Rows.Count > 0)
                            {
                                if (dt_refcom_mod.Rows.Count == 0) {
                                    context.Response.Write("si_refcom_notonly_mod");
                                }

                            }
                            else {
                                si_db._siModifyId = "王胖爺";
                                si_db.UpdateSalaryItem();
                                context.Response.Write("ok");
                            }

                        }

                    }

                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }

                break;
            //薪資項目設定 刪除
            case "del_sidata":
                string del_si_itemguid = string.IsNullOrEmpty(context.Request.Form["del_si_itemguid"]) ? "" : context.Request.Form["del_si_itemguid"].ToString().Trim();
                si_db._siGuid = del_si_itemguid;
                try {
                    si_db.DeleteSalaryItem();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //撈加班費設定 資料
            case "load_odata":
                DataTable dt_odata = o_db.SelectOverTime();
                if (dt_odata.Rows.Count > 0)
                {
                    List<oTooL> oList = new List<oTooL>();
                    for (int i = 0; i < dt_odata.Rows.Count; i++)
                    {
                        oTooL e = new oTooL();
                        e.oGuid = dt_odata.Rows[i]["oGuid"].ToString().Trim();
                        e.oMale = dt_odata.Rows[i]["oMale"].ToString().Trim();
                        e.oFemale = dt_odata.Rows[i]["oFemale"].ToString().Trim();
                        e.oFixed = dt_odata.Rows[i]["oFixed"].ToString().Trim();
                        e.oOverTime1 = dt_odata.Rows[i]["oOverTime1"].ToString().Trim();
                        e.oOverTime2Start = dt_odata.Rows[i]["oOverTime2Start"].ToString().Trim();
                        e.oOverTime2End = dt_odata.Rows[i]["oOverTime2End"].ToString().Trim();
                        e.oOverTime3 = dt_odata.Rows[i]["oOverTime3"].ToString().Trim();
                        e.oOverTimePay1 = dt_odata.Rows[i]["oOverTimePay1"].ToString().Trim();
                        e.oOverTimePay2 = dt_odata.Rows[i]["oOverTimePay2"].ToString().Trim();
                        e.oOverTimePay3 = dt_odata.Rows[i]["oOverTimePay3"].ToString().Trim();
                        e.oOffDay1 = dt_odata.Rows[i]["oOffDay1"].ToString().Trim();
                        e.oOffDay2Start = dt_odata.Rows[i]["oOffDay2Start"].ToString().Trim();
                        e.oOffDay2End = dt_odata.Rows[i]["oOffDay2End"].ToString().Trim();
                        e.oOffDay3Start = dt_odata.Rows[i]["oOffDay3Start"].ToString().Trim();
                        e.oOffDay3End = dt_odata.Rows[i]["oOffDay3End"].ToString().Trim();
                        e.oOffDayPay1 = dt_odata.Rows[i]["oOffDayPay1"].ToString().Trim();
                        e.oOffDayPay2 = dt_odata.Rows[i]["oOffDayPay2"].ToString().Trim();
                        e.oOffDayPay3 = dt_odata.Rows[i]["oOffDayPay3"].ToString().Trim();
                        e.oPublickHoliday = dt_odata.Rows[i]["oPublickHoliday"].ToString().Trim();
                        oList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(oList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else
                {
                    context.Response.Write("nodata");
                }
                break;
            //加班費設定 修改
            case "mod_odata":
                string mod_oGuid = string.IsNullOrEmpty(context.Request.Form["mod_oGuid"]) ? "" : context.Request.Form["mod_oGuid"].ToString().Trim();
                string mod_oMale = string.IsNullOrEmpty(context.Request.Form["mod_oMale"]) ? "0" : context.Request.Form["mod_oMale"].ToString().Trim();
                string mod_oFemale = string.IsNullOrEmpty(context.Request.Form["mod_oFemale"]) ? "0" : context.Request.Form["mod_oFemale"].ToString().Trim();
                string mod_oFixed = string.IsNullOrEmpty(context.Request.Form["mod_oFixed"]) ? "0" : context.Request.Form["mod_oFixed"].ToString().Trim();
                string mod_oOverTime1 = string.IsNullOrEmpty(context.Request.Form["mod_oOverTime1"]) ? "0" : context.Request.Form["mod_oOverTime1"].ToString().Trim();
                string mod_oOverTime2Start = string.IsNullOrEmpty(context.Request.Form["mod_oOverTime2Start"]) ? "0" : context.Request.Form["mod_oOverTime2Start"].ToString().Trim();
                string mod_oOverTime2End = string.IsNullOrEmpty(context.Request.Form["mod_oOverTime2End"]) ? "0" : context.Request.Form["mod_oOverTime2End"].ToString().Trim();
                string mod_oOverTime3 = string.IsNullOrEmpty(context.Request.Form["mod_oOverTime3"]) ? "0" : context.Request.Form["mod_oOverTime3"].ToString().Trim();
                string mod_oOverTimePay1 = string.IsNullOrEmpty(context.Request.Form["mod_oOverTimePay1"]) ? "0" : context.Request.Form["mod_oOverTimePay1"].ToString().Trim();
                string mod_oOverTimePay2 = string.IsNullOrEmpty(context.Request.Form["mod_oOverTimePay2"]) ? "0" : context.Request.Form["mod_oOverTimePay2"].ToString().Trim();
                string mod_oOverTimePay3 = string.IsNullOrEmpty(context.Request.Form["mod_oOverTimePay3"]) ? "0" : context.Request.Form["mod_oOverTimePay3"].ToString().Trim();
                string mod_oOffDay1 = string.IsNullOrEmpty(context.Request.Form["mod_oOffDay1"]) ? "0" : context.Request.Form["mod_oOffDay1"].ToString().Trim();
                string mod_oOffDay2Start = string.IsNullOrEmpty(context.Request.Form["mod_oOffDay2Start"]) ? "0" : context.Request.Form["mod_oOffDay2Start"].ToString().Trim();
                string mod_oOffDay2End = string.IsNullOrEmpty(context.Request.Form["mod_oOffDay2End"]) ? "0" : context.Request.Form["mod_oOffDay2End"].ToString().Trim();
                string mod_oOffDay3Start = string.IsNullOrEmpty(context.Request.Form["mod_oOffDay3Start"]) ? "0" : context.Request.Form["mod_oOffDay3Start"].ToString().Trim();
                string mod_oOffDay3End = string.IsNullOrEmpty(context.Request.Form["mod_oOffDay3End"]) ? "0" : context.Request.Form["mod_oOffDay3End"].ToString().Trim();
                string mod_oOffDayPay1 = string.IsNullOrEmpty(context.Request.Form["mod_oOffDayPay1"]) ? "0" : context.Request.Form["mod_oOffDayPay1"].ToString().Trim();
                string mod_oOffDayPay2 = string.IsNullOrEmpty(context.Request.Form["mod_oOffDayPay2"]) ? "0" : context.Request.Form["mod_oOffDayPay2"].ToString().Trim();
                string mod_oOffDayPay3 = string.IsNullOrEmpty(context.Request.Form["mod_oOffDayPay3"]) ? "0" : context.Request.Form["mod_oOffDayPay3"].ToString().Trim();
                string mod_oPublickHoliday = string.IsNullOrEmpty(context.Request.Form["mod_oPublickHoliday"]) ? "0" : context.Request.Form["mod_oPublickHoliday"].ToString().Trim();
                try {
                    o_db._oMale = Convert.ToInt32(mod_oMale);
                    o_db._oFemale = Convert.ToInt32(mod_oFemale);
                    o_db._oFixed = Convert.ToInt32(mod_oFixed);
                    o_db._oOverTime1 = Convert.ToInt32(mod_oOverTime1);
                    o_db._oOverTime2Start = Convert.ToInt32(mod_oOverTime2Start);
                    o_db._oOverTime2End = Convert.ToInt32(mod_oOverTime2End);
                    o_db._oOverTime3 = Convert.ToInt32(mod_oOverTime3);
                    o_db._oOverTimePay1 = Convert.ToInt32(mod_oOverTimePay1);
                    o_db._oOverTimePay2 = Convert.ToInt32(mod_oOverTimePay2);
                    o_db._oOverTimePay3 = Convert.ToInt32(mod_oOverTimePay3);
                    o_db._oOffDay1 = Convert.ToInt32(mod_oOffDay1);
                    o_db._oOffDay2Start = Convert.ToInt32(mod_oOffDay2Start);
                    o_db._oOffDay2End = Convert.ToInt32(mod_oOffDay2End);
                    o_db._oOffDay3Start = Convert.ToInt32(mod_oOffDay3Start);
                    o_db._oOffDay3End = Convert.ToInt32(mod_oOffDay3End);
                    o_db._oOffDayPay1 = Convert.ToInt32(mod_oOffDayPay1);
                    o_db._oOffDayPay2 = Convert.ToInt32(mod_oOffDayPay2);
                    o_db._oOffDayPay3 = Convert.ToInt32(mod_oOffDayPay3);
                    o_db._oPublickHoliday = Convert.ToInt32(mod_oPublickHoliday);
                    if (mod_oGuid == "")
                    {
                        //新增
                        o_db._oGuid = Guid.NewGuid().ToString();
                        o_db.InsertOverTime();
                    }
                    else {
                        //修改
                        o_db._oGuid = mod_oGuid;
                        o_db.UpdateOverTime();
                    }
                    context.Response.Write("ok");
                } catch (Exception ex){ context.Response.Write("error"); }
                break;
            //撈課稅所得(選項)資料
            case "load_tidata":
                string str_ti_guid = string.IsNullOrEmpty(context.Request.Form["str_ti_guid"]) ? "" : context.Request.Form["str_ti_guid"].ToString().Trim();
                ti_db._tiGuid = str_ti_guid;
                DataTable dt_ti = ti_db.SelectTaxationItem();//撈項目
                DataTable dt_sf = sf_db.SelectSalaryFormula();//撈基本薪資
                DataTable dt_tf;//撈項目底下的計算公式
                if (dt_ti.Rows.Count > 0)
                {
                    List<tiTooL> tiList = new List<tiTooL>();
                    for (int i = 0; i < dt_ti.Rows.Count; i++)
                    {
                        tiTooL e = new tiTooL();
                        e.tiGuid = dt_ti.Rows[i]["tiGuid"].ToString().Trim();
                        e.tiItem = dt_ti.Rows[i]["tiItem"].ToString().Trim();
                        e.tiFormula = dt_ti.Rows[i]["tiFormula"].ToString().Trim();
                        //e.tfGuid = dt_ti.Rows[i]["tfGuid"].ToString().Trim();
                        //e.tfTiGuid = dt_ti.Rows[i]["tfTiGuid"].ToString().Trim();
                        //e.tfClass = dt_ti.Rows[i]["tfClass"].ToString().Trim();
                        //e.tfItem = dt_ti.Rows[i]["tfItem"].ToString().Trim();
                        //e.tfCalculation = dt_ti.Rows[i]["tfCalculation"].ToString().Trim();
                        //e.tfOrder = dt_ti.Rows[i]["tfOrder"].ToString().Trim();
                        if (dt_sf.Rows.Count > 0)
                        {
                            e.sfBasicSalary = dt_sf.Rows[0]["sfBasicSalary"].ToString().Trim();
                        }
                        else {
                            e.sfBasicSalary = "";
                        }
                        tiList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(tiList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //修改課稅所得 資料
            case "mod_tidata":
                string mod_ti_guid1 = string.IsNullOrEmpty(context.Request.Form["mod_ti_guid1"]) ? "" : context.Request.Form["mod_ti_guid1"].ToString().Trim();
                string mod_ti_guid2 = string.IsNullOrEmpty(context.Request.Form["mod_ti_guid2"]) ? "" : context.Request.Form["mod_ti_guid2"].ToString().Trim();
                string mod_ti_str1 = string.IsNullOrEmpty(context.Request.Form["mod_ti_str1"]) ? "" : context.Request.Form["mod_ti_str1"].ToString().Trim();
                string mod_ti_str2 = string.IsNullOrEmpty(context.Request.Form["mod_ti_str2"]) ? "" : context.Request.Form["mod_ti_str2"].ToString().Trim();
                try {
                    ti_db._tiGuid = mod_ti_guid1;
                    ti_db._tiFormula = mod_ti_str1;
                    ti_db.UpdateTaxationItem();
                    ti_db._tiGuid = mod_ti_guid2;
                    ti_db._tiFormula = mod_ti_str2;
                    ti_db.UpdateTaxationItem();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //撈 薪資計算公式-課稅所得公式維護-參數選擇-項目 code_group="15"
            case "load_gtype15":
                DataTable dt_codegroup = code_db.getGroup("15");
                if (dt_codegroup.Rows.Count > 0)
                {
                    string response_str = "";
                    for (int i=0;i<dt_codegroup.Rows.Count;i++) {
                        if (i == 0) {
                            response_str += dt_codegroup.Rows[i]["code_desc"].ToString().Trim();
                        } else {
                            response_str += ","+dt_codegroup.Rows[i]["code_desc"].ToString().Trim();
                        }
                    }
                    context.Response.Write(response_str);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //撈給薪假設定資料
            case "load_phdata":
                string str_ph_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_ph_guid = string.IsNullOrEmpty(context.Request.Form["str_ph_guid"]) ? "" : context.Request.Form["str_ph_guid"].ToString().Trim();
                ph_db._str_keyword = str_ph_keyword;
                ph_db._phGuid = str_ph_guid;
                DataTable dt_phdata = ph_db.SelectPayHoliday();
                if (dt_phdata.Rows.Count > 0)
                {
                    List<phTooL> phList = new List<phTooL>();
                    for (int i = 0; i < dt_phdata.Rows.Count; i++)
                    {
                        phTooL e = new phTooL();
                        e.phGuid = dt_phdata.Rows[i]["phGuid"].ToString().Trim();
                        e.phCode = dt_phdata.Rows[i]["phCode"].ToString().Trim();
                        e.phName = dt_phdata.Rows[i]["phName"].ToString().Trim();
                        e.phBasic = dt_phdata.Rows[i]["phBasic"].ToString().Trim();
                        e.phPs = dt_phdata.Rows[i]["phPs"].ToString().Trim();
                        e.phStatus = dt_phdata.Rows[i]["phStatus"].ToString().Trim();
                        phList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(phList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else
                {
                    context.Response.Write("nodata");
                }
                break;
            //給薪假設定 修改
            case "mod_phdata":
                string mod_ph_guid = string.IsNullOrEmpty(context.Request.Form["mod_ph_guid"]) ? "" : context.Request.Form["mod_ph_guid"].ToString().Trim();
                string mod_ph_name = string.IsNullOrEmpty(context.Request.Form["mod_ph_name"]) ? "" : context.Request.Form["mod_ph_name"].ToString().Trim();
                string mod_ph_basic = string.IsNullOrEmpty(context.Request.Form["mod_ph_basic"]) ? "" : context.Request.Form["mod_ph_basic"].ToString().Trim();
                string mod_ph_ps = string.IsNullOrEmpty(context.Request.Form["mod_ph_ps"]) ? "" : context.Request.Form["mod_ph_ps"].ToString().Trim();
                //string mod_ph_type = string.IsNullOrEmpty(context.Request.Form["mod_ph_type"]) ? "" : context.Request.Form["mod_ph_type"].ToString().Trim();
                try {
                    ph_db._phGuid = mod_ph_guid;
                    ph_db._phName = mod_ph_name;
                    ph_db._phBasic = mod_ph_basic;
                    ph_db._phPs = mod_ph_ps;
                    DataTable dt_chk_name = ph_db.SelectPayHolidayNAme();
                    if (dt_chk_name.Rows.Count > 0 && dt_chk_name.Rows[0]["phGuid"].ToString().Trim()!=mod_ph_guid) {
                            context.Response.Write("notonly");
                    } else {
                        ph_db.UpdatePayHoliday();
                        context.Response.Write("ok");
                    }
                    
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