using System;
using System.Web;
using System.Configuration;
using System.Net;
using System.Data;
using System.IO;

namespace ED.HR.DOWNLOADTXT.WebForm
{
    public partial class DownloadImage : System.Web.UI.Page
    {
        File_DB File_Db = new File_DB();
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Request.QueryString["txt"] != null)
                {
                    //File_Db._file_type = "01";
                    //File_Db._file_parentid = Request.QueryString["pid"].ToString();
                    //DataTable dt = File_Db.SelectFile();
                    //if (dt.Rows.Count > 0)
                    //{
                    string fullName = "";
                    fullName = ConfigurationManager.AppSettings["UploadFileRootDir"] + Request.QueryString["txt"].ToString();
                    //fullName = Server.MapPath("~/Template/" + Request.QueryString["txt"].ToString());
                    System.IO.FileInfo files = new System.IO.FileInfo(fullName);
                    bool filestat = files.Exists;
                    if (filestat) {
                        Download(files);
                    }
                       
                    //}
                }
            }
            catch
            {

            }
        }


        private void Download(System.IO.FileInfo DownloadFile)
        {
            Response.Clear();
            Response.ClearHeaders();
            Response.Buffer = false;
            Response.ContentType = "application/octet-stream";
            string DownloadName = DownloadFile.Name;
            Response.AddHeader("Content-Disposition", "attachment; filename=" + System.Web.HttpUtility.UrlEncode(DownloadName, System.Text.Encoding.UTF8));
            Response.AppendHeader("Content-Length", DownloadFile.Length.ToString());
            Response.HeaderEncoding = System.Text.Encoding.GetEncoding("Big5");
            Response.WriteFile(DownloadFile.FullName);
            Response.Flush();
            Response.End();
        }

        #region 傳回 ContentType
        /// <summary>
        /// 傳回 ContentType
        /// </summary>
        public static string getMineType(string fname)
        {
            string fileExtension = System.IO.Path.GetExtension(fname).ToLower();
            Microsoft.Win32.RegistryKey rk = Microsoft.Win32.Registry.ClassesRoot.OpenSubKey(fileExtension);
            if (rk != null && rk.GetValue("Content Type") != null)
                return rk.GetValue("Content Type").ToString();
            else
                return "text / plain";
        }
        #endregion

        #region 驗證檔案是否存在 路徑 + 檔名
        /// <summary>
        /// 驗證檔案是否存在 路徑 + 檔名
        /// </summary>
        public static bool FileExists(string full_path)
        {
            bool is_exists = false;
            try
            {
                System.IO.FileInfo DownloadFile = new System.IO.FileInfo(full_path);
                if (DownloadFile.Exists) is_exists = true;
            }
            catch { }

            return is_exists;
        }
        #endregion

        #region 全檔案壓縮成ZIP
        //public void ZipFileDownload()
        //{
        //    if (Request.QueryString["gid"] != null && Request.QueryString["type"] != null && Request.QueryString["v"] != null)
        //    {
        //        string ZipName = "";
        //        Cont_DB Cont_Db = new Cont_DB();
        //        Cont_Db._cont_id = Request.QueryString["v"].ToString();
        //        DataTable Cdt = Cont_Db.SelectListById();
        //        if (Cdt.Rows.Count > 0)
        //            ZipName = Cdt.Rows[0]["cont_title"].ToString();
        //        File_DB File_Db = new File_DB();
        //        Xceed.Zip.ReaderWriter.Licenser.LicenseKey = "ZRT51-L1WSL-4KWJJ-GBEA";
        //        using (Stream zipFileStream = new FileStream(ConfigurationManager.AppSettings["UploadFileRootDir"] + "Photo\\" + ZipName + ".zip", FileMode.Create, FileAccess.Write))
        //        {
        //            File_Db._file_type = Request.QueryString["type"].ToString();
        //            File_Db._file_parentid = Common.Md5Decrypt(Request.QueryString["gid"].ToString());
        //            DataTable dt = File_Db.SelectFile();
        //            if (dt.Rows.Count > 0)
        //            {
        //                ZipWriter zipWriter = new ZipWriter(zipFileStream);
        //                for (int i = 0; i < dt.Rows.Count; i++)
        //                {

        //                    ZipItemLocalHeader localHeader;
        //                    //一般
        //                    localHeader = new ZipItemLocalHeader(
        //                      dt.Rows[i]["file_orgname"].ToString() + dt.Rows[i]["file_exten"].ToString(),
        //                      CompressionMethod.Deflated64,
        //                      CompressionLevel.Highest
        //                    );

        //                    zipWriter.WriteItemLocalHeader(localHeader);

        //                    using (Stream sourceStream = new FileStream(ConfigurationManager.AppSettings["UploadFileRootDir"] + "Photo\\" + dt.Rows[i]["file_encryname"].ToString() + dt.Rows[i]["file_exten"].ToString(), FileMode.Open, FileAccess.Read))
        //                    {
        //                        zipWriter.WriteItemData(sourceStream);
        //                    }
        //                }
        //                zipWriter.CloseZipFile();
        //                zipWriter.Dispose();
        //            }
        //        }

        //        System.IO.FileInfo files = new System.IO.FileInfo(UpLoadPath + "Photo\\" + ZipName + ".zip");
        //        bool filestat = files.Exists;
        //        if (filestat)
        //            Download(files);
        //    }
        //}
        #endregion
    }
}