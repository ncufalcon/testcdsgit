<%@ WebHandler Language="C#" Class="ashx_Admin_List" %>

using System;
using System.Web;
using System.Data;

public class ashx_Admin_List : IHttpHandler {

    Dal dal = new Dal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/xml";
        try
        {
            string XmlStr = "";
            string mbName = (!string.IsNullOrEmpty(context.Request.Form["mbName"])) ? (context.Request.Form["mbName"].ToString() == "undefined") ? "" : context.Request.Form["mbName"].ToString() : "";
            string mbJobNumber = (!string.IsNullOrEmpty(context.Request.Form["mbJobNumber"])) ? (context.Request.Form["mbJobNumber"].ToString() == "undefined") ? "" : context.Request.Form["mbJobNumber"].ToString() : "";
            string mbCom = (!string.IsNullOrEmpty(context.Request.Form["mbCom"])) ? (context.Request.Form["mbCom"].ToString() == "undefined") ? "" : context.Request.Form["mbCom"].ToString() : "";
            
            DataView dv = new DataView();

            if (string.IsNullOrEmpty(mbName) && string.IsNullOrEmpty(mbJobNumber) && string.IsNullOrEmpty(mbCom))
                dv = dal.SelAdmin().DefaultView;
            else
                dv = dal.SearchAdminData(mbName, mbJobNumber, mbCom,"").DefaultView;


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
                XmlStr += "<mbGuid>" + dv[i]["mbGuid"].ToString() + "</mbGuid>";
                XmlStr += "<mbName>" + dv[i]["mbName"].ToString() + "</mbName>";
                XmlStr += "<mbJobNumber>" + dv[i]["mbJobNumber"].ToString() + "</mbJobNumber>";
                string mbname = "";
                if (dv[i]["mbCom"].ToString() != "")
                    mbname = dal.MemberName(dv[i]["mbCom"].ToString());
                else
                    mbname = "此角色已刪除";
                XmlStr += "<mbCom>" + mbname + "</mbCom>";
                XmlStr += "<mbPs>" + dv[i]["mbPs"].ToString() + "</mbPs>";
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