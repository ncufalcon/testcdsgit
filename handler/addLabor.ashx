<%@ WebHandler Language="C#" Class="addLabor" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class addLabor : IHttpHandler,IRequiresSessionState {
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    Personnel_DB Personnel_Db = new Personnel_DB();
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
            //勞保
            string pl_No = (context.Request.Form["pl_NoGuid"] != null) ? context.Request.Form["pl_NoGuid"].ToString() : "";
            string pl_SubsidyLevel = (context.Request.Form["pl_SLGuid"] != null) ? context.Request.Form["pl_SLGuid"].ToString() : "";
            string pl_ChangeDate = (context.Request.Form["pl_ChangeDate"] != null) ? context.Request.Form["pl_ChangeDate"].ToString() : "";
            string pl_Change = (context.Request.Form["pl_Change"] != null) ? context.Request.Form["pl_Change"].ToString() : "";
            string pl_LaborPayroll = (context.Request.Form["pl_LaborPayroll"] != null) ? context.Request.Form["pl_LaborPayroll"].ToString() : "";
            string pl_Ps = (context.Request.Form["pl_Ps"] != null) ? context.Request.Form["pl_Ps"].ToString() : "";

            //檢查挑選人員是否為離職人員
            DataTable dtCheckLast = new DataTable();
            Personnel_Db._perGuid = pl_No;
            dtCheckLast = Personnel_Db.getPersonByGuid();
            if (dtCheckLast.Rows.Count>0) {
                if (dtCheckLast.Rows[0]["perLastDate"] != null && dtCheckLast.Rows[0]["perLastDate"].ToString().Trim()!="") {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該員工已離職');</script>");
                    return;
                }
            }
            //檢查離職END

            DataTable checkDt = new DataTable();
            switch (Mode)
            {
                case "New":
                    //驗証
                    switch (pl_Change)
                    {
                        case "01":
                            checkDt = LH_Db.checkLaborLastStatus(pl_No);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["plChange"].ToString() == "01" || checkDt.Rows[0]["plChange"].ToString() == "03")
                                {
                                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該員工已加保');</script>");
                                    return;
                                }
                            }
                            break;
                        case "02":
                        case "04":
                            checkDt = LH_Db.checkLaborLastStatus(pl_No);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["plChange"].ToString() == "02" || checkDt.Rows[0]["plChange"].ToString() == "04")
                                {
                                    string changeStr = (checkDt.Rows[0]["plChange"].ToString() == "02") ? "退保" : "退休";
                                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該員工已" + changeStr + "');</script>");
                                    return;
                                }
                            }
                            break;
                    }

                    LH_Db._plGuid = Guid.NewGuid().ToString();
                    LH_Db._plPerGuid = pl_No;
                    LH_Db._plSubsidyLevel = pl_SubsidyLevel;
                    LH_Db._plLaborNo = getLH_Code(pl_No, "L");
                    LH_Db._plChangeDate = pl_ChangeDate;
                    LH_Db._plChange = pl_Change;
                    LH_Db._plLaborPayroll = decimal.Parse(pl_LaborPayroll);
                    LH_Db._plPs = pl_Ps;
                    LH_Db._piCreateId = USERINFO.MemberGuid;
                    LH_Db._piModifyId = USERINFO.MemberGuid;
                    LH_Db.addLabor();
                    WriteBackInfo(pl_No,pl_SubsidyLevel);
                    break;
                case "Modify":
                    LH_Db._plGuid = id;
                    LH_Db._plPerGuid = pl_No;
                    LH_Db._plSubsidyLevel = pl_SubsidyLevel;
                    LH_Db._plLaborNo = getLH_Code(pl_No, "L");
                    LH_Db._plChangeDate = pl_ChangeDate;
                    LH_Db._plChange = pl_Change;
                    LH_Db._plLaborPayroll = decimal.Parse(pl_LaborPayroll);
                    LH_Db._plPs = pl_Ps;
                    LH_Db._piModifyId = USERINFO.MemberGuid;
                    LH_Db.modLabor();
                    WriteBackInfo(pl_No,pl_SubsidyLevel);
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LB');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addLabor');</script>"); }
    }

    private string getLH_Code(string perGuid, string type)
    {
        string codeStr = string.Empty;
        DataTable dt = Personnel_Db.getLHcode(perGuid);
        if (dt.Rows.Count > 0)
        {
            if (type == "L")
                codeStr = dt.Rows[0]["comLaborProtectionCode"].ToString();
            else
                codeStr = dt.Rows[0]["comHealthInsuranceCode"].ToString();
        }
        return codeStr;
    }

    //同步人員基本資料補助身分
    private void WriteBackInfo(string pGuid, string SL_val)
    {
        Personnel_Db._perGuid = pGuid;
        Personnel_Db._perLaborID = SL_val;
        Personnel_Db.LaborSL();
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}