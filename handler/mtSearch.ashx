<%@ WebHandler Language="C#" Class="mtSearch" %>

using System;
using System.Web;
using System.Data;

public class mtSearch : IHttpHandler {
    Personnel_DB Personnel_Db = new Personnel_DB();
    public void ProcessRequest (HttpContext context) {
        try
        {
            string xmlStr = string.Empty;

            DataTable dt = Personnel_Db.mutiPersonnel();
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    if (i == 0)
                    {
                        xmlStr = "<company id=\"" + dt.Rows[i]["perComGuid"].ToString() + "\" name=\"" + dt.Rows[i]["comAbbreviate"].ToString() + "\">";
                        xmlStr += "<dep id=\"" + dt.Rows[i]["perDep"].ToString() + "\" name=\"" + dt.Rows[i]["cbName"].ToString() + "\">";
                        xmlStr += "<per id=\"" + dt.Rows[i]["perGuid"].ToString() + "\" no=\"" + dt.Rows[i]["perNo"].ToString() + "\" name=\"" + dt.Rows[i]["perName"].ToString() + "\" />";
                    }
                    else
                    {
                        if (dt.Rows[i]["perComGuid"].ToString() == dt.Rows[i - 1]["perComGuid"].ToString())
                        {
                            if (dt.Rows[i]["perDep"].ToString() == dt.Rows[i - 1]["perDep"].ToString())
                            {
                                xmlStr += "<per id=\"" + dt.Rows[i]["perGuid"].ToString() + "\" no=\"" + dt.Rows[i]["perNo"].ToString() + "\" name=\"" + dt.Rows[i]["perName"].ToString() + "\" />";
                            }
                            else
                            {
                                xmlStr += "</dep>";
                                xmlStr += "<dep id=\"" + dt.Rows[i]["perDep"].ToString() + "\" name=\"" + dt.Rows[i]["cbName"].ToString() + "\">";
                                xmlStr += "<per id=\"" + dt.Rows[i]["perGuid"].ToString() + "\" no=\"" + dt.Rows[i]["perNo"].ToString() + "\" name=\"" + dt.Rows[i]["perName"].ToString() + "\" />";
                            }
                        }
                        else
                        {
                            xmlStr += "</dep></company>";
                            xmlStr += "<company id=\"" + dt.Rows[i]["perComGuid"].ToString() + "\" name=\"" + dt.Rows[i]["comAbbreviate"].ToString() + "\">";
                            xmlStr += "<dep id=\"" + dt.Rows[i]["perDep"].ToString() + "\" name=\"" + dt.Rows[i]["cbName"].ToString() + "\">";
                            xmlStr += "<per id=\"" + dt.Rows[i]["perGuid"].ToString() + "\" no=\"" + dt.Rows[i]["perNo"].ToString() + "\" name=\"" + dt.Rows[i]["perName"].ToString() + "\" />";
                        }
                    }

                    if (i == (dt.Rows.Count - 1))
                    {
                        xmlStr += "</dep></company>";
                    }
                }
            }

            xmlStr = "<root>" + xmlStr + "</root>";
            context.Response.Write(xmlStr);
        }
        catch (Exception ex) { context.Response.Write("error"); }

    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}