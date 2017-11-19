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
        }catch(Exception ex)
        {
            JavaScript.AlertMessage(this.Page, "程式發生錯誤");
        }
    }
}