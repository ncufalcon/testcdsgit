<%@ WebHandler Language="C#" Class="InsertImage" %>

using System;
using System.Web;
using System.IO;
using System.Data;
using System.Web.UI.HtmlControls;

public class InsertImage : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        if (context.Request.Files.Count > 0)
        {
            HttpFileCollection files = context.Request.Files;
            HttpPostedFile file = files[0];
        }
        //context.Response.ContentType = "text/plain";
        context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun();</script>");
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}