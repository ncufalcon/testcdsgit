﻿<%@ WebHandler Language="C#" Class="ashx_AllList" %>

using System;
using System.Web;

public class ashx_AllList : IHttpHandler {
    
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