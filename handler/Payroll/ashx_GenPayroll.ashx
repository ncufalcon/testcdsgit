<%@ WebHandler Language="C#" Class="ashx_GenPayroll" %>

using System;
using System.Web;
using System.Data;
public class ashx_GenPayroll : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    public void ProcessRequest (HttpContext context) {

        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string XmlStr = "";
                DataView dv = new DataView();
                string rGuid = (!string.IsNullOrEmpty(context.Request.Form["rGuid"])) ? context.Request.Form["rGuid"].ToString() : "";

                string[] str = { rGuid};
                string sqlinj = com.CheckSqlInJection(str);

                if (sqlinj == "")
                {
                   // DataTable dt =   dal.GenRayroll(rGuid,USERINFO.MemberGuid); 
                   dal.GenRayroll(rGuid,USERINFO.MemberGuid); 
                    context.Response.Write("ok");
                }
                else { context.Response.Write("DangerWord"); }
            }
            else { context.Response.Write("Timeout"); }
        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            //err.InsErrorLog("ashx_NewStaffList.ashx", ex.Message, USERINFO.MemberEmpno);
            context.Response.Write("error");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}