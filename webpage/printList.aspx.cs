using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class webpage_printList : System.Web.UI.Page
{
    payroll.gdal dal = new payroll.gdal();
    protected void Page_Load(object sender, EventArgs e)
    {
        string srGuid = Request.QueryString["guid"];
        string perNo = Request.QueryString["No"];
        string perName = Request.QueryString["Name"];
        string Company = Request.QueryString["Com"];
        string Dep = Request.QueryString["Dep"];
        string Amt = Request.QueryString["Amt"];
        string Lev = Request.QueryString["Lev"];


        if (string.IsNullOrEmpty(srGuid))
        {
            JavaScript.AlertMessage(this.Page, "請選擇計薪週期");
            return;
        }

        //if (string.IsNullOrEmpty(perNo))
        //{
        //    JavaScript.AlertMessage(this.Page, "請輸入測試工號");
        //    return;
        //}

        DataView dv = dal.Sel_SalaryPrint(srGuid, perNo, perName, Company, Dep, Amt, Lev).DefaultView;
        for (int i = 0; i < dv.Count; i++)
        {
            div_show.InnerHtml += dv[i]["htmlstr"].ToString() + "<p style='page-break-after:always'></p>";
            //ScriptManager.RegisterStartupScript(Page, GetType(), "clicktest", "<script>printpage()</script>", false);
        }
    }
}