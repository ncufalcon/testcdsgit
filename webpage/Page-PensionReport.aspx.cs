using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Microsoft.Reporting.WebForms;
using System.Reflection;

public partial class webpage_Page_PensionReport : System.Web.UI.Page
{
    payroll.gdal dal = new payroll.gdal();
    Common Com = new Common();
    protected void Page_Load(object sender, EventArgs e)
    {
        


    }
    protected void Page_PreRender(object sender, EventArgs e)
    {
        // 此段要放在Page_PreRender中，若要隱藏PDF，把關鍵字”PDF”放入字串陣列中即可。
        DisableExportButtons(this.ReportViewer1, new string[] { "Excel", "EXCELOPENXML", "IMAGE", "WORD", "WORDOPENXML" });
    }



    // 主要處理函式
    public void DisableExportButtons(ReportViewer ReportViewerID, string[] strFormatName)
    {
        try
        {
            FieldInfo FInfo;
            foreach (RenderingExtension RenExt in
            ReportViewerID.LocalReport.ListRenderingExtensions())
            {
                foreach (string s in strFormatName)
                {
                    if (RenExt.Name.Equals(s))
                    {
                        FInfo = RenExt.GetType().GetField("m_isVisible",
                             BindingFlags.Instance | BindingFlags.NonPublic);
                        FInfo.SetValue(RenExt, false);
                    }
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btn_Search_Click(object sender, EventArgs e)
    {


        ReportViewer1.LocalReport.Dispose();
        ReportViewer1.LocalReport.DataSources.Clear(); //將資料清空
        ReportViewer1.Reset();

        string Sdate = txt_sDate.Value.Trim();
        string Edate = txt_eDate.Value.Trim();
        string PerNo = txt_PerNo.Text.Trim();
        string PerName = txt_PerName.Text.Trim();
        string PerDep = txt_Dep.Text.Trim();
        string PerCompany = txt_CompanyNo.Text.Trim();

        string[] str = { Sdate, Edate, PerNo, PerName, PerDep, PerCompany };
        string sqlinj = Com.CheckSqlInJection(str);
        if (sqlinj == "")
        {


            //撈出我要的資料
            payroll.model.sy_Person p = new payroll.model.sy_Person();
            p.sDate = Sdate;
            p.eDate = Edate;
            p.perNo = PerNo;
            p.perName = PerName;
            p.perDep = PerDep;
            p.perCompanyName = PerCompany;
            DataTable dt = dal.Sel_sy_PersonPension(p);

            ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/rdlc/Report.rdlc"); //給報表檔案的路徑
            ReportDataSource source = new ReportDataSource("DataSet1", dt);
            ReportViewer1.LocalReport.EnableExternalImages = true;
            string imagePath = new Uri(Server.MapPath("~/images/report.jpg")).AbsoluteUri;
            ReportParameter parameter = new ReportParameter("img", imagePath);
            ReportViewer1.LocalReport.SetParameters(parameter);
            //ReportParameter SdatePar = new ReportParameter("SDate", txt_Sdate.Value);
            //ReportParameter EdatePar = new ReportParameter("EDate", txt_Edate.Value);
            //ReportParameter GroupPar = new ReportParameter("Group", Group);
            //ReportParameter TitlePar = new ReportParameter("Title", getTitle(Group));
            //ReportParameter UnitPar = new ReportParameter("UnitCode", "單位/部門:" + UnitCode);
            //ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { SdatePar, EdatePar, GroupPar, TitlePar, UnitPar });
            ReportViewer1.LocalReport.DataSources.Add(source);
            //重整
            ReportViewer1.LocalReport.Refresh();
            //ReportViewer1.LocalReport.Dispose();

        }
        else { Response.Redirect("~/ErrorPage.aspx?err=par"); }
    }
}