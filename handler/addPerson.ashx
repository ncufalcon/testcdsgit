<%@ WebHandler Language="C#" Class="addPerson" %>

using System;
using System.Web;

public class addPerson : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
        try
        {
            string pNo = (context.Request.Form["pNo"] != null) ? context.Request.Form["pNo"].ToString() : "";
            string pName = (context.Request.Form["pName"] != null) ? context.Request.Form["pName"].ToString() : "";
            string pComGuid = (context.Request.Form["pComGuid"] != null) ? context.Request.Form["pComGuid"].ToString() : "";
            string pDep = (context.Request.Form["pDep"] != null) ? context.Request.Form["pDep"].ToString() : "";
            string pSex = (context.Request.Form["pSex"] != null) ? context.Request.Form["pSex"].ToString() : "";
            string perMarriage = (context.Request.Form["perMarriage"] != null) ? context.Request.Form["perMarriage"].ToString() : "";
            string pPosition = (context.Request.Form["pPosition"] != null) ? context.Request.Form["pPosition"].ToString() : "";
            string pBirthday = (context.Request.Form["pBirthday"] != null) ? context.Request.Form["pBirthday"].ToString() : "";
            string pIDNumber = (context.Request.Form["pIDNumber"] != null) ? context.Request.Form["pIDNumber"].ToString() : "";
            string pContract = (context.Request.Form["pContract"] != null) ? context.Request.Form["pContract"].ToString() : "";
            string pFirstDate = (context.Request.Form["pFirstDate"] != null) ? context.Request.Form["pFirstDate"].ToString() : "";
            string pLastDate = (context.Request.Form["pLastDate"] != null) ? context.Request.Form["pLastDate"].ToString() : "";
            string pExaminationDate = (context.Request.Form["pExaminationDate"] != null) ? context.Request.Form["pExaminationDate"].ToString() : "";
            string pExaminationLastDate = (context.Request.Form["pExaminationLastDate"] != null) ? context.Request.Form["pExaminationLastDate"].ToString() : "";
            string pResidentPermitDate = (context.Request.Form["pResidentPermitDate"] != null) ? context.Request.Form["pResidentPermitDate"].ToString() : "";
            string pTel = (context.Request.Form["pTel"] != null) ? context.Request.Form["pTel"].ToString() : "";
            string pPhone = (context.Request.Form["pPhone"] != null) ? context.Request.Form["pPhone"].ToString() : "";
            string pEmail = (context.Request.Form["pEmail"] != null) ? context.Request.Form["pEmail"].ToString() : "";
            string pPostalCode = (context.Request.Form["pPostalCode"] != null) ? context.Request.Form["pPostalCode"].ToString() : "";
            string pAddr = (context.Request.Form["pAddr"] != null) ? context.Request.Form["pAddr"].ToString() : "";
            string pResPostalCode = (context.Request.Form["pResPostalCode"] != null) ? context.Request.Form["pResPostalCode"].ToString() : "";
            string pResidentAddr = (context.Request.Form["pResidentAddr"] != null) ? context.Request.Form["pResidentAddr"].ToString() : "";
            string pContactPerson = (context.Request.Form["pContactPerson"] != null) ? context.Request.Form["pContactPerson"].ToString() : "";
            string pContactTel = (context.Request.Form["pContactTel"] != null) ? context.Request.Form["pContactTel"].ToString() : "";
            string pRel = (context.Request.Form["pRel"] != null) ? context.Request.Form["pRel"].ToString() : "";
            string pPs = (context.Request.Form["pPs"] != null) ? context.Request.Form["pPs"].ToString() : "";

            context.Response.ContentType = "text/html";
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun();</script>");
        }
        catch (Exception ex) { context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun();</script>"); }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}