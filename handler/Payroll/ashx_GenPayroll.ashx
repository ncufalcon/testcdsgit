<%@ WebHandler Language="C#" Class="ashx_GenPayroll" %>

using System;
using System.Web;
using System.Data;
public class ashx_GenPayroll : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    ErrorLog err = new ErrorLog();
    public void ProcessRequest(HttpContext context)
    {

        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = new DataView();
                string rGuid = (!string.IsNullOrEmpty(context.Request.Form["rGuid"])) ? context.Request.Form["rGuid"].ToString() : "";
                string perGuid = (!string.IsNullOrEmpty(context.Request.Form["perGuid"])) ? context.Request.Form["perGuid"].ToString() : "";
                string[] str = { rGuid };
                string sqlinj = com.CheckSqlInJection(str);

                if (sqlinj == "")
                {
                    dal.GenRayroll(rGuid, USERINFO.MemberGuid, perGuid);
                    context.Response.Write("ok");
                }
                else { context.Response.Write("DangerWord"); }
            }
            else { context.Response.Write("Timeout"); }
        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_GenPayroll.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("error");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}