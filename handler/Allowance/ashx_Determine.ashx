<%@ WebHandler Language="C#" Class="ashx_Determine" %>

using System;
using System.Web;

public class ashx_Determine : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                dal.InsImportsyAllowance(USERINFO.MemberGuid);
                dal.DelsyAllowanceTemp();
                context.Response.Write("ok");
            }
            else { context.Response.Write("t"); }


        }
        catch (Exception ex) { context.Response.Write("e"); }


    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}