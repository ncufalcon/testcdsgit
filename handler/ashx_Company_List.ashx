<%@ WebHandler Language="C#" Class="ashx_Company_List" %>

using System;
using System.Web;
using System.Data;

public class ashx_Company_List : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context){
                    context.Response.ContentType = "text/xml";
        try
        {
            string XmlStr = "";
            string comName = (!string.IsNullOrEmpty(context.Request.Form["comName"])) ? (context.Request.Form["comName"].ToString() == "undefined") ? "" : context.Request.Form["comName"].ToString() : "";
            string comUniform = (!string.IsNullOrEmpty(context.Request.Form["comUniform"])) ? (context.Request.Form["comUniform"].ToString() == "undefined") ? "" : context.Request.Form["comUniform"].ToString(): "";
            
            DataView dv = new DataView();

            if (string.IsNullOrEmpty(comName) && string.IsNullOrEmpty(comUniform))
                dv = dal.SelCompanyData().DefaultView;
            else
                dv = dal.SearchCompanyData(comName, comUniform).DefaultView;

            
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
                XmlStr += "<comGuid>" + dv[i]["comGuid"].ToString() + "</comGuid>";    
                XmlStr += "<comName>" + dv[i]["comName"].ToString() + "</comName>";
                XmlStr += "<comAbbreviate>" + dv[i]["comAbbreviate"].ToString() + "</comAbbreviate>";
                XmlStr += "<comUniform>" + dv[i]["comUniform"].ToString() + "</comUniform>";
                XmlStr += "<comBusinessEntity>" + dv[i]["comBusinessEntity"].ToString() + "</comBusinessEntity>";
                XmlStr += "<comResponsible>" + dv[i]["comResponsible"].ToString() + "</comResponsible>";
                XmlStr += "<comTel>" + dv[i]["comTel"].ToString() + "</comTel>";                
                XmlStr += "<comAddress1>" + dv[i]["comAddress1"].ToString() + "</comAddress1>";                                
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