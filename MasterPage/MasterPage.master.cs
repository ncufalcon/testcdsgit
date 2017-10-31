using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class MasterPage_MasterPage : System.Web.UI.MasterPage
{
    Common com = new Common();
    payroll.gdal dal = new payroll.gdal();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(USERINFO.MemberGuid))
        {
            JavaScript.AlertMessageRedirect(this.Page, "請重新登入", "Page-Login.aspx");
        }
        else { sp_MemberName.InnerText = "您好  " + USERINFO.MemberName; };

        if (!IsPostBack)
        {
            CheckUI();

            CheckIdenn();
        }
    }

    protected void lkb_out_Click(object sender, EventArgs e)
    {
        com.Logout();
        Response.Redirect("~/webpage/Page-Login.aspx");

    }


    /// <summary>
    /// 判斷權限開啟頁面
    /// </summary>
    void CheckUI()
    {

        string[] ComStr = USERINFO.MemberCompetence.Split(',');
        for (int j = 0; j < ComStr.Length; j++)
        {
            payroll.model.sy_Member m = new payroll.model.sy_Member();
            m.gpCode = ComStr[j].ToString();       


            DataView dv = dal.SelMemberGroup(m).DefaultView;
            if (dv.Count != 0)
            {
                switch (dv[0]["gpName"].ToString())
                {
                    case "Person":
                        a_PersonMag.Visible = true;
                        a_Person.Visible = true;
                        break;
                    case "Insurance":
                        
                        a_Insurance.Visible = true;
                        break;
                    case "Modify":
                        a_PersonMag.Visible = true;
                        a_Modify.Visible = true;
                        break;
                    case "Allowance":
                        a_PayrollMag.Visible = true;
                        a_Allowance.Visible = true;
                        break;
                    case "Gifts":
                        a_PayrollMag.Visible = true;
                        a_Gifts.Visible = true;
                        break;
                    case "SalaryHoliday":
                        a_PayrollMag.Visible = true;
                        a_SalaryHoliday.Visible = true;
                        break;
                    case "Payroll":
                        a_PayrollMag.Visible = true;
                        a_Payroll.Visible = true;
                        break;
                    case "Saveto":
                        a_PayrollMag.Visible = true;
                        a_Saveto.Visible = true;
                        break;
                    case "PayrollPrint":
                        a_PayrollMag.Visible = true;
                        a_PayrollPrint.Visible = true;
                        break;
                    case "PayrollList":
                        a_PayrollMag.Visible = true;
                        a_PayrollList.Visible = true;
                        break;
                    case "PayrollElectronic":
                        a_PayrollMag.Visible = true;
                        //a_PayrollElectronic.Visible = true;
                        break;
                    case "IndividualTax":
                        a_PayrollMag.Visible = true;
                        a_IndividualTax.Visible = true;
                        break;

                    case "WorkHours":
                        a_WorkHoursMsg.Visible = true;
                        a_WorkHours.Visible = true;
                        break;
                    case "Seniority":
                        a_WorkHoursMsg.Visible = true;
                        a_Seniority.Visible = true;
                        break;
                    case "Attendance":
                        a_WorkHoursMsg.Visible = true;
                        a_Attendance.Visible = true;
                        break;
                    case "InsuranceFee":
                        a_Report.Visible = true;
                        a_InsuranceFee.Visible = true;
                        break;
                    case "AttendanceDetail":
                        a_Report.Visible = true;
                        a_AttendanceDetail.Visible = true;
                        break;
                    case "PensionReport":
                        a_Report.Visible = true;
                        a_PensionReport.Visible = true;
                        break;
                    case "InsuranceReport":
                        a_Report.Visible = true;
                        a_InsuranceReport.Visible = true;
                        break;
                    case "AnnualLeaveReport":
                        a_StatisticsMag.Visible = true;
                        a_AnnualLeaveRepor.Visible = true;
                        break;
                    case "company":
                        a_SystemMag.Visible = true;
                        a_Company.Visible = true;
                        break;
                    case "admin":
                        a_SystemMag.Visible = true;
                        a_ManageMsg.Visible = true;
                        a_Admin.Visible = true;
                        break;
                    case "Competence":
                        a_SystemMag.Visible = true;
                        a_ManageMsg.Visible = true;
                        a_Competence.Visible = true;
                        break;
                    case "regionadmin":
                        a_SystemMag.Visible = true;
                        a_regionadmin.Visible = true;
                        break;
                    case "calendaradmin":
                        a_SystemMag.Visible = true;
                        a_calendaradmin.Visible = true;
                        break;
                    case "hourlyadmin":
                        a_SystemMag.Visible = true;
                        a_hourlyadmin.Visible = true;
                        break;
                    case "nssadmin":
                        a_SystemMag.Visible = true;
                        a_nssadmin.Visible = true;
                        break;
            

                }
            }
        }

    }




    /// <summary>
    /// 判斷個頁面是否有權限瀏覽
    /// </summary>
    void CheckIdenn()
    {
        //權限判別
        string thePathNameWithExtention = PageName();

        //判斷是否為 不須權限謝面
        if (HttpContext.GetGlobalResourceObject("ExceptionPage", thePathNameWithExtention) == null)
        {
            string MemberCom = "";//紀錄會員權限
            string CheckStr = "";//紀錄是否有 權限 Y:有 空白:沒 
            if (!string.IsNullOrEmpty(USERINFO.MemberClass))
                MemberCom = USERINFO.MemberClass;
            else
                //表示guest
                JavaScript.AlertMessageRedirect(this.Page, "您沒有權限訪問此頁面", "index.aspx");


            if (MemberCom != "99") //99為管理者 免判斷
            {
                if (HttpContext.GetGlobalResourceObject("Competence", thePathNameWithExtention) != null)//判斷資源檔裡有無此路徑
                {
                    string PageStr = HttpContext.GetGlobalResourceObject("Competence", thePathNameWithExtention).ToString();

                    string ComGroup = USERINFO.MemberCompetence;

                    if (ComGroup != "")
                    {
                        string[] ComStr = ComGroup.Split(',');
                        for (int j = 0; j < ComStr.Length; j++)
                        {
                            if (ComStr[j] == PageStr)
                                CheckStr = "Y";
                        }
                    }

                }

                //如果CheckStr代表沒權限 直接導回首頁
                if (CheckStr == "")
                    JavaScript.AlertMessageRedirect(this.Page, "您沒有權限訪問此頁面", "Page-Login.aspx");


            }
        }
    }

    string PageName()
    {
        string thePathNameWithExtention = Request.AppRelativeCurrentExecutionFilePath;
        thePathNameWithExtention = thePathNameWithExtention.Replace("~/", "").Replace(".", "_").Replace("/", "_").Replace("-", "_");
        return thePathNameWithExtention;
    }
}
