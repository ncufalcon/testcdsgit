<%@ WebHandler Language="C#" Class="page_nssadmin" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;
using System.Web.SessionState;

public class page_nssadmin : IHttpHandler, IRequiresSessionState
{
    //sy_InsuranceBasic 欄位 保險設定資料
    public class ibTooL
    {
        public string ibGuid { get; set; }
        public string ibLaborProtection1 { get; set; }
        public string ibLaborProtection2 { get; set; }
        public string ibLaborProtection3 { get; set; }
        public string ibLaborProtection4 { get; set; }
        public string ibLaborProtection5 { get; set; }
        public string ibLaborProtection6 { get; set; }
        public string ibLaborProtection7 { get; set; }
        public string ibHealthcare1 { get; set; }
        public string ibHealthcare2 { get; set; }
        public string ibHealthcare3 { get; set; }
        public string ibHealthcare4 { get; set; }
        public string ibHealthcare5 { get; set; }
        public string ibHealthcare6 { get; set; }
        public string ibHealthcare6_up { get; set; }
        public string ibHealthcare6_down { get; set; }
        public string ibHealthcare7 { get; set; }
    }
    //sy_GroupInsurance 欄位 團體保險資料
    public class giTooL
    {
        public  string giGuid { get; set; }
        public  string giInsuranceCode { get; set; }
        public  string giInsuranceName { get; set; }
        public  string giAge { get; set; }
        public  string giPs { get; set; }
        public  string giCreatId { get; set; }
        public  string giCreatDate { get; set; }
        public  string giModifyId { get; set; }
        public  string giModifyDate { get; set; }
        public  string giStatus { get; set; }
    }
    //sy_InsuranceIdentity_DB 欄位 勞健保身分資料
    public class iiTooL
    {
        public  string iiGuid { get; set; }
        public  string iiIdentityCode { get; set; }
        public  string iiIdentity { get; set; }
        public  string iiInsurance1 { get; set; }
        public  string iiInsurance2 { get; set; }
        public  string iiInsurance3 { get; set; }
        public  string iiInsurance4 { get; set; }
        public  string iiInsurance5 { get; set; }
        public  string iiRetirement { get; set; }
        public  string iiStatus { get; set; }
    }
    //sy_GroupInsuranceIdentity 欄位 團保投保身分資料
    public class giiTooL
    {
        public string giiGuid { get; set; }
        public string giidentityCode { get; set; }
        public string giiIdentity { get; set; }
        public string giiItem1 { get; set; }
        public string giiItem2 { get; set; }
        public string giiItem3 { get; set; }
        public string giiStatus { get; set; }
    }
    //sy_SubsidyLevel 欄位 輔助等級設定資料
    public class slTooL
    {
        public string slGuid { get; set; }
        public string slSubsidyCode { get; set; }
        public string slSubsidyIdentity { get; set; }
        public string slSubsidyRatio1 { get; set; }
        public string slSubsidyRatio2 { get; set; }
        public string slSubsidyRatio3 { get; set; }
        public string slStatus { get; set; }
    }
    //sy_SubsidyLevel 欄位 投保級距設定資料
    public class ilTooL
    {
        public string ilGuid { get; set; }
        public string ilItem1 { get; set; }
        public string ilItem2 { get; set; }
        public string ilItem3 { get; set; }
        public string ilItem4 { get; set; }
        public string ilEffectiveDate { get; set; }
        public string ilStatus { get; set; }
    }
    //sy_SubsidyLevel 投保級距設定資料 生效日期 
    public class ildateTooL
    {
        public string ilEffectiveDate { get; set; }
    }
    //sy_SetStartInsurance 到職保薪設定
    public class ssiTooL
    {
        public string ssi_labor { get; set; }
        public string ssi_ganbor { get; set; }
        public string ssi_tahui { get; set; }
    }
    sy_InsuranceBasic_DB ib_db = new sy_InsuranceBasic_DB();
    sy_GroupInsurance_DB gi_db = new sy_GroupInsurance_DB();
    sy_InsuranceIdentity_DB ii_db = new sy_InsuranceIdentity_DB();
    sy_GroupInsuranceIdentity_DB gii_db = new sy_GroupInsuranceIdentity_DB();
    sy_SubsidyLevel_DB sl_db = new sy_SubsidyLevel_DB();
    sy_InsuranceLevel_DB il_db = new sy_InsuranceLevel_DB();
    sy_SetStartInsurance_DB ssi_db = new sy_SetStartInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        string session_no = string.IsNullOrEmpty(USERINFO.MemberGuid) ? "" : USERINFO.MemberGuid.ToString().Trim();
        string session_name = string.IsNullOrEmpty(USERINFO.MemberName) ? "" : USERINFO.MemberName.ToString().Trim();
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func)
        {
            //撈保險基本設定資料
            case "load_iddata":
                DataTable dt_ibdata = ib_db.SelectInsuranceBasic();
                if (dt_ibdata.Rows.Count > 0)
                {
                    List<ibTooL> ibList = new List<ibTooL>();
                    for (int i = 0; i < dt_ibdata.Rows.Count; i++)
                    {
                        ibTooL e = new ibTooL();
                        e.ibGuid = dt_ibdata.Rows[i]["ibGuid"].ToString().Trim();
                        e.ibLaborProtection1 = dt_ibdata.Rows[i]["ibLaborProtection1"].ToString().Trim();
                        e.ibLaborProtection2 = dt_ibdata.Rows[i]["ibLaborProtection2"].ToString().Trim();
                        e.ibLaborProtection3 = dt_ibdata.Rows[i]["ibLaborProtection3"].ToString().Trim();
                        e.ibLaborProtection4 = dt_ibdata.Rows[i]["ibLaborProtection4"].ToString().Trim();
                        e.ibLaborProtection5 = dt_ibdata.Rows[i]["ibLaborProtection5"].ToString().Trim();
                        e.ibLaborProtection6 = dt_ibdata.Rows[i]["ibLaborProtection6"].ToString().Trim();
                        e.ibLaborProtection7 = dt_ibdata.Rows[i]["ibLaborProtection7"].ToString().Trim();
                        e.ibHealthcare1 = dt_ibdata.Rows[i]["ibHealthcare1"].ToString().Trim();
                        e.ibHealthcare2 = dt_ibdata.Rows[i]["ibHealthcare2"].ToString().Trim();
                        e.ibHealthcare3 = dt_ibdata.Rows[i]["ibHealthcare3"].ToString().Trim();
                        e.ibHealthcare4 = dt_ibdata.Rows[i]["ibHealthcare4"].ToString().Trim();
                        e.ibHealthcare5 = dt_ibdata.Rows[i]["ibHealthcare5"].ToString().Trim();
                        e.ibHealthcare6 = dt_ibdata.Rows[i]["ibHealthcare6"].ToString().Trim();
                        e.ibHealthcare6_up = dt_ibdata.Rows[i]["ibHealthcare6_up"].ToString().Trim();
                        e.ibHealthcare6_down = dt_ibdata.Rows[i]["ibHealthcare6_down"].ToString().Trim();
                        e.ibHealthcare7 = dt_ibdata.Rows[i]["ibHealthcare7"].ToString().Trim();
                        ibList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(ibList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else
                {
                    context.Response.Write("nodata");
                }
                break;
            //修改保險設定
            case "mod_iddata":
                string mod_ibLaborProtection1 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection1"]) ? "" : context.Request.Form["mod_ibLaborProtection1"].ToString().Trim();
                string mod_ibLaborProtection2 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection2"]) ? "" : context.Request.Form["mod_ibLaborProtection2"].ToString().Trim();
                string mod_ibLaborProtection3 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection3"]) ? "" : context.Request.Form["mod_ibLaborProtection3"].ToString().Trim();
                string mod_ibLaborProtection4 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection4"]) ? "" : context.Request.Form["mod_ibLaborProtection4"].ToString().Trim();
                string mod_ibLaborProtection5 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection5"]) ? "" : context.Request.Form["mod_ibLaborProtection5"].ToString().Trim();
                string mod_ibLaborProtection6 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection6"]) ? "" : context.Request.Form["mod_ibLaborProtection6"].ToString().Trim();
                string mod_ibLaborProtection7 = string.IsNullOrEmpty(context.Request.Form["mod_ibLaborProtection7"]) ? "" : context.Request.Form["mod_ibLaborProtection7"].ToString().Trim();
                string mod_ibHealthcare1 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare1"]) ? "" : context.Request.Form["mod_ibHealthcare1"].ToString().Trim();
                string mod_ibHealthcare2 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare2"]) ? "" : context.Request.Form["mod_ibHealthcare2"].ToString().Trim();
                string mod_ibHealthcare3 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare3"]) ? "" : context.Request.Form["mod_ibHealthcare3"].ToString().Trim();
                string mod_ibHealthcare4 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare4"]) ? "" : context.Request.Form["mod_ibHealthcare4"].ToString().Trim();
                string mod_ibHealthcare5 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare5"]) ? "" : context.Request.Form["mod_ibHealthcare5"].ToString().Trim();
                string mod_ibHealthcare6 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare6"]) ? "" : context.Request.Form["mod_ibHealthcare6"].ToString().Trim();
                string mod_ibHealthcare6_up = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare6_up"]) ? "" : context.Request.Form["mod_ibHealthcare6_up"].ToString().Trim();
                string mod_ibHealthcare6_down = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare6_down"]) ? "" : context.Request.Form["mod_ibHealthcare6_down"].ToString().Trim();
                string mod_ibHealthcare7 = string.IsNullOrEmpty(context.Request.Form["mod_ibHealthcare7"]) ? "" : context.Request.Form["mod_ibHealthcare7"].ToString().Trim();

                try {
                    ib_db._ibLaborProtection1 = (mod_ibLaborProtection1 == "") ? 0 : Convert.ToDecimal(mod_ibLaborProtection1);
                    ib_db._ibLaborProtection2 = (mod_ibLaborProtection2 == "") ? 0 : Convert.ToDecimal(mod_ibLaborProtection2);
                    ib_db._ibLaborProtection3 = (mod_ibLaborProtection3 == "") ? 0 : Convert.ToDecimal(mod_ibLaborProtection3);
                    ib_db._ibLaborProtection4 = (mod_ibLaborProtection4 == "") ? 0 : Convert.ToDecimal(mod_ibLaborProtection4);
                    ib_db._ibLaborProtection5 = (mod_ibLaborProtection5 == "") ? 0 : Convert.ToDecimal(mod_ibLaborProtection5);
                    ib_db._ibLaborProtection6 = (mod_ibLaborProtection6 == "") ? 0 : Convert.ToDecimal(mod_ibLaborProtection6);
                    ib_db._ibLaborProtection7 = mod_ibLaborProtection7;
                    ib_db._ibHealthcare1 = (mod_ibHealthcare1 == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare1);
                    ib_db._ibHealthcare2 = (mod_ibHealthcare2 == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare2);
                    ib_db._ibHealthcare3 = (mod_ibHealthcare3 == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare3);
                    ib_db._ibHealthcare4 = (mod_ibHealthcare4 == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare4);
                    ib_db._ibHealthcare5 = (mod_ibHealthcare5 == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare5);
                    ib_db._ibHealthcare6 = (mod_ibHealthcare6 == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare6);
                    ib_db._ibHealthcare6_up = (mod_ibHealthcare6_up == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare6_up);
                    ib_db._ibHealthcare6_down = (mod_ibHealthcare6_down == "") ? 0 : Convert.ToDecimal(mod_ibHealthcare6_down);
                    ib_db._ibHealthcare7 = mod_ibHealthcare7;
                    ib_db._ibModifyId = session_no;
                    DataTable dt_chkibdata = ib_db.SelectInsuranceBasic();
                    if (dt_chkibdata.Rows.Count > 0)
                    {
                        ib_db._ibGuid = dt_chkibdata.Rows[0]["ibGuid"].ToString().Trim();
                        ib_db.UpdateInsuranceBasic();
                    }
                    else
                    {
                        ib_db._ibGuid = Guid.NewGuid().ToString();
                        ib_db.InsertInsuranceBasic();
                    }
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //撈團體保險資料
            case "load_gidata":
                string str_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                gi_db._str_keyword = str_keyword;
                gi_db._giGuid = str_guid;
                DataTable dt_gi = gi_db.SelectGroupInsurance();
                if (dt_gi.Rows.Count > 0)
                {
                    List<giTooL> giList = new List<giTooL>();
                    for (int i = 0; i < dt_gi.Rows.Count; i++)
                    {
                        giTooL e = new giTooL();
                        e.giGuid = dt_gi.Rows[i]["giGuid"].ToString().Trim();
                        e.giInsuranceCode = dt_gi.Rows[i]["giInsuranceCode"].ToString().Trim();
                        e.giInsuranceName = dt_gi.Rows[i]["giInsuranceName"].ToString().Trim();
                        e.giAge = dt_gi.Rows[i]["giAge"].ToString().Trim();
                        e.giPs = dt_gi.Rows[i]["giPs"].ToString().Trim();
                        e.giStatus = dt_gi.Rows[i]["giStatus"].ToString().Trim();
                        giList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(giList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;

            //團體保險 新增/修改
            case "mod_gidata":
                string mod_gi_code = string.IsNullOrEmpty(context.Request.Form["mod_gi_code"]) ? "" : context.Request.Form["mod_gi_code"].ToString().Trim();
                string mod_gi_name = string.IsNullOrEmpty(context.Request.Form["mod_gi_name"]) ? "" : context.Request.Form["mod_gi_name"].ToString().Trim();
                string mod_gi_age = string.IsNullOrEmpty(context.Request.Form["mod_gi_age"]) ? "" : context.Request.Form["mod_gi_age"].ToString().Trim();
                string mod_gi_ps = string.IsNullOrEmpty(context.Request.Form["mod_gi_ps"]) ? "" : context.Request.Form["mod_gi_ps"].ToString().Trim();
                string mod_gi_Status = string.IsNullOrEmpty(context.Request.Form["mod_gi_Status"]) ? "" : context.Request.Form["mod_gi_Status"].ToString().Trim();
                string mod_gi_guid = string.IsNullOrEmpty(context.Request.Form["mod_gi_guid"]) ? "" : context.Request.Form["mod_gi_guid"].ToString().Trim();
                try
                {
                    gi_db._giAge = mod_gi_age;
                    gi_db._giInsuranceCode = mod_gi_code;
                    gi_db._giInsuranceName = mod_gi_name;
                    gi_db._giPs = mod_gi_ps;
                    gi_db._giCreatId = session_no;
                    gi_db._giModifyId = session_no;
                    DataTable dt_chk_code = gi_db.SelectGroupInsuranceCode();
                    if (mod_gi_Status=="新增") {

                        if (dt_chk_code.Rows.Count > 0)
                        {
                            context.Response.Write("notonly");
                        }
                        else {
                            gi_db._giGuid = Guid.NewGuid().ToString();
                            gi_db.InsertGroupInsurance();
                            context.Response.Write("ok");
                        }

                    }
                    if (mod_gi_Status=="修改") {
                        gi_db._giGuid = mod_gi_guid;
                        DataTable dt_chk_code_mod = gi_db.SelectGroupInsuranceCode();
                        if (dt_chk_code.Rows.Count > 0 && dt_chk_code_mod.Rows.Count == 0)
                        {//table已經有這個保險代號 但 這代號不屬於正在修改的這筆資料 表示代號重複能能update
                            context.Response.Write("notonly");
                        }
                        else {
                            gi_db.UpdateGroupInsurance();
                            context.Response.Write("ok");
                        }
                    }

                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //團體保險 刪除
            case "del_gidata":
                string del_gi_guid = string.IsNullOrEmpty(context.Request.Form["del_gi_guid"]) ? "" : context.Request.Form["del_gi_guid"].ToString().Trim();
                try {
                    gi_db._giGuid = del_gi_guid;
                    gi_db._giModifyId = session_no;
                    gi_db.DeleteGroupInsurance();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //撈 勞健保身分 資料
            case "load_iidata":
                string str_ii_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_ii_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                ii_db._str_keyword = str_ii_keyword;
                ii_db._iiGuid = str_ii_guid;
                DataTable dt_ii = ii_db.SelectInsuranceIdentity();
                if (dt_ii.Rows.Count > 0)
                {
                    List<iiTooL> iiList = new List<iiTooL>();
                    for (int i = 0; i < dt_ii.Rows.Count; i++)
                    {
                        iiTooL e = new iiTooL();
                        e.iiGuid = dt_ii.Rows[i]["iiGuid"].ToString().Trim();
                        e.iiIdentityCode = dt_ii.Rows[i]["iiIdentityCode"].ToString().Trim();
                        e.iiIdentity = dt_ii.Rows[i]["iiIdentity"].ToString().Trim();
                        e.iiInsurance1 = dt_ii.Rows[i]["iiInsurance1"].ToString().Trim();
                        e.iiInsurance2 = dt_ii.Rows[i]["iiInsurance2"].ToString().Trim();
                        e.iiInsurance3 = dt_ii.Rows[i]["iiInsurance3"].ToString().Trim();
                        e.iiInsurance4 = dt_ii.Rows[i]["iiInsurance4"].ToString().Trim();
                        e.iiInsurance5 = dt_ii.Rows[i]["iiInsurance5"].ToString().Trim();
                        e.iiRetirement = dt_ii.Rows[i]["iiRetirement"].ToString().Trim();
                        e.iiStatus = dt_ii.Rows[i]["iiStatus"].ToString().Trim();
                        iiList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(iiList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //勞健保身分 新增/修改
            case "mod_iidata":
                string mod_ii_iiIdentityCode = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiIdentityCode"]) ? "" : context.Request.Form["mod_ii_iiIdentityCode"].ToString().Trim();
                string mod_ii_iiIdentity = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiIdentity"]) ? "" : context.Request.Form["mod_ii_iiIdentity"].ToString().Trim();
                string mod_ii_iiInsurance1 = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiInsurance1"]) ? "" : context.Request.Form["mod_ii_iiInsurance1"].ToString().Trim();
                string mod_ii_iiInsurance2 = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiInsurance2"]) ? "" : context.Request.Form["mod_ii_iiInsurance2"].ToString().Trim();
                string mod_ii_iiInsurance3 = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiInsurance3"]) ? "" : context.Request.Form["mod_ii_iiInsurance3"].ToString().Trim();
                string mod_ii_iiInsurance4 = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiInsurance4"]) ? "" : context.Request.Form["mod_ii_iiInsurance4"].ToString().Trim();
                string mod_ii_iiInsurance5 = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiInsurance5"]) ? "" : context.Request.Form["mod_ii_iiInsurance5"].ToString().Trim();
                string mod_ii_iiRetirement = string.IsNullOrEmpty(context.Request.Form["mod_ii_iiRetirement"]) ? "" : context.Request.Form["mod_ii_iiRetirement"].ToString().Trim();
                string mod_ii_guid = string.IsNullOrEmpty(context.Request.Form["mod_ii_guid"]) ? "" : context.Request.Form["mod_ii_guid"].ToString().Trim();
                string mod_ii_Status = string.IsNullOrEmpty(context.Request.Form["mod_ii_Status"]) ? "" : context.Request.Form["mod_ii_Status"].ToString().Trim();
                try
                {
                    ii_db._iiIdentityCode = mod_ii_iiIdentityCode;
                    ii_db._iiIdentity = mod_ii_iiIdentity;
                    ii_db._iiInsurance1 = mod_ii_iiInsurance1;
                    ii_db._iiInsurance2 = mod_ii_iiInsurance2;
                    ii_db._iiInsurance3 = mod_ii_iiInsurance3;
                    ii_db._iiInsurance4 = mod_ii_iiInsurance4;
                    ii_db._iiInsurance5 = mod_ii_iiInsurance5;
                    ii_db._iiRetirement = mod_ii_iiRetirement;
                    ii_db._iiCreatId = session_no;
                    ii_db._iiModifyId = session_no;
                    DataTable dt_chk_code = ii_db.SelectInsuranceIdentityCode();
                    if (mod_ii_Status=="新增") {

                        if (dt_chk_code.Rows.Count > 0)
                        {
                            context.Response.Write("notonly");
                        }
                        else {
                            ii_db._iiGuid = Guid.NewGuid().ToString();
                            ii_db.InsertInsuranceIdentity();
                            context.Response.Write("ok");
                        }

                    }
                    if (mod_ii_Status=="修改") {
                        ii_db._iiGuid = mod_ii_guid;
                        DataTable dt_chk_code_mod = ii_db.SelectInsuranceIdentityCode();
                        if (dt_chk_code.Rows.Count > 0 && dt_chk_code_mod.Rows.Count == 0)
                        {//table已經有這個保險代號 但 這代號不屬於正在修改的這筆資料 表示代號重複能能update
                            context.Response.Write("notonly");
                        }
                        else {
                            ii_db.UpdateInsuranceIdentity();
                            context.Response.Write("ok");
                        }
                    }

                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //勞健保身分 刪除
            case "del_iidata":
                string del_ii_guid = string.IsNullOrEmpty(context.Request.Form["del_ii_guid"]) ? "" : context.Request.Form["del_ii_guid"].ToString().Trim();
                try {
                    ii_db._iiGuid = del_ii_guid;
                    ii_db._iiModifyId = session_no;
                    ii_db.DeleteInsuranceIdentity();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //撈 團保投保身分 資料
            case "load_giidata":
                string str_gii_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_gii_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                gii_db._str_keyword = str_gii_keyword;
                gii_db._giiGuid = str_gii_guid;
                DataTable dt_gii = gii_db.SelectGroupInsuranceIdentity();
                if (dt_gii.Rows.Count > 0)
                {
                    List<giiTooL> giiList = new List<giiTooL>();
                    for (int i = 0; i < dt_gii.Rows.Count; i++)
                    {
                        giiTooL e = new giiTooL();
                        e.giiGuid = dt_gii.Rows[i]["giiGuid"].ToString().Trim();
                        e.giidentityCode = dt_gii.Rows[i]["giidentityCode"].ToString().Trim();
                        e.giiIdentity = dt_gii.Rows[i]["giiIdentity"].ToString().Trim();
                        e.giiItem1 = dt_gii.Rows[i]["giiItem1"].ToString().Trim();
                        e.giiItem2 = dt_gii.Rows[i]["giiItem2"].ToString().Trim();
                        e.giiItem3 = dt_gii.Rows[i]["giiItem3"].ToString().Trim();
                        e.giiStatus = dt_gii.Rows[i]["giiStatus"].ToString().Trim();
                        giiList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(giiList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //團保投保身分 新增/修改
            case "mod_giidata":
                string mod_gii_giidentityCode = string.IsNullOrEmpty(context.Request.Form["mod_gii_giidentityCode"]) ? "" : context.Request.Form["mod_gii_giidentityCode"].ToString().Trim();
                string mod_gii_giiIdentity = string.IsNullOrEmpty(context.Request.Form["mod_gii_giiIdentity"]) ? "" : context.Request.Form["mod_gii_giiIdentity"].ToString().Trim();
                string mod_gii_giiItem1 = string.IsNullOrEmpty(context.Request.Form["mod_gii_giiItem1"]) ? "" : context.Request.Form["mod_gii_giiItem1"].ToString().Trim();
                string mod_gii_giiItem2 = string.IsNullOrEmpty(context.Request.Form["mod_gii_giiItem2"]) ? "" : context.Request.Form["mod_gii_giiItem2"].ToString().Trim();
                string mod_gii_giiItem3 = string.IsNullOrEmpty(context.Request.Form["mod_gii_giiItem3"]) ? "" : context.Request.Form["mod_gii_giiItem3"].ToString().Trim();
                string mod_gii_guid = string.IsNullOrEmpty(context.Request.Form["mod_gii_guid"]) ? "" : context.Request.Form["mod_gii_guid"].ToString().Trim();
                string mod_gii_Status = string.IsNullOrEmpty(context.Request.Form["mod_gii_Status"]) ? "" : context.Request.Form["mod_gii_Status"].ToString().Trim();
                try
                {
                    gii_db._giidentityCode = mod_gii_giidentityCode;
                    gii_db._giiIdentity = mod_gii_giiIdentity;
                    gii_db._giiItem1 = mod_gii_giiItem1;
                    gii_db._giiItem2 = mod_gii_giiItem2;
                    gii_db._giiItem3 = mod_gii_giiItem3;
                    gii_db._giiCreatId = session_no;
                    gii_db._giiModifyId = session_no;
                    DataTable dt_chk_code = gii_db.SelectGroupInsuranceIdentityCode();
                    if (mod_gii_Status=="新增") {

                        if (dt_chk_code.Rows.Count > 0)
                        {
                            context.Response.Write("notonly");
                        }
                        else {
                            gii_db._giiGuid = Guid.NewGuid().ToString();
                            gii_db.InsertGroupInsuranceIdentity();
                            context.Response.Write("ok");
                        }

                    }
                    if (mod_gii_Status=="修改") {
                        gii_db._giiGuid = mod_gii_guid;
                        DataTable dt_chk_code_mod = gii_db.SelectGroupInsuranceIdentityCode();
                        if (dt_chk_code.Rows.Count > 0 && dt_chk_code_mod.Rows.Count == 0)
                        {//table已經有這個保險代號 但 這代號不屬於正在修改的這筆資料 表示代號重複能能update
                            context.Response.Write("notonly");
                        }
                        else {
                            gii_db.UpdateGroupInsuranceIdentity();
                            context.Response.Write("ok");
                        }
                    }

                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //團保投保身分 刪除
            case "del_giidata":
                string del_gii_guid = string.IsNullOrEmpty(context.Request.Form["del_gii_guid"]) ? "" : context.Request.Form["del_gii_guid"].ToString().Trim();
                try {
                    gii_db._giiGuid = del_gii_guid;
                    gii_db._giiModifyId = session_no;
                    gii_db.DeleteGroupInsuranceIdentity();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //******************************//
            //撈 補助等級設定 資料
            case "load_sldata":
                string str_sl_keyword = string.IsNullOrEmpty(context.Request.Form["str_keyword"]) ? "" : context.Request.Form["str_keyword"].ToString().Trim();
                string str_sl_guid = string.IsNullOrEmpty(context.Request.Form["str_guid"]) ? "" : context.Request.Form["str_guid"].ToString().Trim();
                sl_db._str_keyword = str_sl_keyword;
                sl_db._slGuid = str_sl_guid;
                DataTable dt_sl = sl_db.SelectSubsidyLevel();
                if (dt_sl.Rows.Count > 0)
                {
                    List<slTooL> slList = new List<slTooL>();
                    for (int i = 0; i < dt_sl.Rows.Count; i++)
                    {
                        slTooL e = new slTooL();
                        e.slGuid = dt_sl.Rows[i]["slGuid"].ToString().Trim();
                        e.slSubsidyCode = dt_sl.Rows[i]["slSubsidyCode"].ToString().Trim();
                        e.slSubsidyIdentity = dt_sl.Rows[i]["slSubsidyIdentity"].ToString().Trim();
                        e.slSubsidyRatio1 = dt_sl.Rows[i]["slSubsidyRatio1"].ToString().Trim();
                        e.slSubsidyRatio2 = dt_sl.Rows[i]["slSubsidyRatio2"].ToString().Trim();
                        e.slSubsidyRatio3 = dt_sl.Rows[i]["slSubsidyRatio3"].ToString().Trim();
                        e.slStatus = dt_sl.Rows[i]["slStatus"].ToString().Trim();
                        slList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(slList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //團保投保身分 新增/修改
            case "mod_sldata":
                string mod_sl_slSubsidyCode = string.IsNullOrEmpty(context.Request.Form["mod_sl_slSubsidyCode"]) ? "" : context.Request.Form["mod_sl_slSubsidyCode"].ToString().Trim();
                string mod_sl_slSubsidyIdentity = string.IsNullOrEmpty(context.Request.Form["mod_sl_slSubsidyIdentity"]) ? "" : context.Request.Form["mod_sl_slSubsidyIdentity"].ToString().Trim();
                string mod_sl_slSubsidyRatio1 = string.IsNullOrEmpty(context.Request.Form["mod_sl_slSubsidyRatio1"]) ? "" : context.Request.Form["mod_sl_slSubsidyRatio1"].ToString().Trim();
                string mod_sl_slSubsidyRatio2 = string.IsNullOrEmpty(context.Request.Form["mod_sl_slSubsidyRatio2"]) ? "" : context.Request.Form["mod_sl_slSubsidyRatio2"].ToString().Trim();
                string mod_sl_slSubsidyRatio3 = string.IsNullOrEmpty(context.Request.Form["mod_sl_slSubsidyRatio3"]) ? "" : context.Request.Form["mod_sl_slSubsidyRatio3"].ToString().Trim();
                string mod_sl_guid = string.IsNullOrEmpty(context.Request.Form["mod_sl_guid"]) ? "" : context.Request.Form["mod_sl_guid"].ToString().Trim();
                string mod_sl_Status = string.IsNullOrEmpty(context.Request.Form["mod_sl_Status"]) ? "" : context.Request.Form["mod_sl_Status"].ToString().Trim();
                try
                {
                    sl_db._slSubsidyCode = mod_sl_slSubsidyCode;
                    sl_db._slSubsidyIdentity = mod_sl_slSubsidyIdentity;
                    sl_db._slSubsidyRatio1 = Convert.ToDecimal(mod_sl_slSubsidyRatio1);
                    sl_db._slSubsidyRatio2 = Convert.ToDecimal(mod_sl_slSubsidyRatio2);
                    sl_db._slSubsidyRatio3 = Convert.ToDecimal(mod_sl_slSubsidyRatio3);
                    sl_db._slCreatId = session_no;
                    sl_db._slModifyId = session_no;
                    DataTable dt_chk_code = sl_db.SelectGroupInsuranceIdentityCode();
                    if (mod_sl_Status=="新增") {

                        if (dt_chk_code.Rows.Count > 0)
                        {
                            context.Response.Write("notonly");
                        }
                        else {
                            sl_db._slGuid = Guid.NewGuid().ToString();
                            sl_db.InsertSubsidyLevel();
                            context.Response.Write("ok");
                        }

                    }
                    if (mod_sl_Status=="修改") {
                        sl_db._slGuid = mod_sl_guid;
                        DataTable dt_chk_code_mod = sl_db.SelectGroupInsuranceIdentityCode();
                        if (dt_chk_code.Rows.Count > 0 && dt_chk_code_mod.Rows.Count == 0)
                        {//table已經有這個保險代號 但 這代號不屬於正在修改的這筆資料 表示代號重複能能update
                            context.Response.Write("notonly");
                        }
                        else {
                            sl_db.UpdateSubsidyLevel();
                            context.Response.Write("ok");
                        }
                    }

                }
                catch (Exception ex){
                    context.Response.Write("error");
                }
                break;
            //團保投保身分 刪除
            case "del_sldata":
                string del_sl_guid = string.IsNullOrEmpty(context.Request.Form["del_sl_guid"]) ? "" : context.Request.Form["del_sl_guid"].ToString().Trim();
                try {
                    sl_db._slGuid = del_sl_guid;
                    sl_db._slModifyId = session_no;
                    sl_db.DeleteSubsidyLevel();
                    context.Response.Write("ok");
                }
                catch (Exception ex) {
                    context.Response.Write("error");
                }
                break;
            //******************************//
            //撈 投保級距設定 資料
            case "load_ildata":
                string str_il_date = string.IsNullOrEmpty(context.Request.Form["str_il_date"]) ? "" : context.Request.Form["str_il_date"].ToString().Trim();
                il_db._ilEffectiveDate = str_il_date;
                DataTable dt_il = il_db.SelectInsuranceLevel();
                if (dt_il.Rows.Count > 0)
                {
                    List<ilTooL> ilList = new List<ilTooL>();
                    for (int i = 0; i < dt_il.Rows.Count; i++)
                    {
                        ilTooL e = new ilTooL();
                        e.ilGuid = dt_il.Rows[i]["ilGuid"].ToString().Trim();
                        e.ilItem1 = dt_il.Rows[i]["ilItem1"].ToString().Trim();
                        e.ilItem2 = dt_il.Rows[i]["ilItem2"].ToString().Trim();
                        e.ilItem3 = dt_il.Rows[i]["ilItem3"].ToString().Trim();
                        e.ilItem4 = dt_il.Rows[i]["ilItem4"].ToString().Trim();
                        e.ilEffectiveDate = dt_il.Rows[i]["ilEffectiveDate"].ToString().Trim();
                        e.ilStatus = dt_il.Rows[i]["ilStatus"].ToString().Trim();
                        ilList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(ilList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //撈 生效日期 資料
            case "load_il_date":
                DataTable dt_il_date = il_db.SelectInsuranceLevelDate();
                if (dt_il_date.Rows.Count > 0)
                {
                    List<ildateTooL> ildateList = new List<ildateTooL>();
                    for (int i = 0; i < dt_il_date.Rows.Count; i++)
                    {
                        ildateTooL e = new ildateTooL();
                        e.ilEffectiveDate = dt_il_date.Rows[i]["ilEffectiveDate"].ToString().Trim();
                        ildateList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(ildateList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //到職保薪設定
            case "load_SetStartInsurance":
                DataTable dt_ssi = new DataTable();
                dt_ssi = ssi_db.SelectSetStartInsurance();
                if (dt_ssi.Rows.Count > 0)
                {
                    //ssi_labor
                    //ssi_ganbor
                    //ssi_tahui
                    List<ssiTooL> ssiList = new List<ssiTooL>();
                    for (int i = 0; i < dt_ssi.Rows.Count; i++)
                    {
                        ssiTooL e = new ssiTooL();
                        e.ssi_labor = dt_ssi.Rows[i]["ssi_labor"].ToString().Trim();
                        e.ssi_ganbor = dt_ssi.Rows[i]["ssi_ganbor"].ToString().Trim();
                        e.ssi_tahui = dt_ssi.Rows[i]["ssi_tahui"].ToString().Trim();
                        ssiList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(ssiList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;

            //新增/修改 到職保薪設定
            case "mod_SetStartInsurance":
                string mod_labor = string.IsNullOrEmpty(context.Request.Form["mod_labor"]) ? "0" : context.Request.Form["mod_labor"].ToString().Trim();
                string mod_ganbor = string.IsNullOrEmpty(context.Request.Form["mod_ganbor"]) ? "0" : context.Request.Form["mod_ganbor"].ToString().Trim();
                string mod_tahui = string.IsNullOrEmpty(context.Request.Form["mod_tahui"]) ? "0" : context.Request.Form["mod_tahui"].ToString().Trim();
                try
                {
                    DateTime dt_now = DateTime.Now;
                    ssi_db._ssi_labor = Convert.ToDecimal(mod_labor);
                    ssi_db._ssi_ganbor = Convert.ToDecimal(mod_ganbor);
                    ssi_db._ssi_tahui = Convert.ToDecimal(mod_tahui);
                    ssi_db._ssi_CreateId = session_no;
                    ssi_db._ssi_ModifyId = session_no;
                    ssi_db._ssi_CreateDate = dt_now;
                    ssi_db._ssi_ModifyDate = dt_now;
                    DataTable dt_chkssi = new DataTable();
                    dt_chkssi = ssi_db.SelectSetStartInsurance();
                    if (dt_chkssi.Rows.Count > 0)
                    {//修改
                        ssi_db.UpdateSetStartInsurance();
                    }
                    else {//新增
                        ssi_db.InsertSetStartInsurance();
                    }
                    context.Response.Write("ok");
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