<%@ WebHandler Language="C#" Class="ashx_AllList" %>

using System;
using System.Web;
using System.Data;
public class ashx_AllList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
        Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/xml";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string XmlStr = "";
                DataView dv = new DataView();
                string psaPerGuid = (!string.IsNullOrEmpty(context.Request.Form["psaPerGuid"])) ? context.Request.Form["psaPerGuid"].ToString() : "";
                string psaPsmGuid = (!string.IsNullOrEmpty(context.Request.Form["psaPsmGuid"])) ? context.Request.Form["psaPsmGuid"].ToString() : "";

                string[] str = { psaPerGuid, psaPsmGuid};
                string sqlinj = com.CheckSqlInJection(str);

                payroll.model.sy_PayAllowance pModel = new payroll.model.sy_PayAllowance();
                pModel.psaPerGuid = psaPerGuid;
                pModel.psaPsmGuid = psaPsmGuid;


                if (sqlinj == "")
                {

                    dv = dal.Selsy_PaySalaryAllowance(pModel).DefaultView;
                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<psaGuid>" + dv[i]["psaGuid"].ToString() + "</psaGuid>";
                        XmlStr += "<psaPerGuid>" + dv[i]["psaPerGuid"].ToString() + "</psaPerGuid>";
                        XmlStr += "<psaPsmGuid>" + dv[i]["psaPsmGuid"].ToString() + "</psaPsmGuid>";
                        XmlStr += "<psaAllowanceCode>" + dv[i]["psaAllowanceCode"].ToString() + "</psaAllowanceCode>";
                        XmlStr += "<psaPrice>" + dv[i]["psaPrice"].ToString() + "</psaPrice>";
                        XmlStr += "<psaQuantity>" + dv[i]["psaQuantity"].ToString() + "</psaQuantity>";
                        XmlStr += "<psaCost>" + dv[i]["psaCost"].ToString() + "</psaCost>";
                        XmlStr += "<psaStatus>" + dv[i]["psaStatus"].ToString() + "</psaStatus>";  
                        XmlStr += "<siItemName>" + dv[i]["siItemName"].ToString() + "</siItemName>";  
                        XmlStr += "<siItemCode>" + dv[i]["siItemCode"].ToString() + "</siItemCode>";  
                        XmlStr += "<siAddstr>" + dv[i]["siAddstr"].ToString() + "</siAddstr>";  
              
                        XmlStr += "</dView>";
                    }
                    XmlStr += "</dList>";

                    context.Response.Write(XmlStr);
                }
                else { context.Response.Write("<dList>DangerWord</dList>"); }
            }
            else { context.Response.Write("<dList>Timeout</dList>"); }
        }
        catch (Exception ex)
        {
            //ErrorLog err = new ErrorLog();
            //err.InsErrorLog("ashx_NewStaffList.ashx", ex.Message, USERINFO.MemberEmpno);
            context.Response.Write("<dList>error</dList>");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}