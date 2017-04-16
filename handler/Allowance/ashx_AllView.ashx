<%@ WebHandler Language="C#" Class="ashx_AllView" %>

using System;
using System.Web;
using System.Data;
public class ashx_AllView : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/xml";
        try
        {
            string XmlStr = "";
            DataView dv = new DataView();
            string guid = (!string.IsNullOrEmpty(context.Request.Form["guid"])) ? context.Request.Form["guid"].ToString() : "";
            payroll.model.sy_PersonSingleAllowance pModel = new payroll.model.sy_PersonSingleAllowance();
            pModel.paGuid = guid;
            dv = dal.SelPersonSingleAllowance(pModel).DefaultView;

            XmlStr += "<dList>";
            for (int i = 0; i < dv.Count; i++)
            {
                XmlStr += "<dView>";
                XmlStr += "<paGuid>" + dv[i]["paGuid"].ToString() + "</paGuid>";
                XmlStr += "<paPerGuid>" + dv[i]["paPerGuid"].ToString() + "</paPerGuid>";
                XmlStr += "<paAllowanceCode>" + dv[i]["paAllowanceCode"].ToString() + "</paAllowanceCode>";
                XmlStr += "<paPrice>" + dv[i]["paPrice"].ToString() + "</paPrice>";
                XmlStr += "<paQuantity>" + dv[i]["paQuantity"].ToString() + "</paQuantity>";
                XmlStr += "<paCost>" + dv[i]["paCost"].ToString() + "</paCost>";
                XmlStr += "<paDate>" + dv[i]["paDate"].ToString() + "</paDate>";
                XmlStr += "<paPs>" + dv[i]["paPs"].ToString() + "</paPs>";
                XmlStr += "<paCreateId>" + dv[i]["paCreateId"].ToString() + "</paCreateId>";
                XmlStr += "<paModifyId>" + dv[i]["paModifyId"].ToString() + "</paModifyId>";
                XmlStr += "<paStatus>" + dv[i]["paStatus"].ToString() + "</paStatus>";
                XmlStr += "<perName>" + dv[i]["perName"].ToString() + "</perName>";
                XmlStr += "<perNo>" + dv[i]["perNo"].ToString() + "</perNo>";
                XmlStr += "<siItemCode>" + dv[i]["siItemCode"].ToString() + "</siItemCode>";
                XmlStr += "<siItemName>" + dv[i]["siItemName"].ToString() + "</siItemName>";
                XmlStr += "<siAdd>" + dv[i]["siAdd"].ToString() + "</siAdd>";
                XmlStr += "<siAddChi>" + dv[i]["siAddChi"].ToString() + "</siAddChi>";
                XmlStr += "</dView>";
            }
            XmlStr += "</dList>";
            context.Response.Write(XmlStr);

        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            //err.InsErrorLog("ashx_NewStaffList.ashx", ex.Message, USERINFO.MemberEmpno);
            context.Response.Write("<dList>error</dList>");
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