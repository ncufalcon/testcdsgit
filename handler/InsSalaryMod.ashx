<%@ WebHandler Language="C#" Class="InsSalaryMod" %>

using System;
using System.Web;
using System.Web.SessionState;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Configuration;

public class InsSalaryMod : IHttpHandler,IRequiresSessionState {

    public void ProcessRequest (HttpContext context) {
        bool status = true;
        string exStr = string.Empty;
        string IM_Guid = (context.Request.Form["im_gv"] != null) ? context.Request.Form["im_gv"].ToString() : "";
        string L_SL = (context.Request.Form["im_lSL"] != null) ? context.Request.Form["im_lSL"].ToString() : "";
        string H_SL = (context.Request.Form["im_hSL"] != null) ? context.Request.Form["im_hSL"].ToString() : "";
        string bf_L = (context.Request.Form["bf_L"] != null) ? context.Request.Form["bf_L"].ToString() : "";
        string bf_H = (context.Request.Form["bf_H"] != null) ? context.Request.Form["bf_H"].ToString() : "";
        string bf_P = (context.Request.Form["bf_P"] != null) ? context.Request.Form["bf_P"].ToString() : "";
        string af_L = (context.Request.Form["af_L"] != null) ? context.Request.Form["af_L"].ToString() : "";
        string af_H = (context.Request.Form["af_H"] != null) ? context.Request.Form["af_H"].ToString() : "";
        string af_P = (context.Request.Form["af_P"] != null) ? context.Request.Form["af_P"].ToString() : "";
        string labor_id = (context.Request.Form["labor_id"] != null) ? context.Request.Form["labor_id"].ToString() : "";
        string ganbor_id = (context.Request.Form["ganbor_id"] != null) ? context.Request.Form["ganbor_id"].ToString() : "";
        string[] Gid = IM_Guid.Split(','); //Person Guid
        string[] L_SLAry = L_SL.Split(','); //前次異動勞保補助等級
        string[] H_SLAry = H_SL.Split(','); //前次異動健保補助等級
        string[] bf_Lary = bf_L.Split(','); //前次異動勞保級距
        string[] bf_Hary = bf_H.Split(','); //前次異動勞保級距
        string[] bf_Pary= bf_P.Split(','); //前次異動勞退級距
        string[] af_Lary = af_L.Split(','); //本次異動勞保級距
        string[] af_Hary = af_H.Split(','); //本次異動勞保級距
        string[] af_Pary= af_P.Split(','); //本次異動勞退級距
        string[] LaborIDary= labor_id.Split(','); //勞保卡號
        string[] GanborIDary= ganbor_id.Split(','); //健保卡號
        string LCstr = string.Empty;
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
            oCmd.Parameters.Add("@plPerGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plSubsidyLevel", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plLaborNo", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plChangeDate", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plChange", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plLaborPayroll", SqlDbType.Decimal);
            oCmd.Parameters.Add("@plCreateId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plModifyId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@plModifyDate", SqlDbType.DateTime);
            oCmd.Parameters.Add("@plStatus", SqlDbType.NVarChar);
            //健保
            oCmd.Parameters.Add("@piGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piPerGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piSubsidyLevel", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piCardNo", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piChangeDate", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piChange", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piInsurancePayroll", SqlDbType.Decimal);
            oCmd.Parameters.Add("@piCreateId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piModifyId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@piModifyDate", SqlDbType.DateTime);
            oCmd.Parameters.Add("@piStatus", SqlDbType.NVarChar);
            //勞退
            oCmd.Parameters.Add("@ppGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppPerGuid", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppChange", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppChangeDate", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppPayPayroll", SqlDbType.Decimal);
            oCmd.Parameters.Add("@ppLarboRatio", SqlDbType.Decimal);
            oCmd.Parameters.Add("@ppEmployerRatio", SqlDbType.Decimal);
            oCmd.Parameters.Add("@ppCreateId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppModifyId", SqlDbType.NVarChar);
            oCmd.Parameters.Add("@ppModifyDate", SqlDbType.DateTime);
            oCmd.Parameters.Add("@ppStatus", SqlDbType.NVarChar);
            for (int i = 0; i< Gid.Length; i++)
            {
                oCmd.CommandText = "";

                oCmd.Parameters["@plGuid"].Value = Guid.NewGuid().ToString();
                oCmd.Parameters["@plPerGuid"].Value = Gid[i];
                oCmd.Parameters["@plSubsidyLevel"].Value = L_SLAry[i];
                oCmd.Parameters["@plLaborNo"].Value = LaborIDary[i];
                oCmd.Parameters["@plChangeDate"].Value = DateTime.Now.ToString("yyyy/MM/dd");
                oCmd.Parameters["@plChange"].Value = "03";
                oCmd.Parameters["@plLaborPayroll"].Value = decimal.Parse(af_Lary[i].ToString());
                oCmd.Parameters["@plCreateId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@plModifyId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@plModifyDate"].Value = DateTime.Now;
                oCmd.Parameters["@plStatus"].Value = "A";

                if (bf_Lary[i] != "0")
                {
                    oCmd.CommandText += @"insert into sy_PersonLabor (
                    plGuid,
                    plPerGuid,
                    plSubsidyLevel,
                    plLaborNo,
                    plChangeDate,
                    plChange,
                    plLaborPayroll,
                    plCreateId,
                    plModifyId,
                    plModifyDate,
                    plStatus
                    ) values (
                    @plGuid,
                    @plPerGuid,
                    @plSubsidyLevel,
                    @plLaborNo,
                    @plChangeDate,
                    @plChange,
                    @plLaborPayroll,
                    @plCreateId,
                    @plModifyId,
                    @plModifyDate,
                    @plStatus
                    ) ";
                }

                oCmd.Parameters["@piGuid"].Value = Guid.NewGuid().ToString();
                oCmd.Parameters["@piPerGuid"].Value = Gid[i];
                oCmd.Parameters["@piSubsidyLevel"].Value = H_SLAry[i];
                oCmd.Parameters["@piCardNo"].Value = GanborIDary[i];
                oCmd.Parameters["@piChangeDate"].Value = DateTime.Now.ToString("yyyy/MM/dd");
                oCmd.Parameters["@piChange"].Value = "03";
                oCmd.Parameters["@piInsurancePayroll"].Value = decimal.Parse(af_Hary[i].ToString());
                oCmd.Parameters["@piCreateId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@piModifyId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@piModifyDate"].Value = DateTime.Now;
                oCmd.Parameters["@piStatus"].Value = "A";

                if (bf_Hary[i] != "0")
                {
                    oCmd.CommandText += @"insert into sy_PersonInsurance (
                    piGuid,
                    piPerGuid,
                    piSubsidyLevel,
                    piCardNo,
                    piChangeDate,
                    piChange,
                    piInsurancePayroll,
                    piCreateId,
                    piModifyId,
                    piModifyDate,
                    piStatus
                    ) values (
                    @piGuid,
                    @piPerGuid,
                    @piSubsidyLevel,
                    @piCardNo,
                    @piChangeDate,
                    @piChange,
                    @piInsurancePayroll,
                    @piCreateId,
                    @piModifyId,
                    @piModifyDate,
                    @piStatus
                    ) ";
                }

                oCmd.Parameters["@ppGuid"].Value = Guid.NewGuid().ToString();
                oCmd.Parameters["@ppPerGuid"].Value = Gid[i];
                oCmd.Parameters["@ppChange"].Value = "02";
                oCmd.Parameters["@ppChangeDate"].Value = DateTime.Now.ToString("yyyy/MM/dd");
                oCmd.Parameters["@ppPayPayroll"].Value = decimal.Parse(af_Pary[i].ToString());
                oCmd.Parameters["@ppLarboRatio"].Value = decimal.Parse("6");
                oCmd.Parameters["@ppEmployerRatio"].Value = decimal.Parse("6");
                oCmd.Parameters["@ppCreateId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@ppModifyId"].Value = USERINFO.MemberGuid;
                oCmd.Parameters["@ppModifyDate"].Value = DateTime.Now;
                oCmd.Parameters["@ppStatus"].Value = "A";

                if (bf_Pary[i] != "0")
                {
                    oCmd.CommandText += @"insert into sy_PersonPension (
                    ppGuid,
                    ppPerGuid,
                    ppChange,
                    ppChangeDate,
                    ppPayPayroll,
                    ppLarboRatio,
                    ppEmployerRatio,
                    ppCreateId,
                    ppModifyId,
                    ppModifyDate,
                    ppStatus
                    ) values (
                    @ppGuid,
                    @ppPerGuid,
                    @ppChange,
                    @ppChangeDate,
                    @ppPayPayroll,
                    @ppLarboRatio,
                    @ppEmployerRatio,
                    @ppCreateId,
                    @ppModifyId,
                    @ppModifyDate,
                    @ppStatus
                    ) ";
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
                context.Response.Write("<script type='text/JavaScript'>parent.feedbackFun('InsSalaryMod');</script>");
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}