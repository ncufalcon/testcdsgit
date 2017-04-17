<%@ WebHandler Language="C#" Class="pageModify" %>

using System;
using System.Web;
using System.Data;
using System.Collections.Generic;

public class pageModify : IHttpHandler
{
    //codetable 欄位 代碼檔
    public class codeTooL
    {
        public string code_value { get; set; }//value
        public string code_desc { get; set; }//中文名稱
    }
    //sy_CodeBranches 欄位 分店
    public class storeTooL
    {
        public string cbGuid { get; set; }//guid
        public string cbValue { get; set; }//value
        public string cbName { get; set; }//中文名稱
    }
    //sy_PersonChange 欄位 人事異動資料
    public class pcTooL
    {
        public string pcGuid { get; set; }//GUID
        public string perNo { get; set; }//人員編號
        public string perName { get; set; }//人員姓名
        public string pcPerGuid { get; set; }//人員對應GUID
        public string pcChangeName { get; set; }//異動項目
        public string ChangeCName { get; set; }//異動項目 中文名稱
        public string pcChangeDate { get; set; }//異動日期
        public string pcChangeBegin { get; set; }//異動前
        public string pcChangeEnd { get; set; }//異動後
        public string pcVenifyDate { get; set; }//確認日
        public string pcVenify { get; set; }//確認者
        public string pcStatus { get; set; }//狀態
        public string pcPs { get; set; }//備註
        public string begin_name { get; set; }//
        public string end_name { get; set; }//
    }
    //sy_Person 欄位 人事資料
    public class pTooL
    {
        public string perGuid { get; set; }//GUID
        public string perNo { get; set; }//人員編號
        public string perName { get; set; }//人員姓名
        public string perDep { get; set; }//部門
        public string cbName { get; set; }//部門名稱
        public string perPosition { get; set; }//職務
        public string PositionName { get; set; }//職務名稱
        public string perFirstDate { get; set; }//到職日期
    }

