using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Net.Mail;
using System.Data.OleDb;

/// <summary>
/// Common 的摘要描述
/// </summary>
public class Common
{
    /// <summary>
    /// get Url前段 :http://localhost:1897/
    /// </summary>
    /// <returns></returns>
    public string GenUrl()
    {
        string UrlStr = "";
        string url_head = HttpContext.Current.Request.Url.Scheme + "://";
        string url_body = HttpContext.Current.Request.Url.Authority;
        //string url_fooder = ResolveUrl("~/EIP/News/news_view.aspx");

        UrlStr = url_head + url_body;
        return UrlStr;
    }

    /// <summary>產生亂數字串</summary>  
    /// <param name="Number">字元數</param>  
    /// <returns></returns>  
    public string CreateRandomCode(int Number)
    {
        //string allDigital = "0,1,2,3,4,5,6,7,8,9";
        //string allSmall = "a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z";
        //string allBig = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
        string allChar = "0,1,2,3,4,5,6,7,8,9,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z";
        string[] allCharArray = allChar.Split(',');
        string randomCode = "";
        int temp = -1;

        Random rand = new Random();
        for (int i = 0; i < Number; i++)
        {
            int t = 0;
            t = rand.Next(62);
            if (temp != -1)
                rand = new Random(i * temp * ((int)DateTime.Now.Ticks));

            if (temp != -1 && temp == t)
                return CreateRandomCode(Number);

            temp = t;
            randomCode += allCharArray[t];
        }
        return randomCode;
    }
    /// <summary>
    /// 加密
    /// </summary>
    public string desEncryptBase64(string source)
    {
        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        byte[] key = Encoding.ASCII.GetBytes("12345678");
        byte[] iv = Encoding.ASCII.GetBytes("87654321");
        byte[] dataByteArray = Encoding.UTF8.GetBytes(source);

        des.Key = key;
        des.IV = iv;
        string encrypt = "";
        using (MemoryStream ms = new MemoryStream())
        using (CryptoStream cs = new CryptoStream(ms, des.CreateEncryptor(), CryptoStreamMode.Write))
        {
            cs.Write(dataByteArray, 0, dataByteArray.Length);
            cs.FlushFinalBlock();
            encrypt = Convert.ToBase64String(ms.ToArray());
        }
        return encrypt;
    }

    /// <summary>
    /// 解密
    /// </summary>
    public string desDecryptBase64(string encrypt)
    {
        DESCryptoServiceProvider des = new DESCryptoServiceProvider();
        byte[] key = Encoding.ASCII.GetBytes("12345678");
        byte[] iv = Encoding.ASCII.GetBytes("87654321");
        des.Key = key;
        des.IV = iv;

        byte[] dataByteArray = Convert.FromBase64String(encrypt);
        using (MemoryStream ms = new MemoryStream())
        {
            using (CryptoStream cs = new CryptoStream(ms, des.CreateDecryptor(), CryptoStreamMode.Write))
            {
                cs.Write(dataByteArray, 0, dataByteArray.Length);
                cs.FlushFinalBlock();
                return Encoding.UTF8.GetString(ms.ToArray());
            }
        }
    }


