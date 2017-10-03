<%@ WebHandler Language="C#" Class="ashx_ExportExcel" %>

using System;
using System.Web;
using System.IO;
using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System.Data;

public class ashx_ExportExcel : IHttpHandler, System.Web.SessionState.IReadOnlySessionState
{
    NpoiExcel Npo = new NpoiExcel();
    payroll.gdal dal = new payroll.gdal();
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string sr_guid = (!string.IsNullOrEmpty(context.Request.QueryString["sr_guid"])) ? context.Request.QueryString["sr_guid"].ToString() : "";
            string sDate = (!string.IsNullOrEmpty(context.Request.QueryString["sDate"])) ? context.Request.QueryString["sDate"].ToString() : "";
            string eDate = (!string.IsNullOrEmpty(context.Request.QueryString["eDate"])) ? context.Request.QueryString["eDate"].ToString() : "";
            string PerNo = (!string.IsNullOrEmpty(context.Request.QueryString["PerNo"])) ? context.Request.QueryString["PerNo"].ToString() : "";
            string Company = (!string.IsNullOrEmpty(context.Request.QueryString["Company"])) ? context.Request.QueryString["Company"].ToString() : "";
            string Dep = (!string.IsNullOrEmpty(context.Request.QueryString["Dep"])) ? context.Request.QueryString["Dep"].ToString() : "";
            string Position = (!string.IsNullOrEmpty(context.Request.QueryString["Position"])) ? context.Request.QueryString["Position"].ToString() : "";



