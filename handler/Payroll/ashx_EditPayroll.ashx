<%@ WebHandler Language="C#" Class="ashx_EditPayroll" %>

using System;
using System.Web;
using System.Data;
public class ashx_EditPayroll : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {

    public void ProcessRequest (HttpContext context) {
        Common com = new Common();
        payroll.gdal dal = new payroll.gdal();
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string pspContent = (!string.IsNullOrEmpty(context.Request.Form["pspContent"])) ? context.Request.Form["pspContent"].ToString() : "";
                dal.Upsy_SalaryPrint(pspContent,USERINFO.MemberGuid);
                context.Response.Write("ok");

            }
            else { context.Response.Write("t"); }
        }catch(Exception ex) { context.Response.Write("e");  }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}