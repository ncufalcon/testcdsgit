<%@ WebHandler Language="C#" Class="ashx_NHIReport" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_NHIReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState {

    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    NpoiExcel Npo = new NpoiExcel();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string srGuid = (!string.IsNullOrEmpty(context.Request.QueryString["srGuid"])) ? context.Request.QueryString["srGuid"].ToString() : "";
            string PerNo = (!string.IsNullOrEmpty(context.Request.QueryString["PerNo"])) ? context.Request.QueryString["PerNo"].ToString() : "";
            string PerName = (!string.IsNullOrEmpty(context.Request.QueryString["PerName"])) ? context.Request.QueryString["PerName"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";
            string SalaryDate = (!string.IsNullOrEmpty(context.Request.QueryString["SalaryDate"])) ? context.Request.QueryString["SalaryDate"].ToString() : "";

            payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();
            pModel.sr_Guid = srGuid;
            pModel.pPerNo = PerNo;
                pModel.pPerName = PerName;
            pModel.pCompanyName = Company;
            pModel.pDepCode = Dep;


            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
               
                DataView dv = dal.SelSy_PaySalaryExport(pModel).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/NHI.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(3);
                ICell DateCell = HeaderRow.CreateCell(0);
                //ICell DateCell_10 = HeaderRow.CreateCell(10);
                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();

                //DateCell.CellStyle = cellStyle;
                //font.FontHeightInPoints = 10;
                //font.Color = NPOI.HSSF.Util.HSSFColor.Red.Index;
                //cellStyle.SetFont(font);
                DateCell.SetCellValue("製表日期:" + DateTime.Now.ToString("yyyy/MM/dd"));
                //DateCell_10.SetCellValue("核對年月:2017/08:" + DateTime.Now.ToString("yyyy/MM/dd"));
                 int rowNumber = 4; //從第幾row開始塞資料
                int cellN = 0 + rowNumber;
                for (int i = 0; i < dv.Count; i++)
                {
                     cellN += 1;
                    IRow row = sh.CreateRow(cellN);
                    row.CreateCell(0).SetCellValue(dv[i]["pPerDepCode"].ToString());//分店編號
                    row.CreateCell(1).SetCellValue(dv[i]["pPerNo"].ToString());//工號
                    row.CreateCell(2).SetCellValue(dv[i]["pPerName"].ToString());//姓名
                    row.CreateCell(3).SetCellValue(dv[i]["pPerIDNumber"].ToString());//身分證號
                    row.CreateCell(4).SetCellValue(com.toDou(dv[i]["pPerInsuranceSalary"].ToString()));//健保薪資
                    row.CreateCell(6).SetCellValue(com.toDou(dv[i]["pPersonInsurance"].ToString()));//員工負擔
                    row.CreateCell(7).SetCellValue(com.toDou(dv[i]["pComLabor"].ToString()));//資方負擔 


                    payroll.model.sy_FamilyInsurance pfModel = new payroll.model.sy_FamilyInsurance();
                    pfModel.psfiPerGuid = dv[i]["pPerGuid"].ToString();
                        pfModel.srGuid = srGuid;
                    DataView fdv = dal.Sel_sy_PaySalaryFamilyInsurance(pfModel).DefaultView;
                    row.CreateCell(5).SetCellValue(com.toDou((fdv.Count + 1).ToString()));//眷保人數
                    for (int j = 0; j < fdv.Count; j++)
                    {
                        cellN += 1;
                        IRow rowf = sh.CreateRow(cellN);

                        rowf.CreateCell(8).SetCellValue(fdv[j]["psfiName"].ToString());//眷屬姓名
                        rowf.CreateCell(9).SetCellValue(fdv[j]["psfiIDNumber"].ToString());//眷屬身分證
                        rowf.CreateCell(10).SetCellValue(fdv[j]["psfibirthday"].ToString());//出生年月日
                        rowf.CreateCell(11).SetCellValue(fdv[j]["psfiTitleCht"].ToString());//關係
                    }


                }
                Npo.ExporkExcelNew(wk, "NHI_" + DateTime.Now.ToString("yyyyMMdd"));//下載excel
            }
            else
            {
                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_NHIReport.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("程式發生錯誤，請聯絡相關管理人員");

        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}