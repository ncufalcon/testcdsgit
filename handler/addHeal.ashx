<%@ WebHandler Language="C#" Class="addHeal" %>

using System;
using System.Web;
using System.Web.SessionState;

public class addHeal : IHttpHandler,IRequiresSessionState {
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            //勞保
            string pi_No = (context.Request.Form["pi_NoGuid"] != null) ? context.Request.Form["pi_NoGuid"].ToString() : "";
            string pi_SubsidyLevel = (context.Request.Form["pi_SLGuid"] != null) ? context.Request.Form["pi_SLGuid"].ToString() : "";
            string pi_ChangeDate = (context.Request.Form["pi_ChangeDate"] != null) ? context.Request.Form["pi_ChangeDate"].ToString() : "";
            string pi_Change = (context.Request.Form["pi_Change"] != null) ? context.Request.Form["pi_Change"].ToString() : "";
            string pi_InsurancePayroll = (context.Request.Form["pi_InsurancePayroll"] != null) ? context.Request.Form["pi_InsurancePayroll"].ToString() : "";
            string pi_Ps = (context.Request.Form["pi_Ps"] != null) ? context.Request.Form["pi_Ps"].ToString() : "";

            switch (Mode)
            {
                case "New":
                    LH_Db._piGuid = Guid.NewGuid().ToString();
                    LH_Db._piPerGuid = pi_No;
                    LH_Db._piSubsidyLevel = pi_SubsidyLevel;
                    LH_Db._piChangeDate = pi_ChangeDate;
                    LH_Db._piChange = pi_Change;
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
                    LH_Db._piChangeDate = pi_ChangeDate;
                    LH_Db._piChange = pi_Change;
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}