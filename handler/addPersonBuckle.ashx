<%@ WebHandler Language="C#" Class="addPersonBuckle" %>

using System;
using System.Web;
using System.Web.SessionState;

public class addPersonBuckle : IHttpHandler,IRequiresSessionState {
    PersonBuckle_DB PB_Db = new PersonBuckle_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            if (string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LoginFailed','');</script>");
                return;
            }

            string Mode = (context.Request.Form["mode"] != null) ? context.Request.Form["mode"].ToString() : "";
            string PerID = (context.Request.Form["idtmp"] != null) ? context.Request.Form["idtmp"].ToString() : "";
            string id = (context.Request.Form["pbid"] != null) ? context.Request.Form["pbid"].ToString() : "";
            //眷屬資料
            string pb_Creditor = (context.Request.Form["pb_Creditor"] != null) ? context.Request.Form["pb_Creditor"].ToString() : "";
            string pb_CreditorCost = (context.Request.Form["pb_CreditorCost"] != null) ? context.Request.Form["pb_CreditorCost"].ToString() : "";
            string pb_Ratio = (context.Request.Form["pb_Ratio"] != null) ? context.Request.Form["pb_Ratio"].ToString() : "";
            string pb_Issued = (context.Request.Form["pb_Issued"] != null) ? context.Request.Form["pb_Issued"].ToString() : "";
            string pb_IntoNumber = (context.Request.Form["pb_IntoNumber"] != null) ? context.Request.Form["pb_IntoNumber"].ToString() : "";
            string pb_IntoAccount = (context.Request.Form["pb_IntoAccount"] != null) ? context.Request.Form["pb_IntoAccount"].ToString() : "";
            string pb_IntoName = (context.Request.Form["pb_IntoName"] != null) ? context.Request.Form["pb_IntoName"].ToString() : "";
            string pb_Payment = (context.Request.Form["pb_Payment"] != null) ? context.Request.Form["pb_Payment"].ToString() : "";
            string pb_Contractor = (context.Request.Form["pb_Contractor"] != null) ? context.Request.Form["pb_Contractor"].ToString() : "";
            string pb_Tel = (context.Request.Form["pb_Tel"] != null) ? context.Request.Form["pb_Tel"].ToString() : "";
            string pb_Fee = (context.Request.Form["pb_Fee"] != null) ? context.Request.Form["pb_Fee"].ToString() : "";
            string pb_No = (context.Request.Form["pb_No"] != null) ? context.Request.Form["pb_No"].ToString() : "";

            switch (Mode)
            {
                case "New":
                    PB_Db._pbGuid = Guid.NewGuid().ToString();
                    PB_Db._pbPerGuid = PerID;
                    PB_Db._pbCreditor = pb_Creditor;
                    PB_Db._pbCreditorCost = decimal.Parse(pb_CreditorCost);
                    PB_Db._pbRatio = pb_Ratio;
                    PB_Db._pbIssued = pb_Issued;
                    PB_Db._pbIntoNumber = pb_IntoNumber;
                    PB_Db._pbIntoAccount = pb_IntoAccount;
                    PB_Db._pbIntoName = pb_IntoName;
                    PB_Db._pbPayment = pb_Payment;
                    PB_Db._pbContractor = pb_Contractor;
                    PB_Db._pbTel = pb_Tel;
                    PB_Db._pbFee = decimal.Parse(pb_Fee);
                    PB_Db._pbCreateId = USERINFO.MemberGuid;
                    PB_Db._pbModifyId = USERINFO.MemberGuid;
                    PB_Db._pbNo = pb_No;
                    PB_Db.addPersonBuckle();
                    break;
                case "Modify":
                    PB_Db._pbGuid = id;
                    PB_Db._pbCreditor = pb_Creditor;
                    PB_Db._pbCreditorCost = decimal.Parse(pb_CreditorCost);
                    PB_Db._pbRatio = pb_Ratio;
                    PB_Db._pbIssued = pb_Issued;
                    PB_Db._pbIntoNumber = pb_IntoNumber;
                    PB_Db._pbIntoAccount = pb_IntoAccount;
                    PB_Db._pbIntoName = pb_IntoName;
                    PB_Db._pbPayment = pb_Payment;
                    PB_Db._pbContractor = pb_Contractor;
                    PB_Db._pbTel = pb_Tel;
                    PB_Db._pbFee = decimal.Parse(pb_Fee);
                    PB_Db._pbModifyId = USERINFO.MemberGuid;
                    PB_Db._pbNo = pb_No;
                    PB_Db.modPersonBuckle();
                    break;
            }

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('PB');</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('error','editPersonBuckle');</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}