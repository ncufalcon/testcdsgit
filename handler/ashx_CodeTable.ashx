<%@ WebHandler Language="C#" Class="ashx_CodeTable" %>

using System;
using System.Web;
using System.Collections.Generic;
using System.Data;

public class ashx_CodeTable : IHttpHandler {

    partial class Code
    {
        public string Text { get; set; }
        public string Value { get; set; }
    }
    Dal dal = new Dal();

    public void ProcessRequest(HttpContext context)
    {

        if (!string.IsNullOrEmpty(context.Request.Form["Class"]))
        {
            string ClassStr = context.Request.Form["Class"].ToString();
            string ans = "";
            context.Response.ContentType = "application/json";
            List<Code> Tool_List = new List<Code>();
            DataView dv = new DataView();
            switch (ClassStr)
            {
                case "City":
                    dv = dal.city().DefaultView;
                    for (int i = 0; i < dv.Count; i++)
                    {
                        Code e = new Code();
                        e.Text = dv[i]["code_desc"].ToString();
                        e.Value = dv[i]["code_value"].ToString();
                        Tool_List.Add(e);
                    }
                    break;

                case "Member":
                    dv = dal.Member().DefaultView;
                    for (int i = 0; i < dv.Count; i++)
                    {
                        Code e = new Code();
                        e.Text = dv[i]["cmName"].ToString();
                        e.Value = dv[i]["cmClass"].ToString();
                        Tool_List.Add(e);
                    }
                    break;

                case "MemberCom":
                    dv = dal.SelCompetence().DefaultView;
                    for (int i = 0; i < dv.Count; i++)
                    {
                        Code e = new Code();
                        e.Text = dv[i]["cmName"].ToString();
                        e.Value = dv[i]["cmClass"].ToString();
                        Tool_List.Add(e);
                    }
                    break;

                case "MemberGroup":
                    dv = dal.MemberGroup().DefaultView;
                    for (int i = 0; i < dv.Count; i++)
                    {
                        Code e = new Code();
                        e.Text = dv[i]["gpName"].ToString();
                        e.Value = dv[i]["gpCode"].ToString();
                        Tool_List.Add(e);
                    }
                    break;
            }


            System.Web.Script.Serialization.JavaScriptSerializer objSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            ans = objSerializer.Serialize(Tool_List);
            context.Response.Write(ans);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}