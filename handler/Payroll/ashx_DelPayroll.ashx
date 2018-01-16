<%@ WebHandler Language="C#" Class="ashx_DelPayroll" %>

using System;
using System.Web;

public class ashx_DelPayroll : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {
    
    public void ProcessRequest (HttpContext context) {
        Common com = new Common();
        payroll.gdal dal = new payroll.gdal();
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string pGuid = (!string.IsNullOrEmpty(context.Request.Form["pGuid"])) ? context.Request.Form["pGuid"].ToString() : "";
                dal.DelRayroll(pGuid,USERINFO.MemberGuid);
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