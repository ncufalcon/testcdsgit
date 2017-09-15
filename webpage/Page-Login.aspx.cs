using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class webpage_Page_Login : System.Web.UI.Page
{
    Common com = new Common();
    Member mb = new Member();
    payroll.gdal dal = new payroll.gdal();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void lkb_Send_Click(object sender, EventArgs e)
    {
        if (txt_Id.Text.Trim() == "")
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

        if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            string ComGroup = USERINFO.MemberCompetence;

            if (ComGroup != "")
            {
                string[] ComStr = ComGroup.Split(',');
                for (int j = 0; j < ComStr.Length; j++)
                {
                    payroll.model.sy_Member p = new payroll.model.sy_Member();
                    p.gpCode = ComStr[0];
                    DataView dv = dal.SelMemberGroup(p).DefaultView;
                    if (dv.Count != 0)
                    {
                        //JavaScript.AlertMessage(this.Page, "登入成功");
                        //Response.Write("<script>alert('登入成功');</script>");
                        //Response.Redirect(dv[0]["gpIndex"].ToString());
                        JavaScript.AlertMessageRedirect(this.Page, "登入成功", dv[0]["gpIndex"].ToString());
                    }
                }
            }
            else { JavaScript.AlertMessageRedirect(this.Page, "登入成功", "Page-ModifyPd.aspx"); }





           

        }
        else { td_msg.InnerText = "●帳號密碼錯誤"; }


    }
}