    /// <summary>
    /// 檢查特殊字元
    /// </summary>
    /// <param name="checkValue">欲檢查的值</param>
    /// <returns></returns>
    public bool CheckSQLInjectionEncode(string checkValue)
    {
        //「%27」:「'」(單引號)
        //「%2B」:「+」(加號)
        //「%3D」:「=」(等號)
        //「%7C」:「|」(｜)
        //「ALERT(」
        //「--」
        //「%2F*」:「/*」
        //「*%2F」:「*/」
        //「%26」:「&」
        //「%40」:「@」
        //「%25」:「%」
        //「%3B」:「;」
        //「%24」:「$」
        //「%26」:「*」
        //「%22」:「"」
        //「%2C」:「,」
        //「%2f」:「/」
        //「%5c」:「\」
        //「%22」:「"」

        checkValue = HttpContext.Current.Server.UrlEncode(checkValue);

        if (checkValue.Length > 0 && (checkValue.ToUpper().IndexOf("%27") >= 0 || checkValue.ToUpper().IndexOf("%2B") >= 0
         || checkValue.ToUpper().IndexOf("'") >= 0) || checkValue.ToUpper().IndexOf("ALERT(") >= 0
         || checkValue.ToUpper().IndexOf("%3D") >= 0 || checkValue.ToUpper().IndexOf("=") >= 0
         || checkValue.ToUpper().IndexOf("--") >= 0 || checkValue.ToUpper().IndexOf("%7C") >= 0
         || checkValue.ToUpper().IndexOf("%2F*") >= 0 || checkValue.ToUpper().IndexOf("*%2F") >= 0
         || checkValue.ToUpper().IndexOf("%26") >= 0  //|| checkValue.ToUpper().IndexOf("%40") >= 0 || checkValue.ToUpper().IndexOf("%2C") >= 0 
         || checkValue.ToUpper().IndexOf("%25") >= 0  //|| checkValue.ToUpper().IndexOf("%3B") >= 0
         || checkValue.ToUpper().IndexOf("%24") >= 0 || checkValue.ToUpper().IndexOf("*") >= 0
         || checkValue.ToUpper().IndexOf("%22") >= 0 //|| checkValue.ToUpper().IndexOf("%2F") >= 0 
         || checkValue.ToUpper().IndexOf("%5C") >= 0)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    /// <summary>
    /// 檢查特殊字元導error page
    /// </summary>
    /// <param name="checkValue">欲檢查的值</param>
    /// <returns></returns>
    public void CheckSQLInjectionEncodeR(string checkValue)
    {
        //「%27」:「'」(單引號)
        //「%2B」:「+」(加號)
        //「%3D」:「=」(等號)
        //「%7C」:「|」(｜)
        //「ALERT(」
        //「--」
        //「%2F*」:「/*」
        //「*%2F」:「*/」
        //「%26」:「&」
        //「%40」:「@」
        //「%25」:「%」
        //「%3B」:「;」
        //「%24」:「$」
        //「%26」:「*」
        //「%22」:「"」
        //「%2C」:「,」
        //「%2f」:「/」
        //「%5c」:「\」
        //「%22」:「"」

        checkValue = HttpContext.Current.Server.UrlEncode(checkValue);

        if (checkValue.Length > 0 && (checkValue.ToUpper().IndexOf("%27") >= 0 || checkValue.ToUpper().IndexOf("%2B") >= 0
         || checkValue.ToUpper().IndexOf("'") >= 0) || checkValue.ToUpper().IndexOf("ALERT(") >= 0
         || checkValue.ToUpper().IndexOf("%3D") >= 0 || checkValue.ToUpper().IndexOf("=") >= 0
         || checkValue.ToUpper().IndexOf("--") >= 0 || checkValue.ToUpper().IndexOf("%7C") >= 0
         || checkValue.ToUpper().IndexOf("%2F*") >= 0 || checkValue.ToUpper().IndexOf("*%2F") >= 0
         || checkValue.ToUpper().IndexOf("%26") >= 0  //|| checkValue.ToUpper().IndexOf("%40") >= 0
         || checkValue.ToUpper().IndexOf("%25") >= 0  //|| checkValue.ToUpper().IndexOf("%3B") >= 0
         || checkValue.ToUpper().IndexOf("%24") >= 0 || checkValue.ToUpper().IndexOf("*") >= 0
         || checkValue.ToUpper().IndexOf("%22") >= 0 || checkValue.ToUpper().IndexOf("%2C") >= 0 || checkValue.ToUpper().IndexOf("%2F") >= 0 || checkValue.ToUpper().IndexOf("%5C") >= 0)
        {
            System.Web.HttpContext.Current.Response.Redirect("Error.aspx?err=par");
        }
    }


    /// <summary>
    /// 取得下載檔案的路徑
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public string getFileUrl(string id)
    {
        string defroot = VirtualPathUtility.ToAbsolute("~/filedownload.ashx?id=" + HttpContext.Current.Server.HtmlEncode(desEncryptBase64(id)));
        return defroot;
    }

    /// <summary>
    /// 取得上傳證照附件路徑
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    public string getUploadFileUrl(string id)
    {
        string root = ConfigurationManager.AppSettings["UploadFileRootDir"].ToString() + "LicFile\\" + id + "\\";
        return root;
    }
}

public class JavaScript
{
    /// <summary>
    /// AlertMessage
    /// </summary>
    public static void AlertMessage(System.Web.UI.Page objPage, string strMessage)
    {
        strMessage = strMessage.Replace("\r\n", "\\r");
        StringBuilder sb = new StringBuilder();
        sb.AppendFormat(@"<Script language=""javascript"" type=""text/javascript"">");
        sb.AppendFormat(@"alert(""{0}"");", strMessage);
        sb.AppendFormat(@"</Script>");

        //objPage.ClientScript.RegisterClientScriptBlock(objPage.GetType(), "", strJS, false);
        objPage.ClientScript.RegisterStartupScript(objPage.GetType(), "", sb.ToString(), false);
    }

    /// <summary>
    /// AlertMessageClose
    /// </summary>
    public static void AlertMessageClose(System.Web.UI.Page objPage, string strMessage)
    {
        string strJS = "";
        strMessage = strMessage.Replace("\r\n", "\\r");
        strJS = @"<Script language='javascript' type='text/javascript' >";
        strJS += "alert('" + strMessage + "');";
        strJS += "window.close();";
        strJS += "</Script>";
        //objPage.ClientScript.RegisterClientScriptBlock(objPage.GetType(), "", strJS, false);
        objPage.ClientScript.RegisterStartupScript(objPage.GetType(), "", strJS, false);
    }

    /// <summary>
    /// AlertMessageRedirect
    /// </summary>
    public static void AlertMessageRedirect(System.Web.UI.Page objPage, string strMessage, string strRedirectPage)
    {
        AlertMessageRedirect(objPage, strMessage, strRedirectPage, false);
    }

    public static void AlertMessageRedirect(System.Web.UI.Page objPage, string strMessage, string strRedirectPage, bool IsDisplayData)
    {
        string strJS = "";
        strMessage = strMessage.Replace("\r\n", "\\r");
        strJS = @"<Script language='javascript' type='text/javascript'>";
        strJS += "alert('" + strMessage + "');";
        strJS += "window.location ='" + strRedirectPage + "'; ";
        strJS += "</Script>";

        if (IsDisplayData)
            objPage.ClientScript.RegisterStartupScript(objPage.GetType(), "", strJS, false);
        else
            objPage.ClientScript.RegisterClientScriptBlock(objPage.GetType(), "", strJS, false);
    }
}