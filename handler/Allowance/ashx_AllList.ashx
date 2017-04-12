<%@ WebHandler Language="C#" Class="ashx_AllList" %>

using System;
using System.Web;
using System.Data;
public class ashx_AllList : IHttpHandler,System.Web.SessionState.IReadOnlySessionState {
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/xml";
        try
        {
            string XmlStr = "";
            DataView dv = new DataView();
            string PerNo = (!string.IsNullOrEmpty(context.Request.Form["PerNo"])) ? context.Request.Form["PerNo"].ToString() : "";
            string PerName = (!string.IsNullOrEmpty(context.Request.Form["PerName"])) ? context.Request.Form["PerName"].ToString() : "";
            string Code = (!string.IsNullOrEmpty(context.Request.Form["Code"])) ? context.Request.Form["Code"].ToString() : "";
            decimal Cost = (!string.IsNullOrEmpty(context.Request.Form["Cost"])) ? decimal.Parse(context.Request.Form["Cost"].ToString()) : 0;
            string Date = (!string.IsNullOrEmpty(context.Request.Form["Date"])) ? context.Request.Form["Date"].ToString() : "";
            string typ = (!string.IsNullOrEmpty(context.Request.Form["typ"])) ? context.Request.Form["typ"].ToString() : "";

            string[] str = { PerNo, PerName, Code, Date, Cost.ToString()};
            string sqlinj = com.CheckSqlInJection(str);
            payroll.model.sy_PersonSingleAllowance pModel = new payroll.model.sy_PersonSingleAllowance();
            pModel.perName = PerName;
            pModel.perNo = PerNo;
            pModel.paCost = Cost;
            pModel.paAllowanceCode = Code;
            pModel.paDate = Date;

            if (sqlinj == "")
            {
                if (typ == "Y") //代表第一次進入畫面 Top 200
                    dv = dal.SelPersonSingleAllowanceTop200().DefaultView;
                else
                    dv = dal.SelPersonSingleAllowance(pModel).DefaultView;

                //string paging = (Math.Ceiling(decimal.Parse((dvList.Count / 10).ToString())) + 1).ToString();
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
            else { context.Response.Write("<dList>DangerWord</dList>"); }
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