            if (!string.IsNullOrEmpty(USERINFO.MemberGuid))
            {
                DataView dv = dal.Call_pr_LeaveExport(sr_guid, PerNo, Company, Dep, Position).DefaultView;


                FileStream fs = new FileStream(context.Server.MapPath("~/Excel_sample/LeaveExport.xlsx"), FileMode.Open, FileAccess.Read);
                XSSFWorkbook wk = new XSSFWorkbook(fs);
                XSSFSheet sh = (XSSFSheet)wk.GetSheetAt(0);

                IRow HeaderRow = sh.CreateRow(0);
                ICell DateCell = HeaderRow.CreateCell(0);

                XSSFCellStyle cellStyle = (XSSFCellStyle)wk.CreateCellStyle();
                XSSFFont font = (XSSFFont)wk.CreateFont();

                DateCell.CellStyle = cellStyle;
                font.FontHeightInPoints = 10;
                //font.Color = NPOI.HSSF.Util.HSSFColor.RED.index;
                cellStyle.SetFont(font);
                DateCell.SetCellValue("請假期間：" + sDate + "~" + eDate);
                for (int i = 0; i < dv.Count; i++)
                {
                    int cellN = i + 2;
                    if (dv[i]["PerGuid"].ToString() == "Sum")//加總
                    {
                        HeaderRow.CreateCell(3).SetCellValue(dv[i]["Duration1"].ToString()); //事假／家庭照顧假
                        HeaderRow.CreateCell(4).SetCellValue(dv[i]["Duration14"].ToString());//彈性休假
                        HeaderRow.CreateCell(5).SetCellValue(dv[i]["Duration9"].ToString());//產假
                        HeaderRow.CreateCell(6).SetCellValue(dv[i]["Duration15"].ToString());//流產假
                        HeaderRow.CreateCell(7).SetCellValue(dv[i]["Duration4"].ToString());//公傷病假
                        HeaderRow.CreateCell(8).SetCellValue(dv[i]["Duration10"].ToString());//安胎假
                        HeaderRow.CreateCell(9).SetCellValue(dv[i]["Duration13"].ToString());//住院病假
                        HeaderRow.CreateCell(10).SetCellValue(dv[i]["Duration5"].ToString());//普通病假
                        HeaderRow.CreateCell(11).SetCellValue(dv[i]["Duration7"].ToString());//生理假
                        HeaderRow.CreateCell(12).SetCellValue(dv[i]["sickLavelSum"].ToString());//病假加總
                        HeaderRow.CreateCell(13).SetCellValue(dv[i]["Duration11"].ToString());//兵役假
                        HeaderRow.CreateCell(14).SetCellValue(dv[i]["Duration2"].ToString());//婚假
                        HeaderRow.CreateCell(15).SetCellValue(dv[i]["Duration3"].ToString());//喪假
                        HeaderRow.CreateCell(16).SetCellValue(dv[i]["Duration8"].ToString());//產檢假／陪產假
                        HeaderRow.CreateCell(17).SetCellValue(dv[i]["Duration12"].ToString());//特休
                        HeaderRow.CreateCell(18).SetCellValue(dv[i]["pAnnualLeavePro"].ToString());//特休假工時比例
                        HeaderRow.CreateCell(19).SetCellValue(dv[i]["pAnnualLeaveSalary"].ToString());//特休假代金
                        HeaderRow.CreateCell(20).SetCellValue(dv[i]["pP1Time"].ToString());//P1工時
                        HeaderRow.CreateCell(21).SetCellValue(dv[i]["pSickLeaveSalary"].ToString());//病假薪資
                        HeaderRow.CreateCell(22).SetCellValue(dv[i]["pMarriageLeaveSalary"].ToString());//婚假薪資
                        HeaderRow.CreateCell(23).SetCellValue(dv[i]["pFuneralLeaveSalary"].ToString());//喪假薪資
                        HeaderRow.CreateCell(24).SetCellValue(dv[i]["pProductionLeaveSalary"].ToString());//產檢/陪產
                        HeaderRow.CreateCell(25).SetCellValue(dv[i]["pMaternityLeaveSalary"].ToString());//產假薪資
                        HeaderRow.CreateCell(26).SetCellValue(dv[i]["pAbortionLeaveSalary"].ToString());//流產假薪資
                        HeaderRow.CreateCell(27).SetCellValue(dv[i]["pMilitaryLeaveSalary"].ToString());//兵役薪資
                        cellN = cellN - 1;
                    }
                    else
                    {
                        //IRow row = sh.GetRow(cellN);
                        IRow row = sh.CreateRow(cellN);
                        row.CreateCell(0).SetCellValue(dv[i]["PerNo"].ToString());
                        row.CreateCell(1).SetCellValue(dv[i]["cbValue"].ToString());
                        row.CreateCell(2).SetCellValue(dv[i]["perName"].ToString());

                        row.CreateCell(3).SetCellValue(dv[i]["Duration1"].ToString()); //事假／家庭照顧假
                        row.CreateCell(4).SetCellValue(dv[i]["Duration14"].ToString());//彈性休假
                        row.CreateCell(5).SetCellValue(dv[i]["Duration9"].ToString());//產假
                        row.CreateCell(6).SetCellValue(dv[i]["Duration15"].ToString());//流產假
                        row.CreateCell(7).SetCellValue(dv[i]["Duration4"].ToString());//公傷病假
                        row.CreateCell(8).SetCellValue(dv[i]["Duration10"].ToString());//安胎假
                        row.CreateCell(9).SetCellValue(dv[i]["Duration13"].ToString());//住院病假
                        row.CreateCell(10).SetCellValue(dv[i]["Duration5"].ToString());//普通病假
                        row.CreateCell(11).SetCellValue(dv[i]["Duration7"].ToString());//生理假
                        row.CreateCell(12).SetCellValue(dv[i]["sickLavelSum"].ToString());//病假加總
                        row.CreateCell(13).SetCellValue(dv[i]["Duration11"].ToString());//兵役假
                        row.CreateCell(14).SetCellValue(dv[i]["Duration2"].ToString());//婚假
                        row.CreateCell(15).SetCellValue(dv[i]["Duration3"].ToString());//喪假
                        row.CreateCell(16).SetCellValue(dv[i]["Duration8"].ToString());//產檢假／陪產假
                        row.CreateCell(17).SetCellValue(dv[i]["Duration12"].ToString());//特休
                        row.CreateCell(18).SetCellValue(dv[i]["pAnnualLeavePro"].ToString());//特休假工時比例
                        row.CreateCell(19).SetCellValue(dv[i]["pAnnualLeaveSalary"].ToString());//特休假代金
                        row.CreateCell(20).SetCellValue(dv[i]["pP1Time"].ToString());//P1工時
                        row.CreateCell(21).SetCellValue(dv[i]["pSickLeaveSalary"].ToString());//病假薪資
                        row.CreateCell(22).SetCellValue(dv[i]["pMarriageLeaveSalary"].ToString());//婚假薪資
                        row.CreateCell(23).SetCellValue(dv[i]["pFuneralLeaveSalary"].ToString());//喪假薪資
                        row.CreateCell(24).SetCellValue(dv[i]["pProductionLeaveSalary"].ToString());//產檢/陪產
                        row.CreateCell(25).SetCellValue(dv[i]["pMaternityLeaveSalary"].ToString());//產假薪資
                        row.CreateCell(26).SetCellValue(dv[i]["pAbortionLeaveSalary"].ToString());//流產假薪資
                        row.CreateCell(27).SetCellValue(dv[i]["pMilitaryLeaveSalary"].ToString());//兵役薪資
                    }
                }


                Npo.ExporkExcelNew(wk, "給薪假紀錄");//下載excel
            }
            else
            {
                context.Response.Write("TimeOut");
            }
        }
        catch (Exception ex)
        {
            ErrorLog err = new ErrorLog();
            err.InsErrorLog("ashx_ExportPayroll.ashx", ex.Message, USERINFO.MemberName);
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