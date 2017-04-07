using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class webpage_Page_ModifyPd : System.Web.UI.Page
{
    payroll.gdal dal = new payroll.gdal();
 
    Common com = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lkb_Send_Click(object sender, EventArgs e)
    {
        sy_Member m = new sy_Member();
        m.mbGuid = USERINFO.MemberGuid;
        m.mbPassword = com.desEncryptBase64(txt_Id.Text.Trim());
        DataView dv = dal.SelMember(m).DefaultView;
        if (dv.Count == 1)
        {
            if (txt_Pd.Text.Trim() == txt_Pd_again.Text.Trim())
            {
                m.mbPassword = com.desEncryptBase64(txt_Pd.Text.Trim());
                dal.UpMemberPd(m);
                Session.Remove("MemberInfo_Guid");
                Session.Remove("MemberInfo_Name");
                Session.Remove("MemberInfo_Class");
                Session.Remove("MemberInfo_Competence");
                JavaScript.AlertMessageRedirect(this.Page, "修改成功，請重新登入", "Page-Login.aspx");
            }else { JavaScript.AlertMessage(this.Page, "新密碼驗證錯誤"); }
        }
        else { JavaScript.AlertMessage(this.Page, "舊密碼錯誤"); }


    }
}