using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MasterPage_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if(string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            JavaScript.AlertMessageRedirect(this.Page, "請重新登入", "Page-Login.aspx");
        }
    }
}
