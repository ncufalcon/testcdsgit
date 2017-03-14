<%@ WebHandler Language="C#" Class="ashx_Admin_SaveData" %>

using System;
using System.Web;
using System.Data;

public class ashx_Admin_SaveData : IHttpHandler {

    Dal dal = new Dal();
    Common com = new Common();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(context.Request.Form["mbName"])
                && !string.IsNullOrEmpty(context.Request.Form["mbJobNumber"])
                && !string.IsNullOrEmpty(context.Request.Form["mbId"])
                && !string.IsNullOrEmpty(context.Request.Form["mbPassword"])
                && !string.IsNullOrEmpty(context.Request.Form["mbCom"])
                || !string.IsNullOrEmpty(context.Request.Form["mbGuid"]))
            {
                string mbGuid = (!string.IsNullOrEmpty(context.Request.Form["mbGuid"])) ? context.Request.Form["mbGuid"].ToString() : "";

                string EditType = (!string.IsNullOrEmpty(context.Request.Form["EditType"])) ? context.Request.Form["EditType"].ToString() : "";

                string mbName = (!string.IsNullOrEmpty(context.Request.Form["mbName"])) ? context.Request.Form["mbName"].ToString() : "";
                string mbJobNumber = (!string.IsNullOrEmpty(context.Request.Form["mbJobNumber"])) ? context.Request.Form["mbJobNumber"].ToString() : "";
                string mbId = (!string.IsNullOrEmpty(context.Request.Form["mbId"])) ? context.Request.Form["mbId"].ToString() : "";

                string mbPassword = (!string.IsNullOrEmpty(context.Request.Form["mbPassword"])) ? context.Request.Form["mbPassword"].ToString() : "";
                string mbCom = (!string.IsNullOrEmpty(context.Request.Form["mbCom"])) ? context.Request.Form["mbCom"].ToString() : "";
                string mbPs = (!string.IsNullOrEmpty(context.Request.Form["mbPs"])) ? context.Request.Form["mbPs"].ToString() : "";


                string msg = CheckSqlInJection(mbName, mbJobNumber, mbId, mbPassword, mbCom, mbPs);

                string passw = com.desEncryptBase64(mbPassword);
                string Id = "12345";
                DateTime Date = DateTime.Now;


                switch (EditType)
                {
                    case "Ins":
                        if (msg == "")
                        {
                            DataTable dt = dal.SearchAdminData("", "", "", mbId);
                            if (dt.Rows.Count == 0)
                            {
                                dal.insertAdmin(mbName, mbJobNumber, mbId, passw, mbPs, mbCom, Id);
                                context.Response.Write("OK");
                            }
                            else
                                context.Response.Write("repeat");
                        }
                        else { context.Response.Write("sign"); }

                        break;
                    case "Up":
                        if (msg == "")
                        {
                            dal.Up_AdminData(mbName, mbJobNumber, mbId, passw, mbPs, mbCom, Id, Date, mbGuid);
                            context.Response.Write("OK");
                        }
                        else { context.Response.Write("sign"); }
                        break;
                    case "Del":
                        if (msg == "")
                        {
                            dal.Up_Status_AdminData(mbGuid, Id, Date);
                            context.Response.Write("OK");
                        }
                        else { context.Response.Write("sign"); }
                        break;
                }
                //context.Response.Write("OK");

            }
            else { context.Response.Write("Timeout"); }
        }
        catch (Exception ex) { context.Response.Write("error"); }
    }

    /// <summary>
    /// 驗證危險字元
    /// </summary>
    private string CheckSqlInJection(string mbName, string mbJobNumber, string mbId, string mbPassword, string mbCom, string mbPs)
    {
        Common com = new Common();
        string msg = "";
        if (com.CheckSQLInjectionEncode(mbName) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(mbJobNumber) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(mbId) == false)
            msg = "1";

        if (com.CheckSQLInjectionEncode(mbPassword) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(mbCom) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(mbPs) == false)
            msg = "1";

        return msg;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}