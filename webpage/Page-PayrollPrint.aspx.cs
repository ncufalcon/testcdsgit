using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class webpage_Page_PayrollPrint : System.Web.UI.Page
{
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    protected void Page_Load(object sender, EventArgs e)
    {
        sp_sDate.InnerText = hid_sdate.Value;
        sp_eDate.InnerText = hid_edate.Value;
    }

    protected void lkb_design_Click(object sender, EventArgs e)
    {
        DataView dv = dal.Selsy_PaySalaryPrint().DefaultView;
        if (dv.Count == 1)
        {
            tex_designContent.Value = (dv[0]["pspContent"].ToString());

            div_List.Style.Add("display", "none");
            div_Edit.Style.Remove("display");
        }
    }

    protected void lkb_Cancel_Click(object sender, EventArgs e)
    {
        div_List.Style.Remove("display");
        div_Edit.Style.Add("display", "none");
    }

    protected void lkb_subimt_Click(object sender, EventArgs e)
    {
        try
        {
            string pspContent = tex_designContent.Value;
            dal.Upsy_SalaryPrint(pspContent, USERINFO.MemberGuid);
            JavaScript.AlertMessage(this.Page, "儲存成功");
        }
        catch (Exception ex)
        {
            JavaScript.AlertMessage(this.Page, "程式發生錯誤");
        }
    }


    protected void lkb_browse_Click(object sender, EventArgs e)
    {
        sp_gp1.Style.Add("display", "none");
        sp_gp2.Style.Remove("display");
        div_show.Style.Remove("display");
    }

    protected void lkb_TestCancel_Click(object sender, EventArgs e)
    {
        sp_gp2.Style.Add("display", "none");
        sp_gp1.Style.Remove("display");
        div_show.Style.Add("display", "none");
    }

    protected void lkb_TestPrint_Click(object sender, EventArgs e)
    {
        string val = div_show.InnerHtml;
        //Page.ClientScript.RegisterClientScriptInclude(val, "printScreen()");
        ScriptManager.RegisterStartupScript(Page, GetType(), "clicktest", "<script>printScreen('"+ hid_SalaryRangeGuid.Value + "','" + txt_PerNo.Value + "')</script>", false);
    }

    protected void lkb_TestSearch_Click(object sender, EventArgs e)
    {
        string srGuid = hid_SalaryRangeGuid.Value;
        string Amount = (chk_ShouldPay.Checked == true) ? "Y" : "N";
        string Leave = (chk_Leave.Checked == true) ? "Y" : "N";
        string perNo = txt_PerNo.Value;
        string perName = txt_PerName.Value;
        string Company = txt_CompanyNo.Value;
        string Dep = txt_Dep.Value;

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

        DataView dv = dal.Sel_SalaryPrint(srGuid, perNo, perName, Company, Dep, Amount, Leave).DefaultView;
        if (dv.Count == 1)
        {
            div_show.InnerHtml = dv[0]["htmlstr"].ToString();
        }

    }

    protected void lkb_print_Click(object sender, EventArgs e)
    {
        string srGuid = hid_SalaryRangeGuid.Value;
        string Amount = (chk_ShouldPay.Checked == true) ? "Y" : "N";
        string Leave = (chk_Leave.Checked == true) ? "Y" : "N";
        string perNo = txt_PerNo.Value;
        string perName = txt_PerName.Value;
        string Company = txt_CompanyNo.Value;
        string Dep = txt_Dep.Value;
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
        ScriptManager.RegisterStartupScript(Page, GetType(), "clicktest", "<script>opList('" + srGuid + "','" + perNo + "','" + perName + "','" + Company + "','" + Dep + "','" + Amount + "','" + Leave + "' )</script>", false);
        //string srGuid = hid_SalaryRangeGuid.Value;
        //string Amount = (chk_ShouldPay.Checked == true) ? "Y" : "N";
        //string Leave = (chk_Leave.Checked == true) ? "Y" : "N";
        //string perNo = txt_PerNo.Value;
        //string perName = txt_PerName.Value;
        //string Company = txt_CompanyNo.Value;
        //string Dep = txt_Dep.Value;

        //if (string.IsNullOrEmpty(srGuid))
        //{
        //    JavaScript.AlertMessage(this.Page, "請選擇計薪週期");
        //    return;
        //}
        //div_show.Style.Remove("display");
        //DataView dv = dal.Sel_SalaryPrint(srGuid, perNo, perName, Company, Dep, Amount, Leave).DefaultView;
        //for (int i = 0; i < dv.Count; i++)
        //{
        //    div_show.InnerHtml = dv[0]["htmlstr"].ToString();
        //}
    }

    protected void lkb_Back_Click(object sender, EventArgs e)
    {
        dal.Upsy_BackSalaryPrint(USERINFO.MemberGuid);
        DataView dv = dal.Selsy_PaySalaryPrint().DefaultView;
        if (dv.Count == 1)
        {
            tex_designContent.Value = (dv[0]["pspContent"].ToString());
            JavaScript.AlertMessage(this.Page, "還原成功");
        }

    }
}