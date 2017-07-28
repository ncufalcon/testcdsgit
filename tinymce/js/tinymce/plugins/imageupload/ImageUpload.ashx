<%@ WebHandler Language="C#" Class="ImageUpload" %>

using System;
using System.Web;
using System.IO;
using System.Configuration;

public class ImageUpload : IHttpHandler {
 
    public void ProcessRequest (HttpContext context) {
        try
        {
            string ImgUpLoadPath = "";
            if (context.Request.Files.Count > 0)
            {
                //if (ConfigurationManager.AppSettings["UploadFileRootDir"] == null)
                //    ImgUpLoadPath = context.Server.MapPath("~/upload/");
                //else
                ImgUpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"] + "upload\\";
                
                 
                HttpFileCollection files = context.Request.Files;
                HttpPostedFile file = files[0];

                
                
                string Newid = System.Guid.NewGuid().ToString("D");
                DateTime now = DateTime.Now;
                
                
                
                //副檔名
                string imgExtension = System.IO.Path.GetExtension(file.FileName);
                //產生新檔名
                string newfilename = now.ToString("yyyyMMddHHmmss") + imgExtension;//產生新檔名
                //如果上傳路徑中沒有該目錄，則自動新增
                if (!Directory.Exists(ImgUpLoadPath.Substring(0, ImgUpLoadPath.LastIndexOf("\\"))))
                {
                    Directory.CreateDirectory(ImgUpLoadPath.Substring(0, ImgUpLoadPath.LastIndexOf("\\")));
                }
             
                //驗證副檔名
                if (imgExtension.ToLower() != ".jpg" && imgExtension.ToLower() != ".jpeg" && imgExtension.ToLower() != ".png" && imgExtension.ToLower() != ".bmp")
                {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('FormatError');</script>");
                    return;
                }
                //上傳檔案
                file.SaveAs(ImgUpLoadPath + newfilename);


                string ReturnPath = context.Request.Url.Scheme + "://" + context.Request.Url.Authority.ToString() + context.Request.ApplicationPath + "/tinymce/showimg/filedownload.ashx?empno=upload&amp;filename=" + newfilename;

                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('" + ReturnPath + "');</script>");
            }
        }
        catch (Exception ex)
        {
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('" + string.Format("訊息：Error!! {0}", ex.Message) + "');</script>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}