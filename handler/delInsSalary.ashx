<%@ WebHandler Language="C#" Class="delInsSalary" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

public class delInsSalary : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        if (string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('LoginFailed','');</script>");
            return;
        }

        bool status = true;
        string exStr = string.Empty;
        string gv = (context.Request.Form["gv"] != null) ? context.Request.Form["gv"].ToString() : "";
        string TypeName = (context.Request.Form["tp_name"] != null) ? context.Request.Form["tp_name"].ToString() : "";

        string[] Gid = gv.Split(','); //Guid
        string[] TpName = TypeName.Split(','); //類別

        SqlConnection oConn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnString"].ToString());
        oConn.Open();
        SqlCommand oCmd = new SqlCommand();
        oCmd.Connection = oConn;
        SqlTransaction myTrans = oConn.BeginTransaction();
        oCmd.Transaction = myTrans;
        try
        {
            //勞保
            oCmd.Parameters.Add("@plGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plModifyId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plModifyDate", SqlDbType.DateTime);
            //健保
            oCmd.Parameters.Add("@piGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piModifyId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piModifyDate", SqlDbType.DateTime);

            //勞退
            oCmd.Parameters.Add("@ppGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppModifyId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppModifyDate", SqlDbType.DateTime);


            for (int i = 0; i < Gid.Length; i++)
            {
                oCmd.Parameters["@plGuid"].Value = Gid[i];
                oCmd.Parameters["@plModifyId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@plModifyDate"].Value = DateTime.Now;

                oCmd.Parameters["@piGuid"].Value = Gid[i];
                oCmd.Parameters["@piModifyId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@piModifyDate"].Value = DateTime.Now;

                oCmd.Parameters["@ppGuid"].Value = Gid[i];
                oCmd.Parameters["@ppModifyId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@ppModifyDate"].Value = DateTime.Now;

                oCmd.CommandText = "";
                switch (TpName[i])
                {
                    case "L":
                        oCmd.CommandText += @"update sy_PersonLabor set 
                        plModifyId=@plModifyId,
                        plModifyDate=@plModifyDate,
                        plStatus='D'
                        where plGuid=@plGuid ";
                        break;
                    case "H":
                        oCmd.CommandText += @"update sy_PersonInsurance set 
                        piModifyId=@piModifyId,
                        piModifyDate=@piModifyDate,
                        piStatus='D'
                        where piGuid=@piGuid ";
                        break;
                    case "P":
                        oCmd.CommandText += @"update sy_PersonPension set 
                        ppModifyId=@ppModifyId,
                        ppModifyDate=@ppModifyDate,
                        ppStatus='D'
                        where ppGuid=@ppGuid ";
                        break;
                }
                oCmd.ExecuteNonQuery();
            }

            myTrans.Commit();
        }
        catch (Exception ex)
        {
            status = false;
            myTrans.Rollback();
            exStr = ex.Message;
        }
        finally
        {
            oCmd.Connection.Close();
            oConn.Close();
            context.Response.ContentType = "text/html";
            if (status == false)
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('exMsg','" + context.Server.UrlEncode(exStr).Replace("+", " ") + "');</script>");
            else
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('DeleteInsSalary');</script>");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}