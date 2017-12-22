<%@ WebHandler Language="C#" Class="addFamilyIns" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class addFamilyIns : IHttpHandler,IRequiresSessionState {
    FamilyInsurance_DB FI_Db = new FamilyInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            if (string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LoginFailed','');</script>");
                return;
            }

            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";

            string pfi_No = (context.Request.Form["pf_NoGuid"] != null) ? context.Request.Form["pf_NoGuid"].ToString() : "";
            string pfi_PfGuid = (context.Request.Form["pf_PfGuid"] != null) ? context.Request.Form["pf_PfGuid"].ToString() : "";
            string pfi_Change = (context.Request.Form["pfi_Change"] != null) ? context.Request.Form["pfi_Change"].ToString() : "";
            string pfi_DropOutReason = (context.Request.Form["pfi_DropOutReason"] != null) ? context.Request.Form["pfi_DropOutReason"].ToString() : "";
            string pfi_ChangeDate = (context.Request.Form["pfi_ChangeDate"] != null) ? context.Request.Form["pfi_ChangeDate"].ToString() : "";
            string pfi_SubsidyLevel = (context.Request.Form["pf_SLGuid"] != null) ? context.Request.Form["pf_SLGuid"].ToString() : "";
            string pfi_AreaPerson = (context.Request.Form["pfi_AreaPerson"] != null) ? context.Request.Form["pfi_AreaPerson"].ToString() : "";
            string pfi_Ps = (context.Request.Form["pfi_Ps"] != null) ? context.Request.Form["pfi_Ps"].ToString() : "";
            DataTable checkDt = new DataTable();

            switch (Mode)
            {
                case "New":
                    //驗証
                    switch (pfi_Change)
                    {
                        case "01":
                            checkDt = FI_Db.checkLastStatus(pfi_PfGuid);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["pfiChange"].ToString() == "01")
                                {
                                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該成員已加保');</script>");
                                    return;
                                }
                            }
                            break;
                        case "02":
                        case "03":
                            checkDt = FI_Db.checkLastStatus(pfi_PfGuid);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["pfiChange"].ToString() == "02" || checkDt.Rows[0]["pfiChange"].ToString() == "03")
                                {
                                    string changeStr = (checkDt.Rows[0]["pfiChange"].ToString() == "02") ? "退保" : "轉出";
                                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該成員已" + changeStr + "');</script>");
                                    return;
                                }
                            }
                            break;
                    }
                    FI_Db._pfiGuid = Guid.NewGuid().ToString();
                    FI_Db._pfiPerGuid = pfi_No;
                    FI_Db._pfiPfGuid = pfi_PfGuid;
                    FI_Db._pfiChange = pfi_Change;
                    FI_Db._pfiDropOutReason = pfi_DropOutReason;
                    FI_Db._pfiChangeDate = pfi_ChangeDate;
                    FI_Db._pfiSubsidyLevel = pfi_SubsidyLevel;
                    FI_Db._pfiAreaPerson = pfi_AreaPerson;
                    FI_Db._pfiPs = pfi_Ps;
                    FI_Db._pfiStatus = "A";
                    FI_Db._pfiCreateId = USERINFO.MemberGuid;
                    FI_Db._pfiModifyId = USERINFO.MemberGuid;
                    FI_Db.addFamilyIns();
                    break;
                case "Modify":
                    FI_Db._pfiGuid = id;
                    FI_Db._pfiPerGuid = pfi_No;
                    FI_Db._pfiPfGuid = pfi_PfGuid;
                    FI_Db._pfiChange = pfi_Change;
                    FI_Db._pfiDropOutReason = pfi_DropOutReason;
                    FI_Db._pfiChangeDate = pfi_ChangeDate;
                    FI_Db._pfiSubsidyLevel = pfi_SubsidyLevel;
                    FI_Db._pfiAreaPerson = pfi_AreaPerson;
                    FI_Db._pfiPs = pfi_Ps;
                    FI_Db._pfiModifyId = USERINFO.MemberGuid;
                    FI_Db.modFamilyIns();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('PFI');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addFamilyIns');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}