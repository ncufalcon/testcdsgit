<%@ WebHandler Language="C#" Class="ashx_ImportPayroll" %>

using System;
using System.Web;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_ImportPayroll : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    
    NpoiExcel Npo = new NpoiExcel();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest (HttpContext context) {

        string sr_guid = (!string.IsNullOrEmpty(context.Request.QueryString["sr_guid"])) ? context.Request.QueryString["sr_guid"].ToString() : "";
        string sDate = (!string.IsNullOrEmpty(context.Request.QueryString["sDate"])) ? context.Request.QueryString["sDate"].ToString() : "";
        string eDate = (!string.IsNullOrEmpty(context.Request.QueryString["eDate"])) ? context.Request.QueryString["eDate"].ToString() : "";
        string PerNo = (!string.IsNullOrEmpty(context.Request.QueryString["PerNo"])) ? context.Request.QueryString["PerNo"].ToString() : "";
















        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}