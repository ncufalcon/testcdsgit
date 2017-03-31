<%@ WebHandler Language="C#" Class="addLabor" %>

using System;
using System.Web;

public class addLabor : IHttpHandler {
    LaborHealth_DB LH_Db = new LaborHealth_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            //勞保
            string pl_No = (context.Request.Form["pl_NoGuid"] != null) ? context.Request.Form["pl_NoGuid"].ToString() : "";
            string pl_SubsidyLevel = (context.Request.Form["pl_SLGuid"] != null) ? context.Request.Form["pl_SLGuid"].ToString() : "";
            string pl_ChangeDate = (context.Request.Form["pl_ChangeDate"] != null) ? context.Request.Form["pl_ChangeDate"].ToString() : "";
            string pl_Change = (context.Request.Form["pl_Change"] != null) ? context.Request.Form["pl_Change"].ToString() : "";
            string pl_LaborPayroll = (context.Request.Form["pl_LaborPayroll"] != null) ? context.Request.Form["pl_LaborPayroll"].ToString() : "";
            string pl_Ps = (context.Request.Form["pl_Ps"] != null) ? context.Request.Form["pl_Ps"].ToString() : "";

            switch (Mode)
            {
                case "New":
                    LH_Db._plGuid = Guid.NewGuid().ToString();
                    LH_Db._plPerGuid = pl_No;
                    LH_Db._plSubsidyLevel = pl_SubsidyLevel;
                    LH_Db._plChangeDate = pl_ChangeDate;
                    LH_Db._plChange = pl_Change;
                    LH_Db._plLaborPayroll = decimal.Parse(pl_LaborPayroll);
                    LH_Db._plPs = pl_Ps;
                    LH_Db.addLabor();
                    break;
                case "Modify":
                    LH_Db._plGuid = id;
                    LH_Db._plPerGuid = pl_No;
                    LH_Db._plSubsidyLevel = pl_SubsidyLevel;
                    LH_Db._plChangeDate = pl_ChangeDate;
                    LH_Db._plChange = pl_Change;
                    LH_Db._plLaborPayroll = decimal.Parse(pl_LaborPayroll);
                    LH_Db._plPs = pl_Ps;
                    LH_Db.modLabor();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LB');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addLabor');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}