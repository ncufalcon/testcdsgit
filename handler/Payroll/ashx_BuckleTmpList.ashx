<%@ WebHandler Language="C#" Class="ashx_BuckleTmpList" %>

using System;
using System.Web;
using System.Data;
public class ashx_BuckleTmpList : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {


        context.Response.ContentType = "text/xml";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {


                string XmlStr = "";
                DataView dv = new DataView();
                string psbPerGuid = (!string.IsNullOrEmpty(context.Request.Form["psbPerGuid"])) ? context.Request.Form["psbPerGuid"].ToString() : "";
                string psbPsmGuid = (!string.IsNullOrEmpty(context.Request.Form["psbPsmGuid"])) ? context.Request.Form["psbPsmGuid"].ToString() : "";




                payroll.model.sy_PayBuckle p = new payroll.model.sy_PayBuckle();
                p.psbPerGuid = psbPerGuid;
                p.psbPsmGuid = psbPsmGuid;

                string[] str = { psbPerGuid, psbPerGuid };
                string sqlinj = com.CheckSqlInJection(str);


                if (sqlinj == "")
                {
                    dv = dal.Selsy_PaySalaryBuckleTmp(p).DefaultView;

                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<psbGuid>" + dv[i]["psbGuid_Tmp"].ToString() + "</psbGuid>";
                        XmlStr += "<psbPerGuid>" + dv[i]["psbPerGuid_Tmp"].ToString() + "</psbPerGuid>";
                        XmlStr += "<psbPsmGuid>" + dv[i]["psbPsmGuid_Tmp"].ToString() + "</psbPsmGuid>";
                        XmlStr += "<psbCreditor>" + dv[i]["psbCreditor_Tmp"].ToString() + "</psbCreditor>";
                        XmlStr += "<psbCreditorCost>" + dv[i]["psbCreditorCost_Tmp"].ToString() + "</psbCreditorCost>";
                        XmlStr += "<psbRatio>" + dv[i]["psbRatio_Tmp"].ToString() + "</psbRatio>";
                        XmlStr += "<psbIssued>" + dv[i]["psbIssued_Tmp"].ToString() + "</psbIssued>";
                        XmlStr += "<psbPayment>" + dv[i]["psbPayment_Tmp"].ToString() + "</psbPayment>";

                        XmlStr += "<psbIntoName>" + dv[i]["psbIntoName_Tmp"].ToString() + "</psbIntoName>";
                        XmlStr += "<psbIntoNumber>" + dv[i]["psbIntoNumber_Tmp"].ToString() + "</psbIntoNumber>";
                        XmlStr += "<psbIntoAccount>" + dv[i]["psbIntoAccount_Tmp"].ToString() + "</psbIntoAccount>";
                        XmlStr += "<psbContractor>" + dv[i]["psbContractor_Tmp"].ToString() + "</psbContractor>";
                        XmlStr += "<psbTel>" + dv[i]["psbTel_Tmp"].ToString() + "</psbTel>";
                        XmlStr += "<psbFee>" + dv[i]["psbFee_Tmp"].ToString() + "</psbFee>";
                        XmlStr += "<psbCost>" + dv[i]["psbCost_Tmp"].ToString() + "</psbCost>";


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