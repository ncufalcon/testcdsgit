<%@ WebHandler Language="C#" Class="ashx_SelPayrollPrint" %>

using System;
using System.Web;
using System.Data;
public class ashx_SelPayrollPrint : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/html";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.Selsy_PaySalaryPrint().DefaultView;
                if (dv.Count == 1)
                {
                    context.Response.Write((dv[0]["pspContent"].ToString()));
                }
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