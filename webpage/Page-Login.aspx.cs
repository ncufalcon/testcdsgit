using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class webpage_Page_Login : System.Web.UI.Page
{
    Common com = new Common();
    Member mb = new Member();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lkb_Send_Click(object sender, EventArgs e)
    {
        if(txt_Id.Text.Trim()=="")
        {
            td_msg.InnerText = "●請輸入帳號";
            return;
        }

        if (txt_Pd.Text.Trim() == "")
        {
            td_msg.InnerText = "●請輸入密碼";
            return;
        }

        mb.mLogon(txt_Id.Text.Trim(), com.desEncryptBase64(txt_Pd.Text.Trim()));
        
        if(!string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            JavaScript.AlertMessageRedirect(this.Page, "登入成功", "PersonnelInfo.aspx");
            //Response.Redirect("~/webpage/PersonnelInfo.aspx");
           
        }else { td_msg.InnerText = "●帳號密碼錯誤"; }


    }
}