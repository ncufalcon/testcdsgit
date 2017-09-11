using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

public class USERINFO
{
    /// <summary>
    /// 使用Guid
    /// </summary>
    public static string MemberGuid
    {
        get
        {
            return (HttpContext.Current.Session["MemberInfo_Guid"] != null) ?
                (!string.IsNullOrEmpty(HttpContext.Current.Session["MemberInfo_Guid"].ToString())) ? HttpContext.Current.Session["MemberInfo_Guid"].ToString() : "" : "";
        }

        set
        {
            HttpContext.Current.Session["MemberInfo_Guid"] = value;
        }

    }


    /// <summary>
    /// 使用者名稱
    /// </summary>
    public static string MemberName
    {
        get
        {
            return (HttpContext.Current.Session["MemberInfo_Name"] != null) ?
                (!string.IsNullOrEmpty(HttpContext.Current.Session["MemberInfo_Name"].ToString())) ? HttpContext.Current.Session["MemberInfo_Name"].ToString() : "" : "";
        }

        set
        {
            HttpContext.Current.Session["MemberInfo_Name"] = value;
        }

    }


    /// <summary>
    /// 使用者角色
    /// </summary>
    public static string MemberClass
    {
        get
        {
            return (HttpContext.Current.Session["MemberInfo_Class"] != null) ?
                (!string.IsNullOrEmpty(HttpContext.Current.Session["MemberInfo_Class"].ToString())) ? HttpContext.Current.Session["MemberInfo_Class"].ToString() : "" : "";
        }

        set
        {
            HttpContext.Current.Session["MemberInfo_Class"] = value;
        }

    }

    /// <summary>
    /// 使用者權限
    /// </summary>
    /// <returns></returns>
    public static string MemberCompetence
    {
        get
        {


            return (HttpContext.Current.Session["MemberInfo_Competence"] != null) ?
                (!string.IsNullOrEmpty(HttpContext.Current.Session["MemberInfo_Competence"].ToString())) ? HttpContext.Current.Session["MemberInfo_Competence"].ToString() : "" : "";
        }
        set
        {
            HttpContext.Current.Session["MemberInfo_Competence"] = value;
        }
    }


    /// <summary>
    /// 給SESSION值
    /// </summary>
    /// <param name="LoginStatus"></param>
    public static void SET_SESSION(LoginINFO LoginInfo)
    {
        MemberGuid = LoginInfo.MemberGuid;
        MemberName = LoginInfo.MemberName;
        MemberClass = LoginInfo.MemberClass;
        MemberCompetence = LoginInfo.MemberCompetence;
    }

}