<%@ WebHandler Language="C#" Class="ashx_FeeReport" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_FeeReport : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    payroll.gdal dal = new payroll.gdal();
    Common com = new Common();
    NpoiExcel Npo = new NpoiExcel();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string srGuid = (!string.IsNullOrEmpty(context.Request.QueryString["srGuid"])) ? context.Request.QueryString["srGuid"].ToString() : "";
            string Class = (!string.IsNullOrEmpty(context.Request.QueryString["Class"])) ? context.Request.QueryString["Class"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";
            string SalaryDate = (!string.IsNullOrEmpty(context.Request.QueryString["SalaryDate"])) ? context.Request.QueryString["SalaryDate"].ToString() : "";

            string yyyyMM = SalaryDate.Substring(0, 7);
            payroll.model.sy_PayRoll pModel = new payroll.model.sy_PayRoll();
            pModel.sr_Guid = srGuid;
            pModel.pCompanyName = Company;
            pModel.pDep = Dep;
            pModel.pClass = Class;

            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.pr_InsuranceFeeReport(pModel).DefaultView;


                if (Class == "LI")
                {

                    FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LIFee.xlsx"), FileMode.Open, FileAccess.Read);
                    XSSFWorkbook wk = new XSSFWorkbook(fs);
                    XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                    IRow HeaderRow = sh.CreateRow(3);
                    ICell DateCell = HeaderRow.CreateCell(0);
                   ICell DateCel3 = HeaderRow.CreateCell(3);
                    XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                    XSSFFont font = (XSSFFont)wk.CreateFont();

                    DateCell.SetCellValue("製表日期:" + DateTime.Now.ToString("yyyy/MM/dd"));
                    DateCel3.SetCellValue("計費年月:" + yyyyMM);
                    for (int i = 0; i < dv.Count; i++)
                    {
                        int cellN = i + 5;
                        IRow row = sh.CreateRow(cellN);
                        row.CreateCell(0).SetCellValue(com.toDou(dv[i]["pPerLaborSalary"].ToString()));//投保金額
                        row.CreateCell(1).SetCellValue(com.toDou(dv[i]["LastMonthJoin"].ToString()));//上月參加員工
                        row.CreateCell(2).SetCellValue(com.toDou(dv[i]["MonthJoin"].ToString()));//本月加保員工
                        row.CreateCell(3).SetCellValue(com.toDou(dv[i]["MonthCancel"].ToString()));//本月退保員工
                        row.CreateCell(4).SetCellValue(com.toDou(dv[i]["MonthJoinPer"].ToString()));//本月參加員工
                        row.CreateCell(5).SetCellValue(com.toDou(dv[i]["pCompanyPension"].ToString()));//提繳人數
                        row.CreateCell(6).SetCellValue(com.toDou(dv[i]["LaborFee"].ToString()));//員工負擔保費
                        row.CreateCell(7).SetCellValue(com.toDou(dv[i]["ComLaborFee"].ToString()));//資方負擔保費 
                        Npo.ExporkExcelNew(wk, "LIFee_" + DateTime.Now.ToString("yyyyMMdd"));//下載excel
                    }
                }
                else if (Class == "NHI")
                {
                    FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/NIHFee.xlsx"), FileMode.Open, FileAccess.Read);
                    XSSFWorkbook wk = new XSSFWorkbook(fs);
                    XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                    IRow HeaderRow = sh.CreateRow(3);
                    ICell DateCell = HeaderRow.CreateCell(0);
                    ICell DateCel3 = HeaderRow.CreateCell(3);
                    //ICell DateCell_10 = HeaderRow.CreateCell(10);
                    XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                    XSSFFont font = (XSSFFont)wk.CreateFont();

                    DateCell.SetCellValue("製表日期:" + DateTime.Now.ToString("yyyy/MM/dd"));
                    DateCel3.SetCellValue("計費年月:" + yyyyMM);
                    for (int i = 0; i < dv.Count; i++)
                    {
                        int cellN = i + 5;
                        IRow row = sh.CreateRow(cellN);
                        row.CreateCell(0).SetCellValue(com.toDou(dv[i]["pPerInsuranceSalary"].ToString()));//投保金額
                        row.CreateCell(1).SetCellValue(com.toDou(dv[i]["LastMonthJoin"].ToString()));//上月參加員工
                        row.CreateCell(2).SetCellValue(com.toDou(dv[i]["LastMonthJoinF"].ToString()));//上月參加眷屬
                        row.CreateCell(3).SetCellValue(com.toDou(dv[i]["MonthJoin"].ToString()));//本月加保員工
                        row.CreateCell(4).SetCellValue(com.toDou(dv[i]["MonthJoinF"].ToString()));//本月加保眷屬
                        row.CreateCell(5).SetCellValue(com.toDou(dv[i]["MonthQuit"].ToString()));//本月退保員工
                        row.CreateCell(6).SetCellValue(com.toDou(dv[i]["MonthQuitF"].ToString()));//本月退保眷屬
                        row.CreateCell(7).SetCellValue(com.toDou(dv[i]["MonthJ"].ToString()));//本月參加員工                            
                        row.CreateCell(8).SetCellValue(com.toDou(dv[i]["MonthJP"].ToString()));//本月參加眷屬
                        row.CreateCell(9).SetCellValue(com.toDou(dv[i]["pPersonLabor"].ToString()));//員工負擔保費
                        row.CreateCell(10).SetCellValue(com.toDou(dv[i]["pComLabor"].ToString()));//資方負擔保費
                        Npo.ExporkExcelNew(wk, "NHIFee_" + DateTime.Now.ToString("yyyyMMdd"));//下載excel
                    }
                }
            }
            else
            {
                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_LIReport.ashx", ex.Message, USERINFO.MemberName);
            context.Response.Write("程式發生錯誤，請聯絡相關管理人員");

        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}