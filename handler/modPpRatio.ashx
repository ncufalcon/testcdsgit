<%@ WebHandler Language="C#" Class="modPpRatio" %>

using System;
using System.Web;
using System.Xml;
using System.Web.SessionState;

public class modPpRatio : IHttpHandler,IRequiresSessionState {
    ErrorLog err = new ErrorLog();
    PersonPension_DB pp_db = new PersonPension_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            if (string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                context.Response.Write("LoginFailed");
                return;
            }

            string pGuid = (context.Request.Form["pGuid"] != null) ? context.Request.Form["pGuid"].ToString() : "";
            string ChangeDate = (context.Request.Form["ChangeDate"] != null) ? context.Request.Form["ChangeDate"].ToString() : "";
            string xmlstr = (context.Request.Form["xmlstr"] != null) ? context.Request.Form["xmlstr"].ToString() : "";

            string[] pgid = pGuid.Split(',');
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(context.Server.UrlDecode(xmlstr));
            XmlNode node = doc.SelectSingleNode("/root/dataList");//選擇節點
            for (int i = 0; i < pgid.Length; i++)
            {
                foreach (XmlNode childNode in node.ChildNodes)
                {
                    if (childNode["perGuid"].InnerText != pgid[i])
                        continue;

                    pp_db._ppGuid = Guid.NewGuid().ToString();
                    pp_db._ppPerGuid = childNode["perGuid"].InnerText;
                    pp_db._ppChange = "02";
                    pp_db._ppChangeDate = ChangeDate;
                    if (double.Parse(childNode["perYears"].InnerText) >= 2 && double.Parse(childNode["perYears"].InnerText) < 3)
                        pp_db._ppEmployerRatio = decimal.Parse("6.5");
                    else if(double.Parse(childNode["perYears"].InnerText) >= 3)
                        pp_db._ppEmployerRatio = decimal.Parse("7");
                    pp_db._ppLarboRatio = decimal.Parse(childNode["ppLarboRatio"].InnerText);
                    pp_db._ppPayPayroll = decimal.Parse(childNode["ppPayPayroll"].InnerText);
                    pp_db._ppCreateId = USERINFO.MemberGuid;
                    pp_db._ppModifyId = USERINFO.MemberGuid;
                    pp_db.addPension();
                }
            }
            context.Response.Write("succeed");
        }
        catch (Exception ex) {
            err.InsErrorLog("modPpRatio.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("error");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}