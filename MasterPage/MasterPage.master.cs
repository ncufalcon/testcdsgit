using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage_MasterPage : System.Web.UI.MasterPage
{
    Common com = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            JavaScript.AlertMessageRedirect(this.Page, "請重新登入", "Page-Login.aspx");
        } else { sp_MemberName.InnerText = "您好  " + USERINFO.MemberName; };
    }

    protected void lkb_out_Click(object sender, EventArgs e)
    {
        com.Logout();
        Response.Redirect("~/webpage/Page-Login.aspx");

    }
}
