<%@ WebHandler Language="C#" Class="ashx_Competence_Edit" %>

using System;
using System.Web;
using System.Data;

public class ashx_Competence_Edit : IHttpHandler {

    Dal dal = new Dal();
    Common com = new Common(); 
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string cmClass = (!string.IsNullOrEmpty(context.Request.Form["cmClass"])) ? context.Request.Form["cmClass"].ToString() : "";
            string XmlStr = "";
            DataView dv = dal.GetCompetenceData(cmClass).DefaultView;

            //int minNo = (pageNnumber * 10) + 1 - 10; //算sql切割 起始比數
            //int maxNo = minNo + 9; //算sql切割 迄比數
            //int topMin = ((dvList.Count - minNo) >= 10) ? 10 : dvList.Count - minNo + 1;
            //Lic.minNumber = minNo;
            //Lic.maxNumber = maxNo;
            //Lic.topMin = topMin;
            //DataView dv = dal.selLicPage(Lic).DefaultView;

            XmlStr += "<dList>";
            //XmlStr += "<quity>" + dvList.Count + "</quity>";
            //XmlStr += "<paging>" + 10 + "</paging>";
            //XmlStr += "<cur>" + pageNnumber + "</cur>";
            DateTime Today = DateTime.Now;
            for (int i = 0; i < dv.Count; i++)
            {
                XmlStr += "<dView>";

                XmlStr += "<cmName>" + dv[i]["cmName"].ToString() + "</cmName>";
                XmlStr += "<cmCompetence>" + dv[i]["cmCompetence"].ToString() + "</cmCompetence>";
                XmlStr += "<cmDesc>" + dv[i]["cmDesc"].ToString() + "</cmDesc>";

                XmlStr += "</dView>";
            }
            XmlStr += "</dList>";
            context.Response.ContentType = "text/xml";
            context.Response.Write(XmlStr);
        }
        catch (Exception ex)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Write("error");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}