<%@ WebHandler Language="C#" Class="ashx_Competence_List" %>

using System;
using System.Web;
using System.Data;

public class ashx_Competence_List : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/xml";
        try
        {
            string XmlStr = "";
            string cmClass = (!string.IsNullOrEmpty(context.Request.Form["cmClass"])) ? (context.Request.Form["cmClass"].ToString() == "undefined") ? "" : context.Request.Form["cmClass"].ToString() : "";
            

            DataView dv = new DataView();

            if (string.IsNullOrEmpty(cmClass))
                dv = dal.SelCompetence().DefaultView;
            else
                dv = dal.SearchCompetenceData(cmClass,"").DefaultView;


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
                XmlStr += "<cmClass>" + dv[i]["cmClass"].ToString() + "</cmClass>";
                XmlStr += "<cmName>" + dv[i]["cmName"].ToString() + "</cmName>";
                XmlStr += "<cmCompetence>" + dv[i]["cmCompetence"].ToString() + "</cmCompetence>";
                XmlStr += "<cmDesc>" + dv[i]["cmDesc"].ToString() + "</cmDesc>";
                XmlStr += "</dView>";
            }
            XmlStr += "</dList>";

            context.Response.Write(XmlStr);
        }
        catch (Exception ex)
        {

            context.Response.Write("<dList>error</dList>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}