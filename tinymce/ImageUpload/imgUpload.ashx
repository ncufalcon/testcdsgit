<%@ WebHandler Language="C#" Class="imgUpload" %>

using System;
using System.Web;
using System.IO;
using System.Configuration;

public class imgUpload : IHttpHandler {
    
    public void ProcessRequest (HttpContext context) {
        try
        {
            string ImgUpLoadPath = "";
            if (context.Request.Files.Count > 0)
            {
                //圖片路徑
                ImgUpLoadPath = ConfigurationManager.AppSettings["UploadFileRootDir"] + "upload\\";
                
                HttpFileCollection files = context.Request.Files;
                HttpPostedFile afile = files[0];

                string Newid = System.Guid.NewGuid().ToString("D");
                DateTime now = DateTime.Now;



                //副檔名
                string extension = System.IO.Path.GetExtension(afile.FileName);
                //產生新檔名
                string newName = Guid.NewGuid().ToString() + extension;//產生新檔名
                //如果上傳路徑中沒有該目錄，則自動新增
                if (!Directory.Exists(ImgUpLoadPath.Substring(0, ImgUpLoadPath.LastIndexOf("\\"))))
                {
                    Directory.CreateDirectory(ImgUpLoadPath.Substring(0, ImgUpLoadPath.LastIndexOf("\\")));
                }

                //驗證副檔名
                if (extension.ToLower() != ".jpg" && extension.ToLower() != ".jpeg" && extension.ToLower() != ".png" && extension.ToLower() != ".bmp")
                {
                    context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('FormatError');</script>");
                    return;
                }
                //上傳檔案
                afile.SaveAs(ImgUpLoadPath + newName);


                string ReturnPath = context.Request.Url.Scheme + "://" + context.Request.Url.Authority.ToString() + context.Request.ApplicationPath + "/tinymce/ImageUpload/filedownload.ashx?v=" + newName;

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