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

        pp_Change.Value = hid_changeVal.Value;

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
        string PPChange = hid_changeVal.Value;
        string No = txt_No.Text.Trim();

        if (Sdate == "" || Edate == "")
        {
            JavaScript.AlertMessage(this.Page, "請選擇日期起迄");
            return;
        }
        if (PPChange == "")
        {
            JavaScript.AlertMessage(this.Page, "請選擇異動別");
            return;
        }

        if (PerCompany == "")
        {
            JavaScript.AlertMessage(this.Page, "請輸入公司別");
            return;
        }
        if (No == "")
        {
            JavaScript.AlertMessage(this.Page, "請輸入提撥單位編號");
            return;
        }



        string[] str = { Sdate, Edate, PerNo, PerName, PerDep, PerCompany, PPChange };
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
            p.perChange = PPChange;
            DataTable dt = dal.Sel_sy_PersonPension(p);

            DataView dv = dal.Sel_sy_Company(PerCompany).DefaultView;

            if (dv.Count != 0)
            {
                dt = checkDT(dt);
                ReportViewer1.LocalReport.ReportPath = Server.MapPath("~/rdlc/Report.rdlc"); //給報表檔案的路徑
                ReportDataSource source = new ReportDataSource("DataSet1", dt);
                ReportViewer1.LocalReport.EnableExternalImages = true;
                string imagePath = new Uri(Server.MapPath("~/images/report.jpg")).AbsoluteUri;
                ReportParameter parameter = new ReportParameter("img", imagePath);

                ReportParameter CompanyName = new ReportParameter("CompanyName", dv[0]["comBusinessEntity"].ToString());
                ReportParameter comID1 = new ReportParameter("comID1", No.Substring(0, 1));
                ReportParameter comID2 = new ReportParameter("comID2", No.Substring(1, 1));
                ReportParameter comID3 = new ReportParameter("comID3", No.Substring(2, 1));
                ReportParameter comID4 = new ReportParameter("comID4", No.Substring(3, 1));
                ReportParameter comID5 = new ReportParameter("comID5", No.Substring(4, 1));
                ReportParameter comID6 = new ReportParameter("comID6", No.Substring(5, 1));
                ReportParameter comID7 = new ReportParameter("comID7", No.Substring(6, 1));
                ReportParameter comID8 = new ReportParameter("comID8", No.Substring(7, 1));
                ReportParameter comID9 = new ReportParameter("comID9", No.Substring(8, 1));
                ReportParameter yyyy = new ReportParameter("yyyy", (int.Parse(DateTime.Now.ToString("yyyy")) - 1911).ToString());
                ReportParameter MM = new ReportParameter("MM", DateTime.Now.ToString("MM"));
                ReportParameter dd = new ReportParameter("dd", DateTime.Now.ToString("dd"));
                ReportViewer1.LocalReport.SetParameters(parameter);

                //ReportParameter UnitPar = new ReportParameter("UnitCode", "單位/部門:" + UnitCode);
                ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { parameter, CompanyName, comID1, comID2, comID3, comID4, comID5, comID6, comID7, comID8, comID9, yyyy, MM, dd });
                ReportViewer1.LocalReport.DataSources.Add(source);
                //重整
                ReportViewer1.LocalReport.Refresh();
                //ReportViewer1.LocalReport.Dispose();
            }
            else {
                JavaScript.AlertMessage(this.Page, "查詢條件無公司資料");
            }

        }
        else { Response.Redirect("~/ErrorPage.aspx?err=par"); }
    }


    public DataTable checkDT(DataTable dt)
    {
        int n = dt.Rows.Count;
        int s = n % 5;
        int z = 5 - s;

        if (s != 0)
        {
            for (int j = s; j < 5; j++)
            {
                DataRow r = dt.NewRow();
                r["RowNumber"] = dt.Rows.Count + 1;
                dt.Rows.Add(r);
            }
        }
        return dt;
    }
}