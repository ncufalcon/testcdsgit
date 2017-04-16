<%@ WebHandler Language="C#" Class="ashx_AllEdit" %>

using System;
using System.Web;

public class ashx_AllEdit : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                string paGuid = (!string.IsNullOrEmpty(context.Request.Form["guid"])) ? context.Request.Form["guid"].ToString() : "";
                string PerGuid = (!string.IsNullOrEmpty(context.Request.Form["PerGuid"])) ? context.Request.Form["PerGuid"].ToString() : "";
                string AllGuid = (!string.IsNullOrEmpty(context.Request.Form["AllCode"])) ? context.Request.Form["AllCode"].ToString() : "";
                decimal Price = (!string.IsNullOrEmpty(context.Request.Form["Price"])) ? decimal.Parse(context.Request.Form["Price"].ToString()) : 0;
                decimal Quitetiy = (!string.IsNullOrEmpty(context.Request.Form["Quantity"])) ? decimal.Parse(context.Request.Form["Quantity"].ToString()) : 0;
                decimal Cost = (!string.IsNullOrEmpty(context.Request.Form["Cost"])) ? decimal.Parse(context.Request.Form["Cost"].ToString()) : 0;
                string Date = (!string.IsNullOrEmpty(context.Request.Form["Date"])) ? context.Request.Form["Date"].ToString() : "";
                string Ps = (!string.IsNullOrEmpty(context.Request.Form["Ps"])) ? context.Request.Form["Ps"].ToString() : "";
                string EditType = (!string.IsNullOrEmpty(context.Request.Form["typ"])) ? context.Request.Form["typ"].ToString() : "";

                string[] str = { Ps, Date };
                string sqlinj = com.CheckSqlInJection(str);
                payroll.model.sy_PersonSingleAllowance all = new payroll.model.sy_PersonSingleAllowance();
                all.paGuid = paGuid;
                all.paPerGuid = PerGuid;
                all.paAllowanceCode = AllGuid;
                all.paPrice = Price;
                all.paQuantity = Quitetiy;
                all.paCost = Cost;
                all.paDate = Date;
                all.paPs = Ps;
                all.paCreateId = USERINFO.MemberGuid;
                all.paModifyId = USERINFO.MemberGuid;
                if (sqlinj == "")
                {
                    switch (EditType)
                    {
                        case "Ins":
                            dal.InsPersonSingleAllowance(all);
                            break;
                        case "Up":
                            dal.UpPersonSingleAllowance(all);
                            break;
                        case "Del":
                            dal.DelPersonSingleAllowance(all);
                            break;
                    }
                    context.Response.Write("ok");
                }
                else { context.Response.Write("d"); }
            }
            else { context.Response.Write("t"); }
        }
        catch (Exception ex) { context.Response.Write("e"); }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}