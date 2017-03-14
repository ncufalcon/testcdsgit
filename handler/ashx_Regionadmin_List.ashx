<%@ WebHandler Language="C#" Class="ashx_Regionadmin_List" %>

using System;
using System.Web;
using System.Data;

public class ashx_Regionadmin_List : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/xml";
        try
        {
            string XmlStr = "";
            string cbValue = (!string.IsNullOrEmpty(context.Request.Form["cbValue"])) ? (context.Request.Form["cbValue"].ToString() == "undefined") ? "" : context.Request.Form["cbValue"].ToString() : "";
            string cbName = (!string.IsNullOrEmpty(context.Request.Form["cbName"])) ? (context.Request.Form["cbName"].ToString() == "undefined") ? "" : context.Request.Form["cbName"].ToString() : "";

            DataView dv = new DataView();

            if (string.IsNullOrEmpty(cbValue) && string.IsNullOrEmpty(cbName))
                dv = dal.SelRegionadminData().DefaultView;
            else
                dv = dal.SearchRegionadminData(cbValue, cbName).DefaultView;


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
                XmlStr += "<cbGuid>" + dv[i]["cbGuid"].ToString() + "</cbGuid>";
                XmlStr += "<cbValue>" + dv[i]["cbValue"].ToString() + "</cbValue>";
                XmlStr += "<cbName>" + dv[i]["cbName"].ToString() + "</cbName>";
                XmlStr += "<cbDesc>" + dv[i]["cbDesc"].ToString() + "</cbDesc>";
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