    CodeTable_DB code_db = new CodeTable_DB();
    Dal dal_db = new Dal();
    sy_PersonChange pc_db = new sy_PersonChange();
    public void ProcessRequest (HttpContext context)
    {
        string str_func = string.IsNullOrEmpty(context.Request.Form["func"]) ? "" : context.Request.Form["func"].ToString().Trim();
        switch (str_func) {
            //撈異動項目下拉選單資料
            case "load_person_changedata":
                DataTable dt_codegroup = code_db.getGroup("10");
                if (dt_codegroup.Rows.Count>0)
                {
                    List<codeTooL> codeList = new List<codeTooL>();
                    for (int i = 0; i < dt_codegroup.Rows.Count; i++)
                    {
                        codeTooL e = new codeTooL();
                        e.code_value = dt_codegroup.Rows[i]["code_value"].ToString().Trim();//value
                        e.code_desc = dt_codegroup.Rows[i]["code_desc"].ToString().Trim();//中文名稱
                        codeList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(codeList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }else
                {
                    context.Response.Write("nodata");
                }
                break;
            //撈分店資料sy_CodeBranches  dal_db.SearchRegionadminData()
            case "load_storedata":
                DataTable dt_stroedata = dal_db.SearchRegionadminData("","");
                if (dt_stroedata.Rows.Count > 0)
                {
                    List<storeTooL> storeList = new List<storeTooL>();
                    for (int i = 0; i < dt_stroedata.Rows.Count; i++)
                    {
                        storeTooL e = new storeTooL();
                        e.cbGuid = dt_stroedata.Rows[i]["cbGuid"].ToString().Trim();//value
                        e.cbName = dt_stroedata.Rows[i]["cbName"].ToString().Trim();//中文名稱
                        storeList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(storeList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else {
                    context.Response.Write("nodata");
                }
                break;
            //撈職務資料 code_group ='02'
            case "load_prodata":
                DataTable dt_pro_codegroup = code_db.getGroup("02");
                if (dt_pro_codegroup.Rows.Count>0)
                {
                    List<codeTooL> codeList = new List<codeTooL>();
                    for (int i = 0; i < dt_pro_codegroup.Rows.Count; i++)
                    {
                        codeTooL e = new codeTooL();
                        e.code_value = dt_pro_codegroup.Rows[i]["code_value"].ToString().Trim();//value
                        e.code_desc = dt_pro_codegroup.Rows[i]["code_desc"].ToString().Trim();//中文名稱
                        codeList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(codeList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }else
                {
                    context.Response.Write("nodata");
                }
                break;
            //撈人事異動資料
            case "load_personchangedata":
                string str_search_erson_date = string.IsNullOrEmpty(context.Request.Form["str_person_date"]) ? "" : context.Request.Form["str_person_date"].ToString().Trim();
                string str_search_person_keyword = string.IsNullOrEmpty(context.Request.Form["str_person_keyword"]) ? "" : context.Request.Form["str_person_keyword"].ToString().Trim();
                string str_search_person_status = string.IsNullOrEmpty(context.Request.Form["str_person_status"]) ? "" : context.Request.Form["str_person_status"].ToString().Trim();
                string str_search_person_guid = string.IsNullOrEmpty(context.Request.Form["str_search_person_guid"]) ? "" : context.Request.Form["str_search_person_guid"].ToString().Trim();
                pc_db._str_keyword = str_search_person_keyword;
                pc_db._pcChangeDate = str_search_erson_date;
                pc_db._pcStatus = str_search_person_status;
                pc_db._pcGuid = str_search_person_guid;
                DataTable dt_personchange = pc_db.SelectPersonChange();
                if (dt_personchange.Rows.Count > 0)
                {
                    List<pcTooL> pcList = new List<pcTooL>();
                    for (int i = 0; i < dt_personchange.Rows.Count; i++)
                    {
                        pcTooL e = new pcTooL();
                        e.pcGuid = dt_personchange.Rows[i]["pcGuid"].ToString().Trim();//GUID
                        e.perNo = dt_personchange.Rows[i]["perNo"].ToString().Trim();//人員編號
                        e.perName = dt_personchange.Rows[i]["perName"].ToString().Trim();//人員姓名
                        e.pcPerGuid = dt_personchange.Rows[i]["pcPerGuid"].ToString().Trim();//人員對應GUID
                        e.pcChangeDate = dt_personchange.Rows[i]["pcChangeDate"].ToString().Trim();//異動日期
                        e.pcChangeBegin = dt_personchange.Rows[i]["pcChangeBegin"].ToString().Trim();//異動前
                        e.pcChangeEnd = dt_personchange.Rows[i]["pcChangeEnd"].ToString().Trim();//異動後
                        e.pcVenifyDate = dt_personchange.Rows[i]["pcVenifyDate"].ToString().Trim();//確認日
                        e.pcVenify = dt_personchange.Rows[i]["pcVenify"].ToString().Trim();//確認者
                        e.pcStatus = dt_personchange.Rows[i]["pcStatus"].ToString().Trim();//狀態
                        e.pcChangeName = dt_personchange.Rows[i]["pcChangeName"].ToString().Trim();//異動項目
                        e.ChangeCName = dt_personchange.Rows[i]["ChangeCName"].ToString().Trim();//異動項目中文名稱
                        e.pcPs = dt_personchange.Rows[i]["pcPs"].ToString().Trim();//備註
                        if (dt_personchange.Rows[i]["pcChangeName"].ToString().Trim() == "01")
                        {
                            e.begin_name = dt_personchange.Rows[i]["begin_storename"].ToString().Trim();//
                            e.end_name = dt_personchange.Rows[i]["after_storename"].ToString().Trim();//
                        }
                        else if (dt_personchange.Rows[i]["pcChangeName"].ToString().Trim() == "02")
                        {
                            e.begin_name = dt_personchange.Rows[i]["begin_jobname"].ToString().Trim();//
                            e.end_name = dt_personchange.Rows[i]["after_jobname"].ToString().Trim();//
                        }
                        else {
                            e.begin_name = dt_personchange.Rows[i]["pcChangeBegin"].ToString().Trim();//
                            e.end_name = dt_personchange.Rows[i]["pcChangeEnd"].ToString().Trim();//
                        }


                        pcList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(pcList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else
                {
                    context.Response.Write("nodata");
                }
                break;

            //人事異動-----員工代號欄位 帶回姓名 GUID
            case "load_thispeopledata":
                string str_thisno = string.IsNullOrEmpty(context.Request.Form["str_thisno"]) ? "" : context.Request.Form["str_thisno"].ToString().Trim();
                pc_db._perNo = str_thisno;
                DataTable dt_thispeopledata = pc_db.SelectPersonByperNo();
                if (dt_thispeopledata.Rows.Count > 0)
                {
                    List<pTooL> pList = new List<pTooL>();
                    for (int i = 0; i < dt_thispeopledata.Rows.Count; i++)
                    {
                        pTooL e = new pTooL();
                        e.perGuid = dt_thispeopledata.Rows[0]["perGuid"].ToString().Trim();//GUID
                        e.perNo = dt_thispeopledata.Rows[0]["perNo"].ToString().Trim();//人員編號
                        e.perName = dt_thispeopledata.Rows[0]["perName"].ToString().Trim();//人員姓名
                        e.perDep =  dt_thispeopledata.Rows[0]["perDep"].ToString().Trim();//部門
                        e.cbName =  dt_thispeopledata.Rows[0]["cbName"].ToString().Trim();//部門名稱
                        e.perPosition =  dt_thispeopledata.Rows[0]["perPosition"].ToString().Trim();//職務
                        e.PositionName =  dt_thispeopledata.Rows[0]["PositionName"].ToString().Trim();//職務名稱
                        e.PositionName =  dt_thispeopledata.Rows[0]["PositionName"].ToString().Trim();//職務名稱
                        e.perFirstDate =  dt_thispeopledata.Rows[0]["perFirstDate"].ToString().Trim();//到職日期
                        pList.Add(e);
                    }
                    System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                    string ans = objSerializer.Serialize(pList);  //new
                    context.Response.ContentType = "application/json";
                    context.Response.Write(ans);
                }
                else
                {
                    context.Response.Write("nodata");
                }
                break;

            //人事異動 新增/修改
            case "mode_persondata":
                string mod_empno = string.IsNullOrEmpty(context.Request.Form["mod_empno"]) ? "" : context.Request.Form["mod_empno"].ToString().Trim();
                string mod_person_guid = string.IsNullOrEmpty(context.Request.Form["mod_person_guid"]) ? "" : context.Request.Form["mod_person_guid"].ToString().Trim();
                string mod_change_date = string.IsNullOrEmpty(context.Request.Form["mod_change_date"]) ? "" : context.Request.Form["mod_change_date"].ToString().Trim();
                string mod_change_pro = string.IsNullOrEmpty(context.Request.Form["mod_change_pro"]) ? "" : context.Request.Form["mod_change_pro"].ToString().Trim();
                string mod_before = string.IsNullOrEmpty(context.Request.Form["mod_before"]) ? "" : context.Request.Form["mod_before"].ToString().Trim();
                string mod_after = string.IsNullOrEmpty(context.Request.Form["mod_after"]) ? "" : context.Request.Form["mod_after"].ToString().Trim();
                string mod_chkdate = string.IsNullOrEmpty(context.Request.Form["mod_chkdate"]) ? "" : context.Request.Form["mod_chkdate"].ToString().Trim();
                string mod_chkpeople = string.IsNullOrEmpty(context.Request.Form["mod_chkpeople"]) ? "" : context.Request.Form["mod_chkpeople"].ToString().Trim();
                string mod_status = string.IsNullOrEmpty(context.Request.Form["mod_status"]) ? "" : context.Request.Form["mod_status"].ToString().Trim();
                string mod_ps = string.IsNullOrEmpty(context.Request.Form["mod_ps"]) ? "" : context.Request.Form["mod_ps"].ToString().Trim();
                string mod_addormod = string.IsNullOrEmpty(context.Request.Form["mod_addormod"]) ? "" : context.Request.Form["mod_addormod"].ToString().Trim();
                string mod_hidden_pcguid = string.IsNullOrEmpty(context.Request.Form["mod_hidden_pcguid"]) ? "" : context.Request.Form["mod_hidden_pcguid"].ToString().Trim();

                try{
                    pc_db._pcPerGuid = mod_person_guid;
                    pc_db._pcChangeDate = mod_change_date;
                    pc_db._pcChangeName = mod_change_pro;
                    pc_db._pcChangeBegin = mod_before;
                    pc_db._pcChangeEnd = mod_after;
                    pc_db._pcVenifyDate = mod_chkdate;
                    pc_db._pcVenify = mod_chkpeople;
                    pc_db._pcStatus = mod_status;
                    pc_db._pcPs = mod_ps;
                    pc_db._pcCreateId = mod_chkpeople;
                    if (mod_addormod == "新增")
                    {
                        pc_db._pcGuid = Guid.NewGuid().ToString();
                        pc_db.InsertPersonChange();
                    }
                    else
                    {//修改
                        pc_db._pcGuid = mod_hidden_pcguid;
                        pc_db._pcModifyId = mod_chkpeople;
                        pc_db.UpdatePersonChange();
                    }
                    context.Response.Write("ok");
                }catch {
                    context.Response.Write("error");
                }
                break;

            //人事異動 刪除
            case "del_personchangedata":
                string del_guid = string.IsNullOrEmpty(context.Request.Form["del_guid"]) ? "" : context.Request.Form["del_guid"].ToString().Trim();
                try {
                    pc_db._pcGuid = del_guid;
                    pc_db.DeletePersonChange();
                    context.Response.Write("ok");
                }catch {
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