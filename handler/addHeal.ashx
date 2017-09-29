<%@ WebHandler Language="C#" Class="addHeal" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;

public class addHeal : IHttpHandler,IRequiresSessionState {
    CodeTable_DB Code_Db = new CodeTable_DB();
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
            string pi_No = (context.Request.Form["pi_NoGuid"] != null) ? context.Request.Form["pi_NoGuid"].ToString() : "";
            string pi_SubsidyLevel = (context.Request.Form["pi_SLGuid"] != null) ? context.Request.Form["pi_SLGuid"].ToString() : "";
            string pi_ChangeDate = (context.Request.Form["pi_ChangeDate"] != null) ? context.Request.Form["pi_ChangeDate"].ToString() : "";
            string pi_Change = (context.Request.Form["pi_Change"] != null) ? context.Request.Form["pi_Change"].ToString() : "";
            string pi_DropOutReason = (context.Request.Form["pi_DropOutReason"] != null) ? context.Request.Form["pi_DropOutReason"].ToString() : "";
            string pi_InsurancePayroll = (context.Request.Form["pi_InsurancePayroll"] != null) ? context.Request.Form["pi_InsurancePayroll"].ToString() : "";
            string pi_Ps = (context.Request.Form["pi_Ps"] != null) ? context.Request.Form["pi_Ps"].ToString() : "";
            DataTable checkDt = new DataTable();

            switch (Mode)
            {
                case "New":
                    //驗証
                    switch (pi_Change)
                    {
                        case "01":
                        case "05":
                            checkDt = LH_Db.checkInsLastStatus(pi_No);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["piChange"].ToString() == "01" || checkDt.Rows[0]["piChange"].ToString() == "03" || checkDt.Rows[0]["piChange"].ToString() == "05")
                                {
                                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該員工已加保');</script>");
                                    return;
                                }
                            }
                            break;
                        case "02":
                        case "04":
                        case "07":
                            checkDt = LH_Db.checkInsLastStatus(pi_No);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["piChange"].ToString() == "02" || checkDt.Rows[0]["piChange"].ToString() == "04" || checkDt.Rows[0]["piChange"].ToString() == "07")
                                {
                                    DataTable dt=  Code_Db.getCodeCn("12", checkDt.Rows[0]["piChange"].ToString());
                                    if(dt.Rows.Count>0)
                                        context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該員工已" + dt.Rows[0]["code_desc"].ToString() + "');</script>");
                                    return;
                                }
                            }
                            break;
                        case "06":
                            checkDt = LH_Db.checkInsLastStatus(pi_No);
                            if (checkDt.Rows.Count > 0)
                            {
                                if (checkDt.Rows[0]["piChange"].ToString() == "02" || checkDt.Rows[0]["piChange"].ToString() == "04" || checkDt.Rows[0]["piChange"].ToString() == "06" || checkDt.Rows[0]["piChange"].ToString() == "07")
                                {
                                    DataTable dt=  Code_Db.getCodeCn("12", checkDt.Rows[0]["piChange"].ToString());
                                    if(dt.Rows.Count>0)
                                        context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('MsgStr','訊息：該員工已" + dt.Rows[0]["code_desc"].ToString() + "');</script>");
                                    return;
                                }
                            }
                            break;
                    }

                    LH_Db._piGuid = Guid.NewGuid().ToString();
                    LH_Db._piPerGuid = pi_No;
                    LH_Db._piSubsidyLevel = pi_SubsidyLevel;
                    LH_Db._piCardNo = getLH_Code(pi_No, "H");
                    LH_Db._piChangeDate = pi_ChangeDate;
                    LH_Db._piChange = pi_Change;
                    LH_Db._piDropOutReason = pi_DropOutReason;
                    LH_Db._piInsurancePayroll = decimal.Parse(pi_InsurancePayroll);
                    LH_Db._piPs = pi_Ps;
                    LH_Db._piCreateId = USERINFO.MemberGuid;
                    LH_Db._piModifyId = USERINFO.MemberGuid;
                    LH_Db.addHeal();
                    break;
                case "Modify":
                    LH_Db._piGuid = id;
                    LH_Db._piPerGuid = pi_No;
                    LH_Db._piSubsidyLevel = pi_SubsidyLevel;
                    LH_Db._piCardNo = getLH_Code(pi_No, "H");
                    LH_Db._piChangeDate = pi_ChangeDate;
                    LH_Db._piChange = pi_Change;
                    LH_Db._piDropOutReason = pi_DropOutReason;
                    LH_Db._piInsurancePayroll = decimal.Parse(pi_InsurancePayroll);
                    LH_Db._piPs = pi_Ps;
                    LH_Db._piModifyId = USERINFO.MemberGuid;
                    LH_Db.modHeal();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('H');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addHeal');</script>"); }
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

    public bool IsReusable {
        get {
            return false;
        }
    }

}