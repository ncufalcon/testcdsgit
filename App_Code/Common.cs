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
using System.Globalization;

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
    /// 傳入陣列字串 驗證危險字元 如果有危險字元則回傳 N 否則 空白
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string CheckSqlInJection(string[] str)
    {
        string s = "";
        for (int i = 0; i < str.Length; i++)
        {
            if (!CheckSQLInjectionEncode(str[i]))
                s = "N";
        }
        return s;
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


    public void Logout()
    {
        HttpContext.Current.Session.Remove("MemberInfo_Guid");
        HttpContext.Current.Session.Remove("MemberInfo_Name");
        HttpContext.Current.Session.Remove("MemberInfo_Class");
        HttpContext.Current.Session.Remove("MemberInfo_Competence");
    }

    /// <summary>
    /// 驗證字串null傳回""
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string cSNull(string str)
    {
        str = (!string.IsNullOrEmpty(str)) ? str : "";
        return str;
    }

    /// <summary>
    /// 驗證數字null傳回0
    /// </summary>
    /// <param name="d"></param>
    /// <returns></returns>
    public decimal cDNull(decimal d)
    {
        d = (!string.IsNullOrEmpty(d.ToString())) ? d : 0;
        return d;
    }


    #region 檢查有效日期 並回傳yyyy/MM/dd
    /// <summary>
    /// 檢查有效日期(錯誤時回傳訊息；否則，回傳空值。)
    /// </summary>
    /// <param name="inputDate">日期</param>
    /// <returns>錯誤時回傳訊息；否則，回傳空值。</returns>
    public string IsDateFormatRDate(string inputDate)
    {
        try
        {
            string msg = "";
            if (inputDate != "")
            {
                if (inputDate.Length < 8 || inputDate.Length > 10)
                {
                    msg = "請輸入yyyy/MM/dd或yyyyMMdd的日期格式!";
                }
                else
                {
                    try
                    {
                        string[] DateTimeList = { "yyyy/M/d tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd HH:mm:ss",
                                              "yyyy/MM/dd",
                                              "yyyyMMdd"
                                            };
                        DateTime dt = DateTime.ParseExact(inputDate, DateTimeList, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces);
                        msg = dt.ToString("yyyy/MM/dd");
                    }
                    catch
                    {
                        msg = "";
                    }
                }
            }

            return msg;

        }
        catch (Exception ex)
        {
            return "";
        }
    }
    #endregion


    #region 檢查有效日期
    /// <summary>
    /// 檢查有效日期(錯誤時回傳訊息；否則，回傳空值。)
    /// </summary>
    /// <param name="inputDate">日期</param>
    /// <returns>錯誤時回傳訊息；否則，回傳空值。</returns>
    public string IsDateFormat(string inputDate)
    {
        try
        {
            string msg = "";
            if (inputDate != "")
            {
                if (inputDate.Length < 8 || inputDate.Length > 10)
                {
                    msg = "請輸入yyyy/MM/dd或yyyyMMdd的日期格式!";
                }
                else
                {
                    try
                    {
                        string[] DateTimeList = { "yyyy/M/d tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd HH:mm:ss",
                                              "yyyy/MM/dd",
                                              "yyyyMMdd"
                                            };
                        DateTime dt = DateTime.ParseExact(inputDate, DateTimeList, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces);
                    }
                    catch
                    {
                        msg = "請輸入有效日期!";
                    }
                }
            }

            return msg;

        }
        catch (Exception ex)
        {
            throw new Exception("檢查日期(common.IsDateFormat)發生錯誤，錯誤訊息：" + ex.Message);
        }
    }
    #endregion

    #region 檢查起迄有效日期
    /// <summary>
    /// 檢查起迄有效日期(錯誤時回傳訊息；否則，回傳空值。)
    /// </summary>
    /// <param name="inputSDate">開始日期</param>
    /// /// <param name="inputEDate">結束日期</param>
    /// <returns>錯誤時回傳訊息；否則，回傳空值。</returns>
    public string IsDateFormatSE(string inputSDate, string inputEDate)
    {
        try
        {
            string msg = "";
            DateTime sdt = new DateTime();
            DateTime edt = new DateTime();
            if (inputSDate != "")
            {
                if (inputSDate.Length < 8 || inputSDate.Length > 15)
                {
                    msg = "開始日期，請輸入yyyy/MM/dd或yyyyMMdd的日期格式!\n";
                }
                else
                {
                    try
                    {
                        string[] DateTimeList = { "yyyy/M/d tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd HH:mm:ss",
                                              "yyyyMMdd HHmm",
                                              "yyyy/MM/dd",
                                              "yyyyMMdd"
                                            };
                        sdt = DateTime.ParseExact(inputSDate, DateTimeList, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces);
                    }
                    catch
                    {
                        msg = "開始日期，請輸入有效日期!\n";
                    }
                }
            }

            if (inputEDate != "")
            {
                if (inputEDate.Length < 8 || inputEDate.Length > 15)
                {
                    msg += "結束日期，請輸入yyyy/MM/dd或yyyyMMdd的日期格式!";
                }
                else
                {
                    try
                    {
                        string[] DateTimeList = { "yyyy/M/d tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd tt hh:mm:ss",
                                              "yyyy/MM/dd HH:mm:ss",
                                              "yyyyMMdd HHmm",
                                              "yyyy/MM/dd",
                                              "yyyyMMdd"
                                            };
                        edt = DateTime.ParseExact(inputEDate, DateTimeList, CultureInfo.InvariantCulture, DateTimeStyles.AllowWhiteSpaces);
                    }
                    catch
                    {
                        msg += "結束日期，請輸入有效日期!";
                    }
                }
            }

            if (inputSDate != "" && inputEDate != "" && msg == "")
            {
                if (edt < sdt)
                {
                    msg = "開始時間不可大於或等於結束時間!";
                }
            }

            return msg;

        }
        catch (Exception ex)
        {
            throw new Exception("檢查起迄有效日期(common.IsDateFormat)發生錯誤，錯誤訊息：" + ex.Message);
        }
    }
    #endregion


    /// <summary>
    /// 計算日期相差 返回相差時數(yyyyMMddHHmm)
    /// </summary>
    /// <param name="StartDate"></param>
    /// <param name="EndDate"></param>
    /// <returns></returns>
    public string getDateDifference(string StartDate, string EndDate)
    {
        try
        {
            string Differe = "";

            DateTime DateStart = DateTime.ParseExact(StartDate, "yyyyMMddHHmm", null, System.Globalization.DateTimeStyles.AllowWhiteSpaces);
            DateTime DateEnd = DateTime.ParseExact(EndDate, "yyyyMMddHHmm", null, System.Globalization.DateTimeStyles.AllowWhiteSpaces);

            TimeSpan Total = DateEnd.Subtract(DateStart); //日期相減
            Differe = Total.Hours.ToString(); //共幾小時

            return Differe;
        }
        catch
        {
            return "資料錯誤";
        }
    }

    /// <summary>
    /// 驗證數字 如果為0則傳回空
    /// </summary>
    /// <returns></returns>
    public string checkNumber(string n)
    {
        if (!string.IsNullOrEmpty(n))
        {
            if (Math.Ceiling(double.Parse(n)) == 0)
            { return ""; }
            else { return n; }
        }
        else { return ""; }

    }


    /// <summary>
    /// 去小數點後的 0
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public string cutPointZero(string str)
    {
        try
        {
            if (str.IndexOf(".") > 0)
            {
                while (str.Substring(str.Length - 1, 1).Equals("0"))
                {
                    str = str.Substring(0, str.Length - 1);
                }

                if (str.Substring(str.Length - 1, 1).Equals("."))
                    str = str.Substring(0, str.Length - 1);
            }

            return str;
        }catch(Exception ex) { return "0"; }
    }


    /// <summary>
    /// 去小數點後的 0 型態轉double
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public double toDou(string str)
    {
        try
        {
            if (str.IndexOf(".") > 0)
            {
                while (str.Substring(str.Length - 1, 1).Equals("0"))
                {
                    str = str.Substring(0, str.Length - 1);
                }

                if (str.Substring(str.Length - 1, 1).Equals("."))
                    str = str.Substring(0, str.Length - 1);
            }

            double dec = 0;
            bool b = double.TryParse(str, out dec);
            if (b == true)
                return double.Parse(str);
            else
                return 0;
        }
        catch (Exception ex) { return 0; }
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





#region 系統管理者登入使用
/// <summary>
/// MbrAccount 的摘要描述。
/// </summary>
public class Member
{
    /// <summary>
    /// 進行帳號登入檢查，通過後會取得登入者資料並放入session:ds_CurrentUser
    /// </summary>
    /// <param name="id">帳號</param>
    /// <param name="pd">密碼</param>
    /// <returns></returns>
    public MemberInfo mLogon(string id, string pd)
    {
        SqlConnection Sqlconn = new payroll_sqlconn().conn;
        DataTable dt = new DataTable();
        string sql = @"SELECT mbGuid
      ,mbName
      ,mbJobNumber
      ,mbId
      ,mbPassword
      ,mbPs
      ,mbCom
      ,cmCompetence FROM sy_Member left join sy_MemberCom on mbCom=cmClass where mbId=@mbId and mbPassword=@mbPassword and mbStatus<>'D' ";

        SqlCommand cmd = new SqlCommand(sql, Sqlconn);
        cmd.Parameters.AddWithValue("@mbId", id);
        cmd.Parameters.AddWithValue("@mbPassword", pd);
        try
        {
            cmd.Connection.Open();
            new SqlDataAdapter(cmd).Fill(dt);
        }
        catch (Exception ex) { throw ex; }
        finally { cmd.Connection.Close(); cmd.Dispose(); }
        if (dt.Rows.Count > 0)
            return new MemberInfo(dt);
        else
            return null;

    }

}
/*-------------------------------------------------------------------------------------------------------------------------*/

/// <summary>
/// 廠商會員的摘要描述。
/// </summary>
public class MemberInfo
{

    public MemberInfo(DataTable dt)
    {

        USERINFO userinfo = new USERINFO();
        LoginINFO Loginfo = new LoginINFO();

        if (dt.Rows.Count > 0)
        {
            DataRow dr = dt.Rows[0];
            Loginfo.MemberGuid = dr["mbGuid"].ToString();
            Loginfo.MemberName = dr["mbName"].ToString();
            Loginfo.MemberClass = dr["mbCom"].ToString();
            Loginfo.MemberCompetence = dr["cmCompetence"].ToString();
        }

        USERINFO.SET_SESSION(Loginfo);

    }
}

/*-------------------------------------------------------------------------------------------------------------------------*/
#endregion