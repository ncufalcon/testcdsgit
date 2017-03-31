<%@ WebHandler Language="C#" Class="addGroupIns" %>

using System;
using System.Web;

public class addGroupIns : IHttpHandler {
    GroupInsurance_DB GI_Db = new GroupInsurance_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string id = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";

            string pgi_No = (context.Request.Form["pg_NoGuid"] != null) ? context.Request.Form["pg_NoGuid"].ToString() : "";
            string pgi_PfGuid = (context.Request.Form["pg_PfGuid"] != null) ? context.Request.Form["pg_PfGuid"].ToString() : "";
            string pgi_Type = (context.Request.Form["pgi_Change"] != null) ? context.Request.Form["pgi_Change"].ToString() : "";
            string pgi_Change = (context.Request.Form["pgi_Change"] != null) ? context.Request.Form["pgi_Change"].ToString() : "";
            string pgi_ChangeDate = (context.Request.Form["pgi_ChangeDate"] != null) ? context.Request.Form["pgi_ChangeDate"].ToString() : "";
            string pgi_InsuranceCode= (context.Request.Form["pg_ICGuid"] != null) ? context.Request.Form["pg_ICGuid"].ToString() : "";
            string pgi_Ps = (context.Request.Form["pgi_Ps"] != null) ? context.Request.Form["pgi_Ps"].ToString() : "";

            switch (Mode)
            {
                case "New":
                    GI_Db._pgiGuid = Guid.NewGuid().ToString();
                    GI_Db._pgiPerGuid = pgi_No;
                    GI_Db._pgiPfGuid = pgi_PfGuid;
                    GI_Db._pgiType = pgi_Type;
                    GI_Db._pgiChange = pgi_Change;
                    GI_Db._pgiChangeDate = pgi_ChangeDate;
                    GI_Db._pgiInsuranceCode = pgi_InsuranceCode;
                    GI_Db._pgiPs = pgi_Ps;
                    GI_Db.addGroupInsurance();
                    break;
                case "Modify":
                     GI_Db._pgiGuid = id;
                    GI_Db._pgiPerGuid = pgi_No;
                    GI_Db._pgiPfGuid = pgi_PfGuid;
                    GI_Db._pgiType = pgi_Type;
                    GI_Db._pgiChange = pgi_Change;
                    GI_Db._pgiChangeDate = pgi_ChangeDate;
                    GI_Db._pgiInsuranceCode = pgi_InsuranceCode;
                    GI_Db._pgiPs = pgi_Ps;
                    GI_Db.modGroupInsurance();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('PGI');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','addGroupIns');</script>"); }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}