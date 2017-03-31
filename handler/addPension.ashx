<%@ WebHandler Language="C#" Class="addPension" %>

using System;
using System.Web;

public class addPension : IHttpHandler {
    PersonPension_DB PP_Db = new PersonPension_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            //勞保
            string pp_No = (context.Request.Form["pp_NoGuid"] != null) ? context.Request.Form["pp_NoGuid"].ToString() : "";
            string pp_Change = (context.Request.Form["pp_Change"] != null) ? context.Request.Form["pp_Change"].ToString() : "";
            string pp_ChangeDate = (context.Request.Form["pp_ChangeDate"] != null) ? context.Request.Form["pp_ChangeDate"].ToString() : "";
            string pp_LarboRatio = (context.Request.Form["pp_LarboRatio"] != null) ? context.Request.Form["pp_LarboRatio"].ToString() : "";
            string pp_EmployerRatio = (context.Request.Form["pp_LarboRatio"] != null) ? context.Request.Form["pp_LarboRatio"].ToString() : "";
            string pp_PayPayroll = (context.Request.Form["pp_PayPayroll"] != null) ? context.Request.Form["pp_PayPayroll"].ToString() : "";
            string pp_Ps = (context.Request.Form["pp_Ps"] != null) ? context.Request.Form["pp_Ps"].ToString() : "";

            switch (Mode)
            {
                case "New":
                    PP_Db._ppGuid = Guid.NewGuid().ToString();
                    PP_Db._ppPerGuid = pp_No;
                    PP_Db._ppChange = pp_Change;
                    PP_Db._ppChangeDate = pp_ChangeDate;
                    PP_Db._ppLarboRatio = decimal.Parse(pp_LarboRatio);
                    PP_Db._ppEmployerRatio = decimal.Parse(pp_EmployerRatio);
                    PP_Db._ppPayPayroll = decimal.Parse(pp_PayPayroll);
                    PP_Db._ppPs = pp_Ps;
                    PP_Db.addPension();
                    break;
                case "Modify":
                    PP_Db._ppGuid = id;
                    PP_Db._ppPerGuid = pp_No;
                    PP_Db._ppChange = pp_Change;
                    PP_Db._ppChangeDate = pp_ChangeDate;
                    PP_Db._ppLarboRatio = decimal.Parse(pp_LarboRatio);
                    PP_Db._ppEmployerRatio = decimal.Parse(pp_EmployerRatio);
                    PP_Db._ppPayPayroll = decimal.Parse(pp_PayPayroll);
                    PP_Db._ppPs = pp_Ps;
                    PP_Db.modPension();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('PP');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addPension');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}