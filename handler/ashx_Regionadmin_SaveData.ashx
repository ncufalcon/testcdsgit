<%@ WebHandler Language="C#" Class="ashx_Regionadmin_SaveData" %>

using System;
using System.Web;
using System.Data;

public class ashx_Regionadmin_SaveData : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(context.Request.Form["cbValue"])
                && !string.IsNullOrEmpty(context.Request.Form["cbName"])
                || !string.IsNullOrEmpty(context.Request.Form["cbGuid"]))
            {
                string cbGuid = (!string.IsNullOrEmpty(context.Request.Form["cbGuid"])) ? context.Request.Form["cbGuid"].ToString() : "";

                string EditType = (!string.IsNullOrEmpty(context.Request.Form["EditType"])) ? context.Request.Form["EditType"].ToString() : "";

                string cbValue = (!string.IsNullOrEmpty(context.Request.Form["cbValue"])) ? context.Request.Form["cbValue"].ToString() : "";
                string cbName = (!string.IsNullOrEmpty(context.Request.Form["cbName"])) ? context.Request.Form["cbName"].ToString() : "";
                string cbDesc = (!string.IsNullOrEmpty(context.Request.Form["cbDesc"])) ? context.Request.Form["cbDesc"].ToString() : "";



                string msg = CheckSqlInJection(cbValue, cbName, cbDesc);

                
                    string Id = "12345";
                    DateTime Date = DateTime.Now;

                    
                    switch (EditType)
                    {
                        case "Ins":
                            if (msg == "")
                            {
                                DataTable dt = dal.SearchRegionadminData(cbValue, "");
                                if (dt.Rows.Count == 0)
                                {
                                    dal.insertRegionadmin(cbValue, cbName, cbDesc, Id);
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
                                dal.Up_RegionadminData(cbGuid, cbValue, cbName, cbDesc, Id, Date);
                                context.Response.Write("OK");
                            }
                            else { context.Response.Write("sign"); }
                            break;
                        case "Del":
                            if (msg == "")
                            {
                                dal.Up_Status_RegionadminData(cbGuid, Id, Date);
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
    private string CheckSqlInJection(string cbValue, string cbName, string cbDesc)
    {
        Common com = new Common();
        string msg = "";
        if (com.CheckSQLInjectionEncode(cbValue) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(cbName) == false)
            msg = "1";
        if (com.CheckSQLInjectionEncode(cbDesc) == false)
            msg = "1";
        
        return msg;
    }
    public bool IsReusable {
        get {
            return false;
        }
    }

}