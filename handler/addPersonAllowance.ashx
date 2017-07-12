<%@ WebHandler Language="C#" Class="addPersonAllowance" %>

using System;
using System.Web;
using System.Data;
using System.Web.SessionState;

public class addPersonAllowance : IHttpHandler,IRequiresSessionState {
    PersonAllowance_DB PA_Db = new PersonAllowance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string PerID = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            string id = (context.Request.Form["paid"] != null) ? context.Request.Form["paid"].ToString() : "";
            //津貼資料
            string pa_AllowanceCode = (context.Request.Form["pa_AllowanceCode"] != null) ? context.Request.Form["pa_AllowanceCode"].ToString() : "";
            string pa_CodeGuid = (context.Request.Form["pa_CodeGuid"] != null) ? context.Request.Form["pa_CodeGuid"].ToString() : "";
            string pa_Cost = (context.Request.Form["pa_Cost"] != null) ? context.Request.Form["pa_Cost"].ToString() : "";

            PA_Db._paPerGuid = PerID;
            PA_Db._paAllowanceCode = pa_CodeGuid;
            DataTable dt = PA_Db.checkPACode();
            if (dt.Rows.Count > 0)
            {
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('repeatPACode','');</script>");
                return;
            }

            switch (Mode)
            {
                case "New":
                    PA_Db._paGuid = Guid.NewGuid().ToString();
                    PA_Db._paPerGuid = PerID;
                    PA_Db._paAllowanceCode = pa_CodeGuid;
                    PA_Db._paCost = decimal.Parse(pa_Cost);
                    PA_Db._paCreateId = USERINFO.MemberGuid;
                    PA_Db._paModifyId = USERINFO.MemberGuid;
                    PA_Db.addPersonAllowance();
                    break;
                case "Modify":
                    PA_Db._paGuid = id;
                    PA_Db._paAllowanceCode = pa_CodeGuid;
                    PA_Db._paCost = decimal.Parse(pa_Cost);
                    PA_Db._paModifyId = USERINFO.MemberGuid;
                    PA_Db.modPersonAllowance();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('PA');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addPersonAllowance');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}