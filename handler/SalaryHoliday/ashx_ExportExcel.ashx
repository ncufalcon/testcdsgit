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
    Common com = new Common();
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

                XSSFCellStyle intStyle = wk.CreateCellStyle() as XSSFCellStyle;
                XSSFDataFormat format = wk.CreateDataFormat() as XSSFDataFormat;
                intStyle.DataFormat = format.GetFormat("0.0");

                XSSFCellStyle pStyle = wk.CreateCellStyle() as XSSFCellStyle;
                XSSFDataFormat pformat = wk.CreateDataFormat() as XSSFDataFormat;
                pStyle.DataFormat = format.GetFormat("0.0%");


                DateCell.CellStyle = cellStyle;
                font.FontHeightInPoints = 10;
                //font.Color = NPOI.HSSF.Util.HSSFColor.RED.index;
                cellStyle.SetFont(font);
                DateCell.SetCellValue("請假期間：" + sDate + "~" + eDate);
                int cellN = 1;

                for (int i = 0; i < dv.Count; i++)
                {
                    cellN = cellN + 1;
                    if (dv[i]["PerGuid"].ToString() == "Sum")//加總
                    {
                        HeaderRow.CreateCell(3).SetCellValue(double.Parse(dv[i]["Duration1"].ToString())); //事假／家庭照顧假
                        HeaderRow.CreateCell(4).SetCellValue(com.toDou(dv[i]["Duration14"].ToString()));//彈性休假
                        HeaderRow.CreateCell(5).SetCellValue(com.toDou(dv[i]["Duration9"].ToString()));//產假
                        HeaderRow.CreateCell(6).SetCellValue(com.toDou(dv[i]["Duration15"].ToString()));//流產假
                        HeaderRow.CreateCell(7).SetCellValue(com.toDou(dv[i]["Duration4"].ToString()));//公傷病假
                        HeaderRow.CreateCell(8).SetCellValue(com.toDou(dv[i]["Duration10"].ToString()));//安胎假
                        HeaderRow.CreateCell(9).SetCellValue(com.toDou(dv[i]["Duration13"].ToString()));//住院病假
                        HeaderRow.CreateCell(10).SetCellValue(com.toDou(dv[i]["Duration5"].ToString()));//普通病假
                        HeaderRow.CreateCell(11).SetCellValue(com.toDou(dv[i]["Duration7"].ToString()));//生理假
                        HeaderRow.CreateCell(12).SetCellValue(com.toDou(dv[i]["sickLavelSum"].ToString()));//病假加總
                        HeaderRow.CreateCell(13).SetCellValue(com.toDou(dv[i]["Duration11"].ToString()));//兵役假
                        HeaderRow.CreateCell(14).SetCellValue(com.toDou(dv[i]["Duration2"].ToString()));//婚假
                        HeaderRow.CreateCell(15).SetCellValue(com.toDou(dv[i]["Duration3"].ToString()));//喪假
                        HeaderRow.CreateCell(16).SetCellValue(com.toDou(dv[i]["Duration8"].ToString()));//產檢假／陪產假
                        HeaderRow.CreateCell(17).SetCellValue(com.toDou(dv[i]["Duration12"].ToString()));//特休
                        HeaderRow.CreateCell(18).SetCellValue(com.toDou(dv[i]["pAnnualLeavePro"].ToString()));//特休假工時比例
                        HeaderRow.CreateCell(19).SetCellValue(com.toDou(dv[i]["pAnnualLeaveSalary"].ToString()));//特休假代金

                            HeaderRow.CreateCell(20).SetCellValue(com.toDou(dv[i]["perSalary"].ToString()));//時薪
                        HeaderRow.CreateCell(21).SetCellValue(com.toDou(dv[i]["pP1Time"].ToString()));//P1工時
                        HeaderRow.CreateCell(22).SetCellValue(com.toDou(dv[i]["pSickLeaveSalary"].ToString()));//病假薪資
                        HeaderRow.CreateCell(23).SetCellValue(com.toDou(dv[i]["pMarriageLeaveSalary"].ToString()));//婚假薪資
                        HeaderRow.CreateCell(24).SetCellValue(com.toDou(dv[i]["pFuneralLeaveSalary"].ToString()));//喪假薪資
                        HeaderRow.CreateCell(25).SetCellValue(com.toDou(dv[i]["pProductionLeaveSalary"].ToString()));//產檢/陪產
                        HeaderRow.CreateCell(26).SetCellValue(com.toDou(dv[i]["pMaternityLeaveSalary"].ToString()));//產假薪資
                        HeaderRow.CreateCell(27).SetCellValue(com.toDou(dv[i]["pAbortionLeaveSalary"].ToString()));//流產假薪資
                        HeaderRow.CreateCell(28).SetCellValue(com.toDou(dv[i]["pMilitaryLeaveSalary"].ToString()));//兵役薪資
                        cellN = cellN - 1;
                    }
                    else
                    {
                        //IRow row = sh.GetRow(cellN);
                        IRow row = sh.CreateRow(cellN);

                        row.CreateCell(0).SetCellValue(dv[i]["PerNo"].ToString());
                        row.CreateCell(1).SetCellValue(dv[i]["cbValue"].ToString());
                        row.CreateCell(2).SetCellValue(dv[i]["perName"].ToString());



                        ICell c3 = row.CreateCell(3);
                        c3.CellStyle = intStyle;
                        c3.SetCellValue(double.Parse(dv[i]["Duration1"].ToString())); //事假／家庭照顧假

                        ICell c4 = row.CreateCell(4);
                        c4.CellStyle = intStyle;
                        c4.SetCellValue(double.Parse(dv[i]["Duration14"].ToString()));//彈性休假

                        ICell c5 = row.CreateCell(5);
                        c5.CellStyle = intStyle;
                        c5.SetCellValue(double.Parse(dv[i]["Duration9"].ToString()));//產假

                        ICell c6 = row.CreateCell(6);
                        c6.CellStyle = intStyle;
                        c6.SetCellValue(double.Parse(dv[i]["Duration15"].ToString()));//流產假

                        ICell c7 = row.CreateCell(7);
                        c7.CellStyle = intStyle;
                        c7.SetCellValue(double.Parse(dv[i]["Duration4"].ToString()));//公傷病假

                        ICell c8 = row.CreateCell(8);
                        c8.CellStyle = intStyle;
                        c8.SetCellValue(double.Parse(dv[i]["Duration10"].ToString()));//安胎假

                        ICell c9 = row.CreateCell(9);
                        c9.CellStyle = intStyle;
                        c9.SetCellValue(double.Parse(dv[i]["Duration13"].ToString()));//住院病假

                        ICell c10 = row.CreateCell(10);
                        c10.CellStyle = intStyle;
                        c10.SetCellValue(com.toDou(dv[i]["Duration5"].ToString()));//普通病假

                        ICell c11 = row.CreateCell(11);
                        c11.CellStyle = intStyle;
                        c11.SetCellValue(double.Parse(dv[i]["Duration7"].ToString()));//生理假

                        ICell c12 = row.CreateCell(12);
                        c12.CellStyle = intStyle;
                        c12.SetCellValue(double.Parse(dv[i]["sickLavelSum"].ToString()));//病假加總

                        ICell c13 = row.CreateCell(13);
                        c13.CellStyle = intStyle;
                        c13.SetCellValue(double.Parse(dv[i]["Duration11"].ToString()));//兵役假

                        ICell c14 = row.CreateCell(14);
                        c14.CellStyle = intStyle;
                        c14.SetCellValue(double.Parse(dv[i]["Duration2"].ToString()));//婚假

                        ICell c15 = row.CreateCell(15);
                        c15.CellStyle = intStyle;
                        c15.SetCellValue(double.Parse(dv[i]["Duration3"].ToString()));//喪假

                        ICell c16 = row.CreateCell(16);
                        c16.CellStyle = intStyle;
                        c16.SetCellValue(double.Parse(dv[i]["Duration8"].ToString()));//產檢假／陪產假

                        ICell c17 = row.CreateCell(17);
                        c17.CellStyle = intStyle;
                        c17.SetCellValue(double.Parse(dv[i]["Duration12"].ToString()));//特休

                        ICell c18 = row.CreateCell(18);
                        c18.CellStyle = pStyle;
                        c18.SetCellValue(double.Parse(dv[i]["pAnnualLeavePro"].ToString()));//特休假工時比例

                        row.CreateCell(19).SetCellValue(com.toDou(dv[i]["pAnnualLeaveSalary"].ToString()));//特休假代金

                        row.CreateCell(20).SetCellValue(com.toDou(dv[i]["perSalary"].ToString()));//時薪
                        row.CreateCell(21).SetCellValue(com.toDou(dv[i]["pP1Time"].ToString()));//P1工時
                        row.CreateCell(22).SetCellValue(com.toDou(dv[i]["pSickLeaveSalary"].ToString()));//病假薪資
                        row.CreateCell(23).SetCellValue(com.toDou(dv[i]["pMarriageLeaveSalary"].ToString()));//婚假薪資
                        row.CreateCell(24).SetCellValue(com.toDou(dv[i]["pFuneralLeaveSalary"].ToString()));//喪假薪資
                        row.CreateCell(25).SetCellValue(com.toDou(dv[i]["pProductionLeaveSalary"].ToString()));//產檢/陪產
                        row.CreateCell(26).SetCellValue(com.toDou(dv[i]["pMaternityLeaveSalary"].ToString()));//產假薪資
                        row.CreateCell(27).SetCellValue(com.toDou(dv[i]["pAbortionLeaveSalary"].ToString()));//流產假薪資
                        row.CreateCell(28).SetCellValue(com.toDou(dv[i]["pMilitaryLeaveSalary"].ToString()));//兵役薪資
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