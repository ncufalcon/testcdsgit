<%@ WebHandler Language="C#" Class="ashx_NHIReport" %>

using System;
using System.Web;

public class ashx_NHIReport : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";
        context.Response.Write("Hello World");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}