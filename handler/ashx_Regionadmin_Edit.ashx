<%@ WebHandler Language="C#" Class="ashx_Regionadmin_Edit" %>

using System;
using System.Web;
using System.Data;

public class ashx_Regionadmin_Edit : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string cbGuid = (!string.IsNullOrEmpty(context.Request.Form["cbGuid"])) ? context.Request.Form["cbGuid"].ToString() : "";
            string XmlStr = "";
            DataView dv = dal.GetRegionadminData(cbGuid).DefaultView;

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

                XmlStr += "<cbValue>" + dv[i]["cbValue"].ToString() + "</cbValue>";
                XmlStr += "<cbName>" + dv[i]["cbName"].ToString() + "</cbName>";
                XmlStr += "<cbDesc>" + dv[i]["cbDesc"].ToString() + "</cbDesc>";
                
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