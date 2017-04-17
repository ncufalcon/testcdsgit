<%@ WebHandler Language="C#" Class="addPersonFamily" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class addPersonFamily : IHttpHandler,IRequiresSessionState {
    PersonFamily_DB PF_Db = new PersonFamily_DB();
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
    FamilyInsurance_DB FI_Db = new FamilyInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string PerID = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            string id = (context.Request.Form["pfid"] != null) ? context.Request.Form["pfid"].ToString() : "";
            //眷屬資料
            string pf_Name = (context.Request.Form["pf_Name"] != null) ? context.Request.Form["pf_Name"].ToString() : "";
            string pf_HealthInsurance = (context.Request.Form["pf_HealthInsurance"] != null) ? context.Request.Form["pf_HealthInsurance"].ToString() : "";
            string pf_GroupInsurance = (context.Request.Form["pf_GroupInsurance"] != null) ? context.Request.Form["pf_GroupInsurance"].ToString() : "";
            string pf_IDNumber = (context.Request.Form["pf_IDNumber"] != null) ? context.Request.Form["pf_IDNumber"].ToString() : "";
            string pf_Code = (context.Request.Form["pf_Code"] != null) ? context.Request.Form["pf_Code"].ToString() : "";
            string pf_CodeGuid = (context.Request.Form["pf_CodeGuid"] != null) ? context.Request.Form["pf_CodeGuid"].ToString() : "";
            string pf_Title = (context.Request.Form["pf_Title"] != null) ? context.Request.Form["pf_Title"].ToString() : "";
            string pf_Birthday = (context.Request.Form["pf_Birthday"] != null) ? context.Request.Form["pf_Birthday"].ToString() : "";

            string GuidStr = Guid.NewGuid().ToString();
            switch (Mode)
            {
                case "New":
                    PF_Db._pfGuid = GuidStr;
                    PF_Db._pfPerGuid = PerID;
                    PF_Db._pfName = pf_Name;
                    PF_Db._pfHealthInsurance = pf_HealthInsurance;
                    PF_Db._pfGroupInsurance = pf_GroupInsurance;
                    PF_Db._pfIDNumber = pf_IDNumber;
                    PF_Db._pfCode = pf_CodeGuid;
                    PF_Db._pfTitle = pf_Title;
                    PF_Db._pfBirthday = pf_Birthday;
                    PF_Db._pfCreateId = USERINFO.MemberGuid;
                    PF_Db._pfModifyId = USERINFO.MemberGuid;
                    PF_Db.addPersonFamily();

                    //眷屬健保
                    FI_Db._pfiGuid = Guid.NewGuid().ToString();
                    FI_Db._pfiPerGuid = PerID;
                    FI_Db._pfiPfGuid = GuidStr;
                    FI_Db._pfiChange = "01";
                    FI_Db._pfiSubsidyLevel = pf_CodeGuid;
                    FI_Db._pfiModifyId = USERINFO.MemberGuid;
                    FI_Db.addFamilyIns();
                    //眷屬團保
                    if (pf_GroupInsurance == "Y")
                    {
                        GI_Db._pgiGuid = Guid.NewGuid().ToString();
                        GI_Db._pgiPerGuid = PerID;
                        GI_Db._pgiPfGuid = GuidStr;
                        GI_Db._pgiType = "02"; //身份
                        GI_Db._pgiChange = "01"; //異動別
                        GI_Db._pgiModifyId = USERINFO.MemberGuid;
                        GI_Db.addGroupInsurance();
                    }
                    break;
                case "Modify":
                    PF_Db._pfGuid = id;
                    PF_Db._pfName = pf_Name;
                    PF_Db._pfHealthInsurance = pf_HealthInsurance;
                    PF_Db._pfGroupInsurance = pf_GroupInsurance;
                    PF_Db._pfIDNumber = pf_IDNumber;
                    PF_Db._pfCode = pf_CodeGuid;
                    PF_Db._pfTitle = pf_Title;
                    PF_Db._pfBirthday = pf_Birthday;
                    PF_Db._pfModifyId = USERINFO.MemberGuid;
                    PF_Db.modPersonFamily();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('PF');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addPersonFamily');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}