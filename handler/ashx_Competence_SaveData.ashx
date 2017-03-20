<%@ WebHandler Language="C#" Class="ashx_Competence_SaveData" %>

using System;
using System.Web;
using System.Data;

public class ashx_Competence_SaveData : IHttpHandler {

    Dal dal = new Dal();
    Common com = new Common();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(context.Request.Form["cmName"])
                || !string.IsNullOrEmpty(context.Request.Form["cmClass"]))
            {
                string cmClass = (!string.IsNullOrEmpty(context.Request.Form["cmClass"])) ? context.Request.Form["cmClass"].ToString() : "";

                string EditType = (!string.IsNullOrEmpty(context.Request.Form["EditType"])) ? context.Request.Form["EditType"].ToString() : "";

                string cmName = (!string.IsNullOrEmpty(context.Request.Form["cmName"])) ? context.Request.Form["cmName"].ToString() : "";
                string cmCompetence = (!string.IsNullOrEmpty(context.Request.Form["comVal"])) ? context.Request.Form["comVal"].ToString() : "";
                string cmDesc = (!string.IsNullOrEmpty(context.Request.Form["cmDesc"])) ? context.Request.Form["cmDesc"].ToString() : "";


                string[] str = { cmName, cmCompetence, cmDesc};
                string msg = com.CheckSqlInJection(str);

                string Id = "12345";
                DateTime Date = DateTime.Now;

                //cmCompetence = "01,02";

                DataTable dt_int = dal.SelCompetenceInt();
                string str_class = "";
                if (dt_int.Rows.Count != 0)
                {
                    int int_class = int.Parse(dt_int.Rows[0]["cmClass"].ToString());
                    if (int_class > 0)
                        int_class = int_class+1;

                    else
                        int_class = 1;

                    str_class = "0" + int_class.ToString();
                        
                }
                
                switch (EditType)
                {
                    case "Ins":
                        if (msg == "")
                        {
                            DataTable dt = dal.SearchCompetenceData("", cmName);
                            if (dt.Rows.Count == 0)
                            {
                                dal.insertCompetence(str_class,cmName,cmCompetence,cmDesc, Id);
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
                            dal.Up_CompetenceData(cmName,cmCompetence,cmDesc, Id, Date,cmClass);
                            context.Response.Write("OK");
                        }
                        else { context.Response.Write("sign"); }
                        break;
                    case "Del":
                        if (msg == "")
                        {
                            dal.Del_CompetenceData(cmClass);
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
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}