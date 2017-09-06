<%@ WebHandler Language="C#" Class="ashx_GenTax" %>

using System;
using System.Web;
using System.Data;
public class ashx_GenTax : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    ErrorLog err = new ErrorLog();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string yyyy = (!string.IsNullOrEmpty(context.Request.Form["yyyy"])) ? context.Request.Form["yyyy"].ToString() : "";

                string[] str = { yyyy };
                string sqlinj = com.CheckSqlInJection(str);

                if (sqlinj == "")
                {
                    dal.GenTax(yyyy, USERINFO.MemberGuid);
                    context.Response.Write("ok");
                }
                else { context.Response.Write("d"); }
            }
            else { context.Response.Write("t"); }
        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_GenTax.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("e");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}