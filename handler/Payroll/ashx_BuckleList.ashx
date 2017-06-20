<%@ WebHandler Language="C#" Class="ashx_BuckleList" %>

using System;
using System.Web;
using System.Data;
public class ashx_BuckleList : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {
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
                    dv = dal.Selsy_PaySalaryBuckle(p).DefaultView;

                    XmlStr += "<dList>";
                    for (int i = 0; i < dv.Count; i++)
                    {
                        XmlStr += "<dView>";
                        XmlStr += "<psbGuid>" + dv[i]["psbGuid"].ToString() + "</psbGuid>";
                        XmlStr += "<psbPerGuid>" + dv[i]["psbPerGuid"].ToString() + "</psbPerGuid>";
                        XmlStr += "<psbPsmGuid>" + dv[i]["psbPsmGuid"].ToString() + "</psbPsmGuid>";
                        XmlStr += "<psbCreditor>" + dv[i]["psbCreditor"].ToString() + "</psbCreditor>";
                        XmlStr += "<psbCreditorCost>" + dv[i]["psbCreditorCost"].ToString() + "</psbCreditorCost>";
                        XmlStr += "<psbRatio>" + dv[i]["psbRatio"].ToString() + "</psbRatio>";
                        XmlStr += "<psbIssued>" + dv[i]["psbIssued"].ToString() + "</psbIssued>";
                        XmlStr += "<psbPayment>" + dv[i]["psbPayment"].ToString() + "</psbPayment>";

                        XmlStr += "<psbIntoName>" + dv[i]["psbIntoName"].ToString() + "</psbIntoName>";
                        XmlStr += "<psbIntoNumber>" + dv[i]["psbIntoNumber"].ToString() + "</psbIntoNumber>";
                        XmlStr += "<psbIntoAccount>" + dv[i]["psbIntoAccount"].ToString() + "</psbIntoAccount>";
                        XmlStr += "<psbContractor>" + dv[i]["psbContractor"].ToString() + "</psbContractor>";
                        XmlStr += "<psbTel>" + dv[i]["psbTel"].ToString() + "</psbTel>";
                        XmlStr += "<psbFee>" + dv[i]["psbFee"].ToString() + "</psbFee>";
                        XmlStr += "<psbCost>" + dv[i]["psbCost"].ToString() + "</psbCost>";


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