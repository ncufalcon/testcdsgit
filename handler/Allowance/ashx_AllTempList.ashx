﻿<%@ WebHandler Language="C#" Class="ashx_AllTempList" %>

using System;
using System.Web;
using System.Data;
public class ashx_AllTempList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{


    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/xml";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = new DataView();
                string XmlStr = "";
                string perNo = (!string.IsNullOrEmpty(context.Request.Form["perNo"])) ? context.Request.Form["perNo"].ToString() : "";
                string perName = (!string.IsNullOrEmpty(context.Request.Form["perName"])) ? context.Request.Form["perName"].ToString() : "";
                string perCom = (!string.IsNullOrEmpty(context.Request.Form["perCom"])) ? context.Request.Form["perCom"].ToString() : "";
                string perDep = (!string.IsNullOrEmpty(context.Request.Form["perDep"])) ? context.Request.Form["perDep"].ToString() : "";
                if (perNo == "" && perName == "" && perCom == "" && perDep == "")
                    dv = dal.SelAllowanceTempTop200().DefaultView;
                else
                    dv = dal.SelAllowanceTemp(perNo, perName, perCom, perDep).DefaultView;

                XmlStr += "<dList>";
                for (int i = 0; i < dv.Count; i++)
                {
                    XmlStr += "<dView>";
                    XmlStr += "<atGuid>" + dv[i]["atGuid"].ToString() + "</atGuid>";
                    XmlStr += "<atPerNo>" + dv[i]["atPerNo"].ToString() + "</atPerNo>";
                    XmlStr += "<atDate>" + dv[i]["atDate"].ToString() + "</atDate>";
                    XmlStr += "<atItem>" + dv[i]["atItem"].ToString() + "</atItem>";
                    XmlStr += "<atCost>" + dv[i]["atCost"].ToString() + "</atCost>";
                    XmlStr += "<siItemName>" + dv[i]["siItemName"].ToString() + "</siItemName>";
                    XmlStr += "<perName>" + dv[i]["perName"].ToString() + "</perName>";

                    XmlStr += "</dView>";
                }
                XmlStr += "</dList>";

                context.Response.Write(XmlStr);
            }
            else { context.Response.Write("<dList>t</dList>"); }
        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            //err.InsErrorLog("ashx_NewStaffList.ashx", ex.Message, USERINFO.MemberEmpno);
            context.Response.Write("<dList>e</dList>");
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}