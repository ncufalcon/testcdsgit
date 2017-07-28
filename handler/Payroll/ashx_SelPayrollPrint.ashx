<%@ WebHandler Language="C#" Class="ashx_SelPayrollPrint" %>

using System;
using System.Web;
using System.Data;
public class ashx_SelPayrollPrint : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {


        DataView dv = dal.Selsy_PaySalaryPrint().DefaultView;
        if(dv.Count == 1)
        {


        }
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}