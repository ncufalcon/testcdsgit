<%@ WebHandler Language="C#" Class="filedownload" %>

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Text;
using System.Configuration;
using System.IO;


public class filedownload : IHttpHandler 
{    
    public void ProcessRequest (HttpContext context)    
    {
        string FileName = "" + context.Request.QueryString["v"];

        string strpath = string.Format(System.Configuration.ConfigurationManager.AppSettings["UploadFileRootDir"] + "\\{0}\\{1}", "upload", FileName);
        FileInfo file =new FileInfo (strpath);
        //DirectoryInfo dir = new DirectoryInfo(context.Request.MapPath("./"));
        string strContentType = string.Empty;
        switch (file.Extension)
        {
            case ".asf":
                strContentType = "video/x-ms-asf";
                break;
            case ".avi":
                strContentType = "video/avi";
                break;
            case ".doc":
                strContentType = "application/msword";
                break;
            case ".zip":
                strContentType = "application/zip";
                break;
            case ".xls":
                strContentType = "application/vnd.ms-excel";
                break;
            case ".csv":
                strContentType = "application/vnd.ms-excel";
                break;
            case ".gif":
                strContentType = "image/gif";
                break;
            case ".jpg":
                strContentType = "image/jpeg";
                break;
            case "jpeg":
                strContentType = "image/jpeg";
                break;                    
            case ".wav":
                strContentType = "audio/wav";
                break;
            case ".mp3":
                strContentType = "audio/mpeg3";
                break;
            case ".mpg":
                strContentType = "video/mpeg";
                break;
            case "mpeg":
                strContentType = "video/mpeg";
                break;
            case ".htm":
                strContentType = "text/html";
                break;
            case ".html":
                strContentType = "text/html";
                break;
            case ".asp":
                strContentType = "text/asp";
                break;
                
            default:
                strContentType = "application/octet-stream";
                break;                                                                                                                                                                                                                                                                                       
        }
        
        if (file.Exists)
        {
            context.Response.ContentType = strContentType;
            string strDownloadName = string.Empty;

            if (context.Request.Browser.Browser == "IE")
            {
                context.Response.HeaderEncoding = System.Text.Encoding.GetEncoding("big5");
                strDownloadName = context.Request["v"];
            }
            else
            {
                strDownloadName = System.Web.HttpUtility.UrlEncode(context.Request["v"]);
            }

            context.Response.AddHeader("content-disposition", "attachment;filename=" + strDownloadName);
        
            context.Response.WriteFile(strpath);
            context.Response.Flush();
            context.Response.End();
        }                               
    }
 
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }


}