<%@ WebHandler Language="C#" Class="ashx_AllTempDel" %>

using System;
using System.Web;

public class ashx_AllTempDel : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string guid = (!string.IsNullOrEmpty(context.Request.Form["guid"])) ? context.Request.Form["guid"].ToString() : "";
                dal.DelsyAllowanceTempOne(guid);

                context.Response.Write("ok");
            }else {context.Response.Write("t"); }
        }
        catch (Exception ex) { context.Response.Write("e"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}