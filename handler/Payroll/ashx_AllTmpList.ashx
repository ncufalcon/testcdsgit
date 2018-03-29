<%@ WebHandler Language="C#" Class="ashx_AllTmpList" %>

using System;
using System.Web;
using System.Data;
public class ashx_AllTmpList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    
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

                    dv = dal.Selsy_PaySalaryAllowanceTmp(pModel).DefaultView;
                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<psaGuid>" + dv[i]["psaGuid_Tmp"].ToString() + "</psaGuid>";
                        XmlStr += "<psaPerGuid>" + dv[i]["psaPerGuid_Tmp"].ToString() + "</psaPerGuid>";
                        XmlStr += "<psaPsmGuid>" + dv[i]["psaPsmGuid_Tmp"].ToString() + "</psaPsmGuid>";
                        XmlStr += "<psaAllowanceCode>" + dv[i]["psaAllowanceCode_Tmp"].ToString() + "</psaAllowanceCode>";
                        XmlStr += "<psaPrice>" + dv[i]["psaPrice_Tmp"].ToString() + "</psaPrice>";
                        XmlStr += "<psaQuantity>" + dv[i]["psaQuantity_Tmp"].ToString() + "</psaQuantity>";
                        XmlStr += "<psaCost>" + dv[i]["psaCost_Tmp"].ToString() + "</psaCost>";
                        XmlStr += "<psaStatus>" + dv[i]["psaStatus_Tmp"].ToString() + "</psaStatus>";  
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