using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class webpage_print : System.Web.UI.Page
{
    payroll.gdal dal = new payroll.gdal();
    protected void Page_Load(object sender, EventArgs e)
    {

        string srGuid = Request.QueryString["guid"];
        string perNo = Request.QueryString["No"];


        if (string.IsNullOrEmpty(srGuid))
        {
            JavaScript.AlertMessage(this.Page, "請選擇計薪週期");
            return;
        }

        if (string.IsNullOrEmpty(perNo))
        {
            JavaScript.AlertMessage(this.Page, "請輸入測試工號");
            return;
        }

        DataView dv = dal.Sel_SalaryPrint(srGuid, perNo, "", "", "", "", "").DefaultView;
        if (dv.Count == 1)
        {
            div_show.InnerHtml = dv[0]["htmlstr"].ToString();
        }



    